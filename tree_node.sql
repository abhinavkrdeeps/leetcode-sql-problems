Tree table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+
Output: 
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
+----+-------+
-- Explanation: 
-- Node 1 is the root node because its parent node is null and it has child nodes 2 and 3.
-- Node 2 is an inner node because it has parent node 1 and child node 4 and 5.
-- Nodes 3, 4, and 5 are leaf nodes because they have parent nodes and they do not have child nodes.

select id , max(node_type ) as type from (
select id, 'Root' as node_type from tree where p_id is null 
union all
select id , 'Leaf' as node_type from tree where id not in (select p_id from tree where p_id is not null)
union all
select id , 'Inner' as node_type from tree where id in (select p_id from tree where p_id is not null) ) x 
group by id;