delimiter |
begin|
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
			update `ERROR: *onhand_lock_error*` set x = 1;
		END IF;
	END IF;
END
|
commit|