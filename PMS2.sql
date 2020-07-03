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
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(11,'Amir','Dhaka','
Medicine','01679357283');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(22,'Tahmina','Khulna','
Psychiatry','01779357283');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(33,'Rebeka','Comilla','
Gynecologist','01879357283');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(44,'Shamsul','Dhaka','
Skin','01979357283');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(55,'Hridoy','Rajshahi','
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
insert into request(d_NHS,p_NHS,r_date,status) values(1,11,'1/3/2018','approved');
insert into request(d_NHS,p_NHS,r_date,status) values(2,22,'2/3/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(3,33,'3/3/2018','not_approved');
insert into request(d_NHS,p_NHS,r_date,status) values(4,44,'4/3/2018','approved');
insert into request(d_NHS,p_NHS,r_date,status) values(5,55,'1/3/2018','not_approved');
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
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(5,'Rex',0,200,'8/9/20',120);
create table buying(
	d_NHS integer,
	p_NHS integer,
	id integer,
	amount integer,
	b_date varchar(10),
	foreign key(d_NHS) references doctor(d_NHS),
	foreign key(p_NHS) references patient(p_NHS),
	foreign key(id) references pharmacy(id),
	primary key(p_NHS,d_NHS,id)
);
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,11,1,5,'1/3/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(2,22,2,42,'5/9/2017');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(3,33,3,60,'27/2/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(4,44,4,1,'27/1/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(5,55,5,3,'1/2/2018');
select * from doctor;
select * from patient;
select * from request;
select * from pharmacy;
select * from buying;
commit;