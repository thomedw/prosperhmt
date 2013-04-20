begin;
    create table purchasepayment_purchases (
        purchasePayment varchar(255) not null,
        purchase varchar(255) not null
    );

    alter table PurchasePayment
        drop
        foreign key FK56A009A567E90501;
    alter table purchasepayment_purchases
        add index FK680DF5B819E3524C (purchase),
        add constraint FK680DF5B819E3524C
        foreign key (purchase)
        references Purchase (id);
    alter table purchasepayment_purchases
        add index FK680DF5B88D66BC20 (purchasePayment),
        add constraint FK680DF5B88D66BC20
        foreign key (purchasePayment)
        references PurchasePayment (id);

insert into purchasepayment_purchases(purchasePayment,purchase)
	select id,purchase from purchasepayment;
alter table purchasePayment drop purchase;
commit;