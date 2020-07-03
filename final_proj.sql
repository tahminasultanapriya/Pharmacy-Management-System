/*<TOAD_FILE_CHUNK>*/
drop table buying;
drop table pharmacy;
drop table request;
drop table doctor;
drop table patient;
create table doctor(
	d_NHS integer,
	d_name varchar(15),
	d_address varchar(25),
	hospital_name varchar(40),
	d_department varchar(15),
	visiting_hours varchar(12),
	d_contact number(11),
	salary integer,
	d_patient integer default 0,
        primary key(d_NHS)
);
set serveroutput on
declare
   f utl_file.file_type;
   line varchar(1000);
   d_NHS doctor.d_NHS%type;
   d_name doctor.d_name%type;
   d_address doctor.d_address%type;
   hospital_name doctor.hospital_name%type;
   d_department DOCTOR.D_DEPARTMENT%type;
   visiting_hours DOCTOR.VISITING_HOURS%type;
   d_contact DOCTOR.D_CONTACT%type;
    salary doctor.salary%type;
   d_patient DOCTOR.D_PATIENT%type;
begin
    f :=utl_file.fopen('DATABASE','doctor1.csv','r');
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
        salary := regexp_substr(line,'[^,]+',1,8);
        d_patient := regexp_substr(line,'[^,]+',1,9);
        insert into doctor values(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact,salary,d_patient);
        commit;
        dbms_output.put_line(line);
        exception when no_data_found then exit;
        end;
        end loop;
    end if;
    utl_file.fclose(f);
    
    end;
    /
create table patient(
	p_NHS integer,
	p_name varchar(10),
	p_address varchar(10),
	p_department varchar(15),
	p_contact varchar(12),
	primary key(p_NHS)
);  
set serveroutput on
declare
   f utl_file.file_type;
   line varchar(1000);
   p_NHS patient.p_NHS%type;
   p_name  patient.p_name%type;
   p_address  patient.p_address%type;
   p_department  patient.p_DEPARTMENT%type;
   p_contact  patient.p_CONTACT%type;
begin
    f :=utl_file.fopen('DATABASE','patient.csv','r');
    if utl_file.is_open(f) then
        utl_file.get_line(f,line,1000);
        loop begin
        utl_file.get_line(f,line,1000);
        if line is null then exit;
        end if;
        p_NHS := regexp_substr(line,'[^,]+',1,1);
        p_name := regexp_substr(line,'[^,]+',1,2);
        p_address := regexp_substr(line,'[^,]+',1,3);
        p_department := regexp_substr(line,'[^,]+',1,4);
        p_contact := regexp_substr(line,'[^,]+',1,5);
        insert into patient values(p_NHS,p_name,p_address,p_department,p_contact);
        commit;
        dbms_output.put_line(line);
        exception when no_data_found then exit;
        end;
        end loop;
    end if;
    utl_file.fclose(f);
    
    end;
    / 
   

create table request(
	d_NHS integer,
	p_NHS integer,
	r_date varchar(10),
	status varchar(15),
	total_patient integer default 0,
	foreign key(d_NHS) references doctor(d_NHS),
	foreign key(p_NHS) references patient(p_NHS),
	primary key(d_NHS,p_NHS)
);

/*<TOAD_FILE_CHUNK>*/
CREATE OR REPLACE FUNCTION getnum (d_id in request.d_NHS%type)
 RETURN NUMBER IS
  CNT NUMBER:=0;
  CURSOR buy_details IS
  SELECT * FROM request WHERE d_NHS=d_id and status='approved';
  B_REC buy_details%ROWTYPE;
  
BEGIN

        OPEN buy_details;
        for iid in 1..10
        LOOP
        FETCH buy_details INTO B_REC;
        EXIT WHEN buy_details%NOTFOUND;
        CNT:=CNT+1;
        END LOOP;
        RETURN CNT;
        CLOSE buy_details;
