set serveroutput on 
create or replace trigger billm
	before insert or update of bill on buying for each row

        begin
      

        if(:new.amount>=1)
        then
         :new.bill:=100;
        else
       

         :new.bill:=10;
        end if;
    end;
    /

