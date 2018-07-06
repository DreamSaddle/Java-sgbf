
/*---------------------------纯建库脚本---------------------------*/

/*********建库*************/
CREATE DATABASE sgbf;

USE sgbf;



/***********建表及主要约束*****************/

-- 管理员信息表
CREATE TABLE AdminInfo
(
	id INT AUTO_INCREMENT PRIMARY KEY,	-- 管理员编号
	adminName VARCHAR(20) NOT NULL UNIQUE,	-- 管理员名称
	adminPwd VARCHAR(20) NOT NULL	-- 管理员密码
);

-- 公告信息表
CREATE TABLE Bulletin
(
	id INT AUTO_INCREMENT PRIMARY KEY, # 编号
	title VARCHAR(100) NOT NULL,	-- 标题
	content TEXT,	# 内容
	adminId INT NOT NULL, # 发布管理员
	createTime DATETIME NOT NULL,	# 发布时间
	
	FOREIGN KEY(adminId) REFERENCES AdminInfo(id)
);


-- 客户信息表
CREATE TABLE CustomerInfo
(
	id INT AUTO_INCREMENT PRIMARY KEY,	-- 客户编号
	email VARCHAR(100) NOT NULL UNIQUE,	-- 电子邮箱（客户账户名）
	pwd VARCHAR(20) NOT NULL,	-- 密码
	registerTime DATETIME NOT NULL # 注册时间
);


-- 客户详细信息表
CREATE TABLE CustomerDetailInfo
(
	customerId INT PRIMARY KEY,	# 客户编号
	`name` VARCHAR(50) NOT NULL,	-- 收货人姓名
	telphone VARCHAR(20) NOT NULL,	-- 固定电话
	movePhone VARCHAR(20) NOT NULL,	-- 移动电话
	address VARCHAR(100) NOT NULL,	-- 收货地址
	
	FOREIGN KEY(customerId) REFERENCES CustomerInfo(id)
);


-- 商品类别表
CREATE TABLE GoodsType
(
	typeId INT AUTO_INCREMENT PRIMARY KEY,	-- 类别编号
	typeName VARCHAR(20) NOT NULL UNIQUE	-- 类别名称
);


-- 商品信息表
CREATE TABLE GoodsInfo
(
	goodsId INT AUTO_INCREMENT PRIMARY KEY,	-- 商品编号
	typeId INT NOT NULL REFERENCES GoodsType(typeId),	-- 商品类别
	goodsName VARCHAR(50) NOT NULL,	-- 商品名称
	price DECIMAL(8,2) NOT NULL DEFAULT 0.0,	-- 商品价格
	discount FLOAT DEFAULT 10.0, -- 折扣(默认不打折)
	isNew INT NOT NULL,	-- 是否新品(0新品,1不是新品)
	isRecommend INT NOT NULL,	-- 是否推荐（0推荐，1不推荐）
	STATUS INT NOT NULL, -- 商品状态（0上架，1下架）
	photo VARCHAR(50), -- 商品图片
	remark VARCHAR(200) -- 备注
);


-- 订单信息表
CREATE TABLE OrderInfo
(
	orderId INT AUTO_INCREMENT PRIMARY KEY,	-- 订单编号
	customerId INT NOT NULL, -- 客户编号
	STATUS INT NOT NULL DEFAULT 0, -- 订单状态（0未确认，1已确认）
	orderTime DATETIME NOT NULL, # 下订单的时间
	
	FOREIGN KEY(customerId) REFERENCES CustomerInfo(id)
);


-- 订单商品信息表
CREATE TABLE OrderGoodsInfo
(
	orderId INT REFERENCES OrderInfo(orderId), -- 订单编号
	goodsId INT NOT NULL REFERENCES GoodsInfo(goodsId),	-- 商品编号
	quantity INT NOT NULL,	# 商品数量
	PRIMARY KEY (orderId,goodsId) # 联合主键约束
);





/****************插入测试数据***********************/

