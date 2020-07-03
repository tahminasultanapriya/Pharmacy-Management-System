 create or replace function getvalue(p_id in integer)
return number is
    m_id pharmacy.id%type;
    m_price pharmacy.price%type;
    m_amount buying.amount%type;
    medi_bill integer;
BEGIN
    select id,amount into m_id,m_amount from buying where id=p_id ;
    select price into m_price from pharmacy where id=p_id;
    medi_bill:= m_price*m_amount;
    RETURN medi_bill;
END;
/ 