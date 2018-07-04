package sgbf.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sgbf.dao.GoodsInfoPageDao;
import sgbf.entity.GoodsInfo;
import sgbf.util.PageBean;

public class GoodsInfoPageBeanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	
        //获取当前页码，第一次访问页码为null
        String Page = request.getParameter("currentPage");
        //第一次访问设置当前页码为1
        if (Page == null || "".equals(Page.trim()))
            Page = "1";

        int currentPage = Integer.parseInt(Page);
        
        //获取搜索关键字
        String searchKey = request.getParameter("p");
        if (searchKey == null)
        	searchKey = "";
        String searchKey_ = new String(searchKey.getBytes("ISO-8859-1"), "UTF-8");
        
        //获取指定范围内图书PageBean对象
        PageBean<GoodsInfo> pageBean = new GoodsInfoPageDao().getPageBean(currentPage, searchKey_);

        pageBean.setCurrentPage(currentPage);

        //保存PageBean对象
        request.setAttribute("pageBean", pageBean);

        //请求转发
        request.getRequestDispatcher("/admin/goodsinfo.jsp").forward(request, response);
    }
}
