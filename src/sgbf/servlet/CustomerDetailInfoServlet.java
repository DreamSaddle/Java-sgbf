package sgbf.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sgbf.dao.CustomerDetailInfoDao;
import sgbf.dao.CustomerInfoDao;
import sgbf.entity.CustomerDetailInfo;

public class CustomerDetailInfoServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String op = request.getParameter("op");
		
		if ("isaddorupdatecustomerdetailinfo".equals(op.trim())) {
			this.isAddOrUpdateCustomerDetailInfo(request, response);
		}
	}

	public void isAddOrUpdateCustomerDetailInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取登录用户Id
		String email = (String) request.getSession().getAttribute("email");
		int customerId = new CustomerInfoDao().isVerifyCustomerEmailIsExist(email);
		
		String name = request.getParameter("customername");
		String telPhone = request.getParameter("telphone");
		String movePhone = request.getParameter("movephone");
		String address = request.getParameter("address");
		
		CustomerDetailInfo customerDetailInfo = new CustomerDetailInfo(name, telPhone, movePhone, address);
		
		boolean flag = new CustomerDetailInfoDao().isAddOrUpdateCustomerDetailInfo(customerDetailInfo, customerId);
		if (flag) {
			//修改或完善了信息后，需要重新给session的name属性赋值，以便在首页能刷新登录人
			request.getSession().setAttribute("name", name);
			response.sendRedirect("index.jsp");
		} else {
			System.out.println("error");
		}
	}
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
}
