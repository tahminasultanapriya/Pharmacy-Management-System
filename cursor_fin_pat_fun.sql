
/*<TOAD_FILE_CHUNK>*/
CREATE OR REPLACE FUNCTION getnum (d_id in buying.id%type)
 RETURN NUMBER IS
  CNT NUMBER:=0;
  CURSOR buy_details IS
  SELECT * FROM buying WHERE d_NHS=d_id;
  B_REC buy_details%ROWTYPE;
  
BEGIN

        OPEN buy_details;
        for iid in 1..10
        LOOP
        FETCH buy_details INTO B_REC;
        EXIT WHEN buy_details%NOTFOUND;
        CNT:=CNT+1;
        END LOOP;
        RETURN CNT;
        CLOSE buy_details;
END;
/


SET SERVEROUTPUT ON
DECLARE 
 dd_name doctor.d_name%type;
 d_id buying.d_NHS%type;
 pt_num integer;
begin
for iid in 1..10
loop
pt_num:=getnum(iid);
select d_name into dd_name from doctor where d_NHS=iid;

DBMS_OUTPUT.PUT_LINE(pt_num||' patients were visited by Dr.'||dd_name);


end loop;
end;
/