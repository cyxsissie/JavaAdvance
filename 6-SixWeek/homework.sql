-- ----------------------------
-- Table structure for t_spec_group
-- ----------------------------
DROP TABLE IF EXISTS `t_spec_group`;
CREATE TABLE `t_spec_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spg_id` int(10) UNSIGNED NOT NULL COMMENT '品类编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品类名称',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spg_id`(`spg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '品类表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `parent_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '上级分类ID',
  `if_parent` tinyint(1) NOT NULL COMMENT '是否含有下级分类',
  `sort` int(10) UNSIGNED NOT NULL COMMENT '排名指数',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id`) USING BTREE,
  INDEX `idx_sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;



-- ----------------------------
-- Table structure for t_spu
-- ----------------------------
DROP TABLE IF EXISTS `t_spu`;
CREATE TABLE `t_spu`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `sub_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '副标题',
  `category_id` int(10) UNSIGNED NOT NULL COMMENT '分类ID',
  `brand_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '品牌ID',
  `spg_id` int(10) UNSIGNED NOT NULL COMMENT '品类ID',
  `saleable` tinyint(1) NOT NULL COMMENT '是否上架',
  `valid` tinyint(1) NOT NULL COMMENT '是否有效',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `last_update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_brand_id`(`brand_id`) USING BTREE,
  INDEX `idx_category_id`(`category_id`) USING BTREE,
  INDEX `idx_spg_id`(`spg_id`) USING BTREE,
  INDEX `idx_saleable`(`saleable`) USING BTREE,
  INDEX `idx_valid`(`valid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_spec_param
-- ----------------------------
DROP TABLE IF EXISTS `t_spec_param`;
CREATE TABLE `t_spec_param`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spg_id` int(10) UNSIGNED NOT NULL COMMENT '品类编号',
  `spp_id` int(10) UNSIGNED NOT NULL COMMENT '参数编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数名称',
  `numeric` tinyint(1) NOT NULL COMMENT '是否为数字参数',
  `unit` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位(量词)',
  `generic` tinyint(1) NOT NULL COMMENT '是否为通用参数',
  `searching` tinyint(1) NOT NULL COMMENT '是否用于通用搜索',
  `segements` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数值',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spg_id`(`spg_id`) USING BTREE,
  INDEX `idx_spp_id`(`spp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for t_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_sku`;
CREATE TABLE `t_sku`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spu_id` int(10) UNSIGNED NOT NULL COMMENT '产品ID',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品标题',
  `images` json NULL COMMENT '商品图片',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '价格',
  `param` json NOT NULL COMMENT '参数',
  `saleable` tinyint(1) NOT NULL COMMENT '是否上架',
  `valid` tinyint(1) NOT NULL COMMENT '是否有效',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `last_update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_spu_id`(`spu_id`) USING BTREE,
  INDEX `idx_saleable`(`saleable`) USING BTREE,
  INDEX `idx_valid`(`valid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;



-- ----------------------------
-- Table structure for t_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `tel` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `level_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '会员等级',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `last_update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户表' ROW_FORMAT = Dynamic;



-- ----------------------------
-- Table structure for t_customer_address
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_address`;
CREATE TABLE `t_customer_address`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户ID',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `tel` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `prime` tinyint(1) NOT NULL COMMENT '是否是默认地址：1是',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户地址' ROW_FORMAT = Dynamic;



-- ----------------------------
-- Table structure for t_delivery
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery`;
CREATE TABLE `t_delivery`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `sku` json NOT NULL COMMENT '商品',
  `postid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '快递单号',
  `price` decimal(10, 0) UNSIGNED NOT NULL COMMENT '快递费',
  `ecp` tinyint(3) UNSIGNED NOT NULL COMMENT '快递公司编号',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货地址',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE,
  INDEX `idx_postid`(`postid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '快递表' ROW_FORMAT = Dynamic;



-- ----------------------------
-- Table structure for t_level
-- ----------------------------
DROP TABLE IF EXISTS `t_level`;
CREATE TABLE `t_level`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `level` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '等级',
  `discount` decimal(10, 2) UNSIGNED NOT NULL COMMENT '折扣',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员登记表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流水号',
  `customer_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '会员ID',
  `amount` decimal(10, 2) UNSIGNED NOT NULL COMMENT '总金额',
  `payment_type` tinyint(3) UNSIGNED NOT NULL COMMENT '支付方式：1借记卡,2信用卡,3微信,4支付宝,5现金',
  `status` tinyint(3) UNSIGNED NOT NULL COMMENT '状态：1未付款,2已付款,3已发货,4已签收',
  `postage` decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '邮费',
  `weight` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '重量（克）',
  `voucher_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '购物券ID',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_code`(`code`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for t_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail`  (
  `order_id` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `old_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'SKU_OLD表的ID',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '原价格',
  `actual_price` decimal(10, 2) UNSIGNED NOT NULL COMMENT '实际购买价',
  `num` int(10) UNSIGNED NOT NULL COMMENT '购买数量',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`order_id`, `sku_id`) USING BTREE,
  INDEX `idx_old_id`(`old_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单详情表' ROW_FORMAT = Dynamic;



-- ----------------------------
-- Table structure for t_rating
-- ----------------------------
DROP TABLE IF EXISTS `t_rating`;
CREATE TABLE `t_rating`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `order_id` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `img` json NULL COMMENT '买家晒图',
  `rating` tinyint(3) UNSIGNED NOT NULL COMMENT '评分',
  `comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE,
  INDEX `idx_sku_id`(`sku_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评价表' ROW_FORMAT = Dynamic;



-- ----------------------------
-- Table structure for t_shop_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_sku`;
CREATE TABLE `t_shop_sku`  (
  `id` int(10) UNSIGNED NOT NULL COMMENT '库存ID',
  `sku_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `num` int(10) UNSIGNED NOT NULL COMMENT '库存数量',
  `unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '库存单位',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`shop_id`, `sku_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '零售店商品库存表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for t_voucher
-- ----------------------------
DROP TABLE IF EXISTS `t_voucher`;
CREATE TABLE `t_voucher`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `deno` decimal(10, 2) UNSIGNED NOT NULL COMMENT '面值',
  `condition` decimal(10, 2) UNSIGNED NOT NULL COMMENT '订单满多少钱可以使用',
  `start_date` date NULL DEFAULT NULL COMMENT '起始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '截止日期',
  `max_num` int(11) NULL DEFAULT NULL COMMENT '代金券发放最大数量',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物券表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for t_voucher_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_voucher_customer`;
CREATE TABLE `t_voucher_customer`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `voucher_id` int(10) UNSIGNED NOT NULL COMMENT '购物券ID',
  `customer_id` int(10) UNSIGNED NOT NULL COMMENT '客户ID',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户关联购物券数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_backstock
-- ----------------------------
DROP TABLE IF EXISTS `t_backstock`;
CREATE TABLE `t_backstock`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `sku` json NOT NULL COMMENT '退货商品',
  `reason` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '退货原因',
  `qa_id` int(10) UNSIGNED NOT NULL COMMENT '质检员ID',
  `payment` decimal(10, 2) UNSIGNED NOT NULL COMMENT '退款金额',
  `payment_type` tinyint(3) UNSIGNED NOT NULL COMMENT '退款方式：1借记卡，2信用卡，3微信，4支付宝，5现金',
  `status` tinyint(3) UNSIGNED NOT NULL COMMENT '状态：1退货成功,2无法退货',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE,
  INDEX `idx_qa_id`(`qa_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '退货表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_province
-- ----------------------------
DROP TABLE IF EXISTS `t_province`;
CREATE TABLE `t_province`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `province` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '省份',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '省份表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_city
-- ----------------------------
DROP TABLE IF EXISTS `t_city`;
CREATE TABLE `t_city`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `city` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市',
  `province_id` int(10) UNSIGNED NOT NULL COMMENT '省份ID',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除：1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '城市表' ROW_FORMAT = Dynamic;