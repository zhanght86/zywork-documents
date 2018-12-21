-- 采用末尾N级返佣机制，如果分销商自己购买，则此分销商自己为第N级分销商，拿第N级分销商返佣，级别越高，返佣越高
-- 以三级分销为例说明
-- 1->2->3，则1为一级经销商，2为二级经销商，3为三级经销商，一级经销商获取的返佣比例最低，三级经销商获取的返佣比例最高
-- 1->2->3，如果客户从3手上购买了商品，则3获取三级返佣，2获取二级返佣，1获取一级返佣
-- 1->2->3，如果3自己购买了商品，则3获取三级返佣，2获取二级返佣，1获取一级返佣
-- 1->2->3，如果客户从2手上购买了商品，则2获取三级返佣，1获取二级返佣
-- 1->2->3，如果1自己购买了商品，则1获取三级返佣

-- 假设当前分销级别为变量N，等级为变量k

-- 查询所有顶级分销商(没有上级分销商)
select t_user.id, t_user.name from t_user, t_user_hierarchy
where t_user.id = t_user_hierarchy.user_id
group by t_user.id, t_user.name 
having(count(t_user_hierarchy.user_id) = 1)

-- 查询用户编号为1的分销商下面的二级分销商，k = t_user_hierarchy.user_level = 2
select t_user.* from t_user, 
(
	select t_user_hierarchy.user_id from t_user, t_user_hierarchy 
	where t_user.id = t_user_hierarchy.ancestor_id 
	and t_user.id = 1
	and t_user_hierarchy.user_level = 2
) as uh
where t_user.id = uh.user_id

-- 查询编号为1的分销商下面的三级分销商，k = t_user_hierarchy.user_level = 3
select t_user.* from t_user, 
(
	select t_user_hierarchy.user_id from t_user, t_user_hierarchy 
	where t_user.id = t_user_hierarchy.ancestor_id 
	and t_user.id = 1
	and t_user_hierarchy.user_level = 3
) as uh
where t_user.id = uh.user_id

-- 查询编号为1的分销商下面的四级分销商，k = t_user_hierarchy.user_level = 4
-- 查询编号为1的分销商下面的X级分销商，k = t_user_hierarchy.user_level = X
select t_user.* from t_user, 
(
	select t_user_hierarchy.user_id from t_user, t_user_hierarchy 
	where t_user.id = t_user_hierarchy.ancestor_id 
	and t_user.id = 1
	and t_user_hierarchy.user_level = 4
) as uh
where t_user.id = uh.user_id

-- 查询编号为1的分销商发展的二级和三级分销商，k = 2 or k = 3 ==> t_user_hierarchy.user_level = 2 or t_user_hierarchy.user_level = 3
select t_user.*, uh.user_level from t_user, 
(
	select t_user_hierarchy.user_id, t_user_hierarchy.user_level from t_user, t_user_hierarchy 
	where t_user.id = t_user_hierarchy.ancestor_id 
	and t_user.id = 1
	and (t_user_hierarchy.user_level in(2, 3))
) as uh
where t_user.id = uh.user_id
order by uh.user_level

-- 查询编号为1的分销商发展的二级,三级和四分销商，k = 2 or k = 3 or k = 4 ==> t_user_hierarchy.user_level = 2 or t_user_hierarchy.user_level = 3 or t_user_hierarchy.user_level = 4
select t_user.*, uh.user_level from t_user, 
(
	select t_user_hierarchy.user_id, t_user_hierarchy.user_level from t_user, t_user_hierarchy 
	where t_user.id = t_user_hierarchy.ancestor_id 
	and t_user.id = 1
	and (t_user_hierarchy.user_level in (2, 3, 4))
) as uh
where t_user.id = uh.user_id
order by uh.user_level

-- 查询编号为4的分销商上面的三级分销商，假设此时分销等级支持4级，k = 3, t_user_hierarchy.user_level = N - k + 1 ==> 4 - 3 + 1 = 2
select t_user.* from t_user, 
(
	select t_user_hierarchy.ancestor_id from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 4
	and t_user_hierarchy.user_level = 4 - 3 + 1
) as uh
where t_user.id = uh.ancestor_id

-- 查询编号为4的分销商上面的二级分销商，假设此时分销等级支持4级，k = 2, t_user_hierarchy.user_level = N - k + 1 ==> 4 - 2 + 1 = 3
select t_user.* from t_user, 
(
	select t_user_hierarchy.ancestor_id from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 4
	and t_user_hierarchy.user_level = 4 - 2 + 1
) as uh
where t_user.id = uh.ancestor_id

