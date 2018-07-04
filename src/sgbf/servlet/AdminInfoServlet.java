package sgbf.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sgbf.dao.AdminInfoDao;
import sgbf.entity.AdminInfo;

public class AdminInfoServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		
		if ("verifyname".equals(op.trim())) {  //验证账号是否存在
			verifyName(request, response);
		} else if ("verifypwd".equals(op.trim())) {
			verifyPwd(request, response);
		} else if ("login".equals(op.trim())) {
			String adminName = request.getParameter("adminName");
			request.getSession().setAttribute("adminName", adminName);
			request.getRequestDispatcher("admin.jsp").forward(request, response);
		} else if ("editadmin".equals(op.trim())) {
			editAdmin(request, response);
		} else if ("updateadmin".equals(op.trim())) {
			updateAdmin(request, response);
		} else if ("nowselfadmin".equals(op.trim())) {  //当前登录管理员信息
			nowSelfAdmin(request, response);
		} else if ("deleteadmin".equals(op.trim())) {
			deleteAdmin(request, response);
		} else if ("exitadmin".equals(op.trim())) {
			exitAdmin(request, response);
		}
	}
	
	
	public void verifyName(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String adminName = request.getParameter("adminName");
		
		boolean flag = new AdminInfoDao().isVerifyAdminIsExist(adminName);
		
		if (flag)
			response.getWriter().print("t");
		else
			response.getWriter().print("f");
	}

	
	public void verifyPwd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String adminName = request.getParameter("adminName");
		String adminPwd = request.getParameter("adminPwd");
		
		boolean flag = new AdminInfoDao().isVerifyPwdIsTrueByName(adminName, adminPwd);
		
		if (flag)
			response.getWriter().print("t");
		else
			response.getWriter().print("f");
	}
	
	public void editAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int adminId = Integer.parseInt(request.getParameter("id"));
		
		AdminInfo adminInfo = new AdminInfoDao().getAdminById(adminId);
		
		request.setAttribute("admin", adminInfo);
		
		request.getRequestDispatcher("/admin/updateadmininfo.jsp").forward(request, response);
	}
	
	public void updateAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int adminId = Integer.parseInt(request.getParameter("id"));
		String adminPwd = request.getParameter("pwd");
		
		AdminInfo admin = new AdminInfo(adminId, adminPwd);
		
		boolean flag = new AdminInfoDao().isUpdateAdminById(admin);
		
		if (flag)
			request.getRequestDispatcher("admin.jsp").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void nowSelfAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int adminId = new AdminInfoDao().getAdminByName(request.getParameter("admin")).getId();
		
		AdminInfo admin = new AdminInfoDao().getAdminById(adminId);
		
		request.setAttribute("admin", admin);
		
		request.getRequestDispatcher("/admin/adminselfinfo.jsp").forward(request, response);
	}
	
	public void deleteAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int adminId = Integer.parseInt(request.getParameter("id"));
		
		boolean flag = new AdminInfoDao().isDeleteAdminById(adminId);
		
		//注销账号就进入登录页面
		if (flag) {
			request.getSession().removeAttribute("adminName");
			response.sendRedirect("admin/login.jsp");
		}
		else {
			System.out.println("error");
		}
	}
	
	
	public void exitAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().removeAttribute("adminName");
		
		response.sendRedirect("admin/login.jsp");
	}
}
