SET AUTOCOMMIT=0;
begin;
create index flow_unitcost_idx on flow(unitcost);
commit;
