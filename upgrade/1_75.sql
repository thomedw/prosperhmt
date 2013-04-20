begin;
alter table Flow add location varchar(32);
alter table Flow
	add index FK21754ED7AC3576 (location),
	add constraint FK21754ED7AC3576
	foreign key (location)
	references Location (id);
insert into location(id,name,active) values('1', 'Umum',1);
update Flow set location='1' where location is null;
alter table Flow modify location varchar(32) not null;
create table Onhand (
	id bigint not null auto_increment,
	version integer not null,
	quantity double precision not null,
	inventory varchar(32) not null,
	location varchar(32),
	primary key (id),
	unique (inventory, location)
);
alter table Onhand
	add index FK8D0DB2EED7AC3576 (location),
	add constraint FK8D0DB2EED7AC3576
	foreign key (location)
	references Location (id);

alter table Onhand
	add index FK8D0DB2EEBBB1FE2C (inventory),
	add constraint FK8D0DB2EEBBB1FE2C
	foreign key (inventory)
	references Inventory (id) on delete cascade;

delimiter |
DROP PROCEDURE IF EXISTS my_signal|
CREATE PROCEDURE my_signal(in_errortext VARCHAR(255))
BEGIN
   SET @sql=CONCAT('UPDATE `',
            in_errortext,
            '` SET x=1');
   PREPARE my_signal_stmt FROM @sql;
   EXECUTE my_signal_stmt;
   DEALLOCATE PREPARE my_signal_stmt;
END
|
DROP PROCEDURE IF EXISTS modify_onhand|
CREATE PROCEDURE modify_onhand(inventoryId varchar(32), locationId varchar(32), qty double precision)
BEGIN
	DECLARE onhandId bigint DEFAULT NULL;
	DECLARE onhandVersion integer DEFAULT NULL;
	DECLARE updateCount integer DEFAULT NULL;

	SELECT onhand.id, onhand.version INTO onhandId, onhandVersion FROM onhand
		WHERE onhand.location = locationId AND onhand.inventory = inventoryId;

	IF onhandId IS NULL THEN
		INSERT INTO onhand(version, inventory, location, quantity) VALUES(
			0, inventoryId, locationId, qty);
	ELSE
		UPDATE onhand SET quantity=quantity + qty, version=version+1 WHERE
			onhand.id = onhandId AND version = onhandVersion;
		SELECT ROW_COUNT() INTO updateCount;
		IF updateCount IS NULL OR updateCount != 1 THEN
			CALL my_signal('Tidak dapat mengunci onhand. Biasanya hal ini terjadi karena ada beberapa pengguna yang memasukkan data secara bersamaan. Silakan coba beberapa saat kemudian.');
		END IF;
	END IF;
END
|
DROP PROCEDURE IF EXISTS modify_onhand_oldnew|
CREATE PROCEDURE modify_onhand_oldnew(
	oldInventoryId varchar(32), oldLocationId varchar(32), oldQty double precision,
	newInventoryId varchar(32), newLocationId varchar(32), newQty double precision
)
BEGIN
	CALL modify_onhand(oldInventoryId, oldLocationId, -oldQty);
	CALL modify_onhand(newInventoryId, newLocationId, newQty);
END
|


DROP TRIGGER IF EXISTS updateonhand_insert|
CREATE TRIGGER updateonhand_insert BEFORE INSERT ON flow
	FOR EACH ROW CALL modify_onhand(NEW.inventory, NEW.location, NEW.quantity)|
DROP TRIGGER IF EXISTS updateonhand_update|
CREATE TRIGGER updateonhand_update BEFORE UPDATE ON flow
	FOR EACH ROW CALL modify_onhand_oldnew(
	OLD.inventory, OLD.location, OLD.quantity,
	NEW.inventory, NEW.location, NEW.quantity
	)|
DROP TRIGGER IF EXISTS updateonhand_delete|
CREATE TRIGGER updateonhand_delete BEFORE DELETE ON flow
	FOR EACH ROW CALL modify_onhand(OLD.inventory, OLD.location, -OLD.quantity)|

DROP PROCEDURE IF EXISTS synchronize_onhand|
CREATE PROCEDURE synchronize_onhand()
BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE inventoryId VARCHAR(32);
	DECLARE locationId VARCHAR(32);
	DECLARE qtySum DOUBLE PRECISION DEFAULT 0;
	DECLARE oldOnhand DOUBLE PRECISION DEFAULT 0;
	DECLARE cur CURSOR FOR SELECT inventory, location, SUM(quantity) FROM flow GROUP BY inventory,location;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

	OPEN cur;
	REPEAT
		FETCH cur INTO inventoryId, locationId, qtySum;
		IF NOT done THEN
			SELECT coalesce(sum(quantity),0) INTO oldOnhand FROM Onhand WHERE location=locationId
			 	AND inventory=inventoryId;
			CALL modify_onhand_oldnew(inventoryId,locationId,oldOnhand,
				inventoryId,locationId,qtySum);
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur;
END|
delimiter ;
CALL synchronize_onhand();
commit;