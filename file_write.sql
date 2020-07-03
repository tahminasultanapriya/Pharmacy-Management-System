set serveroutput on
declare
   f utl_file.file_type;
   cursor c is select * from customer1;
   
begin
    f :=utl_file.fopen('DATABASE','customer_updated.csv','w');
    utl_file.put(F,'ID'||','||'NAME'||','||'AGE');
    utl_file.new_line(f);
    for c_record in c
        loop
            utl_file.put(F,c_record.id||','||c_record.NAME||','||c_record.AGE);
               utl_file.fclose(f);
              end loop;
    utl_file.fclose(f);
    end;
    /