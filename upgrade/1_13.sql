begin;
alter table inventory
	add retailPrice integer;
update inventory set retailPrice=round(1.1*boxedPrice) where retailPrice is null;
alter table purchase
	add discount float;
commit;