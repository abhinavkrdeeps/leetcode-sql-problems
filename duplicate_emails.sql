Input: 
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output: 
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
-- Explanation: a@b.com is repeated two times.

select person1.email from Person person1
inner join Person person2 on email and person1.id!=person2.id