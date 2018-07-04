SHOW TABLES

SELECT * FROM admininfo;

SELECT * FROM CustomerInfo;
SELECT * FROM customerdetailinfo;
SELECT 1 FROM customerdetailinfo WHERE customerId=6;
UPDATE customerdetailinfo SET `name`='', telphone='', movePhone='', address='' WHERE customerId=100;

SELECT * FROM orderinfo;
SELECT * FROM ordergoodsinfo;

SELECT * FROM orderinfo WHERE customerId=2 ORDER BY orderId DESC LIMIT 0, 1
SELECT a.orderId, customerId, quantity FROM orderinfo AS a RIGHT JOIN ordergoodsinfo AS b ON a.orderId=b.orderId WHERE customerId=1;
SELECT a.orderId, customerId, quantity FROM orderinfo AS a RIGHT JOIN ordergoodsinfo AS b ON a.orderId=b.orderId WHERE customerId=1 GROUP BY a.orderId;
# 查询用户的有效订单条数
SELECT COUNT(*) FROM (SELECT 1 FROM orderinfo AS a RIGHT JOIN ordergoodsinfo AS b ON a.orderId=b.orderId WHERE customerId=1 GROUP BY a.orderId) AS orders;
UPDATE orderinfo SET STATUS=1 WHERE orderid=1;

SELECT * FROM goodsInfo;
SELECT * FROM goodstype;

SELECT * FROM goodsInfo LIMIT 0, 6;
SELECT * FROM goodsInfo WHERE goodsId IN (4, 5, 17, 16, 23, 38);
SELECT goodsId FROM goodsInfo ORDER BY goodsId DESC LIMIT 0, 1;

SELECT a.customerId,a.name,a.movePhone,a.address,b.STATUS,b.orderTime,c.quantity,d.goodsName FROM customerdetailinfo AS a INNER JOIN orderinfo AS b ON a.customerId=b.customerId INNER JOIN ordergoodsinfo AS c ON 
b.orderId=c.orderId INNER JOIN goodsinfo AS d ON d.goodsId=c.goodsId;


SELECT a.`customerId`,b.`orderId`,b.`STATUS` AS orderStatus, b.`orderTime`,c.`goodsId`,c.`quantity` FROM customerdetailinfo AS a INNER JOIN orderinfo AS b ON a.customerId=b.customerId INNER JOIN ordergoodsinfo AS c ON 
b.orderId=c.orderId INNER JOIN goodsinfo AS d ON d.goodsId=c.goodsId;


SELECT * FROM customerdetailinfo AS a INNER JOIN orderinfo AS b ON a.`customerId`=b.`customerId` INNER JOIN ordergoodsinfo AS c ON b.`orderId`=c.`orderId` WHERE a.`name` LIKE '%%' OR a.`address` LIKE '%%' LIMIT 0, 10
SELECT COUNT(*) FROM customerdetailinfo AS a INNER JOIN orderinfo AS b ON a.`customerId`=b.`customerId` INNER JOIN ordergoodsinfo AS c ON b.`orderId`=c.`orderId`
SELECT COUNT(*) FROM customerdetailinfo AS a INNER JOIN orderinfo AS b ON a.`customerId`=b.`customerId` INNER JOIN ordergoodsinfo AS c ON b.`orderId`=c.`orderId` WHERE a.`name` LIKE '%张%' OR a.`address` LIKE '%张%'


SELECT * FROM CustomerInfo AS a LEFT JOIN customerdetailinfo AS b ON a.id=b.customerId WHERE a.id=1

DELETE FROM goodsinfo WHERE goodsId=100

DELETE FROM customerdetailinfo WHERE customerId=100
DELETE FROM customerinfo WHERE id=2

DELETE FROM goodstype WHERE typeId=100
UPDATE goodstype SET typeName='' WHERE typeId=100
UPDATE goodsinfo SET typeId=1, goodsName='', price=12.00, discount=8.0, isNew=1, isRecommend=1, STATUS=0, photo='', remark='' WHERE goodsId=100


SELECT * FROM goodsinfo WHERE goodsName LIKE '%口%' LIMIT 0, 10
SELECT COUNT(*) FROM goodsinfo WHERE goodsName LIKE '%口%'

SELECT * FROM CustomerInfo AS a LEFT JOIN customerdetailinfo AS b ON a.id=b.customerId WHERE a.email LIKE '%%' OR b.name LIKE '%%'


SELECT * FROM admininfo;
SELECT * FROM bulletin;
UPDATE bulletin SET title='', content='', adminId=2, createTime='' WHERE id=100
SELECT a.id, a.title, b.adminName, a.content, a.createTime FROM bulletin AS a INNER JOIN admininfo AS b ON a.adminId=b.id;

