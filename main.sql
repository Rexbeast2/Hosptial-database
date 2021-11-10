create database a;
use a;

create table if not exists patient(
pid varchar(10) primary key,
Pat_phone_no varchar(10) not null,
pat_name varchar(20) not null,
DateOfBirth date not null,
addres varchar(30) not null,
gender varchar(1) check (gender in ('m','f','o')),
covid_patient varchar (1) check (covid_patient in('y','n')));

create table if not exists cov_patient(
covid_patient varchar (1) primary key check (covid_patient in('y','n')),
pat_type varchar(3) not null check (pat_type in ('ipd','opd')));

create table  if not exists doctor(
doc_id varchar(10) primary key,
qualification varchar(20) not null,
empid varchar(10) not null);

create table  if not exists doc_qual(
qualification varchar(20) primary key,
consulting_fees int not null);

create table  if not exists nurse(
nurseid varchar(10) primary key,
patient_count int not null,
empid varchar(10) not null);

create table  if not exists department(
deptid varchar(30) primary key,
dept_name varchar(40) not null,
dept_loc varchar(30) not null);

create table  if not exists employee(
empid varchar(10) primary key, 
emp_name varchar(20) not null,
gender varchar(1) check(gender in ('m','f', 'o')),
join_date date not null, 
DateOfBirth date not null,
phone_no varchar(10), 
leave_date date, 
emp_type varchar(3) not null check(emp_type in ('doc', 'nur')),
deptid varchar(10));

alter table employee add foreign key(deptid) references department(deptid);

create table  if not exists Out_Patient(
OPD_ID varchar(10) primary key,
D_Arrival date not null,
Disease varchar(50) not null,
d_discharge date,
Pid varchar(10) not null);

create table  if not exists in_patient(
ipd_id varchar(10) primary key,
d_disease varchar(20) not null,
d_arrival date not null,
pid varchar(10) not null,
room_id varchar(10) not null);


create table  if not exists room(
room_id varchar(10) primary key,
room_type text);

create table  if not exists type_cost(
room_cost int primary key,
room_type text);

create table  if not exists nurse_assigned(
nurse_id varchar(10),
patient_ipd_id varchar(10) not null,
primary key(nurse_id, patient_ipd_id));

create table  if not exists doctor_assigned(
doc_id varchar(10),
patient_id varchar(10),
primary key(doc_id,patient_id));

create table  if not exists test(
test_id varchar(10) primary key,
test_name text not null,
test_cost int not null);

create table  if not exists medicine(
med_id varchar(10) primary key,
med_name text not null,
med_cost int not null);

create table  if not exists bill(
bill_id varchar(10) primary key,
other_charges int not null,
bill_date date not null,
pid varchar(10) not null);


create table  if not exists takes(
med_id varchar(10) not null,
patient_id varchar(10) not null,
m_date date,
qty int not null, 
primary key(med_id,patient_id));

create table  if not exists has(
test_id varchar(10), 
pid varchar(10),
tdate date not null,
primary key(test_id, pid),
foreign key(pid) references patient(pid),
foreign key(test_id) references test(test_id));  

alter table takes add foreign key(med_id) references medicine(med_id);

alter table takes add foreign key(patient_id) references patient(pid);

alter table doctor add foreign key(empid) references employee(empid);

alter table nurse add foreign key(empid) references employee(empid);

alter table doctor_assigned add foreign key(doc_id) references doctor(doc_id);

alter table doctor_assigned add foreign key(patient_id) references patient(pid);

alter table nurse_assigned add foreign key(nurse_id) references nurse(nurseid);

alter table nurse_assigned add foreign key(patient_ipd_id) references in_patient(ipd_id);

alter table in_patient add foreign key(pid) references patient(pid);

alter table in_patient add foreign key(room_id) references room(room_id);

alter table out_patient add foreign key(pid) references patient(pid);

alter table bill add foreign key(pid) references patient(pid);



