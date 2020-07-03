select d_name from doctor;
select id,name from pharmacy;
select id,name,price from pharmacy where price<100;
select id,name from pharmacy order by price;
update doctor set d_name='N.I.Khan' where d_NHS=1;
select id,name from pharmacy where id in(select id from buying where d_NHS=1);
select count(*) from doctor;
select count(d_name) from doctor;
select name,sum(total) from pharmacy group by name;
select avg(total) as average from pharmacy;
select avg(total) from pharmacy;
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(556,'Rex',50,200,'8/9/20',120);
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(557,'Rex',50,200,'8/9/20',120);
insert into pharmacy(id,name,total,dose_mg,exp_date,price) values(558,'Rex',50,200,'8/9/20',120);
select * from pharmacy;
select count(*) from pharmacy;
select count(name) from pharmacy;
select count(distinct name) from pharmacy;
select min(name) from pharmacy;
select max(name) from pharmacy;
select name,min(id) from pharmacy group by name having min(id)<222;
select name,max(id) from pharmacy group by name having max(id)>222;
select p_name,p_NHS from patient where p_address='Comilla';
select p_name,p_NHS from patient where address in('Comilla','Dhaka');
select p_name,p_NHS from patient where p_NHS between 11 and 33;
select p_name,p_NHS from patient where p_NHS not between 11 and 33;
select p_name,p_NHS from patient order by p_name;
select p_name,p_NHS from patient order by p_name,p_NHS desc;
select p_name,p_NHS from patient where p_name LIKE '%ir';
select p_name,p_NHS from patient where p_name LIKE 'Am%';
delete from pharmacy where id=558;
select d_name,d_NHS,p_name,p_NHS from doctor,patient where (d_NHS,p_NHS) in(select d_NHS,p_NHS from request where r_date='1/3/2018');
insert into doctor(d_NHS,d_name,d_address,hospital_name,d_department,visiting_hours,d_contact) values(0,'Rebeka','Comilla','Chittagong Medical College','
Medicine','Monday','028318235');
select d_name from doctor union select p_name from patient;
select d_name from doctor intersect select p_name from patient;
select d_name from doctor minus select p_name from patient;
select p_name,p_NHS,d_name,d_NHS from patient join doctor on p_name=d_name;
select p_name,p_NHS,d_name,d_NHS from patient join doctor on using(d_name);

commit;









