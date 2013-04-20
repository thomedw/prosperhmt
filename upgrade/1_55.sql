begin;
alter table giro drop issuer;
alter table account drop issuer;
alter table buyer_accounts add unique(account);
commit;