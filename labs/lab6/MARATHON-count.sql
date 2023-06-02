-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- For each sex/age group, report total number of runners in the group, the 
-- overall place of the best runner in the group and the overall place of the 
-- worst runner in the group. Output result sorted by age group and sorted by 
-- sex (F followed by M) within each age group.
SELECT AgeGroup, Sex, COUNT(*), MIN(Place), MAX(Place)
FROM marathon m
GROUP BY AgeGroup, Sex
ORDER BY AgeGroup, Sex ASC;

-- Q2
-- Report the total number of sex/age groups for which both the first and the 
-- second place runners (within the group) hail from the same state.
SELECT COUNT(*)
FROM marathon m, marathon m2
WHERE m.AgeGroup = m2.AgeGroup AND m.Sex = m2.Sex AND m.GroupPlace = 1 
    AND m2.GroupPlace = 2 AND m.State = m2.State;

-- Q3
-- For each full minute, report the total number of runners whose pace was 
-- between that number of minutes and the next. (That is, how many runners 
-- ran the marathon at a pace between 5 and 6 mins, how many - at a pace 
-- between 6 and 7 mins, and so on).
SELECT DATE_FORMAT(Pace, '%i') AS Minutes, COUNT(*)
FROM marathon m
GROUP BY Minutes
ORDER BY Minutes ASC;

-- Q4
-- For each state, whose representatives participated in the marathon report 
-- the number of runners from it who finished in top 10 in their sex-age group 
-- (if a state did not have runners in top 10s, do not output information 
-- about the state). Output in descending order by the computed number.
SELECT State, COUNT(*) AS Top10
FROM marathon m
WHERE m.GroupPlace <= 10
GROUP BY State
ORDER BY Top10 DESC, State ASC;
