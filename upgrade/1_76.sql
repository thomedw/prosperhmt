begin;
alter table flow add transfer varchar(32);
create table Transfer (
	id varchar(32) not null,
	date datetime not null,
	primary key (id)
);

alter table Flow
	add index FK21754EE2C2B820 (transfer),
	add constraint FK21754EE2C2B820
	foreign key (transfer)
	references Transfer (id);

create index transfer_date_idx on Transfer (date);
commit;