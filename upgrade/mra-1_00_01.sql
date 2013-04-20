create table accounting_account ( id varchar(32) not null, versionTimestamp datetime not null, dataDigest varchar(255), number varchar(255), name varchar(255), description varchar(255), accountType varchar(255), balanceCategory varchar(255), profitCategory varchar(255), parent varchar(32), primary key (id) );

create table accounting_flow ( id varchar(32) not null, versionTimestamp datetime not null, dataDigest varchar(255), account varchar(32) not null, subaccount varchar(32) not null, amountVariance decimal(25,2) not null, onHandAmount decimal(25,2) not null, message varchar(255), transactionDate date, number varchar(255), note varchar(1000), voucherNo varchar(255), primary key (id) );

create table accounting_onhand ( id bigint not null auto_increment, version integer not null, amount decimal(19,2), account varchar(32) not null, subaccount varchar(32), primary key (id), unique (account, subaccount) );

create table accounting_subaccount ( id varchar(32) not null, versionTimestamp datetime not null, dataDigest varchar(255), code varchar(255), name varchar(255), description varchar(255), account varchar(32), primary key (id) );

alter table accounting_account add index FK8F40E83B584334A (parent), add constraint FK8F40E83B584334A foreign key (parent) references accounting_account (id);

alter table accounting_flow add index FK3627CC98F4612E87 (subaccount), add constraint FK3627CC98F4612E87 foreign key (subaccount) references accounting_subaccount (id);

alter table accounting_flow add index FK3627CC98AAACB4CD (account), add constraint FK3627CC98AAACB4CD foreign key (account) references accounting_account (id);

alter table accounting_onhand add index FK5ADB5FB8F4612E87 (subaccount), add constraint FK5ADB5FB8F4612E87 foreign key (subaccount) references accounting_subaccount (id);

alter table accounting_onhand add index FK5ADB5FB8AAACB4CD (account), add constraint FK5ADB5FB8AAACB4CD foreign key (account) references accounting_account (id);

alter table accounting_subaccount add index FK175357D7AAACB4CD (account), add constraint FK175357D7AAACB4CD foreign key (account) references accounting_account (id);

