alter table carrier
	add column objectId varchar(255) not null unique;
create index carrier_objectid_idx on carrier(objectid);
alter table inventory
	add creditPeriod int;