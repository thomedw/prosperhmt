SET AUTOCOMMIT=0;
begin;
alter table opname add opnameDate date;
update opname set opnameDate = date where opnameDate is null;

update inventory set boxedprice=1 where boxedPrice=0;
update inventory set bulkprice=1 where bulkPrice=0;
update inventory set retailprice=1 where retailPrice=0;
commit;