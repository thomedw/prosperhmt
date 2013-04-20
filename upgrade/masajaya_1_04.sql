SET AUTOCOMMIT=0;
begin;
alter table buyer add priceBase varchar(255);
alter table opname modify opnameDate date;
commit;