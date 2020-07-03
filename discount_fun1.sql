CREATE OR REPLACE FUNCTION medi_stock(m_id in pharmacy.id%type,
 m_amount in buying.amount%type)
 RETURN NUMBER IS
  m_total pharmacy.total%type;
  
BEGIN
    select id,amount into m_id,m_amount from buying where id=m_id ;
    select total into m_total from pharmacy where id=m_id;
    m_total:=m_total-m_amount;
    RETURN m_total;
END;
/
set serveroutput on
declare 
type namearray is varray(5) of pharmacy.name%type;
m_amount namearray:=namearray();
m_name namearray:=namearray();
total namearray:=namearray();
iid number(3):=1;
begin
while iid<=5
loop
m_amount.extend;
m_name.extend;
select id,name,total into m_name(iid),m_amount(iid) from pharmacy where id=iid;
total(iid):=medi_stock(id,m_amount(iid));
iid:=iid+1;
end loop;
for iid in 1..5
loop
if(total(iid)>=20)
  then
   dbms_output.put_line(' Has enough stock');
  else if(total(iid)=0)
 then 
    dbms_output.put_line(' Out of stock');
 else if (total(iid)<20)
 then
   dbms_output.put_line(' Running out of stock');
 
   end if;
   end if;
   end if;
end loop;
END;
/
