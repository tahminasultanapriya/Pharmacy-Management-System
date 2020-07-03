/*<TOAD_FILE_CHUNK>*/
drop table buying;
drop table pharmacy;
drop table request;
drop table doctor;
drop table patient;
create table doctor(
	d_NHS integer,
	d_name varchar(15),
	d_address varchar(10),
	hospital_name varchar(40),
	d_department varchar(15),
	visiting_hours varchar(12),
	d_contact number(11),
	salary integer,
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
        salary := regexp_substr(line,'[^,]+',1,8);
        insert into doctor values(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact,salary);
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
	foreign key(d_NHS) references doctor(d_NHS),
	foreign key(p_NHS) references patient(p_NHS),
	primary key(d_NHS,p_NHS)
);
insert into request(d_NHS,p_NHS,r_date,status) values(1,1,'1/5/2018','approved');
insert into request(d_NHS,p_NHS,r_date,status) values(2,2,'2/5/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(3,3,'3/5/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(4,4,'4/5/2018','approved');
insert into request(d_NHS,p_NHS,r_date,status) values(5,5,'1/4/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(6,6,'1/6/2018','approved');
insert into request(d_NHS,p_NHS,r_date,status) values(7,7,'2/5/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(8,8,'3/5/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(9,9,'4/5/2018','approved');
insert into request(d_NHS,p_NHS,r_date,status) values(10,10,'1/5/2018','not_approved');
create table pharmacy(
	id integer,
	name varchar(15),
	total integer,
	target_sell integer,
	dose_mg integer,
	exp_date varchar(10),
	buy integer,
	price integer,
	m_profit integer,
	m_loss integer,
	primary key(id)
);
set serveroutput on
create or replace trigger target 
before insert or update of target_sell on pharmacy for each row
declare

begin
:new.target_sell:=:new.total*.8;

end;
/


insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(1,'Zimax',20,500,'3/8/18',28,35);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(2,'Doxicap',20,500,'4/6/19',1,2);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(3,'Pantonix',100,20,'5/2/22',1,2);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(4,'Fexo',250,120,'1/8/21',1,3);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(5,'Rex',100,200,'8/9/20',50,120);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(6,'Napa',10,500,'3/8/18',.5,1);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(7,'EromycinDS',200,500,'4/6/19',5,10);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(8,'Filmet',500,20,'5/2/22',1,4);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(9,'Avita',250,120,'1/8/21',105,220);
insert into pharmacy(id,name,total,dose_mg,exp_date,buy,price) values(10,'Fenadin',100,200,'8/9/20',2,8);

create table buying(
	d_NHS integer,
	p_NHS integer,
	id integer,
	amount number(10),
	b_date varchar(10),
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
        m_target_sell pharmacy.target_sell%type;
        m_buy pharmacy.buy%type;
        m_m_amount PHARMACY.M_PROFIT%type;
        m_m_amount1 PHARMACY.M_loss%type;
        iid number(2):=1;	
        medi_bill integer;
        bill integer;
        buying_bill integer;
        target_bill integer;
        m_bill integer;

        begin

        select id,price,total,buy,target_sell into m_id,m_price,m_amount,m_buy,m_target_sell from pharmacy where id=:new.id;
        if(:new.amount>m_amount)
        then 
        m_amount:=m_amount-0;
        :new.m_comment:='Medicine Not Available';
        else   
        medi_bill:=m_price*(:new.amount);
        if(medi_bill>=1000)
        then
        bill:=(medi_bill-medi_bill*(.25));
         :new.m_comment:='25% Discount';
         :new.bill:=bill;
          m_amount:=m_amount-:new.amount;
          target_bill:= m_target_sell*m_price;
          buying_bill:= m_amount*m_buy;
          m_m_amount := (medi_bill-buying_bill);
          m_m_amount1:=(buying_bill-medi_bill);
          if((medi_bill>target_bill) or (medi_bill>buying_bill))
          then
          update pharmacy set m_profit=m_m_amount where id=:new.id;
          else
          update pharmacy set m_loss=m_m_amount1 where id=:new.id;
          end if;
          update pharmacy set total=m_amount where id=:new.id; 
         
         else if(medi_bill>=400)
        then
        bill:=(medi_bill-medi_bill*(.20));
         :new.m_comment:='20% Discount';
         :new.bill:=bill;
          m_amount:=m_amount-:new.amount;
          target_bill:= m_target_sell*m_price;
          buying_bill:= m_amount*m_buy;
          m_m_amount := (medi_bill-buying_bill);
          m_m_amount1:=(buying_bill-medi_bill);
          if((medi_bill>target_bill) or (medi_bill>buying_bill))
          then
          update pharmacy set m_profit=m_m_amount where id=:new.id;
          else
          update pharmacy set m_loss=m_m_amount1 where id=:new.id;
          end if;
          update pharmacy set total=m_amount where id=:new.id;  
         

         else if(medi_bill>=300)
        then
        bill:=(medi_bill-medi_bill*(.15));
         :new.m_comment:='15% Discount';
         :new.bill:=bill;
          target_bill:= m_target_sell*m_price;
          buying_bill:= m_amount*m_buy;
          m_m_amount := (medi_bill-buying_bill);
          m_m_amount1:=(buying_bill-medi_bill);
           if((medi_bill>target_bill) or (medi_bill>buying_bill))
          then
          update pharmacy set m_profit=m_m_amount where id=:new.id;
          else
          update pharmacy set m_loss=m_m_amount1 where id=:new.id;
          end if;
           m_amount:=m_amount-:new.amount;
          update pharmacy set total=m_amount where id=:new.id;  
        else if(medi_bill>=200)
        then
        bill:=(medi_bill-medi_bill*(.10));
         :new.m_comment:='10% Discount';
         :new.bill:=bill;
           target_bill:= m_target_sell*m_price;
          buying_bill:= m_amount*m_buy;
          m_m_amount := (medi_bill-buying_bill);
          m_m_amount1:=(buying_bill-medi_bill);
           if((medi_bill>target_bill) or (medi_bill>buying_bill))
          then
          update pharmacy set m_profit=m_m_amount where id=:new.id;
          else
          update pharmacy set m_loss=m_m_amount1 where id=:new.id;
          end if;
         m_amount:=m_amount-:new.amount;
          update pharmacy set total=m_amount where id=:new.id;  
         else if(medi_bill>=100)
        then
        bill:=(medi_bill-medi_bill*(.05));
         :new.m_comment:='5% Discount';
         :new.bill:=bill;
          target_bill:= m_target_sell*m_price;
          buying_bill:= m_amount*m_buy;
          m_m_amount := (medi_bill-buying_bill);
          m_m_amount1:=(buying_bill-medi_bill);
           if((medi_bill>target_bill) or (medi_bill>buying_bill))
           then
          update pharmacy set m_profit=m_m_amount where id=:new.id;
          else
          update pharmacy set m_loss=m_m_amount1 where id=:new.id;
          end if;
          m_amount:=m_amount-:new.amount;
          update pharmacy set total=m_amount where id=:new.id;             
         
        else if(medi_bill<100)
        then
   bill:=(medi_bill-medi_bill*(0));
    :new.m_comment:='No Discount';
         :new.bill:=bill;
          target_bill:= m_target_sell*m_price;
          buying_bill:= m_amount*m_buy;
         m_m_amount := (medi_bill-buying_bill);
          m_m_amount1:=(buying_bill-medi_bill);
          if((medi_bill>target_bill) or (medi_bill>buying_bill))
          then
          update pharmacy set m_profit=m_m_amount where id=:new.id;
          else
          update pharmacy set m_loss=m_m_amount1 where id=:new.id;
          end if;
          m_amount:=m_amount-:new.amount;
          update pharmacy set total=m_amount where id=:new.id;  
        end if;
        end if;
        end if;
        end if;
        end if;


        end if; 
        end if;
       target_bill:=0;
       buying_bill:=0;
       medi_bill:=0; 

        
    end;
    /
show errors;
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,2,1,5,'1/3/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,1,2,4,'5/9/2017');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(3,2,3,60,'27/2/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(4,4,4,1,'27/1/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(5,5,5,100,'1/2/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(6,6,6,8,'1/3/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,7,7,50,'5/9/2017');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(8,8,8,60,'27/2/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,9,9,100,'27/1/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(10,10,10,20,'1/2/2018');
select * from doctor;
select * from patient;
select * from request;
select * from pharmacy;
select * from buying;
commit;

