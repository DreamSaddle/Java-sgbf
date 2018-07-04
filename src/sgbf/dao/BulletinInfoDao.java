package sgbf.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import sgbf.entity.BulletinInfo;
import sgbf.entity.GoodsInfo;
import sgbf.util.PageBean;
import sgbf.util.SqlUtil;

public class BulletinInfoDao {

	Connection conn = null;
	PreparedStatement stam = null;
	ResultSet rs = null;
	
	
	public ArrayList<BulletinInfo> getAllBulletinsList() {
		ArrayList<BulletinInfo> bList = new ArrayList<BulletinInfo>();
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM bulletin";
			stam = conn.prepareStatement(sql);
			
			rs = stam.executeQuery();
			while (rs.next()) {
				BulletinInfo bulletinInfo = new BulletinInfo(rs.getInt("id"), rs.getString("title"), rs.getString("content"), new AdminInfoDao().getAdminById(rs.getInt("adminId")), rs.getString("createTime"));
				
				bList.add(bulletinInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return bList;
	}
	
	public boolean isAddBulletin(BulletinInfo bulletin) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "INSERT INTO Bulletin VALUES (NULL, ?, ?, ?, ?)";
			stam = conn.prepareStatement(sql);
			stam.setString(1, bulletin.getTitle());
			stam.setString(2, bulletin.getContent());
			stam.setInt(3, bulletin.getAdmin().getId());
			stam.setString(4, bulletin.getCreateTime());
			
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
	
	public boolean isDeleteBulletinByBulletinId(int bulletinId) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "DELETE FROM bulletin WHERE id=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, bulletinId);
			
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
	
	public BulletinInfo getBulletinByBulletinId(int bulletinId) {
		BulletinInfo bulletinInfo = null;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "SELECT * FROM bulletin where id=?";
			stam = conn.prepareStatement(sql);
			stam.setInt(1, bulletinId);
			
			rs = stam.executeQuery();
			if (rs.next()) {
				bulletinInfo = new BulletinInfo(rs.getInt("id"), rs.getString("title"), rs.getString("content"), new AdminInfoDao().getAdminById(rs.getInt("adminId")), rs.getString("createTime"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlUtil.getClose(conn, stam, rs);
		}
		
		return bulletinInfo;
	}
	
	public boolean isUpdateBulletinByBulletinId(BulletinInfo bulletin) {
		boolean flag = false;
		
		try {
			conn = SqlUtil.getConn();
			String sql = "UPDATE bulletin SET title=?, content=?, adminId=?, createTime=? WHERE id=?";
			stam = conn.prepareStatement(sql);
			stam.setString(1, bulletin.getTitle());
			stam.setString(2, bulletin.getContent());
			stam.setInt(3, bulletin.getAdmin().getId());
			stam.setString(4, bulletin.getCreateTime());
			stam.setInt(5, bulletin.getId());
			
			
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
	
	
	 /**
     * 获取总记录数
     */
    public int getTotalCount(String searchKey) {
        int totalCount = 0;
        try {
            conn = SqlUtil.getConn();
            String sql = null;
            if (searchKey == "" || searchKey == null) {
            	sql = "SELECT COUNT(*) FROM bulletin";
            	stam = conn.prepareStatement(sql);
            } else {
            	sql = "SELECT COUNT(*) FROM bulletin where title like '%"+searchKey+"%' or content like '%"+searchKey+"%'";
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

    
    public PageBean<BulletinInfo> getPageBean(int start, String searchKey) {
        PageBean<BulletinInfo> pageBean = new PageBean<BulletinInfo>();
        List<BulletinInfo> bList = new ArrayList<BulletinInfo>();

        try {
            conn = SqlUtil.getConn();
            String sql = "SELECT * FROM bulletin WHERE content LIKE '%"+searchKey+"%' or title LIKE '%"+searchKey+"%' LIMIT ?, ?";
            stam = conn.prepareStatement(sql);
            //查询起始位置
            int startIndex = (start-1) * pageBean.getPageCount();
            stam.setInt(1, startIndex);
            stam.setInt(2, pageBean.getPageCount());

            rs = stam.executeQuery();
            while (rs.next()) {
            	BulletinInfo bulletinInfo = new BulletinInfo(rs.getInt("id"), rs.getString("title"), rs.getString("content"), new AdminInfoDao().getAdminById(rs.getInt("adminId")), rs.getString("createTime"));
            	
            	bList.add(bulletinInfo);
            }
            pageBean.setPageData(bList);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            SqlUtil.getClose(conn, stam, rs);
        }
        //获取总数据量
        pageBean.setTotalCount(getTotalCount(searchKey));
        return pageBean;
    }
}