-- 查询编号为4的分销商上面的一级分销商，假设此时分销等级支持4级，k = 1, t_user_hierarchy.user_level = N - k + 1 ==> 4 - 1 + 1 = 4
select t_user.* from t_user, 
(
	select t_user_hierarchy.ancestor_id from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 4
	and t_user_hierarchy.user_level = 4 - 1 + 1
) as uh
where t_user.id = uh.ancestor_id

-- 查询编号为4的分销商上面的所有分销商，假设此时分销等级支持4级，k = 3, 2, 1, t_user_hierarchy.user_level = N - k + 1 ==> 4 - 3 + 1 || 4 - 2 + 1 || 4 - 1 + 1 = 3
select t_user.*, 4 - uh.user_level + 1 as level from t_user, 
(
	select t_user_hierarchy.ancestor_id, t_user_hierarchy.user_level from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 4
	and (t_user_hierarchy.user_level in (4 - 3 + 1, 4 - 2 + 1, 4 - 1 + 1))
) as uh
where t_user.id = uh.ancestor_id
order by uh.user_level desc

-- 查询编号为3的分销商上面的三级分销商，假设此时分销等级支持4级，k = 3, t_user_hierarchy.user_level = N - k + 1 ==> 4 - 3 + 1 = 2
select t_user.* from t_user, 
(
	select t_user_hierarchy.ancestor_id from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 3
	and t_user_hierarchy.user_level = 4 - 3 + 1
) as uh
where t_user.id = uh.ancestor_id

-- 查询编号为3的分销商上面的二级分销商，假设此时分销等级支持4级，k = 2, t_user_hierarchy.user_level = N - k + 1 ==> 4 - 2 + 1 = 3
select t_user.* from t_user, 
(
	select t_user_hierarchy.ancestor_id from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 3
	and t_user_hierarchy.user_level = 4 - 2 + 1
) as uh
where t_user.id = uh.ancestor_id

-- 查询编号为3的分销商上面的一级分销商，假设此时分销等级支持4级，k = 1, t_user_hierarchy.user_level = N - k + 1 ==> 4 - 1 + 1 = 4
select t_user.* from t_user, 
(
	select t_user_hierarchy.ancestor_id from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 3
	and t_user_hierarchy.user_level = 4 - 1 + 1
) as uh
where t_user.id = uh.ancestor_id

-- 查询编号为3的分销商上面的二级分销商，假设此时分销等级支持3级，k = 2, t_user_hierarchy.user_level = N - k + 1 ==> 3 - 2 + 1 = 2
select t_user.* from t_user, 
(
	select t_user_hierarchy.ancestor_id from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 3
	and t_user_hierarchy.user_level = 3 - 2 + 1
) as uh
where t_user.id = uh.ancestor_id

-- 查询编号为3的分销商上面的一级分销商，假设此时分销等级支持3级，k = 1, t_user_hierarchy.user_level = N - k + 1 ==> 3 - 1 + 1 = 3
select t_user.* from t_user, 
(
	select t_user_hierarchy.ancestor_id from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 3
	and t_user_hierarchy.user_level = 3 - 1 + 1
) as uh
where t_user.id = uh.ancestor_id

-- 查询编号为3的分销商上面的所有分销商，假设此时分销等级支持4级，k = 3, 2, 1, t_user_hierarchy.user_level = N - k + 1 ==> 4 - 3 + 1 || 4 - 2 + 1 || 4 - 1 + 1 = 3
select t_user.*, 4 - uh.user_level + 1 as level from t_user, 
(
	select t_user_hierarchy.ancestor_id, t_user_hierarchy.user_level from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 3
	and (t_user_hierarchy.user_level in (4 - 3 + 1, 4 - 2 + 1, 4 - 1 + 1))
) as uh
where t_user.id = uh.ancestor_id
order by uh.user_level desc

-- 查询编号为3的分销商上面的所有分销商，假设此时分销等级支持3级，k = 2, 1, t_user_hierarchy.user_level = N - k + 1 ==> 3 - 2 + 1 || 3 - 1 + 1
select t_user.*, 3 - uh.user_level + 1 as level from t_user, 
(
	select t_user_hierarchy.ancestor_id, t_user_hierarchy.user_level from t_user, t_user_hierarchy
	where t_user.id = t_user_hierarchy.ancestor_id
	and t_user_hierarchy.user_id = 3
	and (t_user_hierarchy.user_level in (3 - 2 + 1, 3 - 1 + 1))
) as uh
where t_user.id = uh.ancestor_id
order by uh.user_level desc

-- 查询编号为3的经销商的所有发展路径
select t_user_path.* from t_user_path where t_user_path.user_path like '%3%'

-- 查询编号为9的经销商的所有发展路径
select t_user_path.* from t_user_path where t_user_path.user_path like '%9%'

