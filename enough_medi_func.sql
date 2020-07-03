/*<TOAD_FILE_CHUNK>*/
CREATE OR REPLACE FUNCTION medi_stock
 RETURN NUMBER IS
    m_id pharmacy.id%type := 3;
    m_total pharmacy.total%type;
    m_name pharmacy.name%type;
    m_amount buying.amount%type;
BEGIN
    select id,amount into m_id,m_amount from buying where id=m_id ;
    select total into m_total from pharmacy where id=m_id;
    select name into m_name from pharmacy where id=m_id;
    m_total:=m_total-m_amount;
    RETURN m_total;
END;
/

/*<TOAD_FILE_CHUNK>*/
SET SERVEROUTPUT ON
declare
total number(4);
BEGIN
total:= medi_stock;
if(total>=20)
  then
   dbms_output.put_line(' Has enough stock');
  else if(total=0)
 then 
    dbms_output.put_line(' Is out of stock');
 else if (total<20)
 then
   dbms_output.put_line(' Running out of stock');
 
   end if;
   end if;
   end if;

END;
/

