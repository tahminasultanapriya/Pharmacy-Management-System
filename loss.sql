set serveroutput on 
create or replace trigger target1
	before insert or update of m_profit on pharmacy for each row
        declare

        target_bill integer;
        iid number(2):=1;	
        buying_bill integer;
        begin
        :new.id:=iid;
        target_bill:=(:new.target_sell*:new.price);
        buying_bill:=(:new.total*:new.buy);
     
        :new.m_profit:=target_bill-buying_bill;
       
        
        
        
        
        
           end;
    /
