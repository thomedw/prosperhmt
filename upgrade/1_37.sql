begin;
delimiter //
create procedure upgrade_creation_date()
begin
	declare inventoryId varchar(255);
	declare ts timestamp;
	declare TotalTableRows bigint;
	declare tempRowId bigint;
	declare tempRowCount bigint default 0;
/*	call debug.debug_on('u');*/
	create temporary table temptable (
		rowId int(11) not null auto_increment,
		id varchar(255) not null,
		primary key(rowId)
	) engine=innodb;
	insert into temptable(id)(
		select id from inventory where creationdate is null	
	);
	SELECT COUNT(*) AS RowCount INTO TotalTableRows FROM tempTable;
	select TotalTableRows;
	SELECT MIN(rowId) INTO tempRowId FROM tempTable;
	select tempRowId;
	select tempRowCount;
	WHILE (tempRowCount < TotalTableRows) DO
		SELECT id INTO inventoryId FROM tempTable where rowId = tempRowId;
	/*Explanation Reference 2*/
	IF ISNULL(inventoryId) = 0 THEN
		SET tempRowCount = tempRowCount + 1;
/*		call debug.debug_insert('u', concat('The inventory id is',inventoryId));*/
		select date into ts from purchase join flow on purchase.id=flow.purchase where flow.inventory=inventoryId order by purchase.date limit 1;
/*		select inventoryId, ts;*/
/*		call debug.debug_insert('u', concat('The timestamp is',ts));
		call debug.debug_insert('u', concat('The date is',date(ts)));*/
		update inventory set creationDate=date(ts) where id=inventoryId;
	END IF;
	SET tempRowId = tempRowId + 1;
	END WHILE;
	drop table temptable;
/*	call debug.debug_off('u');*/
end;//
delimiter ;//
call upgrade_creation_date();
drop procedure upgrade_creation_date;

alter table inventory add artNo varchar(255) unique;
create unique index inventory_artno_idx on Inventory (artNo);

commit;