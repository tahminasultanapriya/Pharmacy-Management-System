/*<TOAD_FILE_CHUNK>*/
SET SERVEROUTPUT ON;
CREATE OR REPLACE procedure profit1 IS
type namearray is varray(10) of pharmacy.price%type;
type namearray1 is varray(10) of pharmacy.name%type;
m_price namearray:=namearray();
m_amount namearray:=namearray();
b_price namearray:=namearray();
m_total namearray:=namearray();
m_id namearray:=namearray();
m_name namearray1:=namearray1();
iid number(4);
x number(2):=0;
total number(3);

begin
           for iid in 1..10
           loop 
           m_name.extend;
           select name into m_name(iid) from pharmacy where id=iid;
           
           end loop;
             for iid in 1..10
            loop
               dbms_output.put_line('Name of the medicine '||m_name);
               end loop;
            
           
           

            for iid in 1..10
            loop
            m_price.extend;
            m_amount.extend;
            m_id.extend;
            b_price.extend;
            m_total.extend;
            select sum(amount) into m_amount(iid) from buying where p_NHS=iid;
            select id,amount into m_id(iid),m_amount(iid) from buying where p_NHS=iid;
            select price,buy into m_price(iid),b_price from pharmacy where m_id(iid)=id;
            m_price(iid):=m_price(iid)*m_amount(iid);
            b_price(iid):=b_price(iid)*m_amount(iid);
            end loop;
            for iid in 1..10
            loop
            if(m_price(iid)>=b_price(iid))
            then
              x:=1;
            else 
              x:=0;
            end if;
            
        if(total=1)
  then
    dbms_output.put_line('Enough Profit');
  else
    dbms_output.put_line('Loss');

   end if;
             end loop;

end;
/

/*<TOAD_FILE_CHUNK>*/
BEGIN

profit1;

  

END;
/

