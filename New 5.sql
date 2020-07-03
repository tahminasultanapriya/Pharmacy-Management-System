target_bill:= m_target_sell*m_price;
          buying_bill:= m_amount*m_buy;
          m_bill:= medi_bill;
          if(m_bill>target_bill)
            then
            if(m_bill>buying_bill)
            then
            m_m_amount:= medi_bill-buying_bill;
            update pharmacy set m_profit=m_m_amount where id=:new.id;
            else 
            m_m_amount:= buying_bill-medi_bill;
            update pharmacy set m_loss=m_m_amount where id=:new.id;
            end if;
            else 
            m_m_amount:= buying_bill-medi_bill;
            update pharmacy set m_loss=m_m_amount where id=:new.id;
            end if;