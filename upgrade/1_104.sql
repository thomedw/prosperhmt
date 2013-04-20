SET AUTOCOMMIT=0;
begin;
alter table sale add confirmed bit;
update sale set confirmed=true where confirmed is null;
alter table sale modify confirmed bit not null;
alter table flow add unconfirmedQuantity double precision;
end;