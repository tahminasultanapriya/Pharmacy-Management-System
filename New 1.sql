set serveroutput on
declare 
type namearray is varray(5) of pharmacy.m_name%type;
mm_name namearray:=namearray();
type namearray1 is varray(5) of pharmacy.total%type;
m_amount namearray1:=namearray1();
iid number(2);

begin
for iid in 1..5
loop
mm_name.extend;
m_amount.extend;
select m_name,total into mm_name(iid),m_amount(iid)from pharmacy where id=iid;
end loop;

for iid in 1..5
loop

 dbms_output.put_line('request status patient id p_NHS= '||mm_name(iid)|| ' ' ||m_amount(iid));
 
end loop;
 
 end;
 /