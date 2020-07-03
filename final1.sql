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
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(7,'N.I.Khan','Dhaka','Dhaka Medical College','
Medicine','Monday','028318135');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(8,'Jannatul','Dhaka','Rajshahi Medical College','
Skin','Satday','029111921');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(9,'Rebeka','Comilla','Chittagong Medical','
Psychiatry','Tuesday','029896165');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(10,'Shakil','Chittagong','Comilla Medical','
Urology','Sunday','9132538');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(11,'Niru','Dhaka','Bangladesh Medical','
Medicine','Tuesday','028328325');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(12,'Ohi','Chittagong','Chittagong Medical','
Surgeon','Wednesday','029126637');
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
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(6,'Hafizur','Dhaka','
Pathologist','01679357222');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(7,'Sunayana','Khulna','
Psychiatry','01779357223');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(8,'Hridoy','Barisal','
Gynecologist','01879357273');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(9,'Amzad','Comilla','
Allergist','01979357213');
insert into patient(p_NHS,p_name,p_address,p_department,p_contact) values(10,'Akash','Chittagong','
Dermatology','01679457293');
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
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(1,'Zimax',20,15,500,'3/8/18',30,35);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(2,'Doxicap',20,16,500,'4/6/19',1,2);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(3,'Pantonix',10,8,20,'5/2/22',1,2);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(4,'Fexo',250,200,120,'1/8/21',2,3);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(5,'Rex',100,80,200,'8/9/20',80,120);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(6,'Napa',10,8,500,'3/8/18',.5,1);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(7,'EromycinDS',200,160,500,'4/6/19',8,10);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(8,'Filmet',500,400,20,'5/2/22',1,2);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(9,'Avita',250,200,120,'1/8/21',118,220);
insert into pharmacy(id,name,total,target_sell,dose_mg,exp_date,buy,price) values(10,'Fenadin',100,80,200,'8/9/20',5,8);
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(1,2,1,5,'1/3/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(2,1,2,42,'5/9/2017');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(3,3,3,60,'27/2/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(4,4,4,1,'27/1/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(5,5,5,200,'1/2/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(6,6,6,18,'1/3/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(7,7,7,10,'5/9/2017');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(8,8,8,60,'27/2/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(9,9,9,13,'27/1/2018');
insert into buying(d_NHS,p_NHS,id,amount,b_date) values(10,10,10,20,'1/2/2018');