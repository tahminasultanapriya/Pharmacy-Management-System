    set serveroutput on 
create or replace trigger profit_loss
	before insert or update of m_profit,m_loss on pharmacy for each row
        declare
        m_amount buying.amount%type;
        m_id buying.id%type;
        m_date buying.b_date%type;
        medi_bill number(20);
        targets integer;
        bill integer;
        begin
        select id,amount into m_id,m_amount from buying where m_date like '%Jan%';
        select :new.total,:new.target_sell,:new.buy,:new.price from pharmacy where id=:new.id;
        medi_bill:=(:new.price*:new.target_sell);
        bill:=(:new.price*m_amount);
        if(bill>medi_bill)
        then
        :new.m_profit:=bill-medi_bill;
        else
        :new.m_loss:=medi_bill-bill;
        end if;
        end;
    /