insert into department values('DPT01','Physiotherapy','Building 3, left wing A block');
insert into department values('DPT02','Neurology','Building 2, left wing C block');
insert into department values('DPT03','Ortho','Building 3, left wing A block');
insert into department values('DPT04','Psychology','Building 1, left wing B block');
insert into department values('DPT05','Gynaecology','Building 1, left wing C block');
insert into department values('DPT06','Medicine','Building 1, left wing A block');
insert into department values('DPT07','Gastroentrology','Building 3, left wing B block');
insert into department values('DPT08','Cardiac','Building 2, left wing A block');
insert into department values('DPT09','ENT','Building 3, left wing A block');
insert into department values('DPT10','General Surgery','Building 2, left wing B block');
insert into department values('DPT11','Anaesthetics','Building 1, left wing A block');

insert into employee values('EM001','Akshay','m','2019-07-21','1989-12-21','1234567890',null,'doc','DPT06');
insert into employee values('EM002','Raj','m','2017-12-12','1981-12-12','1234567899',null,'doc','DPT08');
insert into employee values('EM003','Ravi','m','2018-04-09','1991-11-10','1234567898',null,'doc','DPT05');
insert into employee values('EM004','Darshan','m','2015-05-24','1986-3-16','1234567897','2020-05-24','doc','DPT04');
insert into employee values('EM005','Laveena','f','2021-01-13','1981-10-19','1234567896',null,'doc','DPT03');
insert into employee values('EM006','Harsheen','f','2020-04-16','1986-3-16','1234567895',null,'doc','DPT07');
insert into employee values('EM007','Nikhal','m','2019-01-08','1983-10-19','1234567894',null,'doc','DPT02');
insert into employee values('EM008','Adit','m','2019-03-21','1992-03-11','1234567893',null,'doc','DPT09');
insert into employee values('EM009','Manish','m','2015-09-21','1992-10-19','1234567892','2021-01-15','doc','DPT06');
insert into employee values('EM010','Muskhesh','m','2018-08-29','1993-11-10','1234567891',null,'nur',null);
insert into employee values('EM011','Riya','f','2016-12-31','1993-1-10','1234567800',null,'nur',null);
insert into employee values('EM012','Seema','f','2016-10-26','1993-1-1','1234567880',null,'nur',null);
insert into employee values('EM013','Joyti','f','2019-04-15','1996-1-20','1234567870',null,'nur',null);
insert into employee values('EM014','Poorvi','f','2017-05-01','1991-10-18','1234567860',null,'nur',null);
insert into employee values('EM015','Priya','f','2018-10-10','1981-01-15','1234567850',null,'nur',null);

insert into doctor values('DOC01','MBBS','EM001');
insert into doctor values('DOC02','MBBS','EM002');
insert into doctor values('DOC03','MBBS','EM003');
insert into doctor values('DOC04','MD','EM004');
insert into doctor values('DOC05','MS','EM005');
insert into doctor values('DOC06','MD','EM006');
insert into doctor values('DOC07','MS','EM007');
insert into doctor values('DOC08','MD','EM008');
insert into doctor values('DOC09','MD','EM009');

insert into doc_qual values('MBBS',3000);
insert into doc_qual values('MD',8000);
insert into doc_qual values('MS',4000);

insert into nurse values('NUR01',1,'EM010');
insert into nurse values('NUR02',1,'EM011');
insert into nurse values('NUR03',1,'EM012');
insert into nurse values('NUR04',2,'EM013');
insert into nurse values('NUR05',1,'EM014');
insert into nurse values('NUR06',2,'EM015');

