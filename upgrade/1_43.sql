begin;
alter table inventory
	add replacementCost integer,
	add lastReplacementCostUpdate datetime;
create table inventory_oldReplacementCosts (
	inventory varchar(255) not null,
	date datetime not null,
	cost integer not null
);
alter table inventory_oldReplacementCosts
	add index FKCE682C38BBB1FE2C (inventory),
	add constraint FKCE682C38BBB1FE2C
	foreign key (inventory)
	references Inventory (id);
commit;