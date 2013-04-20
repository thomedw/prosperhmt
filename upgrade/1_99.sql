SET AUTOCOMMIT=0;
begin;
delete from onhand where location is null;
alter table onhand modify location varchar(32) not null;
end;