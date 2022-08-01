-- https://leetcode.com/problems/evaluate-boolean-expression/
# Write your MySQL query statement below
select expressions.left_operand, expressions.operator, expressions.right_operand,

case when operator = '>' then if(left_p.value > right_p.value, 'true', 'false') 
when operator = '<' then if(left_p.value < right_p.value, 'true', 'false') 
when operator = '=' then if(left_p.value = right_p.value, 'true', 'false') 
end as value
from expressions
left join variables left_p on expressions.left_operand=left_p.name
left join variables right_p on expressions.right_operand = right_p.name