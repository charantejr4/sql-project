insert into employee values 
 ('Franklin','T','Wong',333445555,'1955-12-08','M',40000,'638 Voss,Houstan,TX',888665555,5),
('Alicia','J','Zelaya',999887777,'1968-01-19','F',25000,'3321 Castle,Spring,TX',987654321,4),
('Jenifer','S','Wallace',987654321,'1941-06-20','F',43000,'291 Berry, Bellaire, TX',888665555,4),
('Ramesh','K','Narayan',666884444,'1962-09-15','M',38000,'975 Fire Oak, Humble, TX',333445555,5),
('Joyce','A','English',453453453,'1972-07-31','F',25000,'5631 Rice,Houstan, TX',333445555,5),
('Ahmad','V','Jabbar',987987987,'1969-03-29','M',25000,'980 Dallas, Houstan, TX',987987987,4),
('James','E','Brag',888665555,'1937-11-10','M',55000,'450 Stone,Houstan, TX',NULL,1)
;

alter table employee
modify column ADDRESS varchar(40);

alter table employee
drop foreign key employee_ibfk_2;

insert into DEPARTMENT values
('Reasearch',5,333445555,'1988-05-22'),
('Administration',4,987654321,'1995-01-01'),
('Headquarters',1,888665555,'1981-06-19');

alter table department modify column dname varchar(20);


insert into dept_locations values 
(1,'Houstan'),
(4,'Stafford'),
(5,'Bellaire'),
(5,'Sugarland'),
(5,'Houstan');

insert into project values
('ProductX',1,'Bellaire',5),
('ProductY',2,'Sugarland',5),
('ProductZ',3,'Houstan',5),
('Computerization',10,'Stafford',4),
('Reorganization',20,'Houstan',1),
('Newbenefits',30,'Stafford',4);

alter table project 
modify column pname varchar(20);
 
 insert into works_on values
 (123456789, 1,32.5),
 (123456789, 2, 7.5),
 (666884444 ,3 ,40),
 (453453453, 1 ,20),
(453453453 ,2 ,20),
(333445555, 2, 10),
(333445555, 3, 10),
(333445555 ,10 ,10),
(333445555, 20, 10),
(999887777 ,30 ,30),
(999887777 ,10, 10),
(987987987 ,10 ,35),
(987987987 ,30 ,5),
(987654321 ,30 ,20),
(987654321 ,20 ,15),
(888665555 ,20 ,NULL);


insert into dependent values
(333445555, 'Alice' ,'F' ,'1986-04-05' ,'Daughter'),
(333445555, 'Theodore' ,'M' ,'1983-10-25' ,'Son'),
(333445555, 'Joy' ,'F' , '1958-05-03' ,'Spouse'),
(987654321, 'Abner' ,'M' , '1942-02-28' ,'Spouse'),
(123456789, 'Michael','M' , '1988-01-04' ,'Son'),
(123456789, 'Elizabeth','F' ,'1967-05-05','Spouse');