END;
/
set serveroutput on 
create or replace trigger total_pat
before insert or update of total_patient on request for each row
declare 
d_id integer;
pt_num integer;
total_pat integer;
iid integer:=1;
dd_patient integer;
maxi integer:=0;
d_salary doctor.salary%type;
dd_id integer;
p_amount integer:=null;
d_patient integer;
ct integer;
counter integer:=0;
begin
    select d_NHS,salary into d_id,d_salary from doctor where d_NHS=:new.d_NHS;
    if(:new.status='approved')
    then
    :new.total_patient:=:new.total_patient+1;
    d_salary:=d_salary+d_salary*.1;
    update doctor set salary= d_salary where d_NHS=:new.d_NHS;
    end if;
    for iid in 1..10
    loop
    pt_num:=getnum(iid);
    update doctor set d_patient=pt_num where d_NHS=iid; 
    end loop;
    
      
end;
/
show errors
insert into request(d_NHS,p_NHS,r_date,status) values(1,1,to_date('1/5/2018','DD/MM/YYYY'),'approved');
insert into request(d_NHS,p_NHS,r_date,status) values(1,2,to_date('2/5/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(1,3,to_date('3/5/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(1,4,to_date('4/5/2018','DD/MM/YYYY'),'approved');
insert into request(d_NHS,p_NHS,r_date,status) values(6,5,to_date('1/4/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(5,6,to_date('1/6/2018','DD/MM/YYYY'),'approved');
insert into request(d_NHS,p_NHS,r_date,status) values(7,1,to_date('2/5/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(8,8,to_date('3/5/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(9,9,to_date('4/5/2018','DD/MM/YYYY'),'approved');
insert into request(d_NHS,p_NHS,r_date,status) values(10,10,to_date('1/5/2018','DD/MM/YYYY'),'not_approved');
create table pharmacy(
	id integer,
	name varchar(15),
	aftersell integer default 0,
	total integer,
	dose_mg integer,
	exp_date date,
	buy integer,
	price integer,
	sysdat varchar(20) default sysdate,
	amount_to_buy integer default 0,
	b_profit integer default 0,
	b_loss integer default 0,
	comm varchar(20),
	primary key(id)
);
set serveroutput on 
create or replace trigger billmin
before insert or update of comm on pharmacy for each row
declare 
begin

   if(:new.exp_date>:new.sysdat)
   then
     :new.comm:='Not Exp';
   else if(:new.exp_date<:new.sysdat)
   then
      :new.comm:='Exp';
   end if;
   end if;
end;
/
show errors;
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(1,'Zimax',20,500,'03-AUG-18',28,25);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(2,'Doxicap',20,100,'04-JUN-18',1,2);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(3,'Pantonix',100,20,'05-FEB-22',1,2);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(4,'Fexo',250,120,'01-AUG-28',1,3);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(5,'Rex',100,200,'08-SEP-19',50,120);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(6,'Napa',10,500,'03-AUG-18',.5,1);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(7,'EromycinDS',200,500,'04-JUN-18',10,5);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(8,'Filmet',500,20,'03-AUG-18',1,4);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(9,'Avita',250,120,'03-AUG-18',105,220);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(10,'Fenadin',100,200,'04-JUN-18',2,8);
create table buying(
	d_NHS integer,
	p_NHS integer,
	id integer,
	amount number(10),
	b_date date,
	m_comment varchar(20),
	bill number(10),
	foreign key(d_NHS) references doctor(d_NHS),
	foreign key(p_NHS) references patient(p_NHS),
	foreign key(id) references pharmacy(id),
	primary key(p_NHS,d_NHS,id)
);

set serveroutput on 
create or replace trigger billm
	before insert or update of bill on buying for each row
        declare
        m_price pharmacy.price%type;
        m_amount pharmacy.total%type;
        m_id pharmacy.id%type ;      
        m_buy pharmacy.buy%type;
        iid number(2):=1;	
        medi_bill integer;
        bill integer;
        buying_bill integer;
        target_bill integer;
        m_bill integer;
        b_profit integer;
        b_loss integer;
        medi_profit integer :=0;
        buy_amount integer;
        sell_amount integer;
        m_amount_to_buy integer;
        dateb varchar(20);
        exp_date varchar(20);
        sysdat varchar(20);
        comm varchar(20);
 

        begin

        select id,price,total,buy,b_profit,b_loss,amount_to_buy,exp_date,sysdat,comm into m_id,m_price,m_amount,m_buy,b_profit,b_loss,m_amount_to_buy,exp_date,sysdat,comm from pharmacy where id=:new.id;
        if(:new.amount>m_amount)
        then 
        m_amount:=m_amount-0;
        :new.m_comment:='Not Avilable';
        :new.bill:=0;
        else  
        if(comm='Not Exp')
        then
        medi_bill:=m_price*(:new.amount);
        if(medi_bill>=1000)
        then
        bill:=(medi_bill-medi_bill*(.25));
         :new.m_comment:='25% Discount';
         :new.bill:=bill;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
          m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0;   
          medi_profit:=0;
          m_amount_to_buy:=0;
          m_amount:=0;
         else if(medi_bill>=400)
        then
        bill:=(medi_bill-medi_bill*(.20));
         :new.m_comment:='20% Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id;  
          b_profit:=0;
          b_loss:=0;
          m_amount_to_buy:=0; 
          medi_profit:=0;    
         else if(medi_bill>=300)
        then
        bill:=(medi_bill-medi_bill*(.15));
         :new.m_comment:='15% Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buying_bill:= m_amount*m_buy;
           buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0;
          m_amount_to_buy:=0;
          medi_profit:=0;       
        else if(medi_bill>=200)
        then
        bill:=(medi_bill-medi_bill*(.10));
         :new.m_comment:='10% Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buying_bill:= m_amount*m_buy;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0;
          m_amount_to_buy:=0;
          medi_profit:=0;       
         else if(medi_bill>=100)
        then
        bill:=(medi_bill-medi_bill*(.05));
         :new.m_comment:='5% Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0;
          m_amount_to_buy:=0; 
          medi_profit:=0;                        
        else if(medi_bill<100)
        then
         bill:=(medi_bill-medi_bill*(0));
         :new.m_comment:='No Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buying_bill:= m_amount*m_buy;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0; 
          m_amount_to_buy:=0;
          medi_profit:=0;     
        end if;
        end if;
        end if;
        end if;
        end if;
        end if;
        else if(comm='Exp')
        then
          buying_bill:= m_amount*m_buy;
          medi_profit:=b_loss+buying_bill;
          update pharmacy set b_loss=medi_profit where id=:new.id;
          m_amount:=0;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount where id=:new.id; 
          :new.m_comment:='Not Avilable';
          :new.bill:=0;
          b_profit:=0;
          b_loss:=0; 
          m_amount_to_buy:=0;
          medi_profit:=0;  
        
        end if;
        end if;
        end if;
      
    end;
    /
show errors;
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,2,1,5,to_date('1/3/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,1,1,4,to_date('5/9/2017','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(3,2,3,60,to_date('27/2/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(4,4,4,1,to_date('27/1/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(5,5,2,20,to_date('1/2/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(6,6,6,8,to_date('1/3/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,7,7,50,to_date('5/9/2017','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(8,8,8,60,to_date('27/2/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,9,9,100,to_date('27/1/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(10,10,10,20,to_date('1/2/2018','DD/MM/YYYY'));
select * from doctor;
select * from patient;
select * from request;
select * from pharmacy;
select * from buying;
select * from doctor,buying;
commit;

/*<TOAD_FILE_CHUNK>*/
CREATE OR REPLACE FUNCTION getnum (d_id in request.d_NHS%type)
 RETURN NUMBER IS
  CNT NUMBER:=0;
  CURSOR buy_details IS
  SELECT * FROM request WHERE d_NHS=d_id and status='approved';
  B_REC buy_details%ROWTYPE;
  
BEGIN

        OPEN buy_details;
        LOOP
        FETCH buy_details INTO B_REC;
        EXIT WHEN buy_details%NOTFOUND;
        CNT:=CNT+1;
        END LOOP;
        RETURN CNT;
        CLOSE buy_details;
END;
/
set serveroutput on 
create or replace trigger total_pat
before insert or update of total_patient on request for each row
declare 
d_id integer;
pt_num integer;
total_pat integer;
iid integer:=1;
dd_patient integer;
maxi integer:=0;
d_salary doctor.salary%type;
dd_id integer;
p_amount integer:=null;
d_patient integer;
ct integer;
counter integer:=0;
begin
    select d_NHS,salary into d_id,d_salary from doctor where d_NHS=:new.d_NHS;
    if(:new.status='approved')
    then
    :new.total_patient:=:new.total_patient+1;
    d_salary:=d_salary+d_salary*.1;
    update doctor set salary= d_salary where d_NHS=:new.d_NHS;
    end if;
    for iid in 1..10
    loop
    pt_num:=getnum(iid);
    update doctor set d_patient=pt_num where d_NHS=iid; 
    end loop;
    
      
end;
/
show errors
insert into request(d_NHS,p_NHS,r_date,status) values(1,1,to_date('1/5/2018','DD/MM/YYYY'),'approved');
insert into request(d_NHS,p_NHS,r_date,status) values(1,2,to_date('2/5/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(1,3,to_date('3/5/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(1,4,to_date('4/5/2018','DD/MM/YYYY'),'approved');
insert into request(d_NHS,p_NHS,r_date,status) values(6,5,to_date('1/4/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(5,6,to_date('1/6/2018','DD/MM/YYYY'),'approved');
insert into request(d_NHS,p_NHS,r_date,status) values(7,1,to_date('2/5/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(8,8,to_date('3/5/2018','DD/MM/YYYY'),'not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(9,9,to_date('4/5/2018','DD/MM/YYYY'),'approved');
insert into request(d_NHS,p_NHS,r_date,status) values(10,10,to_date('1/5/2018','DD/MM/YYYY'),'not_approved');
create table pharmacy(
	id integer,
	name varchar(15),
	aftersell integer default 0,
	total integer,
	dose_mg integer,
	exp_date date,
	buy integer,
	price integer,
	sysdat varchar(20) default sysdate,
	amount_to_buy integer default 0,
	b_profit integer default 0,
	b_loss integer default 0,
	comm varchar(20),
	primary key(id)
);
set serveroutput on 
create or replace trigger billmin
before insert or update of comm on pharmacy for each row
declare 
begin

   if(:new.exp_date>:new.sysdat)
   then
     :new.comm:='Not Exp';
   else if(:new.exp_date<:new.sysdat)
   then
      :new.comm:='Exp';
   end if;
   end if;
end;
/
show errors;
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(1,'Zimax',20,500,'03-AUG-18',28,25);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(2,'Doxicap',20,100,'04-JUN-18',1,2);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(3,'Pantonix',100,20,'05-FEB-22',1,2);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(4,'Fexo',250,120,'01-AUG-28',1,3);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(5,'Rex',100,200,'08-SEP-19',50,120);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(6,'Napa',10,500,'03-AUG-18',.5,1);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(7,'EromycinDS',200,500,'04-JUN-18',10,5);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(8,'Filmet',500,20,'03-AUG-18',1,4);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(9,'Avita',250,120,'03-AUG-18',105,220);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(10,'Fenadin',100,200,'04-JUN-18',2,8);
create table buying(
	d_NHS integer,
	p_NHS integer,
	id integer,
	amount number(10),
	b_date date,
	m_comment varchar(20),
	bill number(10),
	foreign key(d_NHS) references doctor(d_NHS),
	foreign key(p_NHS) references patient(p_NHS),
	foreign key(id) references pharmacy(id),
	primary key(p_NHS,d_NHS,id)
);

set serveroutput on 
create or replace trigger billm
	before insert or update of bill on buying for each row
        declare
        m_price pharmacy.price%type;
        m_amount pharmacy.total%type;
        m_id pharmacy.id%type ;      
        m_buy pharmacy.buy%type;
        iid number(2):=1;	
        medi_bill integer;
        bill integer;
        buying_bill integer;
        target_bill integer;
        m_bill integer;
        b_profit integer;
        b_loss integer;
        medi_profit integer :=0;
        buy_amount integer;
        sell_amount integer;
        m_amount_to_buy integer;
        dateb varchar(20);
        exp_date varchar(20);
        sysdat varchar(20);
        comm varchar(20);
 

        begin

        select id,price,total,buy,b_profit,b_loss,amount_to_buy,exp_date,sysdat,comm into m_id,m_price,m_amount,m_buy,b_profit,b_loss,m_amount_to_buy,exp_date,sysdat,comm from pharmacy where id=:new.id;
        if(:new.amount>m_amount)
        then 
        m_amount:=m_amount-0;
        :new.m_comment:='Not Avilable';
        :new.bill:=0;
        else  
        if(comm='Not Exp')
        then
        medi_bill:=m_price*(:new.amount);
        if(medi_bill>=1000)
        then
        bill:=(medi_bill-medi_bill*(.25));
         :new.m_comment:='25% Discount';
         :new.bill:=bill;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
          m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0;   
          medi_profit:=0;
          m_amount_to_buy:=0;
          m_amount:=0;
         else if(medi_bill>=400)
        then
        bill:=(medi_bill-medi_bill*(.20));
         :new.m_comment:='20% Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id;  
          b_profit:=0;
          b_loss:=0;
          m_amount_to_buy:=0; 
          medi_profit:=0;    
         else if(medi_bill>=300)
        then
        bill:=(medi_bill-medi_bill*(.15));
         :new.m_comment:='15% Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buying_bill:= m_amount*m_buy;
           buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0;
          m_amount_to_buy:=0;
          medi_profit:=0;       
        else if(medi_bill>=200)
        then
        bill:=(medi_bill-medi_bill*(.10));
         :new.m_comment:='10% Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buying_bill:= m_amount*m_buy;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0;
          m_amount_to_buy:=0;
          medi_profit:=0;       
         else if(medi_bill>=100)
        then
        bill:=(medi_bill-medi_bill*(.05));
         :new.m_comment:='5% Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0;
          m_amount_to_buy:=0; 
          medi_profit:=0;                        
        else if(medi_bill<100)
        then
         bill:=(medi_bill-medi_bill*(0));
         :new.m_comment:='No Discount';
         :new.bill:=bill;
          buying_bill:= m_amount*m_buy;
          buying_bill:= m_amount*m_buy;
          buy_amount:= :new.amount*m_buy;
          if(:new.bill>buy_amount)
          then
          medi_profit:= b_profit+(:new.bill-buy_amount);
          update pharmacy set b_profit=medi_profit where id=:new.id;
          else if (:new.bill<buy_amount)
          then
          medi_profit:=b_loss+(buy_amount-:new.bill);
          update pharmacy set b_loss=medi_profit where id=:new.id;
          end if;
          end if;
          m_amount_to_buy:=m_amount_to_buy+:new.amount;
           m_amount:=m_amount-m_amount_to_buy;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount_to_buy where id=:new.id; 
          b_profit:=0;
          b_loss:=0; 
          m_amount_to_buy:=0;
          medi_profit:=0;     
        end if;
        end if;
        end if;
        end if;
        end if;
        end if;
        else if(comm='Exp')
        then
          buying_bill:= m_amount*m_buy;
          medi_profit:=b_loss+buying_bill;
          update pharmacy set b_loss=medi_profit where id=:new.id;
          m_amount:=0;
          update pharmacy set aftersell=m_amount where id=:new.id;
          update pharmacy set amount_to_buy=m_amount where id=:new.id; 
          :new.m_comment:='Not Avilable';
          :new.bill:=0;
          b_profit:=0;
          b_loss:=0; 
          m_amount_to_buy:=0;
          medi_profit:=0;  
        
        end if;
        end if;
        end if;
      
    end;
    /
show errors;
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,2,1,5,to_date('1/3/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,1,1,4,to_date('5/9/2017','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(3,2,3,60,to_date('27/2/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(4,4,4,1,to_date('27/1/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(5,5,2,20,to_date('1/2/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(6,6,6,8,to_date('1/3/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,7,7,50,to_date('5/9/2017','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(8,8,8,60,to_date('27/2/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,9,9,100,to_date('27/1/2018','DD/MM/YYYY'));
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(10,10,10,20,to_date('1/2/2018','DD/MM/YYYY'));
select * from doctor;
select * from patient;
select * from request;
select * from pharmacy;
select * from buying;
commit;

