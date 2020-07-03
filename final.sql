set serveroutput on 
create or replace trigger billm
	before insert or update of bill on buying for each row
        declare
        m_price pharmacy.price%type;
        m_amount pharmacy.total%type;
        m_id pharmacy.id%type;
        iid number(2):=1;	
        medi_bill integer;
        bill integer;

        begin
        
       :new.id:=iid;
        select id,price into m_id,m_price from pharmacy where id=:new.id;
        medi_bill:=m_price*(:new.amount);

        if(medi_bill>=1000)
        then
        bill:=(medi_bill-medi_bill*(.25));
         :new.m_comment:='25% Discount';
         :new.bill:=bill;
         
         else if(medi_bill>=400)
        then
        bill:=(medi_bill-medi_bill*(.20));
         :new.m_comment:='20% Discount';
         :new.bill:=bill;
         else if(medi_bill>=300)
        then
        bill:=(medi_bill-medi_bill*(.15));
         :new.m_comment:='15% Discount';
         :new.bill:=bill;
         m_amount:=m_amount-:new.amount;
        update pharmacy set total=m_amount where id=:new.id;
        else if(medi_bill>=200)
        then
        bill:=(medi_bill-medi_bill*(.10));
         :new.m_comment:='10% Discount';
         :new.bill:=bill;
         else if(medi_bill>=100)
        then
        bill:=(medi_bill-medi_bill*(.05));
         :new.m_comment:='5% Discount';
         :new.bill:=bill;
        else if(medi_bill<100)
        then
   bill:=(medi_bill-medi_bill*(0));
    :new.m_comment:='No Discount';
         :new.bill:=bill;
        end if;
        end if;
        end if;
        end if;
        end if;


        end if; 

        
    end;
    /



set serveroutput on 
create or replace trigger target1
	before insert or update of m_profit on pharmacy for each row
        declare

        target_bill integer;
      
        buying_bill integer;
        begin
     
        target_bill:=(:new.target_sell*:new.price);
        buying_bill:=(:new.total*:new.buy);
     
        :new.m_profit:=target_bill-buying_bill;
       
        
        
        
        
        
           end;
    /
