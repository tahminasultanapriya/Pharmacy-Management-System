/*<TOAD_FILE_CHUNK>*/
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE getdiscount IS 
type namearray is varray(10) of pharmacy.price%type;
m_price namearray:=namearray();
m_amount namearray:=namearray();
m_total namearray:=namearray();
m_id namearray:=namearray();
iid number(4);
begin
for iid in 1..10
loop
m_price.extend;
m_amount.extend;
m_id.extend;
m_total.extend;
select sum(amount) into m_amount(iid) from buying where p_NHS=iid;
select id,amount into m_id(iid),m_amount(iid) from buying where p_NHS=iid;
select price into m_price(iid) from pharmacy where m_id(iid)=id;
m_price(iid):=m_price(iid)*m_amount(iid);
end loop;
for iid in 1..10
loop
if(m_price(iid)>=1000)
then
  dbms_output.put_line(iid||'  Here discount is 25% ' );
 dbms_output.put_line('   Total amount of medicine='||m_amount(iid));
 dbms_output.put_line('   The bill is '||(m_price(iid)));
 dbms_output.put_line('   Discounted bill is '||(m_price(iid)-m_price(iid)*(.05)));
 else if(m_price(iid)>=400)
then
 dbms_output.put_line(iid||'  Here discount is 20% ' );
 dbms_output.put_line('   Total amount of medicine='||m_amount(iid));
 dbms_output.put_line('   The bill is '||(m_price(iid)));
 dbms_output.put_line('   Discounted bill is '||(m_price(iid)-m_price(iid)*(.05)));
 else if(m_price(iid)>=300)
then
  dbms_output.put_line(iid||'  Here discount is 15% ' );
 dbms_output.put_line('   Total amount of medicine='||m_amount(iid));
 dbms_output.put_line('   The bill is '||(m_price(iid)));
 dbms_output.put_line('   Discounted bill is '||(m_price(iid)-m_price(iid)*(.05)));

else if(m_price(iid)>=200)
then
 dbms_output.put_line(iid||'  Here discount is 10% ' );
 dbms_output.put_line('   Total amount of medicine='||m_amount(iid));
 dbms_output.put_line('   The bill is '||(m_price(iid)));
 dbms_output.put_line('   Discounted bill is '||(m_price(iid)-m_price(iid)*(.1)));
 else if(m_price(iid)>=100)
then
 dbms_output.put_line(iid||'  Here discount is 5% ' );
 dbms_output.put_line('   Total amount of medicine='||m_amount(iid));
 dbms_output.put_line('   The bill is '||(m_price(iid)));
 dbms_output.put_line('   Discounted bill is '||(m_price(iid)-m_price(iid)*(.05)));
else if(m_price(iid)<100)
then
  dbms_output.put_line(iid||'  No discount' );
 dbms_output.put_line('   Total amount of medicine='||m_amount(iid));
 dbms_output.put_line('   The bill is '||(m_price(iid)));
 dbms_output.put_line('   Discounted bill is '||(m_price(iid)-m_price(iid)*(.05)));
end if;
end if;
end if;
end if;
end if;


end if; 
end loop;
 
END;
/

/*<TOAD_FILE_CHUNK>*/
SHOW ERRORS;
BEGIN
   getdiscount;
END;
/

