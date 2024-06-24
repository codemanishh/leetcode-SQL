-- 1581. Customer Who Visited but Did Not Make Any Transactions
-- Table: Visits
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | visit_id    | int     |
-- | customer_id | int     |
-- +-------------+---------+
-- Table: Transactions
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | transaction_id | int     |
-- | visit_id       | int     |
-- | amount         | int     |
-- +----------------+---------+
-- Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
select customer_id,
    count(*) as count_no_trans
from Visits
where visit_id not in (
        select visit_id
        from Transactions
        where amount is not null
    )
group by customer_id;

-- 1661. Average Time of Process per Machine
-- Table: Activity
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | machine_id     | int     |
-- | process_id     | int     |
-- | activity_type  | enum    |
-- | timestamp      | float   |
-- +----------------+---------+
-- Input: 
-- Activity table:
-- +------------+------------+---------------+-----------+
-- | machine_id | process_id | activity_type | timestamp |
-- +------------+------------+---------------+-----------+
-- | 0          | 0          | start         | 0.712     |
-- | 0          | 0          | end           | 1.520     |
-- | 0          | 1          | start         | 3.140     |
-- | 0          | 1          | end           | 4.120     |
-- | 1          | 0          | start         | 0.550     |
-- | 1          | 0          | end           | 1.550     |
-- | 1          | 1          | start         | 0.430     |
-- | 1          | 1          | end           | 1.420     |
-- +------------+------------+---------------+-----------+
-- Output: 
-- +------------+-----------------+
-- | machine_id | processing_time |
-- +------------+-----------------+
-- | 0          | 0.894           |
-- | 1          | 0.995           |
-- +------------+-----------------+
-- Explanation: 
-- There are 3 machines running 2 processes each.
-- Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
-- Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
-- Machine 2's average time is ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456

select A1.machine_id, ROUND(AVG( A2.timestamp - A1.timestamp),3) AS processing_time 
FROM
ACTIVITY A1
JOIN 
ACTIVITY A2
ON
A1.machine_id=A2.machine_id 
and
A1.process_id=A2.process_id
AND 
A2.timestamp > A1.timestamp
group BY A1.machine_id;


-- 577. Employee Bonus
-- Table: Employee
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | empId       | int     |
-- | name        | varchar |
-- | supervisor  | int     |
-- | salary      | int     |
-- +-------------+---------+
-- Table: Bonus
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | empId       | int  |
-- | bonus       | int  |
-- +-------------+------+
-- Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
# Write your MySQL query statement below
SELECT 
  E.NAME, 
  COALESCE(B.BONUS, NULL) AS BONUS
FROM 
  EMPLOYEE E
  LEFT JOIN BONUS B ON E.EMPID = B.EMPID
WHERE 
  B.BONUS < 1000 OR B.BONUS IS NULL;
