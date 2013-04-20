begin;
alter table inventory add creationdate date;
create index inventory_creationdate_idx on Inventory (creationDate);
commit;