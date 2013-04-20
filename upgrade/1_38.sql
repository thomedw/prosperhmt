begin;

alter table buyer modify name varchar(255) not null;
alter table supplier modify name varchar(255) not null;

commit;