-- 插入管理员数据
INSERT INTO AdminInfo VALUES (NULL,'admin','123456');
INSERT INTO AdminInfo VALUES (NULL,'zhangsan','123456');
INSERT INTO AdminInfo VALUES (NULL,'lisi','123456');


-- 插入商品类型
INSERT INTO GoodsType VALUES (NULL,'国产水果');
INSERT INTO GoodsType VALUES (NULL,'进口水果');
INSERT INTO GoodsType VALUES (NULL,'新鲜时蔬');
INSERT INTO GoodsType VALUES (NULL,'新品上架');


--  ------------begin-----------------------/
-- 插入各类型下的商品
-- 国产水果
INSERT INTO GoodsInfo VALUES (NULL,1,'福建特级红心蜜柚 4个',81.0,DEFAULT,1,1,0,'ht-4.jpg','国产水果');
INSERT INTO GoodsInfo VALUES (NULL,1,'广西青皮芒果青芒玉芒 5斤',49.0,9.5,0,1,0,'ht-5.jpg','国产水果');
INSERT INTO GoodsInfo VALUES (NULL,1,'加力果嗄啦果苹果12个装',46.0,6.7,1,0,0,'ht-6.jpg','国产水果');
INSERT INTO GoodsInfo VALUES (NULL,1,'国内绿奇异果 16颗',57.0,DEFAULT,1,1,0,'rc-6.jpg','国产水果');
INSERT INTO GoodsInfo VALUES (NULL,1,'精选百香果西番莲8颗',34.0,DEFAULT,1,1,0,'ht-9.jpg','国产水果');
INSERT INTO GoodsInfo VALUES (NULL,1,'精选石榴10颗',35.0,DEFAULT,1,1,0,'ht-19.jpg','国产水果');
INSERT INTO GoodsInfo VALUES (NULL,1,'精选香梨8斤',35.0,DEFAULT,1,1,0,'ht-24.jpg','国产水果');
INSERT INTO GoodsInfo VALUES (NULL,1,'精选龙眼10斤',60.0,DEFAULT,1,1,0,'ht-25.jpg','国产水果');
INSERT INTO GoodsInfo VALUES(NULL,1,'越南进口红心火龙果 4个装','42.90',10,0,0,0,'5a51d14eNa115e050.jpg!cc_230x230.jpg','单果约350~420g 新鲜水果');
INSERT INTO GoodsInfo VALUES(NULL,1,'京觅 烟台红富士苹果 12个','45.90',10,1,1,0,'5b053959Ne9dd2a53.jpg!cc_230x230.jpg','果径80mm 约2.6kg 新鲜水果');
INSERT INTO GoodsInfo VALUES(NULL,1,'海南妃子笑荔枝','9.80',10,1,0,1,'5aeea25fN4784c9c5.jpg!cc_230x230.jpg','500g装 新鲜水果');


