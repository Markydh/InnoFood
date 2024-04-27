/*
 Navicat Premium Data Transfer

 Source Server         : loaclhost
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : InnoFood

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 18/12/2023 16:02:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `AdminID` int NOT NULL AUTO_INCREMENT COMMENT '管理员编号\n',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `psrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '/default_avatar.JPG' COMMENT '头像路径',
  PRIMARY KEY (`AdminID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` (`AdminID`, `username`, `password`, `psrc`) VALUES (1, 'admin', 'admin', '/default_avatar.JPG');
INSERT INTO `admin` (`AdminID`, `username`, `password`, `psrc`) VALUES (2, 'mark', 'mark', '/default_avatar.JPG');
COMMIT;

-- ----------------------------
-- Table structure for delivery
-- ----------------------------
DROP TABLE IF EXISTS `delivery`;
CREATE TABLE `delivery` (
  `deliveryID` int NOT NULL AUTO_INCREMENT COMMENT '骑手编号',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '骑手用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `score` decimal(10,2) DEFAULT '0.00' COMMENT '评分',
  `psrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '/default_avatar.JPG' COMMENT '骑手头像',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账号创建时间',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
  PRIMARY KEY (`deliveryID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of delivery
-- ----------------------------
BEGIN;
INSERT INTO `delivery` (`deliveryID`, `username`, `password`, `phone`, `score`, `psrc`, `createDate`, `email`) VALUES (1, 'jack', 'jack', '19309930331', 0.00, '/default_avatar.JPG', '2023-12-04 23:01:23', '2247652123@qq.com');
INSERT INTO `delivery` (`deliveryID`, `username`, `password`, `phone`, `score`, `psrc`, `createDate`, `email`) VALUES (2, 'james', '123', '12932123331', 0.00, '/default_avatar.JPG', '2023-12-04 23:23:28', '3212324787@qq.com');
INSERT INTO `delivery` (`deliveryID`, `username`, `password`, `phone`, `score`, `psrc`, `createDate`, `email`) VALUES (3, 'Ronaldo', '123', '19830321031', 0.00, 'http://localhost:9091/file/9e45bbb001894e879ce43cb50c3594eb.JPG', '2023-12-05 23:01:45', '3454998767@qq.com');
INSERT INTO `delivery` (`deliveryID`, `username`, `password`, `phone`, `score`, `psrc`, `createDate`, `email`) VALUES (4, 'Alice', '123', '17870611582', 0.00, '/default_avatar.JPG', '2023-12-05 23:02:49', '3444338898@qq.com');
INSERT INTO `delivery` (`deliveryID`, `username`, `password`, `phone`, `score`, `psrc`, `createDate`, `email`) VALUES (5, 'Messi', '123', '12343213432', 0.00, '/default_avatar.JPG', '2023-12-06 12:35:02', '2247654142@qq.com');
COMMIT;

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件类型',
  `size` bigint DEFAULT NULL COMMENT '文件大小 (KB)',
  `psrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '下载链接',
  `isDelete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of file
-- ----------------------------
BEGIN;
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (6, 'on-index.png', 'png', 16, 'http://localhost:9091/file/ef265c8afeae44b5806b0c25043c3e6e.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (7, 'on-shopping.png', 'png', 9, 'http://localhost:9091/file/29dcd51103dd4d24bb9b1976998e33f8.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (8, 'on-mine.png', 'png', 13, 'http://localhost:9091/file/5b0b174d728b4f7fbfa43a7ca1103f98.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (9, 'off-mine.png', 'png', 5, 'http://localhost:9091/file/36186cb3dd21446d9daf6097c444e7b4.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (10, 'pexels-waskyria-miranda-2919591.jpg', 'jpg', 362, 'http://localhost:9091/file/c0b2007467bb44b99261e8f447bbef9b.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (11, 'on-mine.png', 'png', 13, 'http://localhost:9091/file/2c530704c3ab41228ff1298ea7649f19.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (12, 'shejie.png', 'png', 6914, 'http://localhost:9091/file/401b74184b384fba96fa0144abab4e43.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (13, 'off-buyCar.png', 'png', 27, 'http://localhost:9091/file/bbed79ca473a4d2f94659eed0336e5f5.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (14, 'off-mine.png', 'png', 5, 'http://localhost:9091/file/45497b21130a4fea8e4a7b6d0267cc0f.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (15, 'on-index.png', 'png', 16, 'http://localhost:9091/file/e5c4902dde55405ea0018e582baccf85.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (16, 'on-mine.png', 'png', 13, 'http://localhost:9091/file/b7a972e68f8742dc88ac8e599a1efe36.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (17, 'off-shop.png', 'png', 5, 'http://localhost:9091/file/3473fe6c6b3c4815aa74d1d3bcdebf7e.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (18, 'shejie.png', 'png', 6914, 'http://localhost:9091/file/a61a2ee05ff74ba6b617bc7712f244f4.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (19, 'off-mine.png', 'png', 5, 'http://localhost:9091/file/7bbb348aab8c4de785ac8f7b63d7d8ed.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (20, 'shejie.png', 'png', 6914, 'http://localhost:9091/file/39b18c9bf91b4798b8c22474b6aef578.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (21, '一点点logo.png', 'png', 215, 'http://localhost:9091/file/d323e4b0c3f54f2d98610cbce120d267.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (22, '霸王茶姬logo.png', 'png', 201, 'http://localhost:9091/file/a5433c5eb783468b8dd1873dd51dee3f.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (23, '古茗logo.png', 'png', 4, 'http://localhost:9091/file/dcc21e0cab4641fa8888818f5fd63440.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (24, '喜茶logo.jpeg', 'jpeg', 35, 'http://localhost:9091/file/4045c049c7224908975bf984419c5639.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (25, '洪都大拇指logo.jpeg', 'jpeg', 86, 'http://localhost:9091/file/84740f2d2b6140a4997fed201d9043a4.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (26, '瑞幸咖啡logo.jpeg', 'jpeg', 4, 'http://localhost:9091/file/d4916bd2a8f64a979f26b364445e0895.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (27, '星巴克logo.jpg', 'jpg', 138, 'http://localhost:9091/file/3c26527e86794d7e9aca3d036a1639cb.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (28, '沪上阿姨logo.jpg', 'jpg', 86, 'http://localhost:9091/file/77fa8c21d9df49f0b32f67497e9633d6.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (29, '茶颜悦色logo.jpg', 'jpg', 178, 'http://localhost:9091/file/a27db9da5e224f90bdcd145813af8952.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (30, '头像.PNG', 'PNG', 6002, 'http://localhost:9091/file/563eaf6dddf24f80b833dfaaf0b4a7ef.PNG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (31, 'IMG_3066.JPG', 'JPG', 215, 'http://localhost:9091/file/04d1ff44f5af49b6a590bd22bc204355.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (32, '海底捞logo.jpg', 'jpg', 107, 'http://localhost:9091/file/4699dc8f16494c66b421ebebb5dff78c.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (33, '季季红logo.png', 'png', 3, 'http://localhost:9091/file/9959e4169c034f1e9730743a96d2d83e.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (34, 'xiaobu logo.jpg', 'jpg', 52, 'http://localhost:9091/file/24c3a270c3ff4189ba9a280d70e73845.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (35, 'shejie.png', 'png', 6914, 'http://localhost:9091/file/f97be8f43d3e4f6f88fe0e31097059b1.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (36, '柠檬水.jpg', 'jpg', 2886, 'http://localhost:9091/file/c9ccecf0e16946879f85aec01b1bc0f9.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (37, '柠檬水.jpg', 'jpg', 2886, 'http://localhost:9091/file/d9568c2b0f5149b4a8229270d76dd39f.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (38, '柠檬水.jpg', 'jpg', 2886, 'http://localhost:9091/file/c85d00844ee7469591eca6f75820ac99.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (39, '百花咖啡.jpg', 'jpg', 672, 'http://localhost:9091/file/0318c0785a4c4d7cb107349dcb84ef08.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (40, '珍珠奶茶.jpg', 'jpg', 614, 'http://localhost:9091/file/71e11b42682947839050534ca5a8e476.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (41, '柠檬水.jpg', 'jpg', 2886, 'http://localhost:9091/file/c63c49b3664c4e7487784ae092a3b8de.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (42, '芝士奶茶.jpg', 'jpg', 1073, 'http://localhost:9091/file/19ebcfd58b1c49c19c0ecb4e519548f2.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (43, '水果奶茶.jpg', 'jpg', 126, 'http://localhost:9091/file/2369c8a2d9e7484192a08e9a3fc1f34e.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (44, '椰果奶茶.jpg', 'jpg', 84, 'http://localhost:9091/file/4c123c7026584795ad332707514036e5.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (45, '巧克力奶茶.jpg', 'jpg', 30, 'http://localhost:9091/file/f555fc1096904673b13e68a8e5c65d1d.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (46, '冬阴功底料.jpg', 'jpg', 131, 'http://localhost:9091/file/65f556a85d80434d9614ed4d7dff8361.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (47, '番茄火锅底料.jpg', 'jpg', 135, 'http://localhost:9091/file/fdbc0dd7bd164364be66d0c576dea10a.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (48, '菌汤火锅底料.jpg', 'jpg', 130, 'http://localhost:9091/file/a3f14a37aa5c453fb281ed656e255b5c.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (49, '清油火锅底料.jpg', 'jpg', 117, 'http://localhost:9091/file/9077b99d27784684a91583caef515100.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (50, '三鲜火锅底料.jpg', 'jpg', 131, 'http://localhost:9091/file/a4bcaa3757d342db9a8b4cd99667f64d.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (51, '鲜油豆皮.JPG', 'JPG', 160, 'http://localhost:9091/file/a4cd921c4a2d412eb5fa7791780900d7.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (52, '鲜油豆皮.JPG', 'JPG', 160, 'http://localhost:9091/file/5b874c2a307e445aa674282b698832d2.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (53, '嫩滑黑鱼片.JPG', 'JPG', 191, 'http://localhost:9091/file/fd7436643c9b42fc92a6183a4472bc82.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (54, '嫩滑黑鱼片.JPG', 'JPG', 191, 'http://localhost:9091/file/e9d999976ab745aca75696a73043b98b.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (55, '铃铃卷.JPG', 'JPG', 186, 'http://localhost:9091/file/a265413eb2fc4686a43b62205adca183.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (56, '捞派猪黄喉.JPG', 'JPG', 105, 'http://localhost:9091/file/1cfc90f52667427a80af34461234401f.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (57, '捞派鸭肠.JPG', 'JPG', 154, 'http://localhost:9091/file/67b471a090cb47f19a6a9c978bca01a4.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (58, '捞派滑牛肉.JPG', 'JPG', 186, 'http://localhost:9091/file/1ccfb1f2ec3c4e088f5867f2931f74b3.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (59, '劲道牛肉丸.JPG', 'JPG', 157, 'http://localhost:9091/file/7358008e93af4c8c988b2142274af6ba.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (60, '海带苗.JPG', 'JPG', 190, 'http://localhost:9091/file/5e0d8f5efb6c41d6ade12b1378e5df77.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (61, '大颗粒虾滑.JPG', 'JPG', 131, 'http://localhost:9091/file/c86c8760bd464896bd776ccb5380756a.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (62, '巴沙鱼片.JPG', 'JPG', 105, 'http://localhost:9091/file/80902b00396843248de605dd3be3af20.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (63, '东来顺火锅.jpg', 'jpg', 251, 'http://localhost:9091/file/f7eb6d77eb8c45b28840c6fd34e1f5a2.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (64, '巴奴火锅.jpg', 'jpg', 17, 'http://localhost:9091/file/ba53e8d0bf5144a7aa0a22de5f7966a8.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (65, 'IMG_3160.JPG', 'JPG', 271, 'http://localhost:9091/file/add1bd4ccb1348839511f476997a2b30.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (66, 'IMG_3160.JPG', 'JPG', 271, 'http://localhost:9091/file/9e45bbb001894e879ce43cb50c3594eb.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (67, 'timg-2.jpeg', 'jpeg', 46, 'http://localhost:9091/file/1fb7963405264dde8ab8e9f7537ef1ed.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (68, 'carousel_1.jpeg', 'jpeg', 137, 'http://localhost:9091/file/68.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (69, 'carousel_2.jpeg', 'jpeg', 108, 'http://localhost:9091/file/69.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (70, 'carousel_3.png', 'png', 1092, 'http://localhost:9091/file/70.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (71, 'carousel_4.jpg', 'jpg', 975, 'http://localhost:9091/file/71.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (85, '蒜蓉小龙虾.JPG', 'JPG', 173, 'http://localhost:9091/file/d254d73c2b3a402997a82328d5d226e9.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (86, '麻辣小龙虾.JPG', 'JPG', 156, 'http://localhost:9091/file/ee26c50447ef47cbbff738b9f6846ce1.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (87, '麻辣小龙虾 套餐1.JPG', 'JPG', 232, 'http://localhost:9091/file/2cd8d4040d3645f6a14446f696153476.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (88, '马路小龙虾 套餐2.JPG', 'JPG', 233, 'http://localhost:9091/file/5bb07f7169254d499264c88adfc4ff06.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (89, '经典羔羊肉.JPG', 'JPG', 128, 'http://localhost:9091/file/906e58510790468b97164e506b7521e7.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (90, '经典羔羊肉.JPG', 'JPG', 128, 'http://localhost:9091/file/6045ff87031c4b19923da5f845107638.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (91, '肥牛卷.JPG', 'JPG', 204, 'http://localhost:9091/file/c0a8216e03514ac29e55c59713b67e8c.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (92, '火锅牛排.JPG', 'JPG', 172, 'http://localhost:9091/file/b12431a3dd7b453a85032929b3b58d22.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (93, '层层血浪猪五花.JPG', 'JPG', 196, 'http://localhost:9091/file/12510221802a4cc290ec91ee9eba8dd2.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (94, '脆脆千层毛肚.JPG', 'JPG', 132, 'http://localhost:9091/file/fc7facbee2f3458b89f2224b2252bbc4.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (95, '血旺.JPG', 'JPG', 153, 'http://localhost:9091/file/f4da5a56fc2c405191d343932b3bb2cf.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (96, '小香肠.JPG', 'JPG', 141, 'http://localhost:9091/file/98fc95458f334c759596cb9bbd9feddd.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (97, '午餐肉.JPG', 'JPG', 135, 'http://localhost:9091/file/e9dd38d287504c689251f8b8b393c8e9.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (98, '我的小郡肝.JPG', 'JPG', 160, 'http://localhost:9091/file/92f4b62e8a314b17a7459f66852b9958.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (99, 'logo_mdl.jpg', 'jpg', 93, 'http://localhost:9091/file/2844a8fbeb8f45c2880c73207f853d2a.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (100, '芝士安格斯牛肉堡.png', 'png', 90, 'http://localhost:9091/file/f31be02899394f3786857584f4e15a26.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (101, 'logo_kfc.jpg', 'jpg', 204, 'http://localhost:9091/file/8da15e5e26d64a15bd28034799816729.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (102, '塔斯汀.jpg', 'jpg', 36, 'http://localhost:9091/file/7c6c1363bb1e4d41a5bd6da30b524195.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (103, '必胜客.jpg', 'jpg', 188, 'http://localhost:9091/file/d9a3df4f386f4a48adb7908076b04cae.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (104, '达美乐.png', 'png', 67, 'http://localhost:9091/file/d24954a11b36427f8f0ce66c00b722e4.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (105, '德克士.png', 'png', 4, 'http://localhost:9091/file/ef237c39e8254eca8307ba2337da2072.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (106, '汉堡王.png', 'png', 11, 'http://localhost:9091/file/dcd601d0a0f74634be2f4222dd9d8aef.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (107, 'logo_jcy.png', 'png', 72, 'http://localhost:9091/file/e0c1162faeda4e07bd4e18891c687cb5.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (108, '江川右.jpeg', 'jpeg', 4, 'http://localhost:9091/file/09be61a8fb604101a9e66aba4ae96c24.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (109, '江川右.jpeg', 'jpeg', 4, 'http://localhost:9091/file/efc9f6acf8614811bd380127e019e4dc.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (110, '江川右.jpeg', 'jpeg', 4, 'http://localhost:9091/file/0d329ca65d22410286721a76bbe9a14f.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (111, '叉烧包.jpg', 'jpg', 998, 'http://localhost:9091/file/ed6ad114ee5b4eb1a00bb458ecf16485.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (112, '灌汤小笼包.jpg', 'jpg', 877, 'http://localhost:9091/file/ccac87e617294a47ac40792221b5d196.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (113, '核桃包.jpg', 'jpg', 849, 'http://localhost:9091/file/cdf215a1876a4fe799a85be317a90e18.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (114, '流沙包.jpg', 'jpg', 392, 'http://localhost:9091/file/869b5302a74048cf8d143cf984a18f95.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (115, '小米南瓜粥.jpg', 'jpg', 621, 'http://localhost:9091/file/72571378cf864dc1a4b7db779f389129.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (116, '绿豆粥.jpg', 'jpg', 560, 'http://localhost:9091/file/7f462405d25d45e1966cb5e09596c91c.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (117, '红豆粥.jpg', 'jpg', 540, 'http://localhost:9091/file/e66c569c9fad417ab3f48c333e08d710.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (118, '灌汤小笼包.jpg', 'jpg', 345, 'http://localhost:9091/file/28368ee2abbb4cdaaa0dca68e15eb5e0.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (119, '曼玲粥.jpg', 'jpg', 109, 'http://localhost:9091/file/47a995859d1a45fc944da39cb99a34a8.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (120, '宏状元.jpeg', 'jpeg', 5, 'http://localhost:9091/file/9516e65f34fd41b2a3edf274e6ad8417.jpeg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (121, 'logo_hyw.png', 'png', 213, 'http://localhost:9091/file/0d37362e64694aeab60adccd942ba0a0.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (122, 'logo_hyw.png', 'png', 190, 'http://localhost:9091/file/80d90043884947f6b9003aa6e573737d.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (123, 'IMG_3490.JPG', 'JPG', 38, 'http://localhost:9091/file/9bb52fc6abaf46b993dfa46e344f3277.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (124, 'IMG_3492.JPG', 'JPG', 33, 'http://localhost:9091/file/4719d7708e1c474f856a171896ad0260.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (125, 'IMG_3494.JPG', 'JPG', 70, 'http://localhost:9091/file/1066c3c4427a45679455b4feff746b30.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (126, 'IMG_3496.JPG', 'JPG', 53, 'http://localhost:9091/file/becb15d3539d4a0a855a5b6e1f861fb4.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (127, 'IMG_3499.JPG', 'JPG', 57, 'http://localhost:9091/file/aca3557d4b3d47bc92bfd13ccd8bfce4.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (128, 'IMG_3501.JPG', 'JPG', 45, 'http://localhost:9091/file/12a0ab644b9d4aa3952d2eb5fc537a07.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (129, 'IMG_3503.JPG', 'JPG', 39, 'http://localhost:9091/file/65234c4c12d742fcb341fd8b733f4fbb.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (130, 'IMG_3505.PNG', 'PNG', 1399, 'http://localhost:9091/file/4e750deccd9945e085218118b735cad7.PNG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (131, 'IMG_3506.jpg', 'jpg', 191, 'http://localhost:9091/file/e7d763d7080343faa3590ba3347d7529.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (132, 'IMG_3507.jpg', 'jpg', 99, 'http://localhost:9091/file/05af2d3a42fc48f88bf4f7bd59c9f261.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (133, 'IMG_3511.jpg', 'jpg', 135, 'http://localhost:9091/file/72f2aa8827f946da8b88b4baa1fdeea2.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (134, 'IMG_3513.jpg', 'jpg', 92, 'http://localhost:9091/file/5097c0b570ec4971ad6fddc7beae98fb.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (135, 'IMG_3514.jpg', 'jpg', 107, 'http://localhost:9091/file/1c6495b8305c458582411ca955da6fbf.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (136, 'IMG_3516.jpg', 'jpg', 68, 'http://localhost:9091/file/03d510c7b2f546eea77033a8f683d03c.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (137, 'IMG_3518.jpg', 'jpg', 124, 'http://localhost:9091/file/a785782f9d26489caa837cc1e979b922.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (138, 'IMG_3519.jpg', 'jpg', 230, 'http://localhost:9091/file/be40dc80e7294ef3b9635bb5905a93f3.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (139, 'IMG_3522.jpg', 'jpg', 162, 'http://localhost:9091/file/8646f100f0554ed19222f6826636a3a0.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (140, 'IMG_3520.jpg', 'jpg', 133, 'http://localhost:9091/file/b4468c50b71a42b9a093601ccb4725e9.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (141, 'IMG_3524.JPG', 'JPG', 134, 'http://localhost:9091/file/8bb36c34a6c748d89be4a1fae303bc8b.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (142, 'IMG_3526.JPG', 'JPG', 145, 'http://localhost:9091/file/56e85240c33c47f59115db0132579466.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (143, 'IMG_3528.JPG', 'JPG', 130, 'http://localhost:9091/file/a0e49c085c52495b922b56eb8c9df12e.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (144, 'IMG_3530.JPG', 'JPG', 94, 'http://localhost:9091/file/9e00d9473fd44a18909ad70204323a5d.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (145, 'IMG_3532.jpg', 'jpg', 200, 'http://localhost:9091/file/b0ff7c5e47f346fabb084b2aa628a19b.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (146, 'IMG_3534.JPG', 'JPG', 141, 'http://localhost:9091/file/85b6ecdd3b114c24b718f9f246f32f3f.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (147, 'IMG_3536.JPG', 'JPG', 119, 'http://localhost:9091/file/e5ddb68a0c394e4e82394d1cf46f7178.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (148, 'IMG_3538.JPG', 'JPG', 132, 'http://localhost:9091/file/85051f2d829c4ddfa955517d61b907d0.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (149, 'IMG_3540.JPG', 'JPG', 132, 'http://localhost:9091/file/28235ab20ba94ecd935a71f097107a07.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (150, 'IMG_3542.JPG', 'JPG', 127, 'http://localhost:9091/file/7affb676bdf442cf9bf02a08e3999f65.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (151, 'IMG_3544.JPG', 'JPG', 108, 'http://localhost:9091/file/f75656ef202649e6be1984bc5b6cd682.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (152, 'IMG_3546.JPG', 'JPG', 123, 'http://localhost:9091/file/1a3fa33b360c437ebf1f2b014cbe9ec4.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (153, 'IMG_3548.JPG', 'JPG', 112, 'http://localhost:9091/file/8f6de83e32b64079b16aa88263274566.JPG', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (154, '小龙坎.png', 'png', 348, 'http://localhost:9091/file/80693c02d51e40d6abd64ec734f3c69e.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (155, '巴蜀匠人.png', 'png', 228, 'http://localhost:9091/file/467ce8c746e1410fbf6175932da998d1.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (156, '老北京涮锅.png', 'png', 189, 'http://localhost:9091/file/8d5aab322dcb40a7af49b1ffb7457156.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (157, '牛关张.png', 'png', 260, 'http://localhost:9091/file/3b0cf5baab524cd7aa40de64b0b17cf9.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (158, '鼎宴.png', 'png', 354, 'http://localhost:9091/file/a304e8eacb404ae5a1b1175f6b500757.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (159, '袁记云饺.png', 'png', 2907, 'http://localhost:9091/file/1c873b65a9c34c82ae61421c87c438ea.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (160, '元气饺子.png', 'png', 1881, 'http://localhost:9091/file/ec89043380a24c6880c85022ee2ae5c2.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (161, '合意.png', 'png', 712, 'http://localhost:9091/file/36431a034ca6485d81263923c8e658c8.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (162, '谢记味庄.jpg', 'jpg', 149, 'http://localhost:9091/file/4596a416942747619fe4ea45f106b8bf.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (163, '十面埋伏.jpg', 'jpg', 56, 'http://localhost:9091/file/8b6deaa41ce247b2a68e5210e2dce2e5.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (164, '牛回回.png', 'png', 679, 'http://localhost:9091/file/3c9f4106c7624c19a450063ba195c6c9.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (165, '龙川拉面.png', 'png', 624, 'http://localhost:9091/file/48d4825af38c43fbbcfb71a7df19c4ff.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (166, '津八爷.png', 'png', 951, 'http://localhost:9091/file/437b810394d54503b996b06d1a964be1.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (167, '一周便当.png', 'png', 471, 'http://localhost:9091/file/7848f070787f4e5cb5678fa07847ab74.png', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (168, '吴记虾饭.jpg', 'jpg', 121, 'http://localhost:9091/file/0f0daeb89e8f40609b734c1c00e85450.jpg', 0, 1);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `psrc`, `isDelete`, `enable`) VALUES (169, '王厨一哥.png', 'png', 979, 'http://localhost:9091/file/354f81365ec34355a3791b5fca59e8a2.png', 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `managerID` int NOT NULL AUTO_INCREMENT COMMENT '商家编号',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商家用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码\n',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话号码',
  `psrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '/default_avatar.JPG' COMMENT '头像\n',
  `state` int NOT NULL DEFAULT '0' COMMENT '账号状态',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`managerID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of manager
-- ----------------------------
BEGIN;
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (1, 'halo', 'halo', 'Herry Micheal', '2243234123@qq.com', '13493892132', 'http://localhost:9091/file/04d1ff44f5af49b6a590bd22bc204355.JPG', 0, '2023-11-24 15:56:25');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (2, 'jack', 'jack', 'jack', 'jack@qq.com', '123123131', '/default_avatar.JPG', 1, '2023-11-23 15:56:29');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (3, 'herry', 'herry', 'herry', 'herry@qq.com', '123123123', '/default_avatar.JPG', 0, '2023-11-21 15:56:34');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (5, 'mark', 'mark', 'mark', '2247654142@qq.com', '18397910331', 'http://localhost:9091/file/f97be8f43d3e4f6f88fe0e31097059b1.png', 0, '2023-11-24 15:56:43');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (6, 'theshy', '123', 'shy哥', 'shy@qq.com', '11022020102', '/default_avatar.JPG', 0, '2023-11-05 15:56:48');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (7, '12345467', '123', 'shy哥', '12345@qq.com', '21397128', '/default_avatar.JPG', 0, '2023-11-13 15:56:52');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (8, 'smb', 'smb', 'smb', 'smb@qq.com', '219398', '/default_avatar.JPG', 0, '2023-11-21 15:56:56');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (9, 'clearlove', 'clearlove', '断肠人', 'clearlove@qq.com', '12341873872', '/default_avatar.JPG', 0, '2023-11-24 15:57:35');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (11, 'adier', 'adier', '阿黛尔', '123213431@qq.com', '19839820134', '/default_avatar.JPG', 0, '2023-11-27 21:40:38');
INSERT INTO `manager` (`managerID`, `username`, `password`, `nickname`, `email`, `phone`, `psrc`, `state`, `createDate`) VALUES (13, 'kin sou qi', '8080', '金颂绮', '87653665@gmail.com', '98398632', '/default_avatar.JPG', 0, '2023-12-18 09:46:02');
COMMIT;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `messageID` int NOT NULL AUTO_INCREMENT COMMENT '消息编号',
  `userID` int DEFAULT NULL COMMENT '用户编号',
  `shopID` int DEFAULT NULL COMMENT '店铺编号',
  `orderID` int DEFAULT NULL COMMENT '订单编号',
  `deliveryID` int DEFAULT NULL COMMENT '骑手编号',
  `msgContent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息内容',
  `msgTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `state` int NOT NULL DEFAULT '0' COMMENT '消息状态，0为未读，1为已读',
  PRIMARY KEY (`messageID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (6, 2, 7, 240, NULL, '用户mark于2023-12-09 17:50:17 下午在古茗提交了一份订单，订单编号为 240', '2023-12-09 17:50:17', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (7, 23, 7, 241, NULL, '用户james于2023-12-09 18:13:14 下午在古茗提交了一份订单，订单编号为 241', '2023-12-09 18:13:14', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (8, 2, 14, 242, NULL, '用户mark于2023-12-11 08:59:36 上午在海底捞提交了一份订单，订单编号为 242', '2023-12-11 08:59:36', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (9, 23, 7, 241, NULL, '店铺：古茗于2023-12-11 09:52:25 上午接单，快递员正在快马加鞭赶来，请您耐心等带', '2023-12-11 09:52:25', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (10, 2, 7, 244, NULL, '用户mark于2023-12-11 10:12:29 上午在古茗提交了一份订单，订单编号为 244', '2023-12-11 10:12:29', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (11, 2, 7, 244, NULL, '店铺：古茗于2023-12-11 10:13:13 上午接单，快递员正在快马加鞭赶来，请您耐心等带', '2023-12-11 10:13:13', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (13, 2, NULL, 22, 5, '快递员：Messi于2023-12-11 12:02:01 下午到达商家，请耐心等待', '2023-12-11 12:02:01', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (14, 2, 7, 245, NULL, '用户mark于2023-12-12 17:07:05 下午在古茗提交了一份订单，订单编号为 245', '2023-12-12 17:07:05', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (15, 2, 7, 246, NULL, '用户mark于2023-12-12 17:11:28 下午在古茗提交了一份订单，订单编号为 246', '2023-12-12 17:11:28', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (16, 2, 7, 247, NULL, '用户mark于2023-12-12 17:12:36 下午在古茗提交了一份订单，订单编号为 247', '2023-12-12 17:12:36', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (17, 2, 7, 248, NULL, '用户mark于2023-12-12 17:12:55 下午在古茗提交了一份订单，订单编号为 248', '2023-12-12 17:12:55', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (18, 2, 7, 249, NULL, '用户mark于2023-12-12 17:15:42 下午在古茗提交了一份订单，订单编号为 249', '2023-12-12 17:15:42', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (19, 2, 7, 250, NULL, '用户mark于2023-12-12 17:17:58 下午在古茗提交了一份订单，订单编号为 250', '2023-12-12 17:17:58', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (20, 2, 7, 251, NULL, '用户mark于2023-12-12 17:29:17 下午在古茗提交了一份订单，订单编号为 251', '2023-12-12 17:29:17', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (21, 2, 7, 251, NULL, '店铺：古茗于2023-12-12 17:29:53 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-12 17:29:53', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (22, 2, 14, 252, NULL, '用户mark于2023-12-14 10:55:35 上午在海底捞提交了一份订单，订单编号为 252', '2023-12-14 10:55:35', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (23, 2, 14, 253, NULL, '用户mark于2023-12-14 10:57:58 上午在海底捞提交了一份订单，订单编号为 253', '2023-12-14 10:57:58', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (24, 2, 7, 254, NULL, '用户mark于2023-12-14 13:23:38 下午在古茗提交了一份订单，订单编号为 254', '2023-12-14 13:23:38', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (25, 2, 14, 255, NULL, '用户mark于2023-12-14 13:38:01 下午在海底捞提交了一份订单，订单编号为 255', '2023-12-14 13:38:01', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (26, 2, 7, 256, NULL, '用户mark于2023-12-14 13:38:30 下午在古茗提交了一份订单，订单编号为 256', '2023-12-14 13:38:30', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (27, 2, 7, 257, NULL, '用户mark于2023-12-14 13:41:02 下午在古茗提交了一份订单，订单编号为 257', '2023-12-14 13:41:02', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (28, 2, 7, 258, NULL, '用户mark于2023-12-14 14:03:34 下午在古茗提交了一份订单，订单编号为 258', '2023-12-14 14:03:34', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (29, 2, 7, 259, NULL, '用户mark于2023-12-14 14:07:50 下午在古茗提交了一份订单，订单编号为 259', '2023-12-14 14:07:50', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (30, 2, 7, 260, NULL, '用户mark于2023-12-14 14:08:58 下午在古茗提交了一份订单，订单编号为 260', '2023-12-14 14:08:58', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (31, 2, NULL, 251, 1, '快递员：jack于2023-12-14 14:18:29 下午到达商家，请耐心等待', '2023-12-14 14:18:29', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (32, 2, NULL, 21, 1, '快递员：jack于2023-12-14 14:32:53 下午到达商家，请耐心等待', '2023-12-14 14:32:53', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (33, 2, 14, 255, NULL, '店铺：海底捞于2023-12-14 14:56:24 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-14 14:56:24', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (34, 2, 7, 261, NULL, '用户mark于2023-12-15 10:19:45 上午在古茗提交了一份订单，订单编号为 261', '2023-12-15 10:19:45', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (35, 2, 7, 262, NULL, '用户mark于2023-12-17 15:36:19 下午在古茗提交了一份订单，订单编号为 262', '2023-12-17 15:36:19', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (36, 2, 14, 263, NULL, '用户mark于2023-12-17 15:41:21 下午在海底捞提交了一份订单，订单编号为 263', '2023-12-17 15:41:21', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (37, 2, 14, 263, NULL, '店铺：海底捞于2023-12-17 15:41:54 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-17 15:41:54', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (38, 2, NULL, 263, 5, '快递员：Messi于2023-12-17 15:42:24 下午到达商家，请耐心等待', '2023-12-17 15:42:24', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (39, 2, 7, 264, NULL, '用户mark于2023-12-17 16:08:31 下午在古茗提交了一份订单，订单编号为 264', '2023-12-17 16:08:31', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (40, 2, 7, 264, NULL, '店铺：古茗于2023-12-17 16:11:36 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-17 16:11:36', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (41, 2, NULL, 264, 5, '快递员：Messi于2023-12-17 16:12:18 下午到达商家，请耐心等待', '2023-12-17 16:12:18', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (42, 2, 14, 265, NULL, '用户mark于2023-12-17 16:39:59 下午在海底捞提交了一份订单，订单编号为 265', '2023-12-17 16:39:59', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (43, 2, 14, 265, NULL, '店铺：海底捞于2023-12-17 16:40:24 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-17 16:40:24', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (44, 2, NULL, 265, 5, '快递员：Messi于2023-12-17 16:40:41 下午到达商家，请耐心等待', '2023-12-17 16:40:41', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (45, 2, 7, 266, NULL, '用户mark于2023-12-17 23:06:04 下午在古茗提交了一份订单，订单编号为 266', '2023-12-17 23:06:04', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (46, 2, 7, 266, NULL, '店铺：古茗于2023-12-17 23:06:24 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-17 23:06:24', 2);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (47, 2, NULL, 266, 5, '快递员：Messi于2023-12-17 23:41:33 下午到达商家，请耐心等待', '2023-12-17 23:41:33', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (48, 2, 19, 267, NULL, '用户mark于2023-12-18 09:24:45 上午在麦当劳提交了一份订单，订单编号为 267', '2023-12-18 09:24:45', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (49, 2, 19, 267, NULL, '店铺：麦当劳于2023-12-18 09:25:25 上午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-18 09:25:25', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (50, 2, NULL, 267, 5, '快递员：Messi于2023-12-18 09:26:50 上午到达商家，请耐心等待', '2023-12-18 09:26:50', 2);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (51, 2, 14, 268, NULL, '用户mark于2023-12-18 14:56:30 下午在海底捞提交了一份订单，订单编号为 268', '2023-12-18 14:56:30', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (52, 2, 7, 269, NULL, '用户mark于2023-12-18 15:14:00 下午在古茗提交了一份订单，订单编号为 269', '2023-12-18 15:14:00', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (53, 2, 7, 269, NULL, '店铺：古茗于2023-12-18 15:14:20 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-18 15:14:20', 2);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (54, 2, NULL, 269, 5, '快递员：Messi于2023-12-18 15:14:42 下午到达商家，请耐心等待', '2023-12-18 15:14:42', 2);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (55, 2, 14, 270, NULL, '用户mark于2023-12-18 15:22:36 下午在海底捞提交了一份订单，订单编号为 270', '2023-12-18 15:22:36', 0);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (56, 2, 14, 271, NULL, '用户mark于2023-12-18 15:37:57 下午在海底捞提交了一份订单，订单编号为 271', '2023-12-18 15:37:57', 1);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (57, 2, 14, 271, NULL, '店铺：海底捞于2023-12-18 15:38:24 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-18 15:38:24', 2);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (58, 2, 14, 270, NULL, '店铺：海底捞于2023-12-18 15:38:26 下午接单，快递员正在快马加鞭赶来，请您耐心等待', '2023-12-18 15:38:26', 2);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (59, 2, NULL, 270, 5, '快递员：Messi于2023-12-18 15:57:49 下午到达商家，请耐心等待', '2023-12-18 15:57:49', 2);
INSERT INTO `message` (`messageID`, `userID`, `shopID`, `orderID`, `deliveryID`, `msgContent`, `msgTime`, `state`) VALUES (60, 2, NULL, 271, 5, '快递员：Messi于2023-12-18 15:57:52 下午到达商家，请耐心等待', '2023-12-18 15:57:52', 2);
COMMIT;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderID` int NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `userID` int NOT NULL COMMENT '用户编号',
  `shopID` int NOT NULL COMMENT '店铺编号',
  `deliveryID` int DEFAULT NULL COMMENT '骑手编号',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `order_state` int DEFAULT '0' COMMENT '订单状态（0：商家未接单，1：商家接单骑手未接单，2：骑手接单但是未送达，3：订单送达）',
  `good_total` decimal(10,2) DEFAULT NULL COMMENT '菜品总价',
  `delivery_price` decimal(10,2) DEFAULT NULL COMMENT '配送费',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '订单总价格',
  `order_time` timestamp NULL DEFAULT NULL COMMENT '店铺接单时间',
  `pick_time` timestamp NULL DEFAULT NULL COMMENT '骑手接单时间',
  `arrive_time` datetime DEFAULT NULL COMMENT '送达时间',
  PRIMARY KEY (`orderID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
BEGIN;
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (12, 2, 7, 2, '2023-12-03 21:24:14', 3, 1.00, 10.00, 29.00, '2023-12-06 12:01:06', '2023-12-07 21:07:13', '2023-12-17 16:07:37');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (13, 2, 7, 2, '2023-12-03 21:29:09', 3, 1.00, 10.00, 21.00, '2023-12-07 21:06:33', '2023-12-07 21:07:17', '2023-12-17 16:07:36');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (14, 2, 7, 3, '2023-12-03 21:35:39', 3, 2.00, 10.00, 39.00, '2023-12-06 11:17:27', '2023-12-06 13:03:18', '2023-12-17 16:07:34');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (15, 2, 7, 3, '2023-12-03 21:36:07', 3, 1.00, 10.00, 27.00, '2023-12-06 11:03:41', '2023-12-06 12:48:15', '2023-12-17 16:07:33');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (16, 2, 7, 5, '2023-12-03 21:36:18', 3, 0.00, 10.00, 9.00, '2023-12-07 21:06:35', '2023-12-09 10:29:18', '2023-12-17 16:07:31');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (17, 2, 7, 2, '2023-12-04 12:39:15', 3, 56.00, 10.00, 66.00, '2023-12-06 12:03:17', '2023-12-07 21:07:15', '2023-12-17 16:07:29');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (18, 2, 7, 2, '2023-12-04 12:46:29', 3, 152.00, 10.00, 162.00, '2023-12-07 21:06:37', '2023-12-09 13:47:20', '2023-12-17 16:07:28');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (21, 2, 7, 1, '2023-12-04 12:49:47', 3, 20.00, 10.00, 30.00, '2023-12-07 21:06:47', '2023-12-14 14:32:53', '2023-12-17 16:07:26');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (22, 2, 7, 5, '2023-12-04 12:55:08', 3, 18.00, 10.00, 28.00, '2023-12-07 21:06:49', '2023-12-11 12:02:01', '2023-12-17 16:07:25');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (23, 2, 7, 2, '2023-12-04 13:07:28', 3, 226.00, 10.00, 236.00, '2023-12-06 11:13:42', '2023-12-06 12:48:25', '2023-12-17 16:07:22');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (24, 2, 7, 2, '2023-12-04 13:11:30', 3, 38.00, 10.00, 48.00, '2023-08-06 15:37:10', '2023-08-06 15:38:23', '2023-08-06 15:56:39');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (25, 2, 7, 2, '2023-12-04 13:11:36', 3, 18.00, 10.00, 28.00, '2023-11-04 17:45:39', '2023-11-06 10:54:15', '2023-12-17 16:07:21');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (26, 2, 7, 2, '2023-12-04 13:13:50', 3, 18.00, 10.00, 28.00, '2023-11-04 17:45:36', '2023-11-06 12:15:43', '2023-12-17 16:07:16');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (27, 2, 7, 2, '2023-10-04 13:14:05', 3, 21.00, 10.00, 31.00, '2023-10-05 11:23:41', '2023-10-05 11:27:43', '2023-10-05 11:32:52');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (28, 2, 7, 2, '2023-09-04 13:15:16', 3, 18.00, 10.00, 28.00, '2023-09-04 11:23:10', '2023-09-04 11:18:13', '2022-09-05 11:27:22');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (37, 2, 7, 2, '2023-08-04 21:14:02', 3, 87.00, 10.00, 97.00, '2023-08-04 21:29:37', '2023-08-05 11:16:44', '2023-08-05 11:22:55');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (38, 2, 7, 2, '2023-12-04 21:43:09', 3, 108.00, 10.00, 118.00, '2023-12-04 21:44:02', '2023-12-04 23:16:53', '2023-12-05 08:49:15');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (39, 2, 14, 2, '2023-12-05 15:41:13', 3, 163.00, 10.00, 173.00, '2023-12-05 15:44:23', '2023-12-05 15:44:41', '2023-12-05 15:59:43');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (240, 2, 7, 5, '2023-12-09 17:50:17', 3, 38.00, 10.00, 48.00, '2023-12-09 18:08:53', '2023-12-09 18:09:47', '2023-12-17 16:07:13');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (244, 2, 7, 5, '2023-08-11 10:12:29', 3, 18.00, 10.00, 28.00, '2023-08-11 10:13:13', '2023-08-11 11:51:47', '2023-08-13 21:48:13');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (263, 2, 14, 5, '2023-09-17 15:41:21', 3, 170.00, 2.00, 172.00, '2023-09-17 15:41:54', '2023-09-17 15:42:24', '2023-09-17 15:43:09');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (264, 2, 7, 5, '2023-09-17 16:08:31', 3, 38.00, 2.00, 40.00, '2023-09-17 16:11:36', '2023-09-17 16:12:18', '2023-09-17 16:12:39');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (265, 2, 14, 5, '2023-12-17 16:39:59', 3, 116.00, 2.00, 118.00, '2023-12-17 16:40:24', '2023-12-17 16:40:41', '2023-12-17 16:46:05');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (266, 2, 7, 5, '2023-12-17 23:06:04', 3, 35.00, 2.00, 37.00, '2023-12-17 23:06:24', '2023-12-17 23:41:33', '2023-12-18 15:15:06');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (267, 2, 19, 5, '2023-12-18 09:24:45', 3, 13.50, 2.00, 15.50, '2023-12-18 09:25:25', '2023-12-18 09:26:50', '2023-12-18 15:15:04');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (268, 2, 14, 5, '2023-12-18 14:56:30', 0, 98.00, 2.00, 100.00, '2023-12-18 15:15:17', '2023-12-18 15:15:19', '2023-12-18 15:15:22');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (269, 2, 7, 5, '2023-12-18 15:14:00', 3, 38.00, 2.00, 40.00, '2023-12-18 15:14:20', '2023-12-18 15:14:42', '2023-12-18 15:15:03');
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (270, 2, 14, 5, '2023-12-18 15:22:36', 2, 66.00, 2.00, 68.00, '2023-12-18 15:38:26', '2023-12-18 15:57:49', NULL);
INSERT INTO `order` (`orderID`, `userID`, `shopID`, `deliveryID`, `create_time`, `order_state`, `good_total`, `delivery_price`, `total_price`, `order_time`, `pick_time`, `arrive_time`) VALUES (271, 2, 14, 5, '2023-12-18 15:37:57', 2, 66.00, 2.00, 68.00, '2023-12-18 15:38:24', '2023-12-18 15:57:52', NULL);
COMMIT;

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `detailID` int NOT NULL AUTO_INCREMENT COMMENT '订单明细编号',
  `orderID` int DEFAULT NULL COMMENT '订单编号',
  `productID` int DEFAULT NULL COMMENT '菜品编号',
  `productname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜品名称',
  `quantity` int DEFAULT NULL COMMENT '菜品销售数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '商品单价',
  PRIMARY KEY (`detailID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=354 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
BEGIN;
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (31, 37, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (32, 37, 17, '水果奶茶', 4, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (33, 38, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (34, 38, 10, '百花咖啡', 3, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (35, 38, 17, '水果奶茶', 1, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (36, 39, 20, '东阴功火锅底料', 1, 50.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (37, 39, 25, '鲜油豆皮', 1, 11.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (38, 39, 34, '巴沙鱼片', 1, 28.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (39, 39, 30, '捞派滑牛肉', 1, 33.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (40, 39, 27, '铃铃卷', 1, 13.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (41, 39, 31, '劲道牛肉丸', 1, 28.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (42, 40, 20, '东阴功火锅底料', 1, 50.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (43, 42, 20, '东阴功火锅底料', 1, 50.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (44, 42, 30, '捞派滑牛肉', 1, 33.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (45, 43, 20, '东阴功火锅底料', 1, 50.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (46, 44, 20, '东阴功火锅底料', 1, 50.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (47, 45, 20, '东阴功火锅底料', 1, 50.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (48, 45, 32, '海带苗', 1, 10.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (49, 46, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (50, 46, 10, '百花咖啡', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (51, 46, 18, '椰果奶茶', 1, 12.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (52, 47, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (53, 47, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (54, 48, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (55, 48, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (56, 49, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (57, 49, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (58, 50, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (59, 50, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (60, 51, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (61, 51, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (62, 52, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (63, 52, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (64, 53, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (65, 53, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (66, 54, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (67, 54, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (68, 55, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (69, 55, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (70, 56, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (71, 56, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (72, 57, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (73, 57, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (74, 58, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (75, 58, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (76, 59, 11, '珍珠奶茶', 2, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (77, 59, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (292, 229, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (293, 230, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (294, 231, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (295, 232, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (296, 233, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (297, 234, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (298, 235, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (299, 236, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (300, 237, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (301, 238, 17, '水果奶茶', 1, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (302, 239, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (303, 240, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (304, 240, 17, '水果奶茶', 1, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (305, 241, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (306, 241, 18, '椰果奶茶', 1, 12.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (307, 242, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (308, 242, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (309, 242, 10, '百花咖啡', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (310, 242, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (311, 242, 19, '巧克力奶茶', 2, 21.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (312, 243, 17, '水果奶茶', 1, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (313, 244, 17, '水果奶茶', 1, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (314, 245, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (315, 245, 18, '椰果奶茶', 1, 12.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (316, 246, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (317, 249, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (318, 251, 17, '水果奶茶', 2, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (319, 251, 10, '百花咖啡', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (320, 252, 21, '番茄火锅底料', 1, 40.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (321, 254, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (322, 255, 24, '三鲜', 1, 30.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (323, 256, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (324, 257, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (325, 258, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (326, 259, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (327, 260, 18, '椰果奶茶', 1, 12.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (328, 261, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (329, 262, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (330, 262, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (331, 263, 20, '东阴功火锅底料', 1, 50.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (332, 263, 26, '嫩滑黑鱼片', 1, 22.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (333, 263, 28, '捞派猪黄喉', 1, 33.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (334, 263, 33, '大颗粒虾滑', 1, 32.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (335, 263, 30, '捞派滑牛肉', 1, 33.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (336, 264, 17, '水果奶茶', 1, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (337, 264, 10, '百花咖啡', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (338, 265, 22, '菌汤火锅底料', 2, 45.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (339, 265, 27, '铃铃卷', 1, 13.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (340, 265, 27, '铃铃卷', 1, 13.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (341, 266, 11, '珍珠奶茶', 1, 15.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (342, 266, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (343, 267, 48, '芝士安格斯牛肉堡', 1, 13.50);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (344, 268, 20, '东阴功火锅底料', 1, 50.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (345, 268, 23, '清油火锅底料', 1, 35.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (346, 268, 27, '铃铃卷', 1, 13.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (347, 269, 16, '芝士奶茶', 1, 20.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (348, 269, 17, '水果奶茶', 1, 18.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (349, 270, 21, '番茄火锅底料', 1, 40.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (350, 270, 27, '铃铃卷', 1, 13.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (351, 270, 27, '铃铃卷', 1, 13.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (352, 271, 21, '番茄火锅底料', 1, 40.00);
INSERT INTO `order_detail` (`detailID`, `orderID`, `productID`, `productname`, `quantity`, `price`) VALUES (353, 271, 27, '铃铃卷', 2, 13.00);
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `productID` int NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `categoryID` int NOT NULL COMMENT '商品类别编号\n',
  `shopID` int DEFAULT NULL COMMENT '店铺编号',
  `productname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `psrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品图片',
  `product_rest` int DEFAULT '0' COMMENT '库存',
  `sales` int DEFAULT '0' COMMENT '销量\n',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品描述',
  PRIMARY KEY (`productID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
BEGIN;
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (10, 13, 7, '百花咖啡', 'http://localhost:9091/file/0318c0785a4c4d7cb107349dcb84ef08.jpg', 58, 2, 20.00, '外观精美，味道醇厚');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (11, 11, 7, '珍珠奶茶', 'http://localhost:9091/file/71e11b42682947839050534ca5a8e476.jpg', 209, 11, 15.00, '经典奶茶');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (16, 11, 7, '芝士奶茶', 'http://localhost:9091/file/19ebcfd58b1c49c19c0ecb4e519548f2.jpg', 10, 20, 20.00, '镇店之茶');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (17, 11, 7, '水果奶茶', 'http://localhost:9091/file/2369c8a2d9e7484192a08e9a3fc1f34e.jpg', 8, 12, 18.00, '水果奶茶，多种多样呦');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (18, 11, 7, '椰果奶茶', 'http://localhost:9091/file/4c123c7026584795ad332707514036e5.jpg', 206, 4, 12.00, '正宗椰果奶茶，不好喝不要钱');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (19, 15, 7, '巧克力奶茶', 'http://localhost:9091/file/f555fc1096904673b13e68a8e5c65d1d.jpg', 97, 3, 21.00, '上等巧克力');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (20, 16, 14, '东阴功火锅底料', 'http://localhost:9091/file/65f556a85d80434d9614ed4d7dff8361.jpg', 10, 1, 50.00, '冬天喝正合适');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (21, 16, 14, '番茄火锅底料', 'http://localhost:9091/file/fdbc0dd7bd164364be66d0c576dea10a.jpg', 1006, 3, 40.00, '经典底料，店长推荐');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (22, 16, 14, '菌汤火锅底料', 'http://localhost:9091/file/a3f14a37aa5c453fb281ed656e255b5c.jpg', 977, 1, 45.00, '养生底料，你值得拥有');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (23, 16, 14, '清油火锅底料', 'http://localhost:9091/file/9077b99d27784684a91583caef515100.jpg', 979, 1, 35.00, '无以言表');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (24, 16, 14, '三鲜', 'http://localhost:9091/file/a4bcaa3757d342db9a8b4cd99667f64d.jpg', 2993, 1, 30.00, '三鲜！十三香');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (25, 17, 14, '鲜油豆皮', 'http://localhost:9091/file/5b874c2a307e445aa674282b698832d2.JPG', 120, 0, 11.00, '口感嫩滑');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (26, 17, 14, '嫩滑黑鱼片', 'http://localhost:9091/file/e9d999976ab745aca75696a73043b98b.JPG', 109, 1, 22.00, '鲜嫩丰腴');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (27, 17, 14, '铃铃卷', 'http://localhost:9091/file/a265413eb2fc4686a43b62205adca183.JPG', 119, 1, 13.00, '外裹汤汁，内含酥脆');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (28, 17, 14, '捞派猪黄喉', 'http://localhost:9091/file/1cfc90f52667427a80af34461234401f.JPG', 200, 0, 33.00, '口感嫩脆弹');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (29, 17, 14, '捞派鸭肠', 'http://localhost:9091/file/67b471a090cb47f19a6a9c978bca01a4.JPG', 199, 1, 23.00, '口感爽脆有韧性');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (30, 17, 14, '捞派滑牛肉', 'http://localhost:9091/file/1ccfb1f2ec3c4e088f5867f2931f74b3.JPG', 119, 1, 33.00, '鲜香滑嫩，久煮不老');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (31, 17, 14, '劲道牛肉丸', 'http://localhost:9091/file/7358008e93af4c8c988b2142274af6ba.JPG', 321, 0, 28.00, '有劲道');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (32, 17, 14, '海带苗', 'http://localhost:9091/file/5e0d8f5efb6c41d6ade12b1378e5df77.JPG', 299, 1, 10.00, '8秒涮烫');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (33, 17, 14, '大颗粒虾滑', 'http://localhost:9091/file/c86c8760bd464896bd776ccb5380756a.JPG', 100, 0, 32.00, '鲜甜Q弹');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (34, 17, 14, '巴沙鱼片', 'http://localhost:9091/file/80902b00396843248de605dd3be3af20.JPG', 209, 1, 28.00, '口感贤能，鱼肉刺少');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (35, 18, 14, '蒜蓉小龙虾', 'http://localhost:9091/file/d254d73c2b3a402997a82328d5d226e9.JPG', 123, 0, 49.90, '虾黄肥厚、肉质紧实、口口满足');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (36, 18, 14, '麻辣小龙虾', 'http://localhost:9091/file/ee26c50447ef47cbbff738b9f6846ce1.JPG', 120, 0, 49.90, '分量十足，肥美肉多，口口满足');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (37, 18, 14, '麻辣小龙虾 套餐1', 'http://localhost:9091/file/2cd8d4040d3645f6a14446f696153476.JPG', 30, 0, 227.50, '分量十足，口味麻辣，超值');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (38, 18, 14, '麻辣小龙虾 套餐2', 'http://localhost:9091/file/5bb07f7169254d499264c88adfc4ff06.JPG', 60, 0, 113.80, '店长推荐');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (39, 21, 14, '经典羔羊肉', 'http://localhost:9091/file/6045ff87031c4b19923da5f845107638.JPG', 130, 0, 28.00, '肉质细嫩，味道鲜美涮煮时间20秒');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (40, 21, 14, '肥牛卷', 'http://localhost:9091/file/c0a8216e03514ac29e55c59713b67e8c.JPG', 200, 0, 35.00, '好吃的肥牛卷，香嫩十足');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (41, 21, 14, '火锅牛排', 'http://localhost:9091/file/b12431a3dd7b453a85032929b3b58d22.JPG', 70, 0, 30.00, '口感细嫩有嚼劲，涮煮时间3分钟');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (42, 21, 14, '层层血浪猪五花', 'http://localhost:9091/file/12510221802a4cc290ec91ee9eba8dd2.JPG', 300, 0, 20.00, '肥瘦相间，香而不腻涮煮时间20秒');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (43, 21, 14, '脆脆千层毛肚', 'http://localhost:9091/file/fc7facbee2f3458b89f2224b2252bbc4.JPG', 40, 0, 40.00, '七上八下即可，火锅必备');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (44, 21, 14, '血旺', 'http://localhost:9091/file/f4da5a56fc2c405191d343932b3bb2cf.JPG', 1000, 0, 8.00, '入口嫩滑爽口，搭配赠送的海椒干碟，涮煮5分钟');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (45, 21, 14, '小香肠', 'http://localhost:9091/file/98fc95458f334c759596cb9bbd9feddd.JPG', 2000, 0, 16.00, '猪肉味道鲜甜，口感脆嫩；涮煮时间6分钟');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (46, 21, 14, '午餐肉', 'http://localhost:9091/file/e9dd38d287504c689251f8b8b393c8e9.JPG', 1020, 0, 20.00, '香味浓郁、肉质鲜嫩。涮煮时间2分钟');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (47, 21, 14, '我的小郡肝', 'http://localhost:9091/file/92f4b62e8a314b17a7459f66852b9958.JPG', 400, 0, 20.00, '口感香辣 爽脆 涮煮时间煮5分钟');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (49, 25, 27, '叉烧包', 'http://localhost:9091/file/ed6ad114ee5b4eb1a00bb458ecf16485.jpg', 200, 0, 1.00, '香糯鲜美，叉烧馅饱满，口感十足');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (50, 25, 27, '灌汤小笼包', 'http://localhost:9091/file/28368ee2abbb4cdaaa0dca68e15eb5e0.jpg', 300, 0, 1.50, '鲜汁爆裂，皮薄馅丰，满口鲜美香浓');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (51, 25, 27, '核桃包', 'http://localhost:9091/file/cdf215a1876a4fe799a85be317a90e18.jpg', 234, 0, 1.60, '香甜独特，核桃酥香，口感丰富');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (52, 25, 27, '流沙包', 'http://localhost:9091/file/869b5302a74048cf8d143cf984a18f95.jpg', 230, 0, 2.00, '流心绵滑，香甜四溢，包馅丰富可口');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (53, 26, 27, '小米南瓜粥', 'http://localhost:9091/file/72571378cf864dc1a4b7db779f389129.jpg', 130, 0, 14.40, '细腻糯香，小米与南瓜相得益彰，暖心美味');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (54, 26, 27, '绿豆粥', 'http://localhost:9091/file/7f462405d25d45e1966cb5e09596c91c.jpg', 300, 0, 16.00, '清爽养颜，绿豆粥清香煮意，健康暖胃');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (55, 26, 27, '红豆粥', 'http://localhost:9091/file/e66c569c9fad417ab3f48c333e08d710.jpg', 330, 0, 18.00, '甜滋醇香，红豆粥温暖心灵，满足味蕾');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (56, 11, 7, '炒黑糖珍珠牛乳', 'http://localhost:9091/file/9bb52fc6abaf46b993dfa46e344f3277.JPG', 310, 0, 13.30, '珍珠软软糯糯有嚼劲');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (57, 11, 7, '芋泥厚厚牛乳', 'http://localhost:9091/file/4719d7708e1c474f856a171896ad0260.JPG', 209, 0, 11.80, '芋泥量足，味道好');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (58, 15, 7, '奥利奥流心芝士', 'http://localhost:9091/file/1066c3c4427a45679455b4feff746b30.JPG', 123, 0, 12.80, '奥利奥配奶茶，味道绝佳');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (59, 11, 7, '伏叶落水香', 'http://localhost:9091/file/becb15d3539d4a0a855a5b6e1f861fb4.JPG', 124, 0, 14.60, '进口牛油果');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (60, 14, 7, '杨枝甘露椰奶', 'http://localhost:9091/file/aca3557d4b3d47bc92bfd13ccd8bfce4.JPG', 201, 0, 15.80, '【店长推荐】很新鲜');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (61, 14, 7, '生椰抹茶麻薯', 'http://localhost:9091/file/12a0ab644b9d4aa3952d2eb5fc537a07.JPG', 40, 0, 20.00, '麻薯分量十足');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (62, 14, 7, '厚道生椰榴莲', 'http://localhost:9091/file/65234c4c12d742fcb341fd8b733f4fbb.JPG', 50, 0, 18.80, '榴莲爱好者强推');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (63, 14, 7, '超A芝士葡萄', 'http://localhost:9091/file/e7d763d7080343faa3590ba3347d7529.jpg', 40, 0, 21.00, '【店长推荐】新鲜葡萄,好喝的不得了');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (64, 14, 7, '酒酿桂花饮', 'http://localhost:9091/file/05af2d3a42fc48f88bf4f7bd59c9f261.jpg', 30, 0, 15.50, '酒酿桂花饮清新养颜，美味滋补');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (65, 14, 7, '满杯红玉石榴', 'http://localhost:9091/file/72f2aa8827f946da8b88b4baa1fdeea2.jpg', 25, 0, 17.00, '清新多汁，满杯红玉石榴，酸甜可口');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (66, 13, 7, '芝士咖啡', 'http://localhost:9091/file/5097c0b570ec4971ad6fddc7beae98fb.jpg', 15, 0, 24.00, '【店长推荐】芝士咖啡，丝滑绵密，浓郁香醇，美味独特');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (67, 14, 7, '招牌柠檬茶', 'http://localhost:9091/file/1c6495b8305c458582411ca955da6fbf.jpg', 200, 0, 11.00, '柠香解渴，招牌柠檬茶清新醒神');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (68, 13, 7, '榴莲生椰拿铁', 'http://localhost:9091/file/03d510c7b2f546eea77033a8f683d03c.jpg', 213, 0, 19.00, '榴莲醇香，生椰拿铁丝滑，香浓口味');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (69, 14, 7, '奇异果爆柠', 'http://localhost:9091/file/a785782f9d26489caa837cc1e979b922.jpg', 120, 0, 15.00, '奇异果酸甜，搭配爆柠爽口，清新独特');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (70, 14, 7, '青橘西柚冰冰茶', 'http://localhost:9091/file/be40dc80e7294ef3b9635bb5905a93f3.jpg', 321, 0, 15.00, '青橘西柚，冰冰茶清凉，口感爽快宜人');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (71, 11, 7, '千里暮山红', 'http://localhost:9091/file/8646f100f0554ed19222f6826636a3a0.jpg', 120, 0, 20.00, '丰富层次，千里暮山红，香醇浓郁，回味悠长');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (72, 11, 7, '云岭茉莉白', 'http://localhost:9091/file/b4468c50b71a42b9a093601ccb4725e9.jpg', 100, 0, 20.00, '清雅芳香，云岭茉莉，滋味淡雅');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (73, 27, 19, '【黄金酥脆】麦香鸡三件套', 'http://localhost:9091/file/8bb36c34a6c748d89be4a1fae303bc8b.JPG', 30, 0, 25.00, '餐品分量很足');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (74, 27, 19, '【招牌牛堡】巨无霸两件套', 'http://localhost:9091/file/56e85240c33c47f59115db0132579466.JPG', 123, 0, 25.00, '巨无霸超好吃');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (75, 27, 19, '1+1堡卷自由拼A', 'http://localhost:9091/file/a0e49c085c52495b922b56eb8c9df12e.JPG', 300, 0, 22.00, '多重享受，1+1饮品甜品自由拼，甜蜜创意，满足味蕾');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (76, 27, 19, '1+1 饮品甜品自由拼', 'http://localhost:9091/file/9e00d9473fd44a18909ad70204323a5d.JPG', 30, 0, 6.00, '多重享受，1+1饮品甜品自由拼，甜蜜创意，满足味蕾');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (77, 27, 19, '【职场干饭人】吃堡三件套随心选', 'http://localhost:9091/file/b0ff7c5e47f346fabb084b2aa628a19b.jpg', 30, 0, 29.90, '非常划算，经济又实惠');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (78, 27, 19, '【招牌牛堡】不素之霸双层牛堡两件套', 'http://localhost:9091/file/85b6ecdd3b114c24b718f9f246f32f3f.JPG', 120, 0, 25.00, '荤素搭配，特别好');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (79, 27, 19, '单人【嗨翻星期一】', 'http://localhost:9091/file/e5ddb68a0c394e4e82394d1cf46f7178.JPG', 123, 0, 13.90, '鱼你所愿套餐，丰盛美味，独特口味，满足味蕾');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (80, 27, 19, '【第二份半价】麦香鸡三件套', 'http://localhost:9091/file/85051f2d829c4ddfa955517d61b907d0.JPG', 134, 0, 36.00, '香脆可口，物美价廉');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (81, 27, 19, '【第二份半价】酥酥多笋三件套', 'http://localhost:9091/file/28235ab20ba94ecd935a71f097107a07.JPG', 12, 0, 45.00, '经济实惠，第二份半价，酥酥多笋三件套，美味可口');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (82, 22, 19, '【满分之选】麦满分三件套', 'http://localhost:9091/file/7affb676bdf442cf9bf02a08e3999f65.JPG', 130, 0, 13.90, '三件套很划算');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (83, 22, 19, '【护你周全】皮蛋鸡肉粥三件套', 'http://localhost:9091/file/f75656ef202649e6be1984bc5b6cd682.JPG', 234, 0, 13.90, '价格实惠好吃');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (84, 22, 19, '早餐双蛋堡', 'http://localhost:9091/file/1a3fa33b360c437ebf1f2b014cbe9ec4.JPG', 203, 0, 19.90, '店长推荐');
INSERT INTO `product` (`productID`, `categoryID`, `shopID`, `productname`, `psrc`, `product_rest`, `sales`, `price`, `description`) VALUES (85, 22, 19, '【卷王推荐】', 'http://localhost:9091/file/8f6de83e32b64079b16aa88263274566.JPG', 234, 0, 18.80, '价格实惠品质好');
COMMIT;

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `categoryID` int NOT NULL AUTO_INCREMENT COMMENT '商品类别编号',
  `categoryname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品类别名',
  `shopID` int NOT NULL COMMENT '店铺编号',
  PRIMARY KEY (`categoryID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of product_category
-- ----------------------------
BEGIN;
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (6, '咖啡', 5);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (8, '奶茶', 5);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (9, '果茶', 5);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (10, '甜点', 5);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (11, '奶茶', 7);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (13, '咖啡', 7);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (14, '果茶', 7);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (15, '奥利奥', 7);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (16, '火锅底料', 14);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (17, '捞派十佳', 14);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (18, '龙虾自由', 14);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (21, '经典荤菜', 14);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (22, '早餐', 19);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (23, '小食甜品', 19);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (24, '饮品', 19);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (25, '包子', 27);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (26, '粥', 27);
INSERT INTO `product_category` (`categoryID`, `categoryname`, `shopID`) VALUES (27, '单人餐', 19);
COMMIT;

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `shopID` int NOT NULL AUTO_INCREMENT COMMENT '店铺编号',
  `managerID` int NOT NULL COMMENT '商家编号',
  `shopName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '店铺名称',
  `psrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '店铺照片',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '店铺描述',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '店铺地址',
  `star` decimal(10,2) DEFAULT '5.00' COMMENT '星级(由商品评分的平均值决定几分对应几星，向下取整)',
  `state` int NOT NULL DEFAULT '1' COMMENT '店铺状态（1代表正在运营，0代表冻结中）',
  `shopTypeID` int DEFAULT NULL COMMENT '店铺类别编号',
  PRIMARY KEY (`shopID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of shop
-- ----------------------------
BEGIN;
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (5, 5, '一点点', 'http://localhost:9091/file/d323e4b0c3f54f2d98610cbce120d267.png', '优质奶茶', '江西省南昌市青山湖区江大南路', 4.30, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (6, 5, '霸王茶姬', 'http://localhost:9091/file/a5433c5eb783468b8dd1873dd51dee3f.png', '优质奶茶', '江西省南昌市青山湖区江大南路', 5.00, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (7, 5, '古茗', 'http://localhost:9091/file/dcc21e0cab4641fa8888818f5fd63440.png', '优质奶茶', '江西省南昌市青山湖区江大南路', 0.30, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (8, 5, '喜茶', 'http://localhost:9091/file/4045c049c7224908975bf984419c5639.jpeg', '优质奶茶', '江西省南昌市青山湖区江大南路', 0.50, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (9, 5, '洪都大拇指', 'http://localhost:9091/file/84740f2d2b6140a4997fed201d9043a4.jpeg', '优质奶茶', '江西省南昌市青山湖区江大南路', 2.00, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (10, 5, '瑞幸咖啡', 'http://localhost:9091/file/d4916bd2a8f64a979f26b364445e0895.jpeg', '优质奶茶', '江西省南昌市青山湖区江大南路', 4.00, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (11, 5, '星巴克', 'http://localhost:9091/file/3c26527e86794d7e9aca3d036a1639cb.jpg', '咖啡届顶流', '江西省南昌市安义县', 5.00, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (12, 5, '沪上阿姨', 'http://localhost:9091/file/77fa8c21d9df49f0b32f67497e9633d6.jpg', '好喝', '上海市徐汇区', 5.00, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (13, 5, '茶颜悦色', 'http://localhost:9091/file/a27db9da5e224f90bdcd145813af8952.jpg', '味如其名', '湖南省长沙市', 5.00, 1, 2);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (14, 1, '海底捞', 'http://localhost:9091/file/4699dc8f16494c66b421ebebb5dff78c.jpg', '遥遥领先', '江西省南昌市青山湖区梦时代广场蓝边碗', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (15, 1, '季季红', 'http://localhost:9091/file/9959e4169c034f1e9730743a96d2d83e.png', '江西省内第一大火锅店，遍布江西大街小巷', '江西省南昌市红谷滩区', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (16, 1, '呷哺呷哺', 'http://localhost:9091/file/24c3a270c3ff4189ba9a280d70e73845.jpg', '高端大气上档次', '北京市海淀区', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (17, 1, '东来顺火锅', 'http://localhost:9091/file/f7eb6d77eb8c45b28840c6fd34e1f5a2.jpg', '百年火锅店', '北京市海淀区', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (18, 1, '巴奴火锅', 'http://localhost:9091/file/ba53e8d0bf5144a7aa0a22de5f7966a8.jpg', '没根，郑州搬到北京了', '河南郑州', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (19, 3, '麦当劳', 'http://localhost:9091/file/2844a8fbeb8f45c2880c73207f853d2a.jpg', '经典汉堡，汉堡之王', '江西省南昌市青山湖区麦当劳龙湖天街店', 5.00, 1, 3);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (20, 3, '肯德基', 'http://localhost:9091/file/8da15e5e26d64a15bd28034799816729.jpg', '经典汉堡', '肯德基(恒茂梦时代 广场店)', 5.00, 1, 3);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (21, 3, '塔斯汀', 'http://localhost:9091/file/7c6c1363bb1e4d41a5bd6da30b524195.jpg', '中国人的汉堡', '塔斯汀中国汉堡(上海北路店)', 5.00, 1, 3);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (22, 3, '必胜客', 'http://localhost:9091/file/d9a3df4f386f4a48adb7908076b04cae.jpg', '美味多样，服务优质，环境舒适', '必胜客(恒茂梦时代广场店)', 5.00, 1, 3);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (23, 3, '达美乐', 'http://localhost:9091/file/d24954a11b36427f8f0ce66c00b722e4.png', '薄皮浓料，口感丰富，快捷服务', '玛尚诺餐厅(南昌武商店)', 5.00, 1, 3);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (24, 3, '德克士', 'http://localhost:9091/file/ef237c39e8254eca8307ba2337da2072.png', '香脆多汁，调味独特，速食首选', '德克士(新城吾悦广场店)', 5.00, 1, 3);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (25, 3, '汉堡王', 'http://localhost:9091/file/dcd601d0a0f74634be2f4222dd9d8aef.png', '火烤美味，品种丰富，满足味蕾', '汉堡王(南昌百盛店)', 5.00, 1, 3);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (27, 13, '江川右', 'http://localhost:9091/file/09be61a8fb604101a9e66aba4ae96c24.jpeg', '醇香煮意，口感绵密，温暖胃心', '江川右(青山湖店)', 5.00, 1, 4);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (30, 13, '曼玲粥', 'http://localhost:9091/file/47a995859d1a45fc944da39cb99a34a8.jpg', '曼玲粥香浓绵滑，美味心动', '曼玲粥店(青山南路店)', 5.00, 1, 4);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (31, 13, '宏状元', 'http://localhost:9091/file/9516e65f34fd41b2a3edf274e6ad8417.jpeg', '宏状元美食，口感丰富，令人回味', '独一处粥城(抚河北路店)', 5.00, 1, 4);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (32, 3, '韩员外炸鸡', 'http://localhost:9091/file/80d90043884947f6b9003aa6e573737d.png', '香脆多汁，韩员外炸鸡鲜美诱人，回味无穷', 'HOOTGIRL韩式炸鸡(陶家新村店)', 5.00, 1, 5);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (33, 1, '小龙坎', 'http://localhost:9091/file/80693c02d51e40d6abd64ec734f3c69e.png', '经典老火锅', '小龙坎火锅(中山路店)', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (34, 1, '巴蜀匠人', 'http://localhost:9091/file/467ce8c746e1410fbf6175932da998d1.png', '真杰出的川菜，味道地道，值得一试', '老时代重庆火锅(正嘉都荟广场店)', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (35, 1, '老北京涮锅', 'http://localhost:9091/file/8d5aab322dcb40a7af49b1ffb7457156.png', '鲜美涮锅，传统老北京风味，值得品尝', '九伬坎里重庆老火锅(恒茂梦时代广场店)', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (36, 1, '牛关张火锅', 'http://localhost:9091/file/3b0cf5baab524cd7aa40de64b0b17cf9.png', '美味牛肉，特色火锅，服务热情，值得一尝', '黄门火锅(恒茂梦时代广场店)', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (37, 1, '鼎宴', 'http://localhost:9091/file/a304e8eacb404ae5a1b1175f6b500757.png', '高雅粤菜，风味独特，菜品精致', '南昌市青山湖区江大南路1号 古乐牛香·鲜牛肉牛杂火锅', 5.00, 1, 1);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (38, 11, '袁记云饺', 'http://localhost:9091/file/1c873b65a9c34c82ae61421c87c438ea.png', '云南美食，袁记云饺独具特色，鲜香可口', '袁记云饺(青山湖区江大南路农贸市场店)', 5.00, 1, 11);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (39, 11, '元气饺子', 'http://localhost:9091/file/ec89043380a24c6880c85022ee2ae5c2.png', '元气饺子，创意独特，口感丰富，美味十足', '元气饺子(瑶湖店)', 5.00, 1, 11);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (40, 11, '和意', 'http://localhost:9091/file/36431a034ca6485d81263923c8e658c8.png', '和意水饺，口感鲜美，馅料新鲜丰富', '袁记云饺(南昌市西湖区绳金塔店)', 5.00, 1, 11);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (41, 11, '谢记味庄', 'http://localhost:9091/file/4596a416942747619fe4ea45f106b8bf.jpg', '谢记味庄，独创美味，菜品丰富多样', '味庄饭店(洪恒山庄店)', 5.00, 1, 9);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (42, 11, '十面埋伏', 'http://localhost:9091/file/8b6deaa41ce247b2a68e5210e2dce2e5.jpg', '十面埋伏，巧妙烹饪，菜品丰富精致', '河南面馆(桃苑西路店)', 5.00, 1, 9);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (43, 11, '牛回回', 'http://localhost:9091/file/3c9f4106c7624c19a450063ba195c6c9.png', '牛回回，醇厚牛肉美味', '熊老五总店', 5.00, 1, 9);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (44, 11, '龙川拉面', 'http://localhost:9091/file/48d4825af38c43fbbcfb71a7df19c4ff.png', '龙川拉面，浓郁湖南风味，拉面劲道爽滑', '中國蘭州拉麵(海上传奇店)', 5.00, 1, 9);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (45, 11, '津八爷', 'http://localhost:9091/file/437b810394d54503b996b06d1a964be1.png', '津八爷，川味麻辣正宗，菜品口味独特', '南昌市南昌县天香大道佳海工业园兰州拉面', 5.00, 1, 9);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (46, 9, '一周便当', 'http://localhost:9091/file/7848f070787f4e5cb5678fa07847ab74.png', '一周便当，精心搭配，口味丰富', '江西省南昌市青山湖区南昌大学北区', 5.00, 1, 10);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (47, 9, '吴记虾饭', 'http://localhost:9091/file/0f0daeb89e8f40609b734c1c00e85450.jpg', '吴记虾饭', '江西省南昌市青山湖区215号', 5.00, 1, 10);
INSERT INTO `shop` (`shopID`, `managerID`, `shopName`, `psrc`, `description`, `address`, `star`, `state`, `shopTypeID`) VALUES (48, 9, '王厨一哥', 'http://localhost:9091/file/354f81365ec34355a3791b5fca59e8a2.png', '王厨一哥', '江西省南昌市青山湖区238号', 5.00, 1, 10);
COMMIT;

-- ----------------------------
-- Table structure for shoptype
-- ----------------------------
DROP TABLE IF EXISTS `shoptype`;
CREATE TABLE `shoptype` (
  `shopTypeID` int NOT NULL AUTO_INCREMENT COMMENT '店铺类别编号',
  `shopTypeName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '店铺类别名称',
  PRIMARY KEY (`shopTypeID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of shoptype
-- ----------------------------
BEGIN;
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (1, '火锅');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (2, '甜点饮品');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (3, '薯条汉堡');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (4, '包子粥店');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (5, '炸鸡炸串');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (6, '能量西餐');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (7, '鸭脖卤味');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (8, '日料寿司');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (9, '米粉面店');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (10, '快餐便当');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (11, '饺子混沌');
INSERT INTO `shoptype` (`shopTypeID`, `shopTypeName`) VALUES (12, '麻辣烫冒菜');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userID` int NOT NULL AUTO_INCREMENT COMMENT 'id\n',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名\n',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称\n',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `score` int NOT NULL DEFAULT '0' COMMENT '积分',
  `state` int NOT NULL DEFAULT '1' COMMENT '账号状态\n',
  `psrc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '/default_avatar.JPG' COMMENT '头像路径',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (1, 'admin', 'admin', '管理员', 'admin@qq.com', '12345432786', '江西省南昌市青山湖区南京东路235号', 0, 1, '/default_avatar.JPG', '2023-12-02 17:13:43');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (2, 'mark', '123', 'markydh', '2247654142@qq.com', '18397910331', '江西省南昌市红谷滩区南昌大学本部', 15, 1, 'http://localhost:9091/file/9e87eece12bb405fa5fecf92d2e39e0a.jpg', '2023-12-18 09:26:03');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (11, 'gem', '123', '邓紫棋', 'gem@qq.com', '77777777777', '中国香港', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:27');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (12, 'R&B', '123', '方大同', 'R&B@qq.com', '1111111111', '中国台湾', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:26');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (13, 'hiphop', '123', '陶喆', 'hiphop@qq.com', '2222222222', '中国台湾', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:25');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (14, 'nba', '123', '美国篮球', 'nba@qq.com', '3333333333', '美国纽约', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:23');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (16, 'LALIGA', '123', '西甲', 'LALIGA@qq.com', '12305', '西班牙马德里', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:24');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (17, 'Premier League', '123', '英超', 'PremierLeague@qq.com', '12306', '英国曼彻斯特', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:21');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (18, 'messi', '123', '梅西', 'messi@qq.com', '88888888', '阿根廷河床', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:22');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (23, 'james', '123', '老詹', 'james@gamil.com', '+10 1234', '美国克利夫兰', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:20');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (24, 'curry', '123', '萌神', '12', '12', '12', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:19');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (27, 'joker', '123', '约基奇', '13', '12', '12', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:17');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (46, 'theshy', '123', '剑魔', '123@qq.com', '1390992124', '韩国首尔', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:18');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (77, 'username', '123', 'zty', 'as@qq.co', '123121', '1212', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:17');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (89, 'kd', '123', 'kevin durant666', '123@qq.com', '123', '123', 12, 1, '/default_avatar.JPG', '2023-12-18 09:39:15');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (93, 'tanggod', '123', '汤神', '123442@qq.com', '123', '123', 0, 1, '/default_avatar.JPG', '2023-12-18 09:39:14');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (94, 'hello', '123', '1234', '12@qq.com', '123', '123', 0, 1, '/default_avatar.JPG', '2023-12-18 09:38:49');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (116, 'faker', '135', '李相赫', 'T1@qq.com', '123', '韩国釜山', 0, 1, '/default_avatar.JPG', '2023-12-02 17:13:43');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (117, 'SKT', '123', '123', '123@qq.com', '123', '123', 0, 1, '/default_avatar.JPG', '2023-12-02 17:13:43');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (118, 'jack', 'jack', 'jack', '123@qq.com', '123', '123', 0, 1, '/default_avatar.JPG', '2023-12-02 17:13:43');
INSERT INTO `user` (`userID`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `score`, `state`, `psrc`, `createDate`) VALUES (122, 'hadesen', 'hadesen', '哈德森', '8986312357@126.com', '18937679083', '南昌市东湖区大士院住宅三区10栋', 0, 1, '/default_avatar.JPG', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
