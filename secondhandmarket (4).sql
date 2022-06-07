-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2022-06-07 09:11:15
-- 伺服器版本： 10.4.21-MariaDB
-- PHP 版本： 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫: `secondhandmarket`
--
CREATE DATABASE IF NOT EXISTS `secondhandmarket` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `secondhandmarket`;

-- --------------------------------------------------------

--
-- 資料表結構 `announcement`
--

DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `AnnouncementId` int(10) UNSIGNED NOT NULL COMMENT '公告編號',
  `Title` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告標題',
  `Content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告標題',
  `Admin` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '管理員帳號',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `announcement`
--

INSERT INTO `announcement` (`AnnouncementId`, `Title`, `Content`, `Admin`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, '23', '232', 'Account', '2022-06-06 23:46:36', '2022-06-06 23:49:38', '2022-06-06 23:49:52'),
(2, '測試公告', '測試公告', 'Account', '2022-06-06 23:50:04', '2022-06-06 23:50:04', '0000-00-00 00:00:00'),
(3, '測試公告3', '測試公告3', 'Account', '2022-06-07 13:58:10', '2022-06-07 13:58:10', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `CategoryId` int(10) UNSIGNED NOT NULL COMMENT '種類編號',
  `Tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '種類名稱',
  `Color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `category`
--

INSERT INTO `category` (`CategoryId`, `Tag`, `Color`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, '文學小說', '#264653', '2022-05-23 17:39:30', '2022-05-23 17:39:30', '0000-00-00 00:00:00'),
(2, '商業理財', '#2A9D8F', '2022-05-23 17:39:44', '2022-05-23 17:39:44', '2022-06-06 23:05:26'),
(3, '藝術設計', '#E9C46A', '2022-05-23 17:39:52', '2022-05-23 17:39:52', '0000-00-00 00:00:00'),
(4, '人文史地', '#F4A261', '2022-05-23 17:40:01', '2022-05-23 17:40:01', '0000-00-00 00:00:00'),
(5, '社會科學', '#E76F51', '2022-05-23 17:40:08', '2022-05-23 17:40:08', '0000-00-00 00:00:00'),
(6, '自然科普', '#3A86FF', '2022-05-23 17:40:34', '2022-05-23 17:40:34', '0000-00-00 00:00:00'),
(7, '心理勵志', '#FFBE0B', '2022-05-23 17:40:52', '2022-05-23 17:40:52', '0000-00-00 00:00:00'),
(8, '醫療保健', '#FB5607', '2022-05-23 17:40:58', '2022-05-23 17:40:58', '0000-00-00 00:00:00'),
(9, '飲食', '#FF006E', '2022-05-23 17:41:02', '2022-05-23 17:41:02', '0000-00-00 00:00:00'),
(10, '生活風格', '#8338EC', '2022-05-23 17:41:08', '2022-05-23 17:41:08', '0000-00-00 00:00:00'),
(11, '旅遊', '#606C38', '2022-05-23 17:41:12', '2022-05-23 17:41:12', '0000-00-00 00:00:00'),
(12, '宗教命理', '#283618', '2022-05-23 17:41:19', '2022-05-23 17:41:19', '0000-00-00 00:00:00'),
(13, '親子教養', '#DDA15E', '2022-05-23 17:41:24', '2022-05-23 17:41:24', '0000-00-00 00:00:00'),
(14, '童書/青少年文學', '#BC6C25', '2022-05-23 17:41:35', '2022-05-23 17:41:35', '0000-00-00 00:00:00'),
(15, '影視偶像', '#003049', '2022-05-23 17:42:15', '2022-05-23 17:42:15', '0000-00-00 00:00:00'),
(16, '輕小說', '#D62828', '2022-05-23 17:42:21', '2022-05-23 17:42:21', '0000-00-00 00:00:00'),
(17, '漫畫/圖書文', '#F77F00', '2022-05-23 17:42:29', '2022-05-23 17:42:29', '0000-00-00 00:00:00'),
(18, '語言學習', '#FCBF49', '2022-05-23 17:42:36', '2022-05-23 17:42:36', '0000-00-00 00:00:00'),
(19, '考試用書', '#EAE2B7', '2022-05-23 17:42:41', '2022-05-23 17:42:41', '0000-00-00 00:00:00'),
(20, '電腦資訊', '#03071E', '2022-05-23 17:42:47', '2022-05-23 17:42:47', '0000-00-00 00:00:00'),
(21, '專業/教科書/政府出版品', '#2EC4B6', '2022-05-23 17:43:00', '2022-06-06 22:25:08', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `chatroom`
--

DROP TABLE IF EXISTS `chatroom`;
CREATE TABLE `chatroom` (
  `RoomId` int(10) UNSIGNED NOT NULL COMMENT '聊天室編號',
  `Seller` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '賣家',
  `User` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用者',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `chatroom`
--

INSERT INTO `chatroom` (`RoomId`, `Seller`, `User`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, 'Account', 'test5', '2022-06-07 14:18:39', '2022-06-07 14:18:39', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `dealmessage`
--

DROP TABLE IF EXISTS `dealmessage`;
CREATE TABLE `dealmessage` (
  `MessageId` int(10) UNSIGNED NOT NULL COMMENT '訊息編號',
  `RecordId` int(10) UNSIGNED NOT NULL COMMENT '紀錄編號',
  `Content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '留言內容',
  `Creator` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '留言者',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `dealreview`
