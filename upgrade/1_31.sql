begin;
alter table sale
	add paid bit;
update sale set paid=false;
create index sale_paid_idx on Sale (paid);
alter table sale
	modify paid bit not null;
delete from SalePayment;
alter table SalePayment
	drop
	foreign key FK9304239F35C047;
create table salepayment_sales (
	salePayment varchar(255) not null,
	sale varchar(255) not null
);
alter table salepayment_sales
	add index FK2357ECAC5B307DD8 (sale),
	add constraint FK2357ECAC5B307DD8
	foreign key (sale)
	references Sale (id);
alter table salepayment_sales
	add index FK2357ECAC4D27BB14 (salePayment),
	add constraint FK2357ECAC4D27BB14
	foreign key (salePayment)
	references SalePayment (id);
alter table salepayment
	drop sale;
alter table salepayment
	add  buyer varchar(255) not null;
alter table SalePayment
	add index FK9304239F88C1A8DA (buyer),
	add constraint FK9304239F88C1A8DA
	foreign key (buyer)
	references Buyer (id);
alter table SalePayment
	add salesman varchar(255) not null;
alter table SalePayment
	add index FK9304239FDBF557A8 (salesman),
	add constraint FK9304239FDBF557A8
	foreign key (salesman)
	references Salesman (id);
alter table purchasepayment
	add supplier varchar(255);
update purchasepayment set supplier=(select supplier from purchasepayment_purchases
	where purchasepayment=purchasepayment.id limit 1);
alter table purchasepayment
	modify supplier varchar(255) not null;
alter table PurchasePayment
	add index FK56A009A52EC4E9A4 (supplier), 
	add constraint FK56A009A52EC4E9A4
	foreign key (supplier)
	references Supplier (id);


commit;