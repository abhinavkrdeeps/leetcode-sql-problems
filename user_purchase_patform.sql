+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| spend_date  | date    |
| platform    | enum    | 
| amount      | int     |
+-------------+---------+

+---------+------------+----------+--------+
| user_id | spend_date | platform | amount |  is_mobile   is_desktop
+---------+------------+----------+--------+
| 1       | 2019-07-01 | mobile   | 100    |   1            0
| 1       | 2019-07-01 | desktop  | 100    |   0            1
| 2       | 2019-07-01 | mobile   | 100    |   1            0
| 2       | 2019-07-02 | mobile   | 100    |   1            0
| 3       | 2019-07-01 | desktop  | 100    |   0            1
| 3       | 2019-07-02 | desktop  | 100    |   0            1
+---------+------------+----------+--------+
Output: 
+------------+----------+--------------+-------------+
| spend_date | platform | total_amount | total_users |
+------------+----------+--------------+-------------+
| 2019-07-01 | desktop  | 100          | 1           |
| 2019-07-01 | mobile   | 100          | 1           |
| 2019-07-01 | both     | 200          | 1           |
| 2019-07-02 | desktop  | 100          | 1           |
| 2019-07-02 | mobile   | 100          | 1           |
| 2019-07-02 | both     | 0            | 0           |
+------------+----------+--------------+-------------+ 



select user_id, spend_date, amount,
case when platform = 'mobile' then 1 else 0 as is_mobile,
case when platform = 'desktop' then 1 else 0 as is_desktop,
 from Spending;