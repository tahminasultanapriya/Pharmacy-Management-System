set serveroutput on
declare
   f utl_file.file_type;
   line varchar(1000);
   d_NHS doctor1.d_NHS%type;
   d_name doctor1.d_name%type;
   d_address doctor1.d_address%type;
   hospital_name doctor1.hospital_name%type;
   d_department DOCTOR1.D_DEPARTMENT%type;
   visiting_hours DOCTOR1.VISITING_HOURS%type;
   d_contact DOCTOR1.D_CONTACT%type;
begin
    f :=utl_file.fopen('DATABASE','doctor.csv','r');
    if utl_file.is_open(f) then
        utl_file.get_line(f,line,1000);
        loop begin
        utl_file.get_line(f,line,1000);
        if line is null then exit;
        end if;
        d_NHS := regexp_substr(line,'[^,]+',1,1);
        d_name := regexp_substr(line,'[^,]+',1,2);
        d_address := regexp_substr(line,'[^,]+',1,3);
        hospital_name := regexp_substr(line,'[^,]+',1,4);
        d_department := regexp_substr(line,'[^,]+',1,5);
        visiting_hours := regexp_substr(line,'[^,]+',1,6);
        d_contact := regexp_substr(line,'[^,]+',1,7);
        insert into doctor1 values(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact);
        commit;
        dbms_output.put_line(line);
        exception when no_data_found then exit;
        end;
        end loop;
    end if;
    utl_file.fclose(f);
    
    end;
    /