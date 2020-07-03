SET SERVEROUTPUT ON
DECLARE 
 dd_name doctor.d_name%type;
 d_id buying.d_NHS%type:=1;
CNT NUMBER:=0;
CURSOR buy_details IS
SELECT * FROM buying WHERE d_NHS=d_id;
buy_record buy_details%ROWTYPE;
BEGIN
OPEN buy_details;
LOOP
FETCH buy_details INTO buSET SERVEROUTPUT ON
DECLARE
CNT NUMBER:=0;
dd_name doctor.d_name%type;



CURSOR buy_details IS
SELECT * FROM buying WHERE d_NHS=1;
B_REC buy_details%ROWTYPE;
BEGIN
OPEN buy_details;
for iid 1..10
LOOP
FETCH buy_details INTO B_REC;
EXIT WHEN buy_details%NOTFOUND;
CNT:=CNT+1;
END LOOP;
select d_name into dd_name from doctor where d_NHS=1;
DBMS_OUTPUT.PUT_LINE(CNT||' patients were visited by Dr. '||dd_name);
CLOSE buy_details;
END;
/


y_record;
EXIT WHEN buy_details%NOTFOUND;
select d_name into dd_name from doctor where d_NHS=d_id;
CNT:=CNT+1;
END LOOP;
DBMS_OUTPUT.PUT_LINE(CNT||' Patient are visited by Dr. '||dd_name);
CLOSE buy_details;
END;
/