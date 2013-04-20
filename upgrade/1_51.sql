begin;
alter table floworder add outstandingQuantity double precision;
create index floworder_outstandingquantity_idx on floworder(outstandingquantity);

commit;