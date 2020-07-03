CREATE procedure requested  IS
type namearray is varray(10) of request.status%type;
r_status namearray:=namearray();
r_pNHS namearray:=namearray();
iid number(3);

BEGIN
        for iid in 1..10
        loop
        r_status.extend;
        r_pNHS.extend;
        select p_NHS,status into r_status(iid),r_pNHS(iid)from request where d_NHS=iid;
        end loop;

        for iid in 1..10
        loop
        if(r_pNHS(iid)='approved')
        then
         dbms_output.put_line('request status patient id p_NHS= '||r_status(iid)|| ' ' ||r_pNHS(iid));

        end if; 
        end loop;
         
 END;
 /
SHOW ERRORS;
BEGIN
   requested;
END;
/