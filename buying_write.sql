set serveroutput on
declare
   f utl_file.file_type;
   cursor c is select * from buying;
   
begin
    f :=utl_file.fopen('DATABASE','buying_updated.csv','w');
    utl_file.put(f,'d_NHS'||','||'p_NHS'||','||'id'||','||'amount'||','||'b_date'||'bill');
    utl_file.new_line(f);
    for c_record in c
        loop
            utl_file.put(f,c_record.d_NHS||','||c_record.p_NHS||','||c_record.id||','||c_record.amount||','||c_record.b_date||','||c_record.bill);
               utl_file.new_line(f);
              end loop;
    utl_file.fclose(f);
    end;
    /