begin;
alter table supplier add bulkPricePercent integer;
alter table supplier add boxPricePercent integer;
alter table supplier add retailPricePercent integer;
commit;