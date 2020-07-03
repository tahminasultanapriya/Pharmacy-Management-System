set serveroutput on
declare 
type namearray is varray(5) of pharmacy.name%type;
m_amount namearray:=namearray();
m_name namearray:=namearray();
iid number(3):=1;
begin
while iid<=5
loop
m_amount.extend;
m_name.extend;
select name,total into m_name(iid),m_amount(iid) from pharmacy where id=iid;
iid:=iid+1;
end loop;
for iid in 1..5
loop
if(m_amount(iid)>=20)
  then
   dbms_output.put_line(m_name(iid)||' has enough stock');
  else if(m_amount(iid)=0)
 then 
    dbms_output.put_line(m_name(iid)||' is out of stocK');
 else if (m_amount(iid)<20)
 then
   dbms_output.put_line(m_name(iid)||' is running out of stock');
 
   end if;
   end if;
   end if;
   end loop;

 
end;
/
