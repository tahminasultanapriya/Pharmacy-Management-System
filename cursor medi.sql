SET SERVEROUTPUT ON
DECLARE
     CURSOR  billl IS SELECT bill FROM buying;
  bill_record billl%ROWTYPE;

BEGIN
OPEN billl;
      LOOP
        FETCH  billl INTO  bill_record;
        EXIT WHEN billl%ROWCOUNT > 5;
      
      END LOOP;
      CLOSE billl;
      end;
      /   
