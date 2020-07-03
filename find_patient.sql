set serveroutput on
declare 

d_id doctor.d_NHS%type := 1;
p_id patient.p_NHS%type;
pp_name patient.p_name%type;


begin

select p_NHS into p_id from buying where d_NHS=d_id ;
select p_name into pp_name from patient where p_NHS=p_id;
 dbms_output.put_line('The patient under the doctor name is '||pp_name);

end;
/
