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
    primary key(d_NHS)
);
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(1,'N.I.Khan','Dhaka','Dhaka Medical College','
Medicine','Monday','028318135');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(2,'Saifuddin','Dhaka','Rajshahi Medical College','
Skin','Tuesday','029111911');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(3,'Hafizur','Dhaka','MUKTI','
Psychiatry','Tuesday','029896165');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(4,'Quoreshi','Dhaka','BSMMU','
Urology','Sunday','9132548');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(5,'Anwarul','Dhaka','BSMMU','
Medicine','Satday','028328125');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(6,'Saidur','Dhaka','Armed Forces Medical','
Surgeon','Friday','029126625');
create table patient(
	p_NHS integer,
	p_name varchar(10),
	p_address varchar(10),
	p_department varchar(15),
	p_contact varchar(12),
	primary key(p_NHS)
);
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(1,'Amir','Dhaka','
Medicine','01679357283');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(2,'Tahmina','Khulna','
Psychiatry','01779357283');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(3,'Rebeka','Comilla','
Gynecologist','01879357283');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(4,'Shamsul','Dhaka','
Skin','01979357283');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(5,'Hridoy','Rajshahi','
Surgeon','01679457283');

create table request(
	d_NHS integer,
	p_NHS integer,
	r_date varchar(10),
	status varchar(15),
	foreign key(d_NHS) references doctor(d_NHS),
	foreign key(p_NHS) references patient(p_NHS),
	primary key(d_NHS,p_NHS)
);
insert into request(d_NHS,p_NHS,r_date,status) values(1,1,'1/3/2018','approved');
insert into request(d_NHS,p_NHS,r_date,status) values(2,2,'2/3/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(3,3,'3/3/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(4,4,'4/3/2018','approved');
insert into request(d_NHS,p_NHS,r_date,status) values(5,5,'1/3/2018','not_approved');
create table pharmacy(
	id integer,
	name varchar(15),
	company_name varchar(10),
	total integer,
	dose_mg integer,
	exp_date varchar(10),
	price integer,
	primary key(id)
);
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(1,'Zimax',10,500,'3/8/18',35);
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(2,'Doxicap',20,500,'4/6/19',2);
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(3,'Pantonix',1000,20,'5/2/22',1);
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(4,'Fexo',250,120,'1/8/21',3);
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(5,'Rex',20,200,'8/9/20',120);
create table buying(
	d_NHS integer,
	p_NHS integer,
	id integer,
	amount number(10),
	b_date varchar(10),
	m_comment varchar(20),
	bill number(20),
	
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
        m_total pharmacy.total%type;
        m_id pharmacy.id%type;
        medi_bill number(20);
        bill integer;

        begin
        
     
        select id,price,total into m_id,m_price,m_total from pharmacy where id=:new.id;
        medi_bill:=m_price*(:new.amount);

        if(medi_bill>=1000)
        then
        bill:=(medi_bill-medi_bill*(.25));
         :new.bill:=bill;
         :new.m_comment:='25% Discount';


         
         
         else if(medi_bill>=400)
        then
        bill:=(medi_bill-medi_bill*(.20));
         :new.m_comment:='25% Discount';
         :new.bill:=bill;
         
         else if(medi_bill>=300)
        then
        bill:=(medi_bill-medi_bill*(.15));
          :new.m_comment:='20% Discount';
         :new.bill:=bill;
        
        else if(medi_bill>=200)
        then
        bill:=(medi_bill-medi_bill*(.10));
          :new.m_comment:='10% Discount';
         :new.bill:=bill;
        
         else if(medi_bill>=100)
        then
        bill:=(medi_bill-medi_bill*(.05));
          :new.m_comment:='5% Discount';
         :new.bill:=bill;
        
        else if(medi_bill<100)
        then
        bill:=(medi_bill-medi_bill*(0));
           :new.m_comment:='No Discount';
         :new.bill:=bill;
       
        end if;
        end if;
        end if;
        end if;
        end if;


        end if; 
    end;
    /

insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,1,1,5,'1/3/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(2,2,2,42,'5/9/2017');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(3,3,1,200,'27/2/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(4,4,4,1,'27/1/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(5,5,5,500,'1/2/2018');
select * from doctor;
select * from patient;
select * from request;
select * from pharmacy;
select * from buying;
commit;

