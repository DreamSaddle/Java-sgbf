package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import sgbf.entity.CustomerInfo;
import sgbf.entity.GoodsInfo;
import sgbf.entity.OrderDetailInfo;
import sgbf.entity.OrderInfo;
import sgbf.util.SqlUtil;

public class OrderInfoDao {

	Connection conn = null;
	PreparedStatement stam = null;
	ResultSet rs = null;
	
	public OrderInfo getOrderByOrderId(int orderId) {
		OrderInfo order = null;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM orderinfo where orderId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, orderId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				 order = new OrderInfo(orderId, new CustomerInfoDao().getCustomerById(rs.getInt("customerId")), rs.getInt("status"), rs.getString("orderTime"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return order;
	}
	
	
	
	public boolean addOrder(OrderInfo order) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "INSERT INTO OrderInfo VALUES(NULL, ?, 0, ?)";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, order.getCustomer().getId());
			stam.setString(2, order.getOrderTime());
			
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
	
	//获取当前用户添加的最后一个订单的订单编号
	public Integer getCustomerLastOrderId(int customerId) {
		Integer lastOrderId = null;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM orderinfo WHERE customerId=? ORDER BY orderId DESC LIMIT 0, 1";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, customerId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				lastOrderId = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return lastOrderId;
	}
	
	
	//获取当前用户的总订单量
	public Integer getCustomerSumOrders(int customerId) {
		Integer sumOrders = null;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT COUNT(*) FROM (SELECT 1 FROM orderinfo AS a RIGHT JOIN ordergoodsinfo AS b ON a.orderId=b.orderId WHERE customerId=? GROUP BY a.orderId) AS orders;";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, customerId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				sumOrders = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return sumOrders;
	}
}
