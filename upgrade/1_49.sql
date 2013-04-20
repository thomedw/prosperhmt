    create table FlowOrder (
        id varchar(255) not null,
        class varchar(255) not null,
        inventory varchar(255) not null,
        quantity double precision,
        unitPrice double precision,
        unitCost double precision,
        saleOrder varchar(255),
        primary key (id)
    );
    create table SaleOrder (
        id varchar(255) not null,
        buyer varchar(255) not null,
        orderNo varchar(255),
        creditPeriod float,
        paymentMethod varchar(255),
        salesman varchar(255) not null,
        date datetime not null,
        primary key (id)
    );
    create index floworder_class_idx on FlowOrder (class);
    alter table FlowOrder
        add index FK1D2842A0BBB1FE2C (inventory),
        add constraint FK1D2842A0BBB1FE2C
        foreign key (inventory)
        references Inventory (id);

    alter table FlowOrder
        add index FK1D2842A0EC0C87A4 (saleOrder),
        add constraint FK1D2842A0EC0C87A4
        foreign key (saleOrder)
        references SaleOrder (id);
    alter table SaleOrder
        add index FK708B0B27DBF557A8 (salesman),
        add constraint FK708B0B27DBF557A8
        foreign key (salesman)
        references Salesman (id);

    alter table SaleOrder
        add index FK708B0B2788C1A8DA (buyer),
        add constraint FK708B0B2788C1A8DA
        foreign key (buyer)
        references Buyer (id);
