begin;
alter table buyer add salesman varchar(255);
alter table Buyer
    add index FK3D91193DBF557A8 (salesman),
    add constraint FK3D91193DBF557A8
    foreign key (salesman)
    references Salesman (id);

commit;