-- 进口水果
INSERT INTO GoodsInfo VALUES(NULL,2,'埃及进口榨汁橙','49.90',8,1,1,0,'5ac96e3aN436186dd.jpg!cc_230x230.jpg','约4kg装 新鲜水果');
INSERT INTO GoodsInfo VALUES(NULL,2,' 新西兰阳光金奇异果','59.90',10,0,0,0,'5acc2a01N54fa281e.jpg!cc_230x230.jpg',' 6个装 经典36号果 单果重约90-100g 新鲜水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'南非进口黄柠檬 6个装',35.0,8.5,1,1,0,'ht-18.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'智利进口新鲜蓝莓 4盒',100.0,9.5,0,1,0,'rc-3.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'美国进口红啤梨 6个',56.0,6.7,1,0,0,'rc-4.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'美国进口无籽红提 1kg',438.0,DEFAULT,0,1,0,'rc-5.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'佳沛新西兰阳光金奇异果8颗',34.0,DEFAULT,1,1,0,'ht-8.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'进口新鲜青苹果 5斤',22.0,DEFAULT,1,1,0,'pr-2.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'进口泰国榴莲4个装',196.0,DEFAULT,1,1,0,'ht-20.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'进口火龙果6个装',80.0,DEFAULT,1,1,0,'ht-27.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,2,'进口山竹5斤',40.0,DEFAULT,1,1,0,'ht-21.jpg','进口水果');

-- 新鲜时蔬
INSERT INTO GoodsInfo VALUES (NULL,3,'菠菜280g',19.0,8.5,1,1,0,'ht-1.jpg','新鲜时蔬');
INSERT INTO GoodsInfo VALUES (NULL,3,'莲藕5g',22.0,9.5,0,0,0,'ht-13.jpg','新鲜时蔬');
INSERT INTO GoodsInfo VALUES (NULL,3,'绿芦笋200g',46.0,8.5,1,1,0,'ht-14.jpg','新鲜时蔬');
INSERT INTO GoodsInfo VALUES (NULL,3,'莲藕5g',22.0,9.5,0,0,0,'ht-13.jpg','新鲜时蔬');
INSERT INTO GoodsInfo VALUES (NULL,3,'西葫芦280g',22.0,9.5,0,0,0,'ht-22.jpg','新鲜时蔬');
INSERT INTO GoodsInfo VALUES (NULL,3,'西蓝花200g',10.0,8.5,1,1,0,'ht-23.jpg','新鲜时蔬');
INSERT INTO GoodsInfo VALUES (NULL,3,'勺菜200g',10.0,9.5,0,0,0,'ht-26.jpg','新鲜时蔬');

-- 新品上架
INSERT INTO GoodsInfo VALUES (NULL,4,'进口精品蓝莓6斤',81.0,DEFAULT,1,1,0,'nw-2.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,4,'进口精品柠檬5斤',65.0,DEFAULT,1,1,0,'nw-3.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,4,'进口精品香梨8斤',100.0,DEFAULT,1,1,0,'nw-4.jpg','进口水果');
INSERT INTO GoodsInfo VALUES (NULL,4,'国内精品火龙果4斤',30.0,DEFAULT,1,1,0,'nw-5.jpg','国产水果');
INSERT INTO GoodsInfo VALUES (NULL,4,'国内精品水蜜桃5斤',35.0,DEFAULT,1,1,0,'tou-1.png','国产水果');


INSERT INTO GoodsInfo VALUES(NULL,4,'新西兰阳光金奇异果',179.00,10.0,0,0,0,'5b07af04N90ae2ec4.jpg',' 新西兰阳光金奇异果 ,  22个原箱装 ,  特大22号果 ,  单果重约134-175g ');
INSERT INTO GoodsInfo VALUES(NULL,4,'海南红心木瓜',17.90,10.0,0,0,0,'579c50c0N9017e5a3.jpg',' 2个装 ,  单果约450g-500g ');
INSERT INTO GoodsInfo VALUES(NULL,4,'四川安岳黄柠檬',25.90,10.0,0,0,0,'59ff238aNa05dedf5.jpg',' 8颗 ,  一级大果 ,  单果约110-130g ');
INSERT INTO GoodsInfo VALUES(NULL,1,'富爸爸 韩国风味泡菜',20.80,10.0,0,0,0,'5b1113ecN99eb0e65.jpg',' 韩国风味泡菜 ,  切件瓶装白菜泡菜 ,  750g ');
INSERT INTO GoodsInfo VALUES(NULL,4,'海南西州蜜哈密瓜',19.90,10.0,0,0,0,'59cb83bdNf0483254.jpg',' 1粒装 ,  约1.25-1.75kg ');
INSERT INTO GoodsInfo VALUES(NULL,3,'绿鲜知 西红柿 ',19.80,10.0,0,0,0,'58b3c666N4d3ff37e.jpg',' 西红柿 ,  番茄 ,  约1100g ');
INSERT INTO GoodsInfo VALUES(NULL,2,'佳农 进口香蕉',25.80,10.0,0,0,0,'5afd5643Nea6519fc.jpg',' 进口香蕉 ,  1kg ,  单根装 ');
INSERT INTO GoodsInfo VALUES(NULL,4,'新西兰阳光金奇异果',39.90,10.0,0,0,0,'5acc2a01N54fa281e.jpg',' 新西兰阳光金奇异果 ,  6个装 ,  经典36号果 ,  单果重约90-100g ');
INSERT INTO GoodsInfo VALUES(NULL,3,'焦作温县沙土铁棍山药',57.90,10.0,0,0,0,'5aa0ef77Ne2bcbd88.jpg',' 焦作温县沙土铁棍山药 ,  3kg ,  60公分礼盒装 ');
INSERT INTO GoodsInfo VALUES(NULL,1,'山东烟台红富士苹果',34.90,10.0,0,0,0,'5b053959Ne9dd2a53.jpg',' 山东烟台红富士苹果 ,  12个 ,  经典80号 ,  约2.6kg ');
INSERT INTO GoodsInfo VALUES(NULL,3,'绿鲜知 上海青 小油菜',8.80,10.0,0,0,0,'58b3c779Na1ec50a0.jpg',' 上海青 ,  小油菜 ,  约400g ,  火锅涮菜 ');
INSERT INTO GoodsInfo VALUES(NULL,4,'四川蒲江丑柑',59.90,10.0,0,0,0,'5a7916a2N73162aa2.jpg',' 美仑达 ,  四川蒲江丑柑 ,  丑橘不知火 ,  2kg装 ,  单果约150g~250g ');
--  ------------end-----------------------/


-- 客户信息
INSERT INTO CustomerInfo VALUES (NULL,'a@sina.com','123456','2009-06-06 12:30:45');
INSERT INTO CustomerInfo VALUES (NULL,'b@sina.com','123456','2009-06-07 12:30:15');
INSERT INTO CustomerInfo VALUES (NULL,'c@sina.com','123456','2009-06-08 12:30:25');
INSERT INTO CustomerInfo VALUES (NULL,'d@sina.com','123456','2009-06-09 12:30:35');


-- 客户详细信息
INSERT INTO CustomerDetailInfo VALUES (1,'张三','32456754','13534563234','重庆市');
INSERT INTO CustomerDetailInfo VALUES (2,'李斯','32456754','13534563234','重庆市');
INSERT INTO CustomerDetailInfo VALUES (3,'王五','32456754','13534563234','重庆市');


-- 订单信息
INSERT INTO OrderInfo VALUES(NULL, 1, 0, NOW());
INSERT INTO OrderInfo VALUES(NULL, 3, 1, NOW());
INSERT INTO OrderInfo VALUES(NULL, 2, 0, NOW());
-- 订单商品详细信息
INSERT INTO OrderGoodsInfo VALUES(1, 1, 13);
INSERT INTO OrderGoodsInfo VALUES(2, 15, 100);
INSERT INTO OrderGoodsInfo VALUES(3, 3, 53);


-- 公告信息
INSERT INTO Bulletin VALUES (NULL,'测试数据-公告标题1','测试数据-公告内容1',1,NOW());
INSERT INTO Bulletin VALUES (NULL,'测试数据-公告标题2','测试数据-公告内容2',1,NOW());
INSERT INTO Bulletin VALUES (NULL,'测试数据-公告标题3','测试数据-公告内容3',1,NOW());
INSERT INTO Bulletin VALUES (NULL,'测试数据-公告标题4','测试数据-公告内容4',1,NOW());
INSERT INTO Bulletin VALUES (NULL,'测试数据-公告标题5','测试数据-公告内容5',1,NOW());
INSERT INTO Bulletin VALUES (NULL,'测试数据-公告标题6','测试数据-公告内容6',1,NOW());

SHOW TABLES;
/*
SELECT * FROM AdminInfo;
SELECT * FROM Bulletin;
SELECT * FROM CustomerInfo;
SELECT * FROM CustomerDetailInfo;
SELECT * FROM GoodsType;
SELECT * FROM GoodsInfo;
SELECT * FROM OrderInfo;
SELECT * FROM OrderGoodsInfo;
*/