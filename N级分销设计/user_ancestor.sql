-- 末尾三级返佣机制，如果分销商自己购买，则此分销商自己为一级分销商，拿一级分销商的返佣
-- 查询所有一级分销商
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.user_id 
and uar.user_level = 1;

-- 查询指定分销商上面的二级分销商
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.ancestor_id 
and uar.user_id = 4 
and uar.user_level = 2;

-- 查询指定分销商上面的三级分销商
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.ancestor_id 
and uar.user_id = 4
and uar.user_level = 3;

-- 查询指定分销商上面的二级和三级分销商
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.ancestor_id 
and uar.user_id = 3
and uar.user_level = 2
union all 
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.ancestor_id 
and uar.user_id = 3
and uar.user_level = 3;

-- 查询指定分销商发展的二级分销商
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.user_id 
and uar.ancestor_id = 2
and uar.user_level = 2;

-- 查询指定分销商发展的一级分销商
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.user_id 
and uar.ancestor_id = 3
and uar.user_level = 3;

-- 查询指定分销商发展的二级和一级分销商
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.user_id 
and uar.ancestor_id = 2
and uar.user_level = 2
union all 
select * from t_user u, t_user_ancestor_relation uar 
where u.id = uar.user_id 
and uar.ancestor_id = 3
and uar.user_level = 3;