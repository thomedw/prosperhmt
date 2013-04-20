begin;
create table Giro (
   id varchar(255) not null,
   amount integer not null,
   bank varchar(255),
   issueDate date not null,
   issuer varchar(255),
   maturity date not null,
   number varchar(255) not null unique,
   selfIssued bit not null,
   primary key (id)
);
create index giro_issuer_idx on Giro (issuer);
create index giro_issuedate_idx on Giro (issueDate);
create index giro_number_idx on Giro (number);

create table salepayment_giro_giros (
   salepayment varchar(255) not null,
   giro varchar(255) not null,
   primary key (salepayment, giro)
);
create table purchasepayment_giro_giros (
   purchasepayment varchar(255) not null,
   giro varchar(255) not null,
   primary key (purchasepayment, giro)
);

alter table salepayment_giro_giros add index FKCAF0A474CC61E3DF (salepayment), add constraint FKCAF0A474CC61E3DF foreign key (salepayment) references SalePayment (id);
alter table salepayment_giro_giros add index FKCAF0A474306A9F (giro), add constraint FKCAF0A474306A9F foreign key (giro) references Giro (id);
alter table purchasepayment_giro_giros add index FK7BA5EEAE2ED4B9E5 (purchasepayment), add constraint FK7BA5EEAE2ED4B9E5 foreign key (purchasepayment) references PurchasePayment (id);
alter table purchasepayment_giro_giros add index FK7BA5EEAE306A9F (giro), add constraint FK7BA5EEAE306A9F foreign key (giro) references Giro (id);

alter table PurchasePayment change amount cashAmount integer;
alter table SalePayment change amount cashAmount integer;

create table Clearing (
   id varchar(255) not null,
   giro varchar(255) not null unique,
   date datetime not null,
   primary key (id)
);
alter table Clearing add index FK32F58695306A9F (giro), add constraint FK32F58695306A9F foreign key (giro) references Giro (id);
alter table sale modify creditPeriod float;
alter table purchase modify creditPeriod float;
commit;