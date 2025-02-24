-- Tanner Rohde - Sawyer Theis - Max Theis
-- Assignment 3
-- Due 2-26-25

--1. List the ID, name, salary of all instructors whose salary is greater than every average salary of every department
select id, name, salary
    from instructor
    where salary > all (
        select avg(salary)
	    from instructor
    );


--2. List the ID, name, and course_id of all students enrolled in Fall 2017
select student.id, student.name, takes.course_id
    from student, takes
    where student.id = takes.id
    and takes.semester = 'Fall'
    and takes.year = 2017;


--3. List the course_id and the number of students enrolled of each course offered in Spring 2018
	-- Courses with different sec_id values are the same course
select course_id, count(id) as NumOfStudents
    from takes
    where semester = 'Spring'
    and year = 2018
    group by course_id;


--4. List all student's names who have never received an A or A- grade in any course
select distinct student.name
	from student
	join takes on student.id = takes.id
	where takes.grade not in ('A', 'A-');


--5. List all student IDs and names for students who have not taken any courses offered before 2018
select student.name, student.id
    from student
    join takes on student.id = takes.id
    group by student.name, student.id
    having min(takes.year) >= 2018;


--6. List the highest instructor salary for each department, except Music
select salary, dept_name
    from instructor
    where salary = (
        select max(salary)
        from instructor as i
        where i.dept_name = instructor.dept_name
    )
    and dept_name != 'Music';

--7. List the ID, name and the number of courses taught for all instructors
	-- The number of courses is 0 for instructors who have not taught any courses
select instructor.id, instructor.name, count(teaches.course_id) as countOfCourses
    from instructor
    left join teaches on instructor.id = teaches.id
    group by instructor.id, instructor.name;

--#8. List the name and the number of instructors assigned to each department
	-- The number of instructors is 0 for departments that have no instructors
select dept_name, count(dept_name) as NumOfInstrutors
    from instructor
    group by dept_name;
    

--9. List the ID and name of all students who took courses in both Fall 2017 and Spring 2018
select student.id, student.name
    from student
    join takes on student.id = takes.id
    where takes.semester = 'Fall'
    and takes.year = 2017
    
UNION

select student.id, student.name
    from student
    join takes on student.id = takes.id
    where takes.semester = 'Spring'
    and takes.year = 2018;

    
--10. List the ID and name of all students who have never taken a course at the university
select student.id, student.name
    from student
    left join takes on student.id = takes.id
    where takes.id is null;
