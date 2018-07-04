package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import sgbf.entity.CustomerInfo;
import sgbf.util.SqlUtil;

public class CustomerInfoDao {

	Connection conn = null;
	PreparedStatement stam = null;
	ResultSet rs = null;
	
	//获取所有客户信息，兼邮箱和客户名模糊查询
	public ArrayList<CustomerInfo> getAllCustomerList(String searchKey) {
		ArrayList<CustomerInfo> cList = new ArrayList<CustomerInfo>();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM CustomerInfo AS a LEFT JOIN customerdetailinfo AS b ON a.id=b.customerId WHERE a.email LIKE '%"+searchKey+"%' OR b.name LIKE '%"+searchKey+"%'";
			stam = conn.prepareStatement(sql);
			
			rs = stam.executeQuery();
			while (rs.next()) {
				CustomerInfo customer = new CustomerInfo(rs.getInt("id"),
						rs.getString("email"), rs.getString("pwd"),
						rs.getString("registerTime"), rs.getString("name"),
						rs.getString("telphone"), rs.getString("movePhone"),
						rs.getString("address"));
				
				cList.add(customer);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return cList;
	}
	
	public CustomerInfo getCustomerById(int id) {
		CustomerInfo customer = new CustomerInfo();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM CustomerInfo AS a LEFT JOIN customerdetailinfo AS b ON a.id=b.customerId WHERE a.id=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, id);
			
			rs = stam.executeQuery();
			while (rs.next()) {
				customer = new CustomerInfo(rs.getInt("id"),
						rs.getString("email"), rs.getString("pwd"),
						rs.getString("registerTime"), rs.getString("name"),
						rs.getString("telphone"), rs.getString("movePhone"),
						rs.getString("address"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return customer;
	}
	
	//验证用户名是否存在，并返回用户id
	public Integer isVerifyCustomerEmailIsExist(String email) {
		Integer id = null;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "select id from CustomerInfo where email=?";
			stam = conn.prepareStatement(sql);
			stam.setString(1, email);
			
			rs = stam.executeQuery();
			if (rs.next())
				id = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return id;
	}
	
	
	public boolean isVerifyCustomerPwdIsTrueByName(String email, String pwd) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "select pwd from CustomerInfo where email=?";
			stam = conn.prepareStatement(sql);
			stam.setString(1, email);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				if (pwd.equals(rs.getString(1)))
					flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return flag;
	}
	
	public boolean isAddCustomer(String email, String pwd) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "INSERT INTO CustomerInfo VALUES (NULL, ?, ?, ?)";
			stam = conn.prepareStatement(sql);
			stam.setString(1, email);
			stam.setString(2, pwd);
			//获取系统当前时间
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");
			String nowDate = sdf.format(date);
			stam.setString(3, nowDate);
			
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
