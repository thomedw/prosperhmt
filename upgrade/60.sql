begin;
create table Bonus (
    id varchar(255) not null,
    date datetime not null,
    amount integer not null,
    salesman varchar(255) not null,
    primary key (id)
);
create table Expense (
    id varchar(255) not null,
    amount integer not null,
    date datetime not null,
    category varchar(255) not null,
    description varchar(255),
    primary key (id)
);
create table ExpenseCategory (
    id varchar(255) not null,
    name varchar(255) not null unique,
    description varchar(255),
    primary key (id)
);
create table SalesmanPayoff (
    id varchar(255) not null,
    date datetime not null,
    description varchar(255),
    amount integer not null,
    salesman varchar(255) not null,
    primary key (id)
);

create index bonus_date_idx on Bonus (date);
alter table Bonus
    add index FK3D62FFFDBF557A8 (salesman),
    add constraint FK3D62FFFDBF557A8
    foreign key (salesman)
    references Salesman (id);
create index expense_date_idx on Expense (date);
alter table Expense
    add index FK152D6038BB3332E8 (category),
    add constraint FK152D6038BB3332E8
    foreign key (category)
    references ExpenseCategory (id);
create index salesman_payoff_idx on SalesmanPayoff (date);
alter table SalesmanPayoff
    add index FK1B2DF255DBF557A8 (salesman),
    add constraint FK1B2DF255DBF557A8
    foreign key (salesman)
    references Salesman (id);
alter table Sale
    add paymentMethod varchar(255);
alter table flow
	add purchaseFlow varchar(255);
alter table Flow
    add index FK21754EF86AC2C8 (purchaseFlow),
    add constraint FK21754EF86AC2C8
    foreign key (purchaseFlow)
    references Flow (id);

create index subentry_className_idx on Subentry (className);
create index subentry_refererId_idx on Subentry (refererId);
commit;