package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Random;

import org.junit.Test;

import sgbf.entity.GoodsInfo;
import sgbf.util.SqlUtil;

public class GoodsInfoDao {

	Connection conn = null;
	PreparedStatement stam = null;
	ResultSet rs = null;
	
	//商品处于上架状态的全部商品
	public ArrayList<GoodsInfo> getAllGoodsList() {
		ArrayList<GoodsInfo> goodsList = new ArrayList<GoodsInfo>();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM goodsinfo";
			stam = conn.prepareStatement(sql);
			
			rs = stam.executeQuery();
			while (rs.next()) {
				GoodsInfo good = new GoodsInfo(rs.getInt("goodsId"), new GoodsTypeDao().getGoodsTypeByTypeId(rs.getInt("typeId")), rs.getString("goodsName"), rs.getFloat("price"), rs.getFloat("discount"), rs.getInt("isNew"), rs.getInt("isRecommend"), rs.getInt("STATUS"), rs.getString("photo"), rs.getString("remark"));
				
				goodsList.add(good);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return goodsList;
	}
	
	public boolean isAddGood(GoodsInfo good) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "INSERT INTO GoodsInfo VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, good.getType().getTypeId());
			stam.setString(2, good.getGoodsName());
			stam.setFloat(3, good.getPrice());
			stam.setFloat(4, good.getDiscount());
			stam.setInt(5, good.getIsNew());
			stam.setInt(6, good.getIsRecommend());
			stam.setInt(7, good.getSTATUS());
			stam.setString(8, good.getPhoto());
			stam.setString(9, good.getRemark());
			
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
	
	public boolean isDeleteGoodByGoodId(int goodId) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "DELETE FROM goodsinfo WHERE goodsId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, goodId);
			
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
	
	public GoodsInfo getGoodByGoodId(int goodId) {
		GoodsInfo good = new GoodsInfo();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM goodsinfo where goodsId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, goodId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				good = new GoodsInfo(rs.getInt("goodsId"), new GoodsTypeDao().getGoodsTypeByTypeId(rs.getInt("typeId")), rs.getString("goodsName"), rs.getFloat("price"), rs.getFloat("discount"), rs.getInt("isNew"), rs.getInt("isRecommend"), rs.getInt("STATUS"), rs.getString("photo"), rs.getString("remark"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return good;
	}
	
	public boolean isUpdateGoodByGoodId(GoodsInfo good) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "UPDATE goodsinfo SET typeId=?, goodsName=?, price=?, discount=?, isNew=?, isRecommend=?, STATUS=?, photo=?, remark=? WHERE goodsId=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, good.getType().getTypeId());
			stam.setString(2, good.getGoodsName());
			stam.setFloat(3, good.getPrice());
			stam.setFloat(4, good.getDiscount());
			stam.setInt(5, good.getIsNew());
			stam.setInt(6, good.getIsRecommend());
			stam.setInt(7, good.getSTATUS());
			stam.setString(8, good.getPhoto());
			stam.setString(9, good.getRemark());
			stam.setInt(10, good.getGoodsId());
			
			
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
	
	
	//获取销量前六商品，  --获取前六条
	public ArrayList<GoodsInfo> getSalesBeforeSexGoodsList() {
		ArrayList<GoodsInfo> goodsList = new ArrayList<GoodsInfo>();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM goodsInfo LIMIT 0, 6;";
			stam = conn.prepareStatement(sql);
			
			rs = stam.executeQuery();
			while (rs.next()) {
				GoodsInfo good = new GoodsInfo(rs.getInt("goodsId"), new GoodsTypeDao().getGoodsTypeByTypeId(rs.getInt("typeId")), rs.getString("goodsName"), rs.getFloat("price"), rs.getFloat("discount"), rs.getInt("isNew"), rs.getInt("isRecommend"), rs.getInt("STATUS"), rs.getString("photo"), rs.getString("remark"));
				
				goodsList.add(good);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return goodsList;
	}
	
	//随机查询六条数据，用于首页商品资讯
	public ArrayList<GoodsInfo> getRandomSexGoodsList() {
		ArrayList<GoodsInfo> goodsList = new ArrayList<GoodsInfo>();
		Random random = new Random();
		//商品最大id
		int maxId = this.getGoodsMaxId();
		//产生六个随机索引  --目前会出现索引重复的情况
		int[] randomIndex = new int[6];
		for (int i = 0; i < 6; i++) {
			randomIndex[i] = random.nextInt(maxId);
		}
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM goodsInfo WHERE goodsId IN (?, ?, ?, ?, ?, ?)";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, randomIndex[0]);
			stam.setInt(2, randomIndex[1]);
			stam.setInt(3, randomIndex[2]);
			stam.setInt(4, randomIndex[3]);
			stam.setInt(5, randomIndex[4]);
			stam.setInt(6, randomIndex[5]);
			
			rs = stam.executeQuery();
			while (rs.next()) {
				GoodsInfo good = new GoodsInfo(rs.getInt("goodsId"), new GoodsTypeDao().getGoodsTypeByTypeId(rs.getInt("typeId")), rs.getString("goodsName"), rs.getFloat("price"), rs.getFloat("discount"), rs.getInt("isNew"), rs.getInt("isRecommend"), rs.getInt("STATUS"), rs.getString("photo"), rs.getString("remark"));
				
				goodsList.add(good);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return goodsList;
	}
	
	//获取商品最大id
	public int getGoodsMaxId() {
		int maxId = 0;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT goodsId FROM goodsInfo ORDER BY goodsId DESC LIMIT 0, 1";
			stam = conn.prepareStatement(sql);
			
			rs = stam.executeQuery();
			if (rs.next())
				maxId = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return maxId;
	}
}
