set serveroutput on 
create or replace trigger billm
	before insert or update of bill on buying for each row
        declare
        m_price pharmacy.price%type;
        m_id pharmacy.id%type;
        iid number(2):=1;	
        medi_bill integer;
        bill integer;

        begin
        
       :new.id:=iid;
        select id,price into m_id,m_price from pharmacy where m_id=:new.id;
        medi_bill:=m_price*(:new.amount);

        if(medi_bill>=1000)
        then
        bill:=(medi_bill-medi_bill*(.25));
         :new.bill:=bill;
         else if(medi_bill>=400)
        then
        bill:=(medi_bill-medi_bill*(.20));
         :new.bill:=bill;
         else if(medi_bill>=300)
        then
 bill:=(medi_bill-medi_bill*(.15));
         :new.bill:=bill;
        else if(medi_bill>=200)
        then
 bill:=(medi_bill-medi_bill*(.10));
         :new.bill:=bill;
         else if(medi_bill>=100)
        then
 bill:=(medi_bill-medi_bill*(.05));
         :new.bill:=bill;
        else if(medi_bill<100)
        then
   bill:=(medi_bill-medi_bill*(0));
         :new.bill:=bill;
        end if;
        end if;
        end if;
        end if;
        end if;


        end if; 
    end;
    /
