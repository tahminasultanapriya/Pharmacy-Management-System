set serveroutput on
create or replace trigger target 
before insert or update of target_sell on pharmacy for each row
declare

begin
:new.target_sell:=:new.total*.8;

end;
/