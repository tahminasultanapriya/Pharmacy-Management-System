/*<TOAD_FILE_CHUNK>*/
CREATE OR REPLACE FUNCTION compare
(m_amount in buying.amount%type,
p_amount in pharmacy.total%type)
 RETURN NUMBER IS
 x number(1):=0;
BEGIN
    select id,amount into m_id,m_amount from buying where id=m_id ;
    select total,name into p_amount,p_name from pharmacy where id=m_id;
    
    if(p_amount>m_amount)
    then
    x:=x+1;
    else
    x:=0;
    end if;   
    return x;   
END;
/

/*<TOAD_FILE_CHUNK>*/
SET SERVEROUTPUT ON
declare
total number(3);
m_id buying.id%type:=3 ;
m_amount buying.amount%type;
p_name pharmacy.name%type;
p_amount pharmacy.total%type;
BEGIN
select id,amount into m_id,m_amount from buying where id=m_id ;
select total,name into p_amount,p_name from pharmacy where id=m_id;
total:=compare(m_amount,p_amount);
if(total=1)
  then
    dbms_output.put_line('The amount of medicine you want to buy is '||m_amount);
    dbms_output.put_line('The amount of medicine have in our stock is '||p_amount);
  
   dbms_output.put_line(p_name||' Medicine is availabe.You can Buy this medicine ');
  else
        dbms_output.put_line('The amount of medicine you want to buy is '||m_amount);
      dbms_output.put_line('The amount of medicine have in our stock is '||p_amount);
      dbms_output.put_line(p_name||' Medicine is not enough in our stock. Sorry now you cannot buy this medicine ');
   end if;
  

END;
/

