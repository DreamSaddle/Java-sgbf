package sgbf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sgbf.dao.AdminInfoDao;
import sgbf.dao.BulletinInfoDao;
import sgbf.dao.GoodsInfoPageDao;
import sgbf.entity.AdminInfo;
import sgbf.entity.BulletinInfo;
import sgbf.entity.GoodsInfo;
import sgbf.util.PageBean;

public class BulletinInfoServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		String op = request.getParameter("op");
		
		if ("querybulletins".equals(op.trim())) {
			queryBulletins(request, response);
		} else if ("deletebulletinbyid".equals(op.trim())) {
			deleteBulletinById(request, response);
		} else if ("editbulletinbyid".equals(op.trim())) {
			editBulletinById(request, response);
		} else if ("updatebulletin".equals(op.trim())) {
			updateBulletinById(request, response);
		} else if ("addbulletin".equals(op.trim())) {
			addBulletinById(request, response);
		}
	}
	
	
	public void queryBulletins(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        String Page = request.getParameter("currentPage");
        if (Page == null || "".equals(Page.trim()))
            Page = "1";

        int currentPage = Integer.parseInt(Page);
        
        String searchKey = request.getParameter("p");
        if (searchKey == null)
        	searchKey = "";
        searchKey = new String(searchKey.getBytes("ISO-8859-1"), "UTF-8");
        
        PageBean<BulletinInfo> pageBean = new BulletinInfoDao().getPageBean(currentPage, searchKey);

        pageBean.setCurrentPage(currentPage);

        request.setAttribute("pageBean", pageBean);
        
        request.getRequestDispatcher("/admin/bulletinsinfo.jsp").forward(request, response);
	}
	
	public void deleteBulletinById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		boolean flag = new BulletinInfoDao().isDeleteBulletinByBulletinId(id);
		
		if (flag)
			request.getRequestDispatcher("bulletinInfoServlet?op=querybulletins").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void editBulletinById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		
		BulletinInfo bulletinInfo = new BulletinInfoDao().getBulletinByBulletinId(id);
		
		request.setAttribute("bulletin", bulletinInfo);
		
		request.getRequestDispatcher("/admin/updatebulletininfo.jsp").forward(request, response);
	}
	
	public void updateBulletinById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int bulletinId = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String adminName = request.getParameter("admin");
		String createTime = request.getParameter("createtime");
	
		BulletinInfo bulletinInfo = new BulletinInfo(bulletinId, title, content, new AdminInfoDao().getAdminByName(adminName), createTime);
		
		boolean flag = new BulletinInfoDao().isUpdateBulletinByBulletinId(bulletinInfo);
		
		if (flag)
			request.getRequestDispatcher("bulletinInfoServlet?op=querybulletins").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void addBulletinById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String adminName = request.getParameter("admin");
		String createTime = request.getParameter("createtime");
		
		BulletinInfo bulletinInfo = new BulletinInfo(title, content, new AdminInfoDao().getAdminByName(adminName), createTime);
		
		boolean flag = new BulletinInfoDao().isAddBulletin(bulletinInfo);
		
		if (flag)
			request.getRequestDispatcher("bulletinInfoServlet?op=querybulletins").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

}
