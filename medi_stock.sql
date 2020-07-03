/*<TOAD_FILE_CHUNK>*/
CREATE OR REPLACE FUNCTION medi_stock(m_id in pharmacy.id%type,
 m_amount in buying.amount%type)
 RETURN NUMBER IS
  m_total pharmacy.total%type;
  
BEGIN
    select id,amount into m_id,m_amount from buying where id=m_id ;
    select total into m_total from pharmacy where id=m_id;
    m_total:=m_total-m_amount;
    RETURN m_total;
END;
/
