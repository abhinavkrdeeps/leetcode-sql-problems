-- https://leetcode.com/problems/median-employee-salary/
with get_rownum_and_cnt as 
(

    select * ,
    row_number() over(partition by company order by salary asc) rn,
    count(1) over(partition by company) cnt
    from employee
)

select id,company,salary from get_rownum_and_cnt
where (cnt % 2 = 0 and rn in (cnt / 2, cnt / 2 + 1)) or
    (cnt % 2 <> 0 and rn = round(cnt / 2))