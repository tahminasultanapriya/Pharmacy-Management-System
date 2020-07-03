set serveroutput on 
create or replace trigger billm
	before insert on buying for each row
        declare
        m_price pharmacy.price%type;
        m_id pharmacy.id%type;
        iid integer:=1;
        begin
        :new.id:=iid;
        select price into m_price from pharmacy where m_id=:new.id;
        :new.bill:=m_price*(:new.amount);

        if(:new.bill>=1000)
        then
         :new.bill:=(:new.bill-:new.bill*(.25));
         else if(:new.bill>=400)
        then
        
         :new.bill:=(:new.bill-:new.bill*(.2));
         else if(medi_bill>=300)
        then

         :new.bill:=(:new.bill-:new.bill*(.15));
        else if(medi_bill>=200)
        then

         :new.bill:=(:new.bill-:new.bill*(.10));
         else if(medi_bill>=100)
        then

         :new.bill:=(:new.bill-:new.bill*(.05));
        else if(medi_bill<100)
        then
   
         :new.bill:=(:new.bill-:new.bill*(0));
        end if;
        end if;
        end if;
        end if;
        end if;


        end if; 
    end;
    /