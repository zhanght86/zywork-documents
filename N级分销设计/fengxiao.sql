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

 Date: 30/11/2018 16:04:20
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES (1, 'A1');
INSERT INTO `t_user` VALUES (2, 'A2');
INSERT INTO `t_user` VALUES (3, 'A3');
INSERT INTO `t_user` VALUES (4, 'A4');
INSERT INTO `t_user` VALUES (5, 'A5');
INSERT INTO `t_user` VALUES (6, 'A6');
INSERT INTO `t_user` VALUES (7, 'A7');
INSERT INTO `t_user` VALUES (8, 'A8');
COMMIT;

-- ----------------------------
-- Table structure for t_user_ancestor_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_user_ancestor_relation`;
CREATE TABLE `t_user_ancestor_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ancestor_id` int(11) DEFAULT NULL COMMENT '祖先编号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户编号',
  `user_level` int(11) DEFAULT NULL COMMENT '用户级别，如1->2，则此条记录对应的level为2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of t_user_ancestor_relation
-- ----------------------------
BEGIN;
INSERT INTO `t_user_ancestor_relation` VALUES (1, 1, 1, 1);
INSERT INTO `t_user_ancestor_relation` VALUES (2, 1, 2, 2);
INSERT INTO `t_user_ancestor_relation` VALUES (3, 2, 2, 1);
INSERT INTO `t_user_ancestor_relation` VALUES (4, 2, 3, 2);
INSERT INTO `t_user_ancestor_relation` VALUES (5, 1, 3, 3);
INSERT INTO `t_user_ancestor_relation` VALUES (6, 3, 3, 1);
INSERT INTO `t_user_ancestor_relation` VALUES (7, 3, 4, 2);
INSERT INTO `t_user_ancestor_relation` VALUES (8, 2, 4, 3);
INSERT INTO `t_user_ancestor_relation` VALUES (9, 1, 4, 4);
INSERT INTO `t_user_ancestor_relation` VALUES (10, 4, 4, 1);
INSERT INTO `t_user_ancestor_relation` VALUES (11, 1, 5, 2);
INSERT INTO `t_user_ancestor_relation` VALUES (12, 5, 5, 1);
INSERT INTO `t_user_ancestor_relation` VALUES (13, 2, 6, 2);
INSERT INTO `t_user_ancestor_relation` VALUES (14, 1, 6, 3);
INSERT INTO `t_user_ancestor_relation` VALUES (15, 6, 6, 1);
INSERT INTO `t_user_ancestor_relation` VALUES (16, 4, 7, 2);
INSERT INTO `t_user_ancestor_relation` VALUES (17, 3, 7, 3);
INSERT INTO `t_user_ancestor_relation` VALUES (18, 2, 7, 4);
INSERT INTO `t_user_ancestor_relation` VALUES (19, 1, 7, 5);
INSERT INTO `t_user_ancestor_relation` VALUES (20, 7, 7, 1);
COMMIT;

-- ----------------------------
-- Procedure structure for invite_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `invite_user`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `invite_user`(in uid int, in pid int)
BEGIN
	declare ancestorId int;
	declare num INT DEFAULT 0;
	declare userLevel int default 2;
	declare ancestor_list cursor for 
	-- 根据直接父id获取其所有祖先id，祖先id按倒序排列，方便得出用户id与祖先id间是多少级关系
	select uar.ancestor_id from t_user_ancestor_relation uar where uar.user_id = pid order by uar.ancestor_id desc;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET num=1;
	if uid != pid then 
		open ancestor_list;
			fetch ancestor_list into ancestorId;
			while num != 1 do
				insert into t_user_ancestor_relation (ancestor_id, user_id, user_level) values(ancestorId, uid, userLevel);
				-- 父id每循环一次，等级加1
				set userLevel = userLevel + 1;
				fetch ancestor_list into ancestorId;
			end while;
		close ancestor_list;
	end if;
	-- 自己与自己的关系，user_level为1
	insert into t_user_ancestor_relation (ancestor_id, user_id, user_level) values(uid, uid, 1);
END;
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
