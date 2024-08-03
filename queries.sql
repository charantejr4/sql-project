-- Retrieve the birth date and address of the employee(s) whose name is 'John B.Smith'.
select fname,bdate, address from employee 
where fname='John' and minit='B' and lname='Smith';

-- 2.Retrieve the name and address of all employees who work for the 'Research' department.

select fname, address from employee
join department on employee.DNO=department.DNUMBER
where dnumber=5;

-- 3.For every project located in 'Stafford',list the project number,the controlling department number
-- ,and the department manager's last name,address,and birth date.

select pnumber,dnumber,lname,address,bdate
from employee
join department on employee.SSN=department.mgrssn
join project on department.DNUMBER=project.dnum
where plocation='Stafford';

-- or
select pnumber,dnumber,lname,address,bdate
from project,employee,department
where dnum=dnumber and mgrssn=ssn and plocation='Stafford';

-- 4.4.Retrieve the names of all employees in department 5 
-- who work more than 10 hours per week on the 'ProductX' project.

select fname , lname
from employee, department,works_on,project
where pname='ProductX' and dno=5 and hours>10 and
pno=PNUMBER and SSN=ESSN;
-- or
SELECT employee.fname, employee.lname
FROM employee
JOIN works_on ON employee.SSN = works_on.ESSN
JOIN project ON works_on.pno = project.PNUMBER
JOIN department ON employee.dno = department.dnumber
WHERE project.pname = 'ProductX'
  AND department.dnumber = 5
  AND works_on.hours > 10;
  
  
  
-- 5.List the names of all employees who have a 
-- dependent with the same first name as themselves.

select fname, lname
from employee
join dependent on employee.ssn=dependent.essn
where employee.fname=dependent.DEPENDENT_NAME;

-- 6.Find the names of all employees who are directly supervised by 'Franklin Wong'.

select fname,lname
from employee
where superssn in (select ssn from employee where fname='Franklin' and lname='Wong');

-- 7.Make a list of all project numbers for project that involve an employee
-- whose last name is 'Smith',either as a worker or as a manager of the 
-- department that controls the project.

select pnumber 
from project,employee
where dnum=dno and lname='Smith' ;
-- or
select pnumber
from project 
join employee on project.dnum=employee.dno 
where lname="Smith";
-- or
select pnumber from project where dnum in (select dno from employee
where lname='Smith');


-- 8.for each employee ,retrive the employee's first and last name and the 
-- first and last name of his or her immediate supervisor.

select e.fname,e.lname ,s.fname,s.lname
from employee as e , employee as s
where s.superssn=e.ssn;


-- 9.select all employees ssn and all combinations of employees ssn 
-- and department dname in the database.

select ssn,dname
from employee,department
where dno=dnumber;

-- 10.Retrieve the salary of every employee and all distinct salary values.
select fname,minit,lname,salary from employee;

-- 11.Retrieve all employees whose address is in Houston, Texas.
select fname,lname,address
from employee where address like "%Houstan, TX%";

-- 12.Find all employees who were born during the 1950s.
select fname ,lname,bdate
from employee where year(bdate)<1960 and year(bdate)>1950;

-- 13.Show the resulting salaries if every employee working on the 'ProductX' 
-- project is given a 10 percent raise.
select salary+(salary*10)/100 from employee , works_on ,
project  where ssn=essn and pno=pnumber and pname='ProductX';


-- 14.Retrieve all employees in department 5 
-- whose salary is between 30000 and 40000.

select fname,salary from employee
where salary between 30000 and 40000 and dno=5;

-- 15.Retrieve a list of employees and the projects they
-- are working on, ordered by department and,within each department, 
-- ordered alphabetically by last name, then first name.

select fname, pname, dname 
from employee, project,department where employee.DNO=project.DNUM and employee.DNO=department.DNUMBER
order by fname asc;

-- 16.Find the names of employees who work on all the projects controlled by department number 5.

select fname,pname, dname,dno
from employee,project,department
where employee.dno=project.dnum and employee.dno=department.DNUMBER and dnum=5;

-- 17.List the names of all employees with two or more dependents.

select fname,lname from employee where ssn in (select essn from dependent group by essn having count(essn)>=2);

-- 18.Retrieve the names of employees who have no dependents.

select fname,lname from employee
where not exists (select *from dependent where ssn=essn);


-- 19.List the names of managers who have atleast one dependent.
select fname,lname from employee
where exists (select *from dependent where ssn=essn)
and exists(select*from department where ssn=mgrssn);

-- 20.Retrieve the names of all employees who donot have supervisers.

select fname from employee where ssn=superssn or superssn is null;

