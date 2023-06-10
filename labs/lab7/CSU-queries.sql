-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find the campus that granted the largest number of degrees from 1990 to 
-- 2004. Report full name of the campus, the county it is located in, and 
-- the total number of degrees granted.
with DegreesGranted as (
    select CampusId,Campus,SUM(degrees) as Granted, County
    from degrees
    join campuses on Id = CampusId
    group by CampusId
)
select Campus, County, Granted
from DegreesGranted
where Granted = (
    select MAX(Granted) from DegreesGranted
);

-- Q2
-- Find the ratio between the largest and the smallest number of degrees 
-- granted by a CSU campus over the period of 1990 through 2004 (inclusive). 
-- Report just the ratio.
with DegreesGranted as (
    select CampusId,Campus,SUM(degrees) as Granted, County
    from degrees
    join campuses on Id = CampusId
    group by CampusId
)
select MAX(Granted) / MIN(Granted) as Ratio
from DegreesGranted;

-- Q3
-- For each university report the year it had the best (lowest) 
-- student-to-faculty ratio (use FTE values for both). Sort in ascending order 
-- by the best ratio. Report the full name of the university, the year, and 
-- the ratio.
with EnrollmentsPerYear as (
    select Campus,enrollments.Year,
    MAX(enrollments.FTE / faculty.FTE) as Ratio from campuses
    join faculty on faculty.CampusId = Id
    join enrollments on enrollments.CampusId = Id
    and faculty.Year = enrollments.Year
    group by enrollments.Year,Campus
)
select Campus,Year, Ratio from EnrollmentsPerYear e1
where Ratio = (
    select MIN(Ratio) from EnrollmentsPerYear e2
    where e2.Campus = e1.Campus
)
order by Ratio;

-- Q4
-- Find the year when the largest number of universities had their best 
-- student-to-faculty ratio. Report the year, and the percentage of all CSU 
-- campuses that had the best student-to-faculty ratio that year. (DO NOT 
-- hardcode the number of campuses into the query).
with EnrollmentsPerYear as (
    select Campus,enrollments.Year,
    MAX(enrollments.FTE / faculty.FTE) as Ratio from campuses
    join faculty on faculty.CampusId = Id
    join enrollments on enrollments.CampusId = Id
    and faculty.Year = enrollments.Year
    group by enrollments.Year,Campus
),
BestRatio as (
    select Year, COUNT(*) as BestRatio from EnrollmentsPerYear e1
    where Ratio = (
        select MIN(Ratio) from EnrollmentsPerYear e2
        where e2.Campus = e1.Campus
    )
    group by Year
)
select Year, (BestRatio / (select COUNT(*) from campuses))*100 as Percent
from BestRatio
where BestRatio = (
    select MAX(BestRatio) from BestRatio
);

-- Q5
-- For each campus that did not have any Engineering programs (graduate or 
-- undergraduate) in 2004, report average faculty FTE for the 2002 -- 2004 
-- (inclusive) period. Report full campus name and the average faculty FTE, 
-- sort output in descending order by the average faculty FTE.
with NoEngineering as (
    select CampusId, AVG(FTE) as AvgFTE from faculty
    where Year >= 2002 and Year <= 2004
    and CampusId not in (
        select CampusId from discEnr
        where Year = 2004 and Discipline in (
            select Id from disciplines
            where Name like '%Engineering%'
        )
    )
    group by CampusId
)
select Campus, AvgFTE 
from NoEngineering
join campuses on Id = CampusId
order by AvgFTE desc;

-- Q6
-- For each campus report whether it existed in 1955. Output name of the 
-- campus and "existed" or "did not exist". Sort output in alphabetical 
-- order by campus.
SELECT DISTINCT Campus, CASE WHEN campuses.Year <= 1955 THEN 'existed'
    ELSE 'did not exist' END AS status
FROM campuses
LEFT OUTER JOIN (
    select CampusId, Year from enrollments
    union
    select CampusId, Year from faculty
    union
    select CampusId, Year from fees
    union
    select CampusId, Year from degrees
) as Years on Years.CampusId = Id
order by Campus;
