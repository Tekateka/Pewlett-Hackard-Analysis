--Deliverable 1: The Number of Retiring Employees by Title
--create retirement titels table
SELECT e.emp_no,
		e.first_name, 
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_title
FROM employees as e 
inner join titles as t
on (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- remove duplicate entities using DISTINC ON
SELECT DISTINCT ON (emp_no) emp_no,
 		rt.first_name,
 		rt.last_name,
 		rt.title
INTO unique_titles
FROM retirement_title as rt 
ORDER BY emp_no, to_date DESC;

-- Number of employees by thier most recent job title
select count(ut.emp_no), 
		ut.title 
INTO retiring_titles
from unique_titles as ut 
group by ut.title 
order by count(ut.title) desc;


-- Deliverable 2. Employees eligible for the mentorship program

SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name, 
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
INTO mentorship_eligibility
from employees as e 
inner join dept_emp as de 
on (e.emp_no = de.emp_no)
inner join titles as t 
on (e.emp_no = t.emp_no)
where (de.to_date = '9999-01-01')
	and (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')	
ORDER BY e.emp_no;


--Number of employees eligible for mentorship by title
SELECT COUNT(me.emp_no),
			me.title
FROM mentorship_eligibility as me 
GROUP BY me.title
order by count(me.title) desc;

--Number of retiring employees by department 
select distinct on(de.emp_no) emp_no,
					de. dept_no,
					de.to_date
INTO recent_dept
from dept_emp as de
order by de.emp_no asc, to_date DESC;

select ut.emp_no,
		ut.title, 
		rd.dept_no,
		rd.to_date,
		d.dept_name
INTO dept_order
from unique_titles as ut 
left join recent_dept as rd 
on ut.emp_no = rd.emp_no
left join departments as d 
on rd.dept_no = d.dept_no;


select count(do2.emp_no),
			do2.dept_name
from dept_order as do2 
group by dept_name
order by count desc;