insert into patient values('PAT001','0123456789','Reena','1991-05-04','Dadar(e), Mumbai','f','y');
insert into patient values('PAT002','1123456789','Parul','1965-10-24','Malad (e),Mumbai','f','y');
insert into patient values('PAT003','2123456789','Bhuvi','1984-05-04','Sion,Mumbai','m','n');
insert into patient values('PAT004','3123456789','Rakesh','2001-04-13','Nacharam,Hyderabad','m','n');
insert into patient values('PAT005','4123456789','Lokesh','1984-04-25','Kemps Corner,Mumbai','m','n');
insert into patient values('PAT006','5123456789','Laxmi','2001-04-25','Khar (west),Mumbai','f','n');
insert into patient values('PAT007','6123456789','Rahul','1984-04-19','Kopri Colony,Mumbai','m','n');
insert into patient values('PAT008','7123456789','Mona','2001-04-13','Purasaiwalkam,Chennai','f','n');
insert into patient values('PAT009','8123456789','Vinita','1984-04-25','Moti Bagh,Delhi','f','n');
insert into patient values('PAT010','9123456789','Tushar','1990-05-04','Fort,Mumbai','m','y');
insert into patient values('PAT011','0223456789','Karan','1984-04-19','Kandivali (west),Mumbai','m','y');
insert into patient values('PAT012','0323456789','Aditi','1979-05-04','K G Marg,Delhi','f','y');
insert into patient values('PAT013','0423456789','Harsh','1979-04-13','Somajiguda,Hyderabad','m','y');
insert into patient values('PAT014','0523456789','Jasmin','1990-04-19','Kalbadevi,Mumbai','f','y');
insert into patient values('PAT015','0623456789','Deepak','1979-05-04','Kandivali (west),Mumbai','m','y');

insert into cov_patient values('y','ipd');
insert into cov_patient values('n','opd');

insert into out_patient values('OPD01','2020-10-21','Heart attack','2020-12-14','PAT001');
insert into out_patient values('OPD02','2021-04-13','Gastric','2021-05-14','PAT004');
insert into out_patient values('OPD03','2021-04-16','Lung Infection','2021-05-30','PAT006');
insert into out_patient values('OPD04','2020-09-27','Ear Pain','2020-10-02','PAT007');
insert into out_patient values('OPD05','2021-01-21','Fever','2021-01-25','PAT009');
insert into out_patient values('OPD06','2021-03-13','Throat Infection','2021-04-11','PAT011');
insert into out_patient values('OPD07','2021-05-09','Lung Infection','2021-06-07','PAT012');
insert into out_patient values('OPD08','2021-04-12','Covid','2021-04-22','PAT013');
insert into out_patient values('OPD09','2021-05-01','White Fungus','2021-05-22','PAT014');

insert into room values('R001','single');
insert into room values('R002','double');
insert into room values('R003','dorm');
insert into room values('R004','single');
insert into room values('R005','double');
insert into room values('R006','dorm');
insert into room values('R007','single');
insert into room values('R008','double');
insert into room values('R009','dorm');
insert into room values('R010','single');
insert into room values('R011','double');
insert into room values('R012','dorm');

insert into type_cost values(4000,'single');
insert into type_cost values(2000,'double');
insert into type_cost values(1000,'dorm');

insert into in_patient values('IPD01','Heart-Attack','2021-06-19','PAT002','R001');
insert into in_patient values('IPD02','Gestational-Diabetes','2021-06-17','PAT003','R002');
insert into in_patient values('IPD03','Kidney Transplant','2021-06-04','PAT005','R004');
insert into in_patient values('IPD04','Hernia','2021-05-25','PAT008','R005');
insert into in_patient values('IPD05','Femur Fracture','2021-06-12','PAT010','R005');
insert into in_patient values('IPD06','Appendicitis','2021-05-30','PAT015','R007');

insert into nurse_assigned values('NUR01','IPD01');
insert into nurse_assigned values('NUR02','IPD01');
insert into nurse_assigned values('NUR03','IPD02');
insert into nurse_assigned values('NUR04','IPD03');
insert into nurse_assigned values('NUR05','IPD03');
insert into nurse_assigned values('NUR06','IPD04');
insert into nurse_assigned values('NUR06','IPD05');
insert into nurse_assigned values('NUR04','IPD06');

