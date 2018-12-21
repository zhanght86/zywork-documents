/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : fengxiao

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 21/12/2018 12:28:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_active` tinyint(4) DEFAULT '0' COMMENT '是否激活',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES (1, '用户1', '2018-12-21 12:14:46', NULL, 0);
INSERT INTO `t_user` VALUES (2, '用户2', '2018-12-21 12:14:50', NULL, 0);
INSERT INTO `t_user` VALUES (3, '用户3', '2018-12-21 12:14:55', NULL, 0);
INSERT INTO `t_user` VALUES (4, '用户4', '2018-12-21 12:15:00', NULL, 0);
INSERT INTO `t_user` VALUES (5, '用户5', '2018-12-21 12:15:05', NULL, 0);
INSERT INTO `t_user` VALUES (6, '用户6', '2018-12-21 12:15:10', NULL, 0);
INSERT INTO `t_user` VALUES (7, '用户7', '2018-12-21 12:15:15', NULL, 0);
INSERT INTO `t_user` VALUES (8, '用户8', '2018-12-21 12:15:20', NULL, 0);
INSERT INTO `t_user` VALUES (9, '用户9', '2018-12-21 12:15:32', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for t_user_hierarchy
-- ----------------------------
DROP TABLE IF EXISTS `t_user_hierarchy`;
CREATE TABLE `t_user_hierarchy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ancestor_id` int(11) DEFAULT NULL COMMENT '祖先编号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户编号',
  `user_level` int(11) DEFAULT NULL COMMENT '用户级别',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_active` tinyint(4) DEFAULT '0' COMMENT '是否激活',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of t_user_hierarchy
-- ----------------------------
BEGIN;
INSERT INTO `t_user_hierarchy` VALUES (1, 1, 1, 1, '2018-12-21 12:15:42', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (2, 1, 2, 2, '2018-12-21 12:15:48', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (3, 2, 2, 1, '2018-12-21 12:15:48', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (4, 2, 3, 2, '2018-12-21 12:15:57', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (5, 1, 3, 3, '2018-12-21 12:15:57', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (6, 3, 3, 1, '2018-12-21 12:15:57', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (7, 3, 4, 2, '2018-12-21 12:16:04', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (8, 2, 4, 3, '2018-12-21 12:16:04', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (9, 1, 4, 4, '2018-12-21 12:16:04', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (10, 4, 4, 1, '2018-12-21 12:16:04', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (11, 4, 7, 2, '2018-12-21 12:16:10', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (12, 3, 7, 3, '2018-12-21 12:16:10', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (13, 2, 7, 4, '2018-12-21 12:16:10', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (14, 1, 7, 5, '2018-12-21 12:16:10', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (15, 7, 7, 1, '2018-12-21 12:16:10', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (16, 1, 5, 2, '2018-12-21 12:16:20', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (17, 5, 5, 1, '2018-12-21 12:16:20', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (18, 2, 6, 2, '2018-12-21 12:16:27', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (19, 1, 6, 3, '2018-12-21 12:16:27', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (20, 6, 6, 1, '2018-12-21 12:16:27', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (21, 8, 8, 1, '2018-12-21 12:17:05', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (22, 8, 9, 2, '2018-12-21 12:17:09', NULL, 0);
INSERT INTO `t_user_hierarchy` VALUES (23, 9, 9, 1, '2018-12-21 12:17:09', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for t_user_path
-- ----------------------------
DROP TABLE IF EXISTS `t_user_path`;
CREATE TABLE `t_user_path` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '路径编号',
  `user_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '用户路径',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_active` tinyint(4) DEFAULT '0' COMMENT '是否激活',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `idx_user_path` (`user_path`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of t_user_path
-- ----------------------------
BEGIN;
INSERT INTO `t_user_path` VALUES (1, '1', '2018-12-21 12:15:42', NULL, 0);
INSERT INTO `t_user_path` VALUES (2, '1/2', '2018-12-21 12:15:48', NULL, 0);
INSERT INTO `t_user_path` VALUES (3, '1/2/3', '2018-12-21 12:15:57', NULL, 0);
INSERT INTO `t_user_path` VALUES (4, '1/2/3/4', '2018-12-21 12:16:04', NULL, 0);
INSERT INTO `t_user_path` VALUES (5, '1/2/3/4/7', '2018-12-21 12:16:10', NULL, 0);
INSERT INTO `t_user_path` VALUES (6, '1/5', '2018-12-21 12:16:20', NULL, 0);
INSERT INTO `t_user_path` VALUES (7, '1/2/6', '2018-12-21 12:16:27', NULL, 0);
INSERT INTO `t_user_path` VALUES (8, '8', '2018-12-21 12:17:05', NULL, 0);
INSERT INTO `t_user_path` VALUES (9, '8/9', '2018-12-21 12:17:09', NULL, 0);
COMMIT;

-- ----------------------------
-- Procedure structure for invite_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `invite_user`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `invite_user`(in uid int, in pid int)
BEGIN
    -- 如果uid等于pid，表示某个用户自己成为顶级经销商
	declare ancestorId int;
	declare num INT DEFAULT 0;
	declare userLevel int default 2;
	declare currentTime datetime default CURRENT_TIMESTAMP;
	declare userPath text;
	DECLARE hasError INTEGER DEFAULT 0;  
	-- 根据直接父id获取其所有祖先id，祖先id按倒序排列，方便得出用户id与祖先id间是多少级关系
	declare ancestorList cursor for 
	select t_user_hierarchy.ancestor_id from t_user_hierarchy where t_user_hierarchy.user_id = pid 
	order by t_user_hierarchy.ancestor_id desc;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET hasError = 1;  
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET num = 1;
	start transaction;
		if uid != pid then 
			open ancestorList;
				fetch ancestorList into ancestorId;
				while num != 1 do
					insert into t_user_hierarchy (ancestor_id, user_id, user_level, create_time) values(ancestorId, uid, userLevel, currentTime);
					-- 祖先id每循环一次，等级加1
					set userLevel = userLevel + 1;
					fetch ancestorList into ancestorId;
				end while;
			close ancestorList;
		end if;
		-- 自己与自己的关系，user_level为1
		insert into t_user_hierarchy (ancestor_id, user_id, user_level) values(uid, uid, 1);
		-- 保存用户层级路径
		if uid != pid then
			select t_user_path.user_path into userPath from t_user_path where t_user_path.user_path like concat('%', pid);
			insert into t_user_path (user_path, create_time) values(concat(userPath, '/', uid), currentTime);
		else
			insert into t_user_path (user_path, create_time) values(uid, currentTime);
		end if;
	IF hasError = 1 THEN  
		ROLLBACK;  
	ELSE  
		COMMIT;  
  END IF; 
END;
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
