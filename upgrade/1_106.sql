SET AUTOCOMMIT=0;
begin;
alter table sale add transactionAmount decimal(30,2);
alter table salereturn add transactionAmount decimal(30,2);
alter table purchase add transactionAmount decimal(30,2);
alter table purchasereturn add transactionAmount decimal(30,2);
alter table purchasepayment add transactionAmount decimal(30,2);
alter table salepayment add transactionAmount decimal(30,2);
commit;