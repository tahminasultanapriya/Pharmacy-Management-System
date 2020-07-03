set serveroutput on
declare 
s_status request.status%type:='approved';
begin
select status into s_status from request where status='approved';
if(s_status=status)
  then
   dbms_output.put_line('the number of male is high');
  else
    dbms_output.put_line('the number of female is high');

end if;
end;
/
