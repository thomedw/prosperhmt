begin;
alter table flow
	add unitCost double precision;
update flow set unitPrice = (select boxedPrice / 1.22 from inventory where inventory.id = flow.inventory) where class like '%OpnameFlow';
drop table subentry;
drop table entry;
drop table account;
commit;