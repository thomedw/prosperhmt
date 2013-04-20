begin;
alter table sale modify creditPeriod float;
alter table purchase modify creditPeriod float;
commit;
