package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import sgbf.entity.BulletinInfo;
import sgbf.entity.GoodsInfo;
import sgbf.entity.OrderDetailInfo;
import sgbf.entity.OrderInfo;
import sgbf.util.PageBean;
import sgbf.util.SqlUtil;

public class OrderDetailInfoDao {

	Connection conn = null;
	PreparedStatement stam = null;
	ResultSet rs = null;
	
	public ArrayList<OrderDetailInfo> getOrderByOrderId(int orderId) {
		ArrayList<OrderDetailInfo> orderdetailList = new ArrayList<OrderDetailInfo>();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM ordergoodsinfo where orderId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, orderId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				//根据订单编号创建订单对象
				OrderInfo order = new OrderInfoDao().getOrderByOrderId(orderId);
				//创建对应商品对象
				GoodsInfo good = new GoodsInfoDao().getGoodByGoodId(rs.getInt("customerId"));
				
				OrderDetailInfo orderDetail = new OrderDetailInfo(order, good, rs.getInt("quantity"));
				
				orderdetailList.add(orderDetail);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return orderdetailList;
	}
	
	
	/**
     * 获取总记录数
     */
    public int getTotalCount(String searchKey) {
        int totalCount = 0;
        try {
            conn = SqlUtil.getConn();
            String sql = null;
            if (searchKey == "" || searchKey == null) {
            	sql = "SELECT count(*) FROM customerdetailinfo AS a"
            			+ " INNER JOIN orderinfo AS b ON "
            			+ "a.`customerId`=b.`customerId` INNER JOIN"
            			+ " ordergoodsinfo AS c ON b.`orderId`=c.`orderId`";
            	stam = conn.prepareStatement(sql);
            } else {
            	sql = "SELECT COUNT(*) FROM customerdetailinfo AS a"
            			+ " INNER JOIN orderinfo AS b ON"
            			+ " a.`customerId`=b.`customerId`"
            			+ " INNER JOIN ordergoodsinfo AS c"
            			+ " ON b.`orderId`=c.`orderId` WHERE"
            			+ " a.`name` LIKE '%"+searchKey+"%'"
            			+ " OR a.`address` LIKE '%"+searchKey+"%'";
            	stam = conn.prepareStatement(sql);
            }
            rs = stam.executeQuery();

            if (rs.next())
                totalCount = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlUtil.getClose(conn, stam, rs);
        }

        return totalCount;
    }

    
    public PageBean<OrderDetailInfo> getPageBean(int start, String searchKey) {
        PageBean<OrderDetailInfo> pageBean = new PageBean<OrderDetailInfo>();
        ArrayList<OrderDetailInfo> orderdetailList = new ArrayList<OrderDetailInfo>();

        try {
            conn = SqlUtil.getConn();
            //分页，根据客户名称、地址模糊查询
            String sql = "SELECT * FROM customerdetailinfo AS a"
            		+ " INNER JOIN orderinfo AS b ON a.`customerId`=b.`customerId`"
            		+ " INNER JOIN ordergoodsinfo AS c ON b.`orderId`=c.`orderId`"
            		+ " WHERE a.`name` LIKE '%"+searchKey+"%' OR a.`address` LIKE '%"+searchKey+"%'"
            		+ " LIMIT ?, ?";
            stam = conn.prepareStatement(sql);
            //查询起始位置
            int startIndex = (start-1) * pageBean.getPageCount();
            stam.setInt(1, startIndex);
            stam.setInt(2, pageBean.getPageCount());

            rs = stam.executeQuery();
            while (rs.next()) {
            	//根据订单编号创建订单对象
				OrderInfo order = new OrderInfoDao().getOrderByOrderId(rs.getInt("orderId"));
				//创建对应商品对象
				GoodsInfo good = new GoodsInfoDao().getGoodByGoodId(rs.getInt("goodsId"));
				
				OrderDetailInfo orderDetail = new OrderDetailInfo(order, good, rs.getInt("quantity"));
				
				orderdetailList.add(orderDetail);
            }
            pageBean.setPageData(orderdetailList);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlUtil.getClose(conn, stam, rs);
        }
        //获取总数据量
        pageBean.setTotalCount(getTotalCount(searchKey));
        return pageBean;
    }
    
    
    public boolean addOrderDetailInfo(HashMap<GoodsInfo, Integer> goodsMap, int lastOrderId) {
    	boolean flag = false;
        try {
            conn = SqlUtil.getConn();
            
            //循环添加
            for (GoodsInfo good : goodsMap.keySet()) {
				String sql = "INSERT INTO OrderGoodsInfo VALUES(?, ?, ?)";
				stam = conn.prepareStatement(sql);
				stam.setInt(1, lastOrderId);
				stam.setInt(2, good.getGoodsId());
				stam.setInt(3, goodsMap.get(good));
				
				stam.executeUpdate();
			}
            
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlUtil.getClose(conn, stam, rs);
        }
        
        
        return flag;
    }
    
    //获取当前用户的所有订单
  	public ArrayList<OrderDetailInfo> getCustomerOrders(int customerId) {
  		ArrayList<OrderDetailInfo> orderdetailList = new ArrayList<OrderDetailInfo>();
  		
  		try {
  			conn = SqlUtil.getConn();
  			String sql = "SELECT a.orderId, customerId, goodsId, quantity FROM orderinfo AS a RIGHT JOIN ordergoodsinfo AS b ON a.orderId=b.orderId WHERE customerId=?";
  			stam = conn.prepareStatement(sql);
  			stam.setInt(1, customerId);
  			
  			rs = stam.executeQuery();
  			while (rs.next()) {
  				//根据订单编号创建订单对象
  				OrderInfo order = new OrderInfoDao().getOrderByOrderId(rs.getInt("orderId"));
  				//创建对应商品对象
  				GoodsInfo good = new GoodsInfoDao().getGoodByGoodId(rs.getInt("goodsId"));
  				
  				OrderDetailInfo orderDetail = new OrderDetailInfo(order, good, rs.getInt("quantity"));
  				
  				orderdetailList.add(orderDetail);
  			}
  		} catch (Exception e) {
  			e.printStackTrace();
  		} finally {
  			SqlUtil.getClose(conn, stam, rs);
  		}
  		
  		return orderdetailList;
  	}
  	
  	//确认订单
	public boolean isAffirmOrder(int orderId) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "UPDATE orderinfo SET STATUS=1 WHERE orderid=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, orderId);
			
			int row = stam.executeUpdate();
			if (row > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return flag;
	}
}
