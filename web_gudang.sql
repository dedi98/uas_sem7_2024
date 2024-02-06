/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100138
 Source Host           : localhost:3306
 Source Schema         : web_gudang

 Target Server Type    : MySQL
 Target Server Version : 100138
 File Encoding         : 65001

 Date: 06/02/2024 16:15:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_barang_keluar
-- ----------------------------
DROP TABLE IF EXISTS `tb_barang_keluar`;
CREATE TABLE `tb_barang_keluar`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_transaksi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal_masuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal_keluar` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_barang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_barang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `satuan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_barang_keluar
-- ----------------------------
INSERT INTO `tb_barang_keluar` VALUES (18, 'WG-202487406351', '06/02/2024', '06/02/2024', 'Jawa Barat', 'WG-001', 'KOPI ABC', 'Pack', '2');

-- ----------------------------
-- Table structure for tb_barang_masuk
-- ----------------------------
DROP TABLE IF EXISTS `tb_barang_masuk`;
CREATE TABLE `tb_barang_masuk`  (
  `id_transaksi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_barang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_barang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `satuan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_transaksi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_barang_masuk
-- ----------------------------
INSERT INTO `tb_barang_masuk` VALUES ('WG-202487406351', '06/02/2024', 'Jawa Barat', 'WG-001', 'KOPI ABC', 'Pack', '18');

-- ----------------------------
-- Table structure for tb_satuan
-- ----------------------------
DROP TABLE IF EXISTS `tb_satuan`;
CREATE TABLE `tb_satuan`  (
  `id_satuan` int NOT NULL AUTO_INCREMENT,
  `kode_satuan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_satuan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_satuan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_satuan
-- ----------------------------
INSERT INTO `tb_satuan` VALUES (1, 'Dus', 'Dus');
INSERT INTO `tb_satuan` VALUES (2, 'Pcs', 'Pcs');
INSERT INTO `tb_satuan` VALUES (5, 'Pack', 'Pack');

-- ----------------------------
-- Table structure for tb_upload_gambar_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_upload_gambar_user`;
CREATE TABLE `tb_upload_gambar_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username_user` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_file` varchar(220) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ukuran_file` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_upload_gambar_user
-- ----------------------------
INSERT INTO `tb_upload_gambar_user` VALUES (4, 'dedi mulyana', 'nopic2.jpg', '3.80');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `role` tinyint NOT NULL DEFAULT 0,
  `last_login` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (20, 'dedi mulyana', 'admin@gmail.com', '$2y$10$3HNkMOtwX8X88Xb3DIveYuhXScTnJ9m16/rPDF1/VTa/VTisxVZ4i', 1, '06-02-2024 9:38');

-- ----------------------------
-- Triggers structure for table tb_barang_keluar
-- ----------------------------
DROP TRIGGER IF EXISTS `TG_BARANG_KELUAR`;
delimiter ;;
CREATE TRIGGER `TG_BARANG_KELUAR` AFTER INSERT ON `tb_barang_keluar` FOR EACH ROW BEGIN
 UPDATE tb_barang_masuk SET jumlah=jumlah-NEW.jumlah
 WHERE kode_barang=NEW.kode_barang;
 DELETE FROM tb_barang_masuk WHERE jumlah = 0;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
