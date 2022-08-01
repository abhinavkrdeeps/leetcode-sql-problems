Salary table:
+----+-------------+--------+------------+
| id | employee_id | amount | pay_date   |
+----+-------------+--------+------------+
| 1  | 1           | 9000   | 2017/03/31 |
| 2  | 2           | 6000   | 2017/03/31 |
| 3  | 3           | 10000  | 2017/03/31 |
| 4  | 1           | 7000   | 2017/02/28 |
| 5  | 2           | 6000   | 2017/02/28 |
| 6  | 3           | 8000   | 2017/02/28 |
+----+-------------+--------+------------+

march - 8333
feb - 7333

1 17-03 9000    more
1 17-02 7000    same
2 17-03 8000    lower
2 17-02 7000    same




Employee table:
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 2             |
| 3           | 2             |
+-------------+---------------+

Output
+-----------+---------------+------------+
| pay_month | department_id | comparison |
+-----------+---------------+------------+
| 2017-02   | 1             | same       |
| 2017-03   | 1             | higher     |
| 2017-02   | 2             | same       |
| 2017-03   | 2             | lower      |
+-----------+---------------+------------+




with join_res as ( 
select sal.amount as amount, sal.pay_date as pay_date , emp.department_id as department_id
 from (
(select * from salary) sal
inner join
(select * from employee) emp
on (sal.employee_id=emp.employee_id)
)
),
temp1 as 
(
select * ,
avg(amount) over(partition by department_id, pay_date order by department_id) as department_monthly_sal,
avg(amount) over(partition by pay_date) as company_monthly_sal

from join_res

),
final_res as (

select distinct substring(pay_date,1,7) as pay_month, department_id,
case when department_monthly_sal>company_monthly_sal then 'higher' when department_monthly_sal<company_monthly_sal then 'lower' else 'same' end as comparison 
from temp1
) select * from final_res