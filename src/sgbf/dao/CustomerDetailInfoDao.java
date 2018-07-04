package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import sgbf.entity.CustomerDetailInfo;
import sgbf.util.SqlUtil;

public class CustomerDetailInfoDao {

	Connection conn = null;
	PreparedStatement stam = null;
	ResultSet rs = null;
	
	
	public CustomerDetailInfo getCustomerDetailInfoByCustomerId(int customerId) {
		CustomerDetailInfo customerDetail = null;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM customerdetailinfo where customerId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, customerId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				customerDetail = new CustomerDetailInfo(new CustomerInfoDao().getCustomerById(customerId), rs.getString("name"), rs.getString("telphone"), rs.getString("movePhone"), rs.getString("address"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return customerDetail;
	}
	
	//添加或者修改客户详细信息
	public boolean isAddOrUpdateCustomerDetailInfo(CustomerDetailInfo customerDetailInfo, int customerId) {
		boolean flag = false;

		//判断该用户是否已经添加过详细信息
		boolean isAddDetailInfo = this.isVerifyCustomerExistsCustomerDetailInfo(customerId);
		try {
			conn = SqlUtil.getConn();
			String sql = "";
			if (isAddDetailInfo) {  //修改
				sql = "UPDATE customerdetailinfo SET `name`=?, telphone=?, movePhone=?, address=? WHERE customerId=?";
				stam = conn.prepareStatement(sql);
				stam.setString(1, customerDetailInfo.getName());
				stam.setString(2, customerDetailInfo.getTelphone());
				stam.setString(3, customerDetailInfo.getMovePhone());
				stam.setString(4, customerDetailInfo.getAddress());
				stam.setInt(5, customerId);
			} else {  //添加
				sql = "INSERT INTO CustomerDetailInfo VALUES (?, ?, ?, ?, ?)";
				stam = conn.prepareStatement(sql);
				stam.setInt(1, customerId);
				stam.setString(2, customerDetailInfo.getName());
				stam.setString(3, customerDetailInfo.getTelphone());
				stam.setString(4, customerDetailInfo.getMovePhone());
				stam.setString(5, customerDetailInfo.getAddress());
			}
			
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
	
	//验证用户是否存在详细信息表中，即是否完善过信息，如果有，就做修改，没有就做添加
	private boolean isVerifyCustomerExistsCustomerDetailInfo(int customerId) {
		boolean flag = false;
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT 1 FROM customerdetailinfo WHERE customerId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, customerId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
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
