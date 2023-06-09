-- Aula 10

--Q1
SELECT FNAME, LNAME FROM EMPLOYEE
WHERE SUPER_SSN IS NULL;

--Q2
SELECT FNAME, LNAME FROM EMPLOYEE
WHERE SUPER_SSN IS NOT NULL;

--Q3
SELECT DISTINCT Pnumber FROM PROJECT
WHERE Pnumber IN
( SELECT Pnumber FROM PROJECT, DEPARTMENT, EMPLOYEE
WHERE Dnum = Dnumber AND
Mgr_ssn = Ssn AND Lname = 'Smith')
OR Pnumber IN
( SELECT Pno FROM WORKS_ON, EMPLOYEE
WHERE Essn = Ssn AND Lname = 'Smith');

--Q4
SELECT DISTINCT Essn FROM WORKS_ON
WHERE (Pno, Hours) IN
( SELECT Pno, Hours FROM WORKS_ON WHERE Essn = '123456789');

--Q5
SELECT Lname, Fname
FROM EMPLOYEE
WHERE Salary > ALL
( SELECT Salary FROM EMPLOYEE WHERE Dno = 5 );

--Q6
SELECT E.Fname, E.Lname FROM EMPLOYEE AS E
WHERE E.Ssn IN
( SELECT D.Essn FROM DEPENDENT AS D
WHERE E.Fname = D.Dependent_name AND E.Sex = D.Sex );

--Q7
SELECT E.Fname, E.Lname
FROM EMPLOYEE AS E, DEPENDENT AS D
WHERE E.Ssn = D.Essn AND E.Sex = D.Sex
AND E.Fname = D.Dependent_name;

--Q8
SELECT E.Fname, E.Lname
FROM EMPLOYEE AS E
WHERE EXISTS ( SELECT *
FROM DEPENDENT AS D
WHERE E.Ssn = D.Essn AND E.Sex = D.Sex
AND E.Fname = D.Dependent_name);

SELECT Fname, Lname
FROM EMPLOYEE
WHERE NOT EXISTS ( SELECT * FROM DEPENDENT
WHERE Ssn = Essn );

--Q9
SELECT Fname, Lname
FROM EMPLOYEE
WHERE EXISTS ( SELECT *
FROM DEPENDENT WHERE Ssn = Essn ) AND
EXISTS ( SELECT *
FROM DEPARTMENT WHERE Ssn = Mgr_ssn );

--Q10
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM EMPLOYEE;

--Q11
SELECT SUM(Salary) AS Total_Sal, MAX(Salary) AS Highest_Sal,
MIN(Salary) AS Lowest_Sal, AVG(Salary) AS Average_Sal
FROM EMPLOYEE;

--Q12
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM (EMPLOYEE JOIN DEPARTMENT ON Dno = Dnumber)
WHERE Dname = 'Research';

--Q13
SELECT COUNT(*)
FROM EMPLOYEE;

--Q14
SELECT COUNT(*)
FROM EMPLOYEE, DEPARTMENT
WHERE DNO = DNUMBER AND DNAME = 'Research';

--Q15
SELECT COUNT(DISTINCT Salary)
FROM EMPLOYEE;

--Q16
SELECT Lname, Fname
FROM EMPLOYEE
WHERE ( SELECT COUNT(*)
FROM DEPENDENT
WHERE Ssn = Essn ) >= 2;

--Q17
SELECT Dno, COUNT(*), AVG(Salary)
FROM EMPLOYEE
GROUP BY Dno;

--Q18
SELECT Pnumber, Pname, COUNT(*)
FROM PROJECT, WORKS_ON
WHERE Pnumber = Pno
GROUP BY Pnumber, Pname;

--Q19
SELECT Pnumber, Pname, COUNT(*)
FROM PROJECT, WORKS_ON
WHERE Pnumber = Pno
GROUP BY Pnumber, Pname
HAVING COUNT(*) > 2;

--Q20
SELECT Pnumber, Pname, COUNT(*)
FROM PROJECT, WORKS_ON, EMPLOYEE
WHERE Pnumber = Pno AND Ssn = Essn AND Dno = 5
GROUP BY Pnumber, Pname;

--Q21
SELECT Dno, COUNT(*)
FROM EMPLOYEE
WHERE Salary>4000
GROUP BY Dno
HAVING COUNT(*) > 3;

--Q22
SELECT Dno, COUNT(*)
FROM EMPLOYEE
WHERE Salary>4000 AND Dno IN
( SELECT Dno
FROM EMPLOYEE GROUP BY Dno
HAVING COUNT(*) > 3) 
GROUP BY Dno;

