drop table takes;
drop table course;
drop table student;
drop table teacher;

create table teacher(
    id integer,
    name varchar(20) not null,
    salary number(7) check(salary>=20000 and salary <=90000),
    primary key(id)
    );

create table student(
    roll integer,
    name varchar(20),
    phone_no number(11) unique,
    gender varchar(10),
    cgpa number(3,2) default 2.00 check(cgpa>=2.00 and cgpa<=4.00),
    adviser_id integer,
    home_district varchar(20),
    primary key(roll),
    foreign key(adviser_id) references teacher(id) on delete cascade
    );
	
create table course(
    course_no varchar(20),
    course_name varchar(20) unique,
    credit number(3,2),
    primary key(course_no)
   );

create table takes(
   roll integer,
   course_no varchar(20),
   foreign key(roll) references student(roll) on delete cascade,
   foreign key(course_no) references course(course_no)on delete cascade,
   primary key(roll,course_no)
   );
	
alter table student add grade varchar(10);
alter table student drop column grade;
insert into teacher (id,name,salary) values (1,'A',20000);
insert into teacher (id,name,salary) values (2,'B',25000);
insert into teacher (id,name,salary) values (3,'C',30000);
insert into teacher (id,name,salary) values (4,'D',35000);
insert into teacher (id,name,salary) values (5,'E',40000);

insert into student (roll,name,phone_no,gender,cgpa,adviser_id,home_district) 
             values (1001,'Abc',017920000,'male',3.00,1,'dhaka');

insert into student (roll,name,phone_no,gender,cgpa,adviser_id,home_district) 
             values (1005,'Abcd',017920001,'male',3.20,1,'dhaka');

insert into student (roll,name,phone_no,gender,cgpa,adviser_id,home_district) 
             values (1002,'cde',017920002,'female',3.10,2,'khulna');

insert into student (roll,name,phone_no,gender,cgpa,adviser_id,home_district) 
             values (1003,'cdef',017920004,'female',3.10,2,'khulna');

insert into student (roll,name,phone_no,gender,cgpa,adviser_id,home_district) 
             values (1006,'bcd',017920005,'male',3.50,1,'jessore');

insert into student (roll,name,phone_no,gender,cgpa,adviser_id,home_district) 
             values (1009,'bcd',017920009,NULL,3.20,5,'khulna');
			
			
insert into course (course_no,course_name,credit) 
            values ('cse3110', 'Database Systems Lab', 1.5);
insert into course (course_no,course_name,credit) 
            values ('cse3109', 'Database Systems', 3.0);


insert into takes (roll, course_no) values (1001,'cse3110');
insert into takes (roll, course_no) values (1001,'cse3109');
insert into takes (roll, course_no) values (1002,'cse3110');
insert into takes (roll, course_no) values (1002,'cse3109');
insert into takes (roll, course_no) values (1003,'cse3110');
insert into takes (roll, course_no) values (1003,'cse3109');
insert into takes (roll, course_no) values (1005,'cse3110');
insert into takes (roll, course_no) values (1005,'cse3109');
select * from teacher;
select * from student;
select * from takes;
select * from course;

commit;