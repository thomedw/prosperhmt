alter table Inventory add unit2 varchar(20), add wrappingContent2 float;
update Inventory set unit2=unit, unit=packaging, packaging=unit2, wrappingContent2=wrappingContent, wrappingContent=packetContent, packetContent=wrappingContent2;
alter table Inventory drop column unit2, drop column wrappingContent2;
alter table Inventory add unique(name, type);
create table IdMigration (
   id varchar(255) not null,
   newIdentifier varchar(255) not null,
   oldIdentifier varchar(255) not null,
   persistentClass varchar(255) not null,
   primary key (id),
   unique (oldIdentifier, persistentClass)
);
alter table Purchase
	add invoiceDate date not null,
	add unique (type, computer, month, sequence);

update Purchase set invoiceDate=date;
update Sale set salesman=(select salesman.id from salesman where salesman.name='TUNAI' limit 1) where salesman is null;
alter table Sale
	add unique (type, computer, month, sequence),
	modify salesman varchar(255) not null;

alter table Flow
	add saleFlow varchar(255),
	add index FK21754E735FBA15 (saleFlow),
	add constraint FK21754E735FBA15 foreign key (saleFlow) references Flow (id);
alter table sale modify creditPeriod float;
alter table purchase modify creditPeriod float;