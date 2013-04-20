begin;
alter table inventory add lastPriceUpdate datetime;
update inventory set lastPriceUpdate='2006-01-01';
create index inventory_lastpriceppdate_idx on inventory(lastPriceUpdate);
commit;