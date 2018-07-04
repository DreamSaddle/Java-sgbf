package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import sgbf.entity.GoodsInfo;
import sgbf.util.PageBean;
import sgbf.util.SqlUtil;

public class GoodsInfoPageDao {
    Connection conn = null;
    PreparedStatement stam = null;
    ResultSet rs = null;

    /**
     * 获取总记录数
     */
    public int getTotalCount(String searchKey) {
        int totalCount = 0;
        try {
            conn = SqlUtil.getConn();
            String sql = null;
            if (searchKey == "" || searchKey == null) {
            	sql = "SELECT COUNT(*) FROM goodsinfo";
            	stam = conn.prepareStatement(sql);
            } else {
            	sql = "SELECT COUNT(*) FROM goodsinfo where goodsName like '%"+searchKey+"%'";
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

    /**
     * 获取指定范围商品的PageBean对象
     * @param start
     * @return
     */
    public PageBean<GoodsInfo> getPageBean(int start, String searchKey) {
        PageBean<GoodsInfo> pageBean = new PageBean<GoodsInfo>();
        List<GoodsInfo> gList = new ArrayList<GoodsInfo>();

        try {
            conn = SqlUtil.getConn();
            String sql = "SELECT * FROM goodsinfo WHERE goodsName LIKE '%"+searchKey+"%' LIMIT ?, ?";
            stam = conn.prepareStatement(sql);
            //查询起始位置
            int startIndex = (start-1) * pageBean.getPageCount();
            stam.setInt(1, startIndex);
            stam.setInt(2, pageBean.getPageCount());

            rs = stam.executeQuery();
            while (rs.next()) {
            	GoodsInfo good = new GoodsInfo(rs.getInt("goodsId"), new GoodsTypeDao().getGoodsTypeByTypeId(rs.getInt("typeId")), rs.getString("goodsName"), rs.getFloat("price"), rs.getFloat("discount"), rs.getInt("isNew"), rs.getInt("isRecommend"), rs.getInt("STATUS"), rs.getString("photo"), rs.getString("remark"));
                gList.add(good);
            }
            pageBean.setPageData(gList);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlUtil.getClose(conn, stam, rs);
        }
        //获取总数据量
        pageBean.setTotalCount(getTotalCount(searchKey));
        return pageBean;
    }
    
    //获取销量靠前商品，--前14条
    public ArrayList<GoodsInfo> getSalesTop() {
    	ArrayList<GoodsInfo> gList = new ArrayList<GoodsInfo>();
    	
    	try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM goodsinfo limit 0, 14";
			stam = conn.prepareStatement(sql);
			
			rs = stam.executeQuery();
			while (rs.next()) {
				GoodsInfo good = new GoodsInfo(rs.getInt("goodsId"), new GoodsTypeDao().getGoodsTypeByTypeId(rs.getInt("typeId")), rs.getString("goodsName"), rs.getFloat("price"), rs.getFloat("discount"), rs.getInt("isNew"), rs.getInt("isRecommend"), rs.getInt("STATUS"), rs.getString("photo"), rs.getString("remark"));
				
				gList.add(good);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
    	
    	return gList;
    }
    
    public PageBean<GoodsInfo> getSalesTopPageBean(int start) {
        PageBean<GoodsInfo> pageBean = new PageBean<GoodsInfo>();
        List<GoodsInfo> gList = new ArrayList<GoodsInfo>();

        try {
            conn = SqlUtil.getConn();
            String sql = "SELECT * FROM goodsinfo LIMIT ?, ?";
            stam = conn.prepareStatement(sql);
            //查询起始位置
            int startIndex = (start-1) * pageBean.getPageCount();
            stam.setInt(1, startIndex);
            stam.setInt(2, pageBean.getPageCount());

            rs = stam.executeQuery();
            while (rs.next()) {
            	GoodsInfo good = new GoodsInfo(rs.getInt("goodsId"), new GoodsTypeDao().getGoodsTypeByTypeId(rs.getInt("typeId")), rs.getString("goodsName"), rs.getFloat("price"), rs.getFloat("discount"), rs.getInt("isNew"), rs.getInt("isRecommend"), rs.getInt("STATUS"), rs.getString("photo"), rs.getString("remark"));
                gList.add(good);
            }
            pageBean.setPageData(gList);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlUtil.getClose(conn, stam, rs);
        }
        //获取总数据量
        pageBean.setTotalCount(14);
        return pageBean;
    }
}
