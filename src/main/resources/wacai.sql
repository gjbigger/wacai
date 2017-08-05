/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50536
Source Host           : 127.0.0.1:3306
Source Database       : wacai

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2017-08-05 12:16:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_account
-- ----------------------------
DROP TABLE IF EXISTS `t_account`;
CREATE TABLE `t_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime NOT NULL,
  `limits` double DEFAULT NULL,
  `bill_day` int(11) DEFAULT NULL,
  `repay_day` int(11) DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_account_type
-- ----------------------------
DROP TABLE IF EXISTS `t_account_type`;
CREATE TABLE `t_account_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_account_unit
-- ----------------------------
DROP TABLE IF EXISTS `t_account_unit`;
CREATE TABLE `t_account_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `abbreviation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_loan
-- ----------------------------
DROP TABLE IF EXISTS `t_loan`;
CREATE TABLE `t_loan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` double DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `loan_body_account_id` int(11) DEFAULT NULL,
  `time` date DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_loan_type
-- ----------------------------
DROP TABLE IF EXISTS `t_loan_type`;
CREATE TABLE `t_loan_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  `is_new` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_pay_in
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_in`;
CREATE TABLE `t_pay_in` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` double DEFAULT NULL,
  `time` date DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_pay_in_type
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_in_type`;
CREATE TABLE `t_pay_in_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_pay_out
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_out`;
CREATE TABLE `t_pay_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` double DEFAULT NULL,
  `big_type_id` int(11) DEFAULT NULL,
  `small_type_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `time` date DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_pay_out_big_type
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_out_big_type`;
CREATE TABLE `t_pay_out_big_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_pay_out_small_type
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_out_small_type`;
CREATE TABLE `t_pay_out_small_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_transfer
-- ----------------------------
DROP TABLE IF EXISTS `t_transfer`;
CREATE TABLE `t_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `src_account_id` int(11) DEFAULT NULL,
  `dest_account_id` int(11) DEFAULT NULL,
  `src_money` double DEFAULT NULL,
  `dest_money` double DEFAULT NULL,
  `time` date DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `user_pwd` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `default_account_unit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
