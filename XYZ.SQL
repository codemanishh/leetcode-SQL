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