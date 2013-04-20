begin;
    create table Location (
        id varchar(32) not null,
        name varchar(255) not null unique,
        description varchar(255),
        active bit not null,
        primary key (id)
    );

commit;