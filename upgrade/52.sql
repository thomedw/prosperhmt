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