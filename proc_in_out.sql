

/*<TOAD_FILE_CHUNK>*/
CREATE OR REPLACE PROCEDURE compare2(m_id in number,p_amount out number) IS 

BEGIN
    select total into p_amount from pharmacy where id=m_id;  
END;
/


set serveroutput on
declare
m_id buying.id%type;
m_amount buying.amount%type;
p_amount pharmacy.total%type:=null;
p_name pharmacy.name%type;
iid number(4):=1;
BEGIN
    while iid<=10
        loop
    
        select amount into m_amount from buying where id=iid ;
        select name into p_name from pharmacy where id=iid;
        compare2(m_id,p_amount);

if(m_amount<p_amount)
           
          then
            dbms_output.put_line(' The amount of medicine you want to buy is '||m_amount);
            dbms_output.put_line('   The amount of medicine have in our stock is '||p_amount);
          
           dbms_output.put_line('   '||p_name||' Medicine is availabe.You can Buy this medicine ');
           p_amount:=p_amount-m_amount;
            update pharmacy set total=p_amount where id=m_id;
          
            select total into p_amount from pharmacy where id=m_id ;
           
              commit;
             
           
           
           
          else
                dbms_output.put_line(' The amount of medicine you want to buy is '||m_amount);
              dbms_output.put_line('   The amount of medicine have in our stock is '||p_amount);
              dbms_output.put_line('   '||p_name||' Medicine is not enough in our stock. Sorry now you cannot buy this medicine ');
           end if;
            dbms_output.put_line('  The amount of medicine after buying is '||p_amount);
            iid:=iid+1;
            end loop;
           
           
          

        


END;
/

