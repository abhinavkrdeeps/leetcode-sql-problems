Actions table:
+---------+---------+-------------+--------+--------+
| user_id | post_id | action_date | action | extra  |
+---------+---------+-------------+--------+--------+
| 1       | 1       | 2019-07-01  | view   | null   |
| 1       | 1       | 2019-07-01  | like   | null   |
| 1       | 1       | 2019-07-01  | share  | null   |
| 2       | 2       | 2019-07-04  | view   | null   |
| 2       | 2       | 2019-07-04  | report | spam   |
| 3       | 4       | 2019-07-04  | view   | null   |
| 3       | 4       | 2019-07-04  | report | spam   |
| 4       | 3       | 2019-07-02  | view   | null   |
| 4       | 3       | 2019-07-02  | report | spam   |
| 5       | 2       | 2019-07-03  | view   | null   |
| 5       | 2       | 2019-07-03  | report | racism |
| 5       | 5       | 2019-07-03  | view   | null   |
| 5       | 5       | 2019-07-03  | report | racism |
+---------+---------+-------------+--------+--------+
Removals table:
+---------+-------------+
| post_id | remove_date |
+---------+-------------+
| 2       | 2019-07-20  |
| 3       | 2019-07-18  |
+---------+-------------+
Output: 
+-----------------------+
| average_daily_percent |
+-----------------------+
| 75.00                 |
+-----------------------+
-- Explanation: 
-- The percentage for 2019-07-04 is 50% because only one post of two spam reported posts were removed.
-- The percentage for 2019-07-02 is 100% because one post was reported as spam and it was removed.
-- The other days had no spam reports so the average is (50 + 100) / 2 = 75%
-- Note that the output is only one number and that we do not care about the remove dates.

{"headers": ["post_id", "action_date", "action", "extra", "spam_reported", "remove_date", "removed_posts"], 
"values": [[1, "2019-07-01", "view", null, 0, null, 3],
 [1, "2019-07-01", "like", null, 0, null, 3], 
 [1, "2019-07-01", "share", null, 0, null, 3], 
 [3, "2019-07-02", "view", null, 1, "2019-07-18", 2], 
 [3, "2019-07-02", "report", "spam", 1, "2019-07-18", 2], 
 [2, "2019-07-03", "view", null, 0, "2019-07-20", 4],
  [2, "2019-07-03", "report", "racism", 0, "2019-07-20", 4], 
  [5, "2019-07-03", "view", null, 0, null, 4],
   [5, "2019-07-03", "report", "racism", 0, null, 4],
    [2, "2019-07-04", "view", null, 2, "2019-07-20", 4],
     [2, "2019-07-04", "report", "spam", 2, "2019-07-20", 4],
      [4, "2019-07-04", "view", null, 2, null, 4], 
      [4, "2019-07-04", "report", "spam", 2, null, 4]]}


with temp1 as (

    select 
    post_id, action_date, action,extra,
    sum(case when action='report' and extra = 'spam' then 1 else 0 end) over(partition by action_date order by action_date) as spam_reported
    from Actions
),
get_removed_post as 
(
    select a.*,r.remove_date  from temp1  a 
    left join Removals r on a.post_id=r.post_id

),
temp2 as (
    select *,
    sum(case when action='report' and extra = 'spam' and remove_date is not null then 1 else 0 end) over(partition by action_date order by action_date) as removed_posts
    from get_removed_post
)select 
action_date,
removed_posts,removed_posts,post_id
 round(removed_posts/removed_posts) as average_daily_percent  
 from temp2 where  average_daily_percent !=0


 