insert into doctor_assigned values('DOC01','PAT001');
insert into doctor_assigned values('DOC02','PAT002');
insert into doctor_assigned values('DOC03','PAT003');
insert into doctor_assigned values('DOC05','PAT004');
insert into doctor_assigned values('DOC08','PAT005');
insert into doctor_assigned values('DOC01','PAT006');
insert into doctor_assigned values('DOC07','PAT007');
insert into doctor_assigned values('DOC04','PAT008');
insert into doctor_assigned values('DOC09','PAT009');
insert into doctor_assigned values('DOC06','PAT010');
insert into doctor_assigned values('DOC06','PAT011');
insert into doctor_assigned values('DOC05','PAT012');
insert into doctor_assigned values('DOC07','PAT013');
insert into doctor_assigned values('DOC06','PAT014');
insert into doctor_assigned values('DOC04','PAT015');

insert into medicine values('MED01','Remdesivir',900);
insert into medicine values('MED02','Citzin',70);
insert into medicine values('MED03','Aspirin',1000);
insert into medicine values('MED04','Wararin',2000);
insert into medicine values('MED05','Insulin-A',600);
insert into medicine values('MED06','Glynase',700);
insert into medicine values('MED07','Paracetamol',100);

insert into test values('TES01','Troponin Test',1500);
insert into test values('TES02','CK-MB Test',2000);
insert into test values('TES03','Serum Myoglobin Test',1700);
insert into test values('TES04','Random Blood Sugar Test',500);
insert into test values('TES05','Fasting Blood Sugar Test',500);
insert into test values('TES06','IC PCR Test',1000);

insert into has values('TES06','PAT002','2021-06-20');
insert into has values('TES02','PAT002','2021-06-20');
insert into has values('TES03','PAT004','2021-05-09');
insert into has values('TES06','PAT003','2021-06-19');
insert into has values('TES04','PAT008','2021-05-30');
insert into has values('TES06','PAT010','2021-06-16');
insert into has values('TES05','PAT015','2021-06-01');

insert into takes values('MED01','PAT001','2020-11-21',2);
insert into takes values('MED01','PAT002','2021-06-24',3);
insert into takes values('MED05','PAT003','2021-06-22',6);
insert into takes values('MED02','PAT004','2021-04-20',8);
insert into takes values('MED04','PAT005','2021-06-27',2);
insert into takes values('MED06','PAT006','2021-04-19',10);
insert into takes values('MED05','PAT007','2021-09-28',10);
insert into takes values('MED07','PAT008','2021-01-22',10);
insert into takes values('MED02','PAT009','2011-05-26',10);
insert into takes values('MED04','PAT010','2021-06-23',10);
insert into takes values('MED05','PAT011','2021-03-14',10);
insert into takes values('MED04','PAT012','2021-06-02',10);
insert into takes values('MED01','PAT013','2021-04-18',10);
insert into takes values('MED01','PAT014','2020-05-03',10);
insert into takes values('MED05','PAT015','2020-06-06',10);

insert into bill values('BILL01',1000,'2020-12-14','PAT001');
insert into bill values('BILL02',100000,'2021-06-30','PAT002');
insert into bill values('BILL03',900,'2021-06-22','PAT003');
insert into bill values('BILL04',1200,'2021-05-14','PAT004');
insert into bill values('BILL05',55000,'2021-06-22','PAT005');
insert into bill values('BILL06',2000,'2021-05-30','PAT006');
insert into bill values('BILL07',1600,'2020-10-02','PAT007');
insert into bill values('BILL08',35000,'2021-06-10','PAT008');
insert into bill values('BILL09',1100,'2021-01-25','PAT009');
insert into bill values('BILL10',65000,'2021-06-30','PAT010');
insert into bill values('BILL11',3000,'2021-04-11','PAT011');
insert into bill values('BILL12',1200,'2021-06-07','PAT012');
insert into bill values('BILL13',1000,'2021-04-22','PAT013');
insert into bill values('BILL14',900,'2021-05-22','PAT014');
insert into bill values('BILL15',90000,'2021-06-21','PAT015');
