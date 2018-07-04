package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import sgbf.entity.GoodsType;
import sgbf.util.SqlUtil;

public class GoodsTypeDao {

	Connection conn = null;
	PreparedStatement stam = null;
	ResultSet rs = null;
	
	public ArrayList<GoodsType> getAllTypeList() {
		ArrayList<GoodsType> tList = new ArrayList<GoodsType>();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM goodstype";
			stam = conn.prepareStatement(sql);
			
			rs = stam.executeQuery();
			while (rs.next()) {
				GoodsType goodsType = new GoodsType(rs.getInt("typeId"), rs.getString("typeName"));
				
				tList.add(goodsType);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return tList;
	}
	
	public boolean isAddGoodsType(String typeName) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "INSERT INTO GoodsType VALUES (NULL, ?)";
			stam = conn.prepareStatement(sql);
			stam.setString(1, typeName);
			
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
	
	public boolean isDeleteGoodsType(int typeId) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "DELETE FROM goodstype WHERE typeId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, typeId);
			
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
	
	public GoodsType getGoodsTypeByTypeId(int typeId) {
		GoodsType type = new GoodsType();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM goodstype where typeId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, typeId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				 type = new GoodsType(rs.getInt("typeId"), rs.getString("typeName"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return type;
	}
	
	public boolean isUpdateGoodsTypeByTypeId(GoodsType type) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "UPDATE goodstype SET typeName=? WHERE typeId=?";
			stam = conn.prepareStatement(sql);
			stam.setString(1, type.getTypeName());
			stam.setInt(2, type.getTypeId());
			
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
