package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import sgbf.entity.AdminInfo;
import sgbf.util.SqlUtil;

public class AdminInfoDao {
	Connection conn = null;
	PreparedStatement stam = null;
	ResultSet rs = null;
	
	public AdminInfo getAdminById(int adminId) {
		AdminInfo adminInfo = new AdminInfo();
		try {
			conn = SqlUtil.getConn();
			String sql = "select * from adminInfo where id=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, adminId);
			
			rs = stam.executeQuery();
			if (rs.next())
				adminInfo = new AdminInfo(adminId, rs.getString("adminName"), rs.getString("adminPwd"));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return adminInfo;
	}
	
	public AdminInfo getAdminByName(String adminName) {
		AdminInfo adminInfo = new AdminInfo();
		try {
			conn = SqlUtil.getConn();
			String sql = "select * from adminInfo where adminName=?";
			stam = conn.prepareStatement(sql);
			stam.setString(1, adminName);
			
			rs = stam.executeQuery();
			if (rs.next())
				adminInfo = new AdminInfo(rs.getInt("id"), adminName, rs.getString("adminPwd"));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return adminInfo;
	}
	
	public boolean isDeleteAdminById(int adminId) {
		boolean flag = false;
		try {
			conn = SqlUtil.getConn();
			String sql = "delete from admininfo where id=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, adminId);
			
			int row = stam.executeUpdate();
			if (row > 0) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return flag;
	}
	
	public boolean isUpdateAdminById(AdminInfo admin) {
		boolean flag = false;
		try {
			conn = SqlUtil.getConn();
			String sql = "update admininfo set adminPwd=? where id=?";
			stam = conn.prepareStatement(sql);
			stam.setString(1, admin.getAdminPwd());
			stam.setInt(2, admin.getId());
			
			int row = stam.executeUpdate();
			if (row > 0) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return flag;
	}
	
	public boolean isVerifyAdminIsExist(String adminName) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "select 1 from AdminInfo where adminName=?";
			stam = conn.prepareStatement(sql);
			stam.setString(1, adminName);
			
			rs = stam.executeQuery();
			if (rs.next())
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return flag;
	}
	
	
	public boolean isVerifyPwdIsTrueByName(String adminName, String adminPwd) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "select adminPwd from AdminInfo where adminName=?";
			stam = conn.prepareStatement(sql);
			stam.setString(1, adminName);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				if (adminPwd.equals(rs.getString(1)))
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
