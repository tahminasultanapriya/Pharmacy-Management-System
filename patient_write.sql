set serveroutput on
declare
   f utl_file.file_type;
   cursor c is select * from patient;
   
begin
    f :=utl_file.fopen('DATABASE','patient_updated.csv','w');
    utl_file.put(f,'p_NHS'||','||'p_name'||','||'p_address'||','||'p_department'||','||'p_contact');
    utl_file.new_line(f);
    for c_record in c
        loop
            utl_file.put(f,c_record.p_NHS||','||c_record.p_name||','||c_record.p_address||','||c_record.p_department||','||c_record.p_contact);
               utl_file.new_line(f);
              end loop;
    utl_file.fclose(f);
    end;
    /