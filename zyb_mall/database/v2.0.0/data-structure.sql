-- MySQL Script generated by MySQL Workbench
-- Sat Oct 26 22:22:19 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zyb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zyb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zyb` DEFAULT CHARACTER SET utf8mb4 ;
USE `zyb` ;

-- -----------------------------------------------------
-- Table `zyb`.`tb_surname`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_surname` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL COMMENT '姓氏',
  `select_key` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `SN_name_IDX` (`name` ASC) INVISIBLE,
  INDEX `SN_key_IDX` (`select_key` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '姓氏表';


-- -----------------------------------------------------
-- Table `zyb`.`tb_surname_punch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_surname_punch` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `punch_count` BIGINT NOT NULL DEFAULT 0 COMMENT '今日打卡次数',
  `punch_date` DATE NOT NULL,
  `surname_id` INT NOT NULL COMMENT '姓氏id',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `SNP_name_punch_UNQ` (`surname_id` ASC, `punch_date` ASC) VISIBLE,
  INDEX `fk_tb_surname_punch_tb_surname1_idx` (`surname_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zyb`.`tb_antique_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_antique_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `antique_name` VARCHAR(45) NOT NULL COMMENT '鉴赏分类名',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zyb`.`tb_user_pro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_user_pro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `antique_type_id` INT NOT NULL COMMENT '鉴赏种类分类',
  `user_id` BIGINT NOT NULL COMMENT '用户id（外键）',
  `mobile` VARCHAR(45) NOT NULL,
  `realname` VARCHAR(45) NOT NULL,
  `id_card` CHAR(18) NOT NULL,
  `rec_realname` VARCHAR(45) NULL COMMENT '推荐专家名',
  `rec_mobile` VARCHAR(45) NULL COMMENT '推荐专家手机号',
  `pro_detail` LONGTEXT NOT NULL COMMENT '个人简历',
  `pro_img` VARCHAR(1024) NOT NULL COMMENT '个人照片',
  `created_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_user_rec_tb_antique_type1_idx` (`antique_type_id` ASC) VISIBLE,
  INDEX `fk_tb_user_rec_tb_user1_idx` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '专家表';


-- -----------------------------------------------------
-- Table `zyb`.`tb_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `wx_union_id` VARCHAR(255) NULL,
  `wx_open_id` VARCHAR(255) NULL,
  `user_type` INT(2) NOT NULL DEFAULT 1 COMMENT '用户类型\n1- 普通用户\n2- 专家用户\n3 - 管理员用户',
  `user_level` INT(2) NOT NULL DEFAULT 1 COMMENT '用户等级',
  `head_img` VARCHAR(1024) NULL COMMENT '头像',
  `nickname` VARCHAR(45) NULL COMMENT '昵称',
  `mobile` VARCHAR(45) NULL COMMENT '手机号',
  `cretaed_time` DATETIME NOT NULL COMMENT '创建时间',
  `wx_info` LONGTEXT NULL COMMENT '授权后微信拿到得所有信息',
  `user_rec_id` INT NOT NULL COMMENT '专家id（外键）',
  PRIMARY KEY (`id`),
  INDEX `fk_tb_user_tb_user_rec1_idx` (`user_rec_id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '用户表';


-- -----------------------------------------------------
-- Table `zyb`.`tb_user_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_user_address` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL COMMENT '外键用户',
  `realname` VARCHAR(45) NOT NULL COMMENT '收货人名字',
  `mobile` VARCHAR(45) NOT NULL COMMENT '收货人手机号',
  `province_no` VARCHAR(45) NULL COMMENT '省编码',
  `city_no` VARCHAR(45) NULL COMMENT '市',
  `region_no` VARCHAR(45) NULL COMMENT '区',
  `address_detail` VARCHAR(1024) NOT NULL COMMENT '详细收货地址',
  `is_default` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否默认收获地址\n1-是\n0-否',
  `created_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_user_address_tb_user_idx` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '收获地址管理';


-- -----------------------------------------------------
-- Table `zyb`.`tb_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_year` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `year_name` VARCHAR(45) NOT NULL COMMENT '年份名',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '年份列别表';


-- -----------------------------------------------------
-- Table `zyb`.`tb_book_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_book_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `book_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zyb`.`tb_goods_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_goods_book` (
  `id` BIGINT NOT NULL,
  `main_img` VARCHAR(1024) NULL COMMENT '商品主图',
  `goods_name` VARCHAR(255) NULL COMMENT '商品名字',
  `author` VARCHAR(255) NULL COMMENT '作者',
  `is_collection` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否收藏\n0 - 不是收藏\n1 - 是收藏',
  `year_id` INT NOT NULL COMMENT '年份类别',
  `book_paper` VARCHAR(45) NULL COMMENT '纸张',
  `book_size` VARCHAR(45) NULL COMMENT '尺寸',
  `book_desc` LONGTEXT NULL,
  `book_num` BIGINT NULL COMMENT '库存',
  `book_type_id` INT NOT NULL COMMENT '种类',
  `is_up` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否上架\n0 - 下架\n1 - 上架',
  `created_time` DATETIME NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  INDEX `fk_tb_goods_book_tb_year1_idx` (`year_id` ASC) VISIBLE,
  INDEX `fk_tb_goods_book_tb_book_type1_idx` (`book_type_id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '商品表';


-- -----------------------------------------------------
-- Table `zyb`.`tb_book_img`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_book_img` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `goods_book_id` BIGINT NOT NULL,
  `img_name` VARCHAR(255) NULL COMMENT 'oss图片名',
  `img_url` VARCHAR(1024) NOT NULL,
  `img_idx` INT(2) NOT NULL DEFAULT 0 COMMENT '图片顺序',
  PRIMARY KEY (`id`),
  INDEX `fk_tb_book_img_tb_goods_book1_idx` (`goods_book_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zyb`.`tb_user_punch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_user_punch` (
  `id` INT NOT NULL,
  `surname_id` INT NOT NULL AUTO_INCREMENT COMMENT '姓氏id',
  `user_id` BIGINT NOT NULL COMMENT '用户id',
  `punch_count` BIGINT NOT NULL DEFAULT 0 COMMENT '用户打卡次数',
  PRIMARY KEY (`id`),
  INDEX `fk_tb_user_punch_tb_surname1_idx` (`surname_id` ASC) VISIBLE,
  INDEX `fk_tb_user_punch_tb_user1_idx` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zyb`.`tb_user_pro_commit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zyb`.`tb_user_pro_commit` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mobile` VARCHAR(45) NOT NULL,
  `realname` VARCHAR(45) NOT NULL,
  `id_card` CHAR(18) NOT NULL,
  `rec_realname` VARCHAR(45) NULL COMMENT '推荐专家名',
  `rec_mobile` VARCHAR(45) NULL COMMENT '推荐专家手机号',
  `pro_detail` LONGTEXT NOT NULL COMMENT '个人简历',
  `pro_img` VARCHAR(1024) NOT NULL COMMENT '个人照片',
  `antique_type_id` VARCHAR(45) NOT NULL COMMENT '鉴赏类别（id）',
  `user_id` VARCHAR(45) NOT NULL COMMENT '用户id（外键）',
  `state` INT(2) NOT NULL DEFAULT 1 COMMENT '审核状态\n默认1 - 提交中\n2 - 审核通过\n3 - 驳回',
  `cretaed_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `UPC_uid_IDX` (`user_id` ASC) VISIBLE,
  INDEX `UPC_type_IDX` (`antique_type_id` ASC) INVISIBLE)
ENGINE = InnoDB
COMMENT = '专家审核信息表表';

-- 2019-10-27 更新
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE `zyb`.`tb_antique_type` ADD COLUMN `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '古董类别名' AFTER `id`;

ALTER TABLE `zyb`.`tb_antique_type` MODIFY COLUMN `id` bigint(20) NOT NULL FIRST;

ALTER TABLE `zyb`.`tb_antique_type` DROP COLUMN `antique_name`;

ALTER TABLE `zyb`.`tb_goods_book` ADD COLUMN `goods_price` int(11) NOT NULL DEFAULT 0 COMMENT '商品价格' AFTER `created_time`;

ALTER TABLE `zyb`.`tb_goods_book` ADD COLUMN `phase_type_id` int(11) NOT NULL COMMENT '外键品相类别' AFTER `goods_price`;

ALTER TABLE `zyb`.`tb_goods_book` ADD INDEX `fk_tb_goods_book_tb_phase_type1_idx`(`phase_type_id`) USING BTREE;

CREATE TABLE `zyb`.`tb_identify`  (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL COMMENT '用户id外键',
  `antique_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '鉴赏得古董名字',
  `antique_detail` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '鉴赏得古董描述',
  `user_pro_id` int(11) NOT NULL COMMENT '专家id外键',
  `identify` int(2) NOT NULL COMMENT '鉴赏状态\n1 - 创建鉴赏\n2 - 提交鉴赏(支付完成才能提交)\n3 - 鉴赏完成\n4 - 鉴赏回退',
  `created_time` datetime(0) NOT NULL COMMENT '创建时间',
  `pro_reply_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专家回复消息',
  `pro_reply_time` datetime(0) NULL DEFAULT NULL,
  `pro_year_id` int(11) NULL DEFAULT NULL COMMENT '专家回复鉴赏得朝代\n(外键，年代id)',
  `pro_back_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回理由',
  `pro_back_detail` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回得其他原因',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDENTIFY_uid_FK`(`user_id`) USING BTREE,
  INDEX `IDENTIFY_year_FK`(`pro_year_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '鉴赏记录（鉴赏订单）' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_identify_img`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identify_id` bigint(20) NOT NULL,
  `img_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `img_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `img_idx` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tb_identify_img_tb_identify1_idx`(`identify_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '鉴赏图片' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_maintain`  (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL COMMENT '用户id（外键）',
  `antique_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '修复得古董名',
  `antique_type_id` bigint(20) NOT NULL COMMENT '古董类别id',
  `maintain_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '修复物品描述',
  `user_address_id` bigint(20) NOT NULL COMMENT '收获i地址外键',
  `is_self_take` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否自提\n0 - 否\n1 - 是',
  `maintain_pro_id` bigint(20) NOT NULL COMMENT '修复得专家',
  `maintain_state` int(2) NOT NULL COMMENT '修复状态\n1 - 创建修复订单(等待官方回复)\n2 - 官方回复完成\n3 - 支付收款（修复中）\n4 - 修复完成 ',
  `created_time` datetime(0) NOT NULL COMMENT '创建时间',
  `c_maintain_amount` int(11) NULL DEFAULT NULL COMMENT '官方修复金额单位分',
  `c_maintain_day` int(11) NULL DEFAULT NULL COMMENT '官方修复天数 整数',
  `c_date` datetime(0) NULL DEFAULT NULL COMMENT '官方给得到达时间',
  `c_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '官方的收获人',
  `c_address` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '官方的收获地址',
  `c_mobile` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '官方的联系方式',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tb_maintain_tb_antique_type1_idx`(`antique_type_id`) USING BTREE,
  INDEX `fk_tb_maintain_tb_maintain_pro1_idx`(`maintain_pro_id`) USING BTREE,
  INDEX `MA_uaid_FK`(`user_address_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '修复订单' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_maintain_company_img`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'oss图片名',
  `img_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `img_idx` int(2) NOT NULL DEFAULT 0 COMMENT '图片顺序',
  `maintain_msg_id` int(11) NOT NULL COMMENT '外汇官放的消息回复',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tb_maintain_company_img_tb_maintain_msg1_idx`(`maintain_msg_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '官方回复的修复图片' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_maintain_evaluate`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `maintain_id` bigint(20) NOT NULL,
  `eva_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `eva_type` int(2) NOT NULL COMMENT '评价度\n1 - 满意\n2 - 一般\n3 - 不满意',
  `eva_img_1` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `eva_img_2` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_time` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tb_maintain_evaluate_tb_maintain1_idx`(`maintain_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '平均表' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_maintain_msg`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maintain_id` bigint(20) NOT NULL COMMENT '修复单id',
  `is_fixed` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是不是预修复回复\n1 - 是预修复回复\n0 - 不是预修复回复',
  `c_maintain_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '回复的消息',
  `created_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tb_maintain_msg_tb_maintain1_idx`(`maintain_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_maintain_pro`  (
  `id` bigint(20) NOT NULL,
  `mobile` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `realname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_card` char(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rec_realname` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '推荐专家名',
  `rec_mobile` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '推荐专家手机号',
  `pro_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '个人简历',
  `pro_img` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '个人照片',
  `created_time` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '修复得专家表' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_maintain_user_img`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'oss图片名',
  `img_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `img_idx` int(2) NOT NULL DEFAULT 0 COMMENT '图片顺序',
  `maintain_id` bigint(20) NOT NULL COMMENT '外键修复单得id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tb_maintain_user_img_tb_maintain1_idx`(`maintain_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户得修复图片' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_pay_order`  (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL COMMENT '所属用户id（外键）',
  `other_id` bigint(20) NOT NULL COMMENT '订单id（由于订单种类较多）\n需要更具type来区分',
  `pay_type` int(2) NOT NULL COMMENT '1 - 鉴赏支付单\n2 - 修复得支付单（修复是2次支付）\n3 - 书城得支付单\n4 - 助理得支付单\n5 - 充值得支付单\n6 - 提现得支付单',
  `pay_order_no` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付单单号(我方)',
  `third_order_no` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方支付订单号(wx方)',
  `repair_type` int(2) NULL DEFAULT NULL COMMENT '修复订单得类型\n 0 - 收款\n1 - 尾款',
  `amont` int(11) NOT NULL COMMENT '支付金额',
  `real_amont` int(11) NOT NULL COMMENT '实际支付金额(无优惠则通支付金额)',
  `state` int(2) NOT NULL COMMENT '状态\n1 - 支付中\n2 - 支付完成 (后台发起支付了就算支付完成)\n3 - 确认支付完成（回调后确认完成）',
  `pay_request_str` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '支付发起得原始字符串',
  `pay_callback_str` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '支付回调得原始字符串',
  `created_time` datetime(0) NULL DEFAULT NULL,
  `updated_time` datetime(0) NULL DEFAULT NULL,
  `pay_complete_time` datetime(0) NULL DEFAULT NULL,
  `is_income` tinyint(1) NULL DEFAULT NULL COMMENT '是不是收入(相对用户)\n0 - 不是 （本单支出）\n1 - 是 （本单收入）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PO_uid_FK`(`user_id`) USING BTREE,
  INDEX `PO_oid_FK`(`other_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付订单（支付记录）' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_phase_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类别名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '品相类别' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_shop_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_state` int(2) NOT NULL COMMENT '订单状态\n1 - 创建订单（代支付）\n2 - 支付完成 （）\n3 - 确认收获\n4 - 完成订单\n5 - 取消订单\n6 - 退款',
  `user_id` bigint(20) NOT NULL COMMENT '用户id外键',
  `cretaed_time` datetime(0) NOT NULL COMMENT '创建时间',
  `complete_time` datetime(0) NULL DEFAULT NULL COMMENT '完成时间',
  `user_address_id` bigint(20) NOT NULL COMMENT '外键',
  `express_price` int(11) NOT NULL DEFAULT 0 COMMENT '快递费用\n单位分',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `SO_uid_FK`(`user_id`) USING BTREE,
  INDEX `SO_uaid_FK`(`user_address_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城订单表' ROW_FORMAT = Dynamic;

CREATE TABLE `zyb`.`tb_shop_order_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `col` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `shop_order_id` int(11) NOT NULL COMMENT '外键',
  `goods_book_id` bigint(20) NOT NULL COMMENT '外键',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_tb_shop_order_detail_tb_shop_order1_idx`(`shop_order_id`) USING BTREE,
  INDEX `fk_tb_shop_order_detail_tb_goods_book1_idx`(`goods_book_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

ALTER TABLE `zyb`.`tb_user` ADD COLUMN `actual_amount` int(11) NOT NULL DEFAULT 0 COMMENT '实际金额' AFTER `user_rec_id`;

ALTER TABLE `zyb`.`tb_user` ADD COLUMN `freeze_amount` int(11) NOT NULL DEFAULT 0 COMMENT '冻结金额' AFTER `actual_amount`;

ALTER TABLE `zyb`.`tb_user_pro` ADD COLUMN `price` int(11) NOT NULL DEFAULT 10000 COMMENT '价格(单位分)\n默认100R一次' AFTER `pro_img`;

ALTER TABLE `zyb`.`tb_user_pro` MODIFY COLUMN `id` bigint(20) NOT NULL FIRST;

SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE IF NOT EXISTS `zyb`.`tb_pro_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL COMMENT '鉴赏分类名',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

ALTER TABLE `zyb`.`tb_maintain_msg`
CHANGE COLUMN `c_maintain_msg` `cm_maintain_msg` VARCHAR(1024) CHARACTER SET 'utf8mb4' NOT NULL COMMENT '回复的消息' ;

ALTER TABLE `zyb`.`tb_maintain`
CHANGE COLUMN `c_maintain_amount` `cm_maintain_amount` INT(11) NULL DEFAULT NULL COMMENT '官方修复金额单位分' ,
CHANGE COLUMN `c_maintain_day` `cm_maintain_day` INT(11) NULL DEFAULT NULL COMMENT '官方修复天数 整数' ,
CHANGE COLUMN `c_date` `cm_date` DATETIME NULL DEFAULT NULL COMMENT '官方给得到达时间' ,
CHANGE COLUMN `c_name` `cm_name` VARCHAR(255) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL COMMENT '官方的收获人' ,
CHANGE COLUMN `c_address` `cm_address` VARCHAR(1024) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL COMMENT '官方的收获地址' ,
CHANGE COLUMN `c_mobile` `cm_mobile` VARCHAR(45) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL COMMENT '官方的联系方式' ;



CREATE TABLE IF NOT EXISTS `tb_shop_banner` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `goods_book_id` BIGINT NOT NULL COMMENT '商品外键',
  `main_img` VARCHAR(1024) NOT NULL COMMENT '主图',
  `banner_idx` INT NOT NULL DEFAULT 0 COMMENT '轮播序列',
  `created_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `SB_gbId_FK` (`goods_book_id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '商城轮播图';

ALTER TABLE `zyb`.`tb_goods_book`
ADD COLUMN `book_type_other_id` INT(11) NULL AFTER `phase_type_id`,
ADD INDEX `GB_gotId_FK` (`book_type_other_id` ASC) INVISIBLE;
;