--

DROP TABLE IF EXISTS `dealreview`;
CREATE TABLE `dealreview` (
  `ReviewId` int(10) UNSIGNED NOT NULL COMMENT '評價編號',
  `RecordId` int(10) UNSIGNED NOT NULL COMMENT '交易編號',
  `CustomerScore` int(11) DEFAULT NULL COMMENT '顧客評價分數',
  `CustomerReview` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '顧客評價內容',
  `CustomerTime` datetime DEFAULT NULL COMMENT '顧客評價時間',
  `SellerScore` int(11) DEFAULT NULL COMMENT '賣家評價分數',
  `SellerReview` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '賣家評價內容',
  `SellerTime` datetime NOT NULL COMMENT '賣家評價時間',
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `dealreview`
--

INSERT INTO `dealreview` (`ReviewId`, `RecordId`, `CustomerScore`, `CustomerReview`, `CustomerTime`, `SellerScore`, `SellerReview`, `SellerTime`, `DeletedAt`) VALUES
(1, 1, 5, '讚', '2022-06-07 14:23:59', 5, '讚', '2022-06-07 14:24:12', '0000-00-00 00:00:00'),
(2, 3, 5, '21354', '2022-06-07 14:34:01', 5, '45354', '2022-06-07 14:34:08', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `deposits`
--

DROP TABLE IF EXISTS `deposits`;
CREATE TABLE `deposits` (
  `DepositId` int(10) UNSIGNED NOT NULL COMMENT '存款編號',
  `User` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用者',
  `BankId` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '銀行編號',
  `DepositAccount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '存款帳戶',
  `State` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '未驗證' COMMENT '存款帳戶狀態',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `deposits`
--

INSERT INTO `deposits` (`DepositId`, `User`, `BankId`, `DepositAccount`, `State`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, 'Account', '508', '74687678678876', '未驗證', '2022-05-10 17:19:40', '2022-05-10 17:21:36', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `functionlist`
--

DROP TABLE IF EXISTS `functionlist`;
CREATE TABLE `functionlist` (
  `FunctionId` int(10) UNSIGNED NOT NULL COMMENT '功能編號',
  `FunctionName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '功能名稱',
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `functionlist`
--

INSERT INTO `functionlist` (`FunctionId`, `FunctionName`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, '公告管理', '2022-05-23 17:33:17', '2022-05-23 17:33:17', '0000-00-00 00:00:00'),
(2, '商品種類管理', '2022-05-23 17:33:34', '2022-05-23 17:33:34', '0000-00-00 00:00:00'),
(3, '權限管理', '2022-05-23 17:33:51', '2022-05-23 17:33:51', '0000-00-00 00:00:00'),
(4, '問題回報', '2022-05-23 17:34:31', '2022-05-23 17:34:31', '0000-00-00 00:00:00'),
(5, '報表分析', '2022-06-06 16:02:46', '2022-06-06 16:02:46', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2022_03_24_100644_create_users_table', 1),
(2, '2022_03_24_100704_create_product_table', 1),
(3, '2022_03_24_100744_create_shoppingcart_table', 1),
(4, '2022_03_24_100813_create_shoppinglist_table', 1),
(5, '2022_03_24_100841_create_recorddeal_table', 1),
(6, '2022_03_24_100856_create_dealmessage_table', 1),
(7, '2022_03_24_100915_create_chatroom_table', 1),
(8, '2022_03_24_101014_create_recordchat_table', 1),
(9, '2022_03_24_101047_create_productimage', 1),
(10, '2022_03_24_101243_create_category_table', 1),
(11, '2022_03_24_101252_create_taglist_table', 1),
(12, '2022_03_24_101341_create__announcement_table', 1),
(13, '2022_03_29_093655_create__product_question_table', 1),
(14, '2022_03_29_094316_create__deal_review_table', 1),
(15, '2022_03_29_095545_create_problemlist_table', 1),
(16, '2022_04_15_180625_create_role_table', 1),
(17, '2022_04_15_180739_create_function_table', 1),
(18, '2022_04_15_180835_create_user_role_table', 1),
(19, '2022_04_15_181045_create_role_permission_table', 1),
(20, '2022_04_15_181133_create_problem_reply_table', 1),
(21, '2022_04_30_034946_create_deposits_table', 1),
(22, '2022_04_30_035019_create_addresses_table', 1),
(23, '2022_04_30_124530_create_phones_table', 1),
(24, '2022_05_05_090644_create_user_token_table', 1);

-- --------------------------------------------------------

--
-- 資料表結構 `problemlist`
--

DROP TABLE IF EXISTS `problemlist`;
CREATE TABLE `problemlist` (
  `ProblemId` int(10) UNSIGNED NOT NULL COMMENT '問題編號',
  `Title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '問題標題',
  `Content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '問題內容',
  `PostUser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '上傳者',
  `State` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '未解決' COMMENT '問題狀態',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `problemlist`
--

INSERT INTO `problemlist` (`ProblemId`, `Title`, `Content`, `PostUser`, `State`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, '修改內容', '測試內容', 'Account', '未解決', '2022-05-10 16:14:16', '2022-05-10 16:16:42', '0000-00-00 00:00:00'),
(2, '測試標題', '測試內容', 'Account', '未解決', '2022-05-10 16:15:13', '2022-05-10 16:15:13', '0000-00-00 00:00:00'),
(3, '測試3', '測試3', 'Account', '未解決', '2022-06-06 17:08:11', '2022-06-06 17:08:11', '0000-00-00 00:00:00'),
(4, '商品錯誤', '商品錯誤', 'test4', '未解決', '2022-06-06 17:09:30', '2022-06-06 17:09:30', '0000-00-00 00:00:00'),
(5, '問題測試', '213', 'test5', '未解決', '2022-06-07 14:24:33', '2022-06-07 14:24:33', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `problemreply`
--

DROP TABLE IF EXISTS `problemreply`;
CREATE TABLE `problemreply` (
  `ProblemReply` int(10) UNSIGNED NOT NULL COMMENT '回覆編號',
  `ProblemId` int(10) UNSIGNED NOT NULL COMMENT '問題編號',
  `Reply` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回覆內容',
  `ReplyUser` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回覆者',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `problemreply`
--

INSERT INTO `problemreply` (`ProblemReply`, `ProblemId`, `Reply`, `ReplyUser`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, 1, 'sd', 'Account', '2022-05-10 16:33:34', '2022-05-10 16:36:20', '2022-05-10 16:36:47'),
(2, 1, 'ok2', 'Account', '2022-05-10 16:33:43', '2022-05-10 16:33:43', '0000-00-00 00:00:00'),
(3, 4, '請問訂單編號?', 'Account', '2022-06-06 17:24:00', '2022-06-06 17:24:00', '0000-00-00 00:00:00'),
(4, 5, '訂單編號1', 'test5', '2022-06-07 14:24:42', '2022-06-07 14:24:42', '0000-00-00 00:00:00'),
(5, 5, 'OK', 'Account', '2022-06-07 14:28:18', '2022-06-07 14:28:18', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `ProductId` int(10) UNSIGNED NOT NULL COMMENT '商品編號',
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名稱',
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品描述',
  `Price` int(11) NOT NULL COMMENT '價格',
  `Inventory` int(11) NOT NULL COMMENT '庫存',
  `State` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'on' COMMENT '商品狀態',
  `Seller` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '賣家',
  `Watch` int(11) NOT NULL DEFAULT 0 COMMENT '觀看數',
  `Rent` tinyint(4) NOT NULL DEFAULT 0,
  `MaxRent` int(11) NOT NULL DEFAULT 0,
  `RentPrice` int(11) NOT NULL DEFAULT 0,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `product`
--

INSERT INTO `product` (`ProductId`, `Name`, `Description`, `Price`, `Inventory`, `State`, `Seller`, `Watch`, `Rent`, `MaxRent`, `RentPrice`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, '刺客正傳系列套書【二十五週年紀念．限量典藏插畫精裝書盒版】', '作者羅蘋．荷布：「二十五年來，蜚滋從一個五歲的小屁孩，成長為一個刺客高手，再到歷經滄桑的六十歲男人。朋友、伙伴來來去去，他經歷過困苦和孤寂，享受過安詳和滿足。一本接著一本書，我和讀者一直陪伴著他……衷心感激你，在心靈騰出一個空間，給了我的人物角色一個家。」', 1999, 48, 'on', 'Account', 0, 1, 20, 10, '2022-06-07 14:10:14', '2022-06-07 14:32:54', '0000-00-00 00:00:00'),
(2, 'testasdfasdf', 'asdfasdf', 25555, 25, 'on', 'test5', 0, 0, 0, 0, '2022-06-07 14:15:15', '2022-06-07 14:15:15', '2022-06-07 14:15:30');

-- --------------------------------------------------------

--
-- 資料表結構 `productimage`
--

DROP TABLE IF EXISTS `productimage`;
CREATE TABLE `productimage` (
  `ImageId` int(10) UNSIGNED NOT NULL COMMENT '商品圖片編號',
  `ProductId` int(10) UNSIGNED NOT NULL COMMENT '商品編號',
  `Image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品圖片',
  `CreatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `productimage`
--

INSERT INTO `productimage` (`ImageId`, `ProductId`, `Image`, `CreatedAt`) VALUES
(1, 1, 'MQ.webp', '2022-06-07 14:11:50'),
(2, 2, 'Mg.webp', '2022-06-07 14:15:24');

-- --------------------------------------------------------

--
-- 資料表結構 `productquestion`
--

DROP TABLE IF EXISTS `productquestion`;
CREATE TABLE `productquestion` (
  `QuestionId` int(10) UNSIGNED NOT NULL COMMENT '問題編號',
  `ProductId` int(10) UNSIGNED NOT NULL COMMENT '商品編號',
  `Content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '問題內容',
  `PostTime` datetime NOT NULL COMMENT '上傳時間',
  `Customer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '買家',
  `Reply` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回應內容',
  `ReplyTime` datetime DEFAULT NULL COMMENT '回應時間',
  `Seller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '賣家',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `productquestion`
--

INSERT INTO `productquestion` (`QuestionId`, `ProductId`, `Content`, `PostTime`, `Customer`, `Reply`, `ReplyTime`, `Seller`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, 1, 'HIHI', '2022-06-07 14:18:12', 'test5', 'HIHI', NULL, 'Account', '2022-06-07 14:18:12', '2022-06-07 14:18:24', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `recordchat`
--

DROP TABLE IF EXISTS `recordchat`;
CREATE TABLE `recordchat` (
  `ChatId` int(10) UNSIGNED NOT NULL COMMENT '聊天訊息編號',
  `RoomId` int(10) UNSIGNED NOT NULL COMMENT '聊天室編號',
  `Creator` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '留言者',
  `Message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '對話內容',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `recordchat`
--

INSERT INTO `recordchat` (`ChatId`, `RoomId`, `Creator`, `Message`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, 1, 'test5', '請問還有貨嗎', '2022-06-07 14:19:04', '2022-06-07 14:19:04', '0000-00-00 00:00:00'),
(2, 1, 'Account', '有的', '2022-06-07 14:19:09', '2022-06-07 14:19:09', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `recorddeal`
--

DROP TABLE IF EXISTS `recorddeal`;
CREATE TABLE `recorddeal` (
  `RecordId` int(10) UNSIGNED NOT NULL COMMENT '交易編號',
  `ShoppingId` int(10) UNSIGNED NOT NULL COMMENT '商品清單編號',
  `State` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易狀態',
  `DealMethod` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易方式',
  `SentAddress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '寄送地址',
  `Phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DealType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易類型',
  `StartTime` datetime DEFAULT NULL COMMENT '起始時間',
  `EndTime` datetime DEFAULT NULL COMMENT '歸還時間',
  `Seller_Agree` tinyint(4) DEFAULT NULL,
  `SellerContent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Customer_Agree` tinyint(4) DEFAULT NULL,
  `CustomerContent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL,
  `ReturnTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `recorddeal`
--

INSERT INTO `recorddeal` (`RecordId`, `ShoppingId`, `State`, `DealMethod`, `SentAddress`, `Phone`, `DealType`, `StartTime`, `EndTime`, `Seller_Agree`, `SellerContent`, `Customer_Agree`, `CustomerContent`, `CreatedAt`, `UpdatedAt`, `DeletedAt`, `ReturnTime`) VALUES
(1, 1, '完成交易', '貨到付款', '台中科大', '0123453645', 'Buy', NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-07 14:23:22', '2022-06-07 14:24:13', '0000-00-00 00:00:00', NULL),
(2, 2, '已取消', '貨到付款', '123123', '09063074576', 'Rent', '2022-06-07 14:30:30', '2022-06-08 14:30:30', 1, '123', 1, NULL, '2022-06-07 14:30:01', '2022-06-07 14:32:41', '0000-00-00 00:00:00', '2022-06-07 14:32:21'),
(3, 3, '完成交易', '貨到付款', '123', '4536453', 'Rent', '2022-06-07 14:33:41', '2022-06-08 14:33:41', NULL, NULL, NULL, NULL, '2022-06-07 14:33:03', '2022-06-07 14:34:09', '0000-00-00 00:00:00', '2022-06-07 14:33:48');

-- --------------------------------------------------------

--
-- 資料表結構 `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `RoleId` int(10) UNSIGNED NOT NULL COMMENT '角色編號',
  `RoleName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名稱',
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `role`
--

INSERT INTO `role` (`RoleId`, `RoleName`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, '超級管理員', '2022-05-23 17:35:00', '2022-06-07 14:07:06', '0000-00-00 00:00:00'),
(2, '財務管理', '2022-06-07 11:19:57', '2022-06-07 11:19:57', '2022-06-07 11:31:27'),
(3, '財務管理', '2022-06-07 11:38:29', '2022-06-07 11:38:29', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `rolepermissions`
--

DROP TABLE IF EXISTS `rolepermissions`;
CREATE TABLE `rolepermissions` (
  `PermissionId` int(10) UNSIGNED NOT NULL COMMENT '權限編號',
  `RoleId` int(10) UNSIGNED NOT NULL COMMENT '功能編號',
  `FunctionId` int(10) UNSIGNED NOT NULL COMMENT '功能名稱',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `rolepermissions`
--

INSERT INTO `rolepermissions` (`PermissionId`, `RoleId`, `FunctionId`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(2, 1, 2, '2022-05-23 17:36:36', '2022-05-23 17:36:36', '0000-00-00 00:00:00'),
(3, 1, 3, '2022-05-23 17:36:47', '2022-05-23 17:36:47', '0000-00-00 00:00:00'),
(4, 1, 4, '2022-05-23 17:36:47', '2022-05-23 17:36:47', '0000-00-00 00:00:00'),
(6, 1, 1, '2022-06-07 10:29:22', '2022-06-07 10:29:22', '0000-00-00 00:00:00'),
(7, 2, 5, '2022-06-07 11:19:58', '2022-06-07 11:19:58', '0000-00-00 00:00:00'),
(8, 3, 5, '2022-06-07 11:38:30', '2022-06-07 11:38:30', '0000-00-00 00:00:00'),
(10, 1, 5, '2022-06-07 14:07:07', '2022-06-07 14:07:07', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `shoppingcart`
--

DROP TABLE IF EXISTS `shoppingcart`;
CREATE TABLE `shoppingcart` (
  `CartId` int(10) UNSIGNED NOT NULL COMMENT '購物車編號',
  `Member` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用者編號',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `shoppingcart`
--

INSERT INTO `shoppingcart` (`CartId`, `Member`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(2, 'Account', '2022-05-10 10:46:22', '2022-05-10 10:46:22', '0000-00-00 00:00:00'),
(3, 'test5', '2022-06-07 14:12:43', '2022-06-07 14:12:43', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `shoppinglist`
--

DROP TABLE IF EXISTS `shoppinglist`;
CREATE TABLE `shoppinglist` (
  `ShoppingId` int(10) UNSIGNED NOT NULL COMMENT '購物編號',
  `CartId` int(10) UNSIGNED NOT NULL COMMENT '購物車編號',
  `ProductId` int(10) UNSIGNED NOT NULL COMMENT '商品編號',
  `Count` int(11) NOT NULL COMMENT '商品數量',
  `Type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Buy',
  `State` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '未結帳' COMMENT '清單狀態',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `shoppinglist`
--

INSERT INTO `shoppinglist` (`ShoppingId`, `CartId`, `ProductId`, `Count`, `Type`, `State`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, 3, 1, 1, 'Buy', '下訂單', '2022-06-07 14:19:34', '2022-06-07 14:23:23', '0000-00-00 00:00:00'),
(2, 3, 1, 1, 'Rent', '下訂單', '2022-06-07 14:29:48', '2022-06-07 14:30:02', '0000-00-00 00:00:00'),
(3, 3, 1, 1, 'Rent', '下訂單', '2022-06-07 14:32:54', '2022-06-07 14:33:03', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `taglist`
--

DROP TABLE IF EXISTS `taglist`;
CREATE TABLE `taglist` (
  `Id` int(10) UNSIGNED NOT NULL,
  `CategoryId` int(10) UNSIGNED NOT NULL COMMENT '種類編號',
  `ProductId` int(10) UNSIGNED NOT NULL COMMENT '商品編號',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `taglist`
--

INSERT INTO `taglist` (`Id`, `CategoryId`, `ProductId`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, 1, 1, '2022-06-07 14:29:11', '2022-06-07 14:29:11', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `userrole`
--

DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole` (
  `UserRoleId` int(10) UNSIGNED NOT NULL COMMENT '使用者角色編號',
  `User` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用者',
  `RoleId` int(10) UNSIGNED NOT NULL COMMENT '角色編號',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `userrole`
--

INSERT INTO `userrole` (`UserRoleId`, `User`, `RoleId`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
(1, 'Account', 1, '2022-05-23 17:38:00', '2022-05-23 17:38:00', '0000-00-00 00:00:00'),
(2, 'test4', 3, '2022-06-07 12:15:52', '2022-06-07 12:19:50', '0000-00-00 00:00:00'),
(3, 'test5', 3, '2022-06-07 14:34:49', '2022-06-07 14:34:49', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `Account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用者帳號',
  `Password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用者編號',
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `Email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '電子信箱',
  `EmailVerifiedAt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '信箱驗證時間',
  `AuthCode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '驗證碼',
  `Money` int(11) NOT NULL DEFAULT 0 COMMENT '帳戶餘額',
  `Balance` tinyint(1) NOT NULL DEFAULT 0 COMMENT '保證金',
  `Address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `Image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '大頭貼',
  `Active` tinyint(4) DEFAULT 0,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `DeletedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `users`
--

INSERT INTO `users` (`Account`, `Password`, `Name`, `Email`, `EmailVerifiedAt`, `AuthCode`, `Money`, `Balance`, `Address`, `Image`, `Active`, `CreatedAt`, `UpdatedAt`, `DeletedAt`) VALUES
('Account', '9dc68d2ca96897f90619ad3ce5ddb2fa5f9e91814b6b1a7a1ffa92dcc1a2df7c', '管理員兼賣家', 'linskybing@gmail.com', NULL, '', 2009, 1, 'asdf', 'YXNkZmFzZGY.jpg', 1, '2022-05-09 09:45:27', '2022-06-07 14:34:09', '0000-00-00 00:00:00'),
('test4', '9dc68d2ca96897f90619ad3ce5ddb2fa5f9e91814b6b1a7a1ffa92dcc1a2df7c', '買家', 'linskybing@gmail.com', NULL, '', 0, 0, '404台中市北區三民路三段129號', NULL, 0, '2022-05-15 03:43:06', '2022-06-07 14:12:08', '0000-00-00 00:00:00'),
('test5', '9dc68d2ca96897f90619ad3ce5ddb2fa5f9e91814b6b1a7a1ffa92dcc1a2df7c', '買家', 'linskybing@gmail.com', NULL, '', 1999, 1, NULL, '6LK35a62.webp', 1, '2022-06-07 14:12:42', '2022-06-07 14:29:45', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- 資料表結構 `usertoken`
--

DROP TABLE IF EXISTS `usertoken`;
CREATE TABLE `usertoken` (
  `Id` int(10) UNSIGNED NOT NULL,
  `Account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用者',
  `Token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `LastAccessAt` datetime NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  `ExpiredAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `usertoken`
--

INSERT INTO `usertoken` (`Id`, `Account`, `Token`, `LastAccessAt`, `CreatedAt`, `UpdatedAt`, `ExpiredAt`) VALUES
(8, 'Account', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBY2NvdW50IjoiQWNjb3VudCIsIk5hbWUiOiJhc2RmYXNkZiIsIlJvbGVJZCI6MSwiQ2FydElkIjoyLCJJbWFnZSI6IiIsImlhdCI6MTY1NDUwMzk0MSwiZXhwIjoxNjU0NTkwMzQxfQ.-6q3gOCECk4rwNsEPgSVwqmJd_5-4Gx2hLx1UqP2bq8', '2022-06-07 13:43:46', '2022-06-06 16:25:41', '2022-06-07 13:43:46', '2022-06-07 16:25:41'),
(9, 'test4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBY2NvdW50IjoidGVzdDQiLCJOYW1lIjoidGVzdDQiLCJSb2xlSWQiOm51bGwsIkNhcnRJZCI6bnVsbCwiSW1hZ2UiOm51bGwsImlhdCI6MTY1NDUwNTg1MywiZXhwIjoxNjU0NTkyMjUzfQ.yLBQdJlzFBPoohl_QNCbqyFbr03Bf3EJQlkHjDSlIX4', '2022-06-06 16:57:33', '2022-06-06 16:57:33', '2022-06-06 16:57:33', '2022-06-07 16:57:33'),
(10, 'test5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBY2NvdW50IjoidGVzdDUiLCJOYW1lIjoi6LK35a62IiwiUm9sZUlkIjpudWxsLCJDYXJ0SWQiOjMsIkltYWdlIjpudWxsLCJpYXQiOjE2NTQ1ODI0NzUsImV4cCI6MTY1NDY2ODg3NX0.OO61skehx0GKiFZJN3pGODSBmJhZWhn6c7IPhohyGmg', '2022-06-07 14:14:35', '2022-06-07 14:14:35', '2022-06-07 14:14:35', '2022-06-08 14:14:35');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`AnnouncementId`),
  ADD KEY `announcement_admin_foreign` (`Admin`);

--
-- 資料表索引 `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`CategoryId`),
  ADD UNIQUE KEY `UNIQUE` (`Tag`);

--
-- 資料表索引 `chatroom`
--
ALTER TABLE `chatroom`
  ADD PRIMARY KEY (`RoomId`),
  ADD KEY `chatroom_seller_foreign` (`Seller`),
  ADD KEY `chatroom_user_foreign` (`User`);

--
-- 資料表索引 `dealmessage`
--
ALTER TABLE `dealmessage`
  ADD PRIMARY KEY (`MessageId`),
  ADD KEY `dealmessage_recordid_foreign` (`RecordId`),
  ADD KEY `dealmessage_creator_foreign` (`Creator`);

--
-- 資料表索引 `dealreview`
--
ALTER TABLE `dealreview`
  ADD PRIMARY KEY (`ReviewId`),
  ADD KEY `dealreview_recordid_foreign` (`RecordId`);

--
-- 資料表索引 `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`DepositId`),
  ADD KEY `deposits_user_foreign` (`User`);

--
-- 資料表索引 `functionlist`
--
ALTER TABLE `functionlist`
  ADD PRIMARY KEY (`FunctionId`);

--
-- 資料表索引 `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `problemlist`
--
ALTER TABLE `problemlist`
  ADD PRIMARY KEY (`ProblemId`),
  ADD KEY `problemlist_postuser_foreign` (`PostUser`);

--
-- 資料表索引 `problemreply`
--
ALTER TABLE `problemreply`
  ADD PRIMARY KEY (`ProblemReply`),
  ADD KEY `problemreply_problemid_foreign` (`ProblemId`),
  ADD KEY `problemreply_replyuser_foreign` (`ReplyUser`);

--
-- 資料表索引 `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ProductId`),
  ADD KEY `product_seller_foreign` (`Seller`);

--
-- 資料表索引 `productimage`
--
ALTER TABLE `productimage`
  ADD PRIMARY KEY (`ImageId`),
  ADD KEY `productimage_productid_foreign` (`ProductId`);

--
-- 資料表索引 `productquestion`
--
ALTER TABLE `productquestion`
  ADD PRIMARY KEY (`QuestionId`),
  ADD KEY `productquestion_productid_foreign` (`ProductId`),
  ADD KEY `productquestion_customer_foreign` (`Customer`),
  ADD KEY `productquestion_seller_foreign` (`Seller`);

--
-- 資料表索引 `recordchat`
--
ALTER TABLE `recordchat`
  ADD PRIMARY KEY (`ChatId`),
  ADD KEY `recordchat_roomid_foreign` (`RoomId`),
  ADD KEY `recordchat_creator_foreign` (`Creator`);

--
-- 資料表索引 `recorddeal`
--
ALTER TABLE `recorddeal`
  ADD PRIMARY KEY (`RecordId`),
  ADD KEY `recorddeal_shoppingid_foreign` (`ShoppingId`);

--
-- 資料表索引 `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`RoleId`);

--
-- 資料表索引 `rolepermissions`
--
ALTER TABLE `rolepermissions`
  ADD PRIMARY KEY (`PermissionId`),
  ADD KEY `rolepermissions_functionid_foreign` (`FunctionId`),
  ADD KEY `rolepermissions_roleid_foreign` (`RoleId`);

--
-- 資料表索引 `shoppingcart`
--
ALTER TABLE `shoppingcart`
  ADD PRIMARY KEY (`CartId`),
  ADD KEY `shoppingcart_member_foreign` (`Member`);

--
-- 資料表索引 `shoppinglist`
--
ALTER TABLE `shoppinglist`
  ADD PRIMARY KEY (`ShoppingId`),
  ADD KEY `shoppinglist_cartid_foreign` (`CartId`),
  ADD KEY `shoppinglist_productid_foreign` (`ProductId`);

--
-- 資料表索引 `taglist`
--
ALTER TABLE `taglist`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `taglist_categoryid_foreign` (`CategoryId`),
  ADD KEY `taglist_productid_foreign` (`ProductId`);

--
-- 資料表索引 `userrole`
--
ALTER TABLE `userrole`
  ADD PRIMARY KEY (`UserRoleId`),
  ADD KEY `userrole_user_foreign` (`User`),
  ADD KEY `userrole_roleid_foreign` (`RoleId`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Account`);

--
-- 資料表索引 `usertoken`
--
ALTER TABLE `usertoken`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `usertoken_account_foreign` (`Account`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `announcement`
--
ALTER TABLE `announcement`
  MODIFY `AnnouncementId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '公告編號', AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `category`
--
ALTER TABLE `category`
  MODIFY `CategoryId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '種類編號', AUTO_INCREMENT=32;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `chatroom`
--
ALTER TABLE `chatroom`
  MODIFY `RoomId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '聊天室編號', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `dealmessage`
--
ALTER TABLE `dealmessage`
  MODIFY `MessageId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '訊息編號';

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `dealreview`
--
ALTER TABLE `dealreview`
  MODIFY `ReviewId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '評價編號', AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `deposits`
--
ALTER TABLE `deposits`
  MODIFY `DepositId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '存款編號', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `functionlist`
--
ALTER TABLE `functionlist`
  MODIFY `FunctionId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '功能編號', AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `problemlist`
--
ALTER TABLE `problemlist`
  MODIFY `ProblemId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '問題編號', AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `problemreply`
--
ALTER TABLE `problemreply`
  MODIFY `ProblemReply` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '回覆編號', AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `product`
--
ALTER TABLE `product`
  MODIFY `ProductId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品編號', AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `productimage`
--
ALTER TABLE `productimage`
  MODIFY `ImageId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品圖片編號', AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `productquestion`
--
ALTER TABLE `productquestion`
  MODIFY `QuestionId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '問題編號', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `recordchat`
--
ALTER TABLE `recordchat`
  MODIFY `ChatId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '聊天訊息編號', AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `recorddeal`
--
ALTER TABLE `recorddeal`
  MODIFY `RecordId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '交易編號', AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `role`
--
ALTER TABLE `role`
  MODIFY `RoleId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色編號', AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `rolepermissions`
--
ALTER TABLE `rolepermissions`
  MODIFY `PermissionId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '權限編號', AUTO_INCREMENT=11;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `shoppingcart`
--
ALTER TABLE `shoppingcart`
  MODIFY `CartId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '購物車編號', AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `shoppinglist`
--
ALTER TABLE `shoppinglist`
  MODIFY `ShoppingId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '購物編號', AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `taglist`
--
ALTER TABLE `taglist`
  MODIFY `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `userrole`
--
ALTER TABLE `userrole`
  MODIFY `UserRoleId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '使用者角色編號', AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `usertoken`
--
ALTER TABLE `usertoken`
  MODIFY `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `announcement`
--
ALTER TABLE `announcement`
  ADD CONSTRAINT `announcement_admin_foreign` FOREIGN KEY (`Admin`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `chatroom`
--
ALTER TABLE `chatroom`
  ADD CONSTRAINT `chatroom_seller_foreign` FOREIGN KEY (`Seller`) REFERENCES `users` (`Account`),
  ADD CONSTRAINT `chatroom_user_foreign` FOREIGN KEY (`User`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `dealmessage`
--
ALTER TABLE `dealmessage`
  ADD CONSTRAINT `dealmessage_creator_foreign` FOREIGN KEY (`Creator`) REFERENCES `users` (`Account`),
  ADD CONSTRAINT `dealmessage_recordid_foreign` FOREIGN KEY (`RecordId`) REFERENCES `recorddeal` (`RecordId`);

--
-- 資料表的限制式 `dealreview`
--
ALTER TABLE `dealreview`
  ADD CONSTRAINT `dealreview_recordid_foreign` FOREIGN KEY (`RecordId`) REFERENCES `recorddeal` (`RecordId`);

--
-- 資料表的限制式 `deposits`
--
ALTER TABLE `deposits`
  ADD CONSTRAINT `deposits_user_foreign` FOREIGN KEY (`User`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `problemlist`
--
ALTER TABLE `problemlist`
  ADD CONSTRAINT `problemlist_postuser_foreign` FOREIGN KEY (`PostUser`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `problemreply`
--
ALTER TABLE `problemreply`
  ADD CONSTRAINT `problemreply_problemid_foreign` FOREIGN KEY (`ProblemId`) REFERENCES `problemlist` (`ProblemId`),
  ADD CONSTRAINT `problemreply_replyuser_foreign` FOREIGN KEY (`ReplyUser`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_seller_foreign` FOREIGN KEY (`Seller`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `productimage`
--
ALTER TABLE `productimage`
  ADD CONSTRAINT `productimage_productid_foreign` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`);

--
-- 資料表的限制式 `productquestion`
--
ALTER TABLE `productquestion`
  ADD CONSTRAINT `productquestion_customer_foreign` FOREIGN KEY (`Customer`) REFERENCES `users` (`Account`),
  ADD CONSTRAINT `productquestion_productid_foreign` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`),
  ADD CONSTRAINT `productquestion_seller_foreign` FOREIGN KEY (`Seller`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `recordchat`
--
ALTER TABLE `recordchat`
  ADD CONSTRAINT `recordchat_creator_foreign` FOREIGN KEY (`Creator`) REFERENCES `users` (`Account`),
  ADD CONSTRAINT `recordchat_roomid_foreign` FOREIGN KEY (`RoomId`) REFERENCES `chatroom` (`RoomId`);

--
-- 資料表的限制式 `recorddeal`
--
ALTER TABLE `recorddeal`
  ADD CONSTRAINT `recorddeal_shoppingid_foreign` FOREIGN KEY (`ShoppingId`) REFERENCES `shoppinglist` (`ShoppingId`);

--
-- 資料表的限制式 `rolepermissions`
--
ALTER TABLE `rolepermissions`
  ADD CONSTRAINT `rolepermissions_functionid_foreign` FOREIGN KEY (`FunctionId`) REFERENCES `functionlist` (`FunctionId`),
  ADD CONSTRAINT `rolepermissions_roleid_foreign` FOREIGN KEY (`RoleId`) REFERENCES `role` (`RoleId`);

--
-- 資料表的限制式 `shoppingcart`
--
ALTER TABLE `shoppingcart`
  ADD CONSTRAINT `shoppingcart_member_foreign` FOREIGN KEY (`Member`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `shoppinglist`
--
ALTER TABLE `shoppinglist`
  ADD CONSTRAINT `shoppinglist_cartid_foreign` FOREIGN KEY (`CartId`) REFERENCES `shoppingcart` (`CartId`),
  ADD CONSTRAINT `shoppinglist_productid_foreign` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`);

--
-- 資料表的限制式 `taglist`
--
ALTER TABLE `taglist`
  ADD CONSTRAINT `taglist_categoryid_foreign` FOREIGN KEY (`CategoryId`) REFERENCES `category` (`CategoryId`),
  ADD CONSTRAINT `taglist_productid_foreign` FOREIGN KEY (`ProductId`) REFERENCES `product` (`ProductId`);

--
-- 資料表的限制式 `userrole`
--
ALTER TABLE `userrole`
  ADD CONSTRAINT `userrole_roleid_foreign` FOREIGN KEY (`RoleId`) REFERENCES `role` (`RoleId`),
  ADD CONSTRAINT `userrole_user_foreign` FOREIGN KEY (`User`) REFERENCES `users` (`Account`);

--
-- 資料表的限制式 `usertoken`
--
ALTER TABLE `usertoken`
  ADD CONSTRAINT `usertoken_account_foreign` FOREIGN KEY (`Account`) REFERENCES `users` (`Account`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