-- 21.Retrieve the name of each employees who has a dependent 
-- with the same first name and is the same sex as the employee.

select fname from employee e, dependent d
where e.fname=d.DEPENDENT_NAME and e.sex=d.sex;

-- 23.Find the sum of salaries of all employees,the maximum 
-- salary,the minimum salary,and the average salary.

select sum(salary),max(salary),min(salary),avg(salary)
from employee;

-- 24.Find the sum of the salaries of all employees of the 'Research' 
-- department,as well as the maximum salary,the minimum salary,and 
-- the average salary in this department.

select sum(salary),max(salary),min(salary),avg(salary)
from employee,department where dno=dnumber and dname='Reasearch';


-- 25.Retrieve the total number of employees in the company.

select count(*) as total_employees
from employee;

-- 26.Retrieve the number of employees in the 'Research' department.

select count(*) from employee,department where dno=dnumber and dname='Reasearch';

-- 27.Count the number of distinct salary values in the database.
select distinct salary from employee;

-- 28.For each department, retrieve the department number, 
-- the number of employees in the department and their average salary.

select dno,count(*),avg(salary)
from employee 
group by dno;

-- 29.For each project, retrieve the project number, the project name, 
-- and the number of employees who work on that project.

select pname,pnumber,count(*)
from project,works_on where pnumber=pno
group by pnumber;

-- 30.For each project on which more than two employees work, 
-- retrieve the project number, the project name, and the number of employees who work on the project.

select pname,pnumber,count(*)
from project,works_on 
where pnumber=pno
group by pnumber,pname having count(*)>2;

-- 31.For each project, retrieve the project number,the project name, 
-- and the number of employees from department 5 who work on the project.

select pnumber,pname,count(*),dnum
from project,works_on,department 
where pnumber=pno and dnum=dnumber
and dnum=5
group by pnumber,pname;

-- 32.For each department that has more than five employees, 
-- retrieve the department number and the number of its employees who are making more than 40000.

select dnumber,count(*)
from employee,works_on
where ssn=essn and salary>40000 
group by dno having count(*)>5;

-- 33. Display all employees names along with their department names.
select fname,lname,dname
from employee,department
where dno=DNUMBER;

-- 35.List the names of employees along with the names 
-- of their supervisors using aliases.

select fname s,fname e
from employee ;


-- 36.Display names of the department and mane of manager for all the departments.

select dname,fname
from department,employee
where ssn=mgrssn;

-- 37.List the departments of each female employee along with her name.

select fname,dname
from employee,department
where DNO=DNUMBER and sex='F';

-- 38.List all employee names and also the names of the department 
-- they manage if they happen to manage a dept.

select fname,dname
from employee,department
where ssn=mgrssn;

-- 39.Retrieve the names of employee who work on all projects that 'john' work on.

select fname,pname 
from employee,project
where dno=dnum in (select*from project,employee where fname='John' and dno=dnum);

-- 40.For each project, list the project name and total hours
-- (by all employee) spent on that project.

select pname,pnumber,sum(hours) as total_hours
from project 
join works_on on project.PNUMBER=works_on.PNO
group by pname,pnumber;

-- 41.Display the name and total number of hours worked by an employee who 
-- is working on maximium number of projects among all the employee.

select fname,hours
from employee,works_on
where ssn=essn and hours=
(select max(count(*)),pno from works_on where ssn=essn
group by pno,pname);

-- 42.Display the names of all employees and also no.of hours, project names 
-- that they work on if they happen to work on any project(use outer join).

select fname,sum(hours) as total_hours,group_concat(pname ),ssn
from employee 
join works_on on employee.ssn=works_on.essn
join project on works_on.pno = project.pnumber
group by ssn,fname
having total_hours IS NOT NULL;


-- 43.List the employee name, project name on which they work and the
-- department they belong to for all the employees using alias names for 
-- the resulting columns.

select fname,group_concat(pname),dname
from employee
join project on employee.dno=project.dnum
join department on project.DNUM=department.DNUMBER
group by fname,dname;

-- 44.List all the departments that contain at least 
-- one occurence of 'C' in their names.

select dname,dnumber
from department
where dname like "%C%";

-- 45. List the projects that are controlled by one department.
select group_concat(pname), group_concat(pnumber),dname
from project,department
where department.DNUMBER=project.DNUM
group by dname;

-- 46.List the managers of the controlling department for all the projects.
select group_concat(pname),mgrssn,fname
from project,department,employee
where dnum=dnumber and ssn=mgrssn
group by  fname,mgrssn;

-- 47.List the location of the controlling departments for all the projects.
select plocation,group_concat(pname)
from project
group by plocation;




