set serveroutput on
create or replace trigger proloss 
before insert or update of m_profit,m_loss on pharmacy for each row
declare
medi_bill integer;
target_bill integer;
buying_bill integer;
bill_value integer;
begin
bill_value:= getvalue(:new.id);
target_bill:= :new.target_sell*:new.price;
buying_bill:= :new.total*:new.buy;
if(medi_bill>target_bill)
then
if(medi_bill>buying_bill)
then
:new.m_profit:= medi_bill-buying_bill;
else 
:new.m_loss:= buying_bill-medi_bill;
end if;
else 
:new.m_loss:= buying_bill-medi_bill;
end if;

end;
/