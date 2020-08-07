create sequence hibernate_sequence start 1 increment 1;

create table dt_user
(
    id              int8    not null,
    activation_code varchar(255),
    active          boolean not null,
    email           varchar(255),
    password        varchar(255) not null,
    username        varchar(255) not null,
    primary key (id)
);

create table dt_user_role
(
    dsid_user int8 not null,
    roles     varchar(255)
);

create table dt_message
(
    id        int8 not null,
    filename  varchar(255),
    tag       varchar(255),
    text      varchar(2048) not null,
    dsid_user int8,
    primary key (id)
);

alter table if exists dt_user_role
    add constraint dt_user_role_dsid_user_fkey foreign key (dsid_user) references dt_user;


alter table if exists dt_message
    add constraint dt_message_dsid_user_fkey foreign key (dsid_user) references dt_user;