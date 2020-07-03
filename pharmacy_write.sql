set serveroutput on
declare
   f utl_file.file_type;
   cursor c is select * from pharmacy;
   
begin
    f :=utl_file.fopen('DATABASE','pharmacy_updated.csv','w');
    utl_file.put(f,'name'||','||'total'||','||'target_sell'||','||'dose_mg'||','||'exp_date'||','||'buy'||','||'price'||','||'m_profit'||','||'m_loss');
    utl_file.new_line(f);
    for c_record in c
        loop
            utl_file.put(f,c_record.name||','||c_record.total||','||c_record.target_sell||','||c_record.dose_mg||','||c_record.exp_date||','||c_record.buy||','||c_record.price||','||c_record.m_profit||','||c_record.m_loss);
               utl_file.new_line(f);
              end loop;
    utl_file.fclose(f);
    end;
    /