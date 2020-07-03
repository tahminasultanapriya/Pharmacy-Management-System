set serveroutput on
declare
   f utl_file.file_type;
   cursor c is select * from doctor;
   
begin
    f :=utl_file.fopen('DATABASE','doctor_updated.csv','w');
    utl_file.put(f,'d_NHS'||','||'d_name'||','||'d_address'||','||'hospital_name'||','||'d_department'||','||'visiting_hours'||','||'d_contact');
    utl_file.new_line(f);
    for c_record in c
        loop
            utl_file.put(f,c_record.d_NHS||','||c_record.d_name||','||c_record.d_address||','||c_record.hospital_name||','||c_record.d_department||','||c_record.visiting_hours||','||c_record.d_contact);
               utl_file.new_line(f);
              end loop;
    utl_file.fclose(f);
    end;
    /