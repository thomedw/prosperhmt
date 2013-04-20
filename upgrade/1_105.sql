SET AUTOCOMMIT=0;
begin;
alter table inventory add defaultpurchaseunit varchar(255);
alter table inventory add defaultsaleunit varchar(255);
alter table flow add unit varchar(255);
commit;