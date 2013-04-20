begin;

alter table sale
	add column year integer;
alter table sale
	drop index type;
alter table purchase
	add column year integer;
alter table purchase
	drop index type;
update sale set year = 2005 where date < "2006-01-01";
update sale set year = 2006 where date >= "2006-01-01";
update purchase set year = 2005 where date < "2006-01-01";
update purchase set year = 2006 where date >= "2006-01-01";
alter table sale
	modify year integer not null;
alter table purchase
	modify year integer not null;

alter table sale
	add unique(type, computer, year, month, sequence);
alter table purchase
	add unique(type, computer, year, month, sequence);

commit;