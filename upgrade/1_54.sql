create table Account (
	id varchar(255) not null,
	bank varchar(255) not null,
	city varchar(255) not null,
	issuer varchar(255) not null,
	number varchar(255) not null,
	primary key (id),
	unique (bank, number)
) DEFAULT CHARSET=utf8;
alter table buyer
	add account varchar(255);
create table buyer_accounts (
	buyer varchar(255) not null,
	account varchar(255) not null
) DEFAULT CHARSET=utf8;
alter table buyer_accounts
	add index FK28B224F288C1A8DA (buyer),
	add constraint FK28B224F288C1A8DA
	foreign key (buyer)
	references Buyer (id);
alter table buyer_accounts
	add index FK28B224F2B55D2CCE (account),
	add constraint FK28B224F2B55D2CCE
	foreign key (account)
	references Account (id);
