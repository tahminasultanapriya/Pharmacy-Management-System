set serveroutput on
declare 

m_id pharmacy.id%type := 3;
m_total pharmacy.total%type;
m_amount buying.amount%type;
m_name pharmacy.name%type;
m_edate pharmacy.exp_date%type;

begin
select id,amount into m_id,m_amount from buying where id=m_id ;
select total,exp_date into m_total,m_edate from pharmacy where id=m_id;
select name into m_name from pharmacy where id=m_id;
m_total:=m_total-m_amount;
dbms_output.put_line('The total amount of '||m_name||' is '||m_total ||' and expire date is '||m_edate);
end;
/