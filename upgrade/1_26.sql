begin;
alter table purchase
	add paid bit not null;
create index purchase_paid_idx on Purchase (paid);
alter table purchase modify creditPeriod float;
alter table sale modify creditPeriod float;
update flow set unitcost=null where id='ff8080810b8e7ba2010b8e890b20000c';
commit;