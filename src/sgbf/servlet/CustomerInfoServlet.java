package sgbf.servlet;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;

import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sendeasymail.GetSession;
import com.sendeasymail.IsSend;
import com.sendeasymail.SetMimeMessage;

import sgbf.dao.CustomerDetailInfoDao;
import sgbf.dao.CustomerInfoDao;
import sgbf.entity.CustomerDetailInfo;
import sgbf.entity.CustomerInfo;
import sgbf.util.VerifyCode;

public class CustomerInfoServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		
		if ("customerdetail".equals(op.trim())) {
			this.customerDetail(request, response);
		} else if ("addcustomer".equals(op.trim())) {
			this.addCustomer(request, response);
		} else if ("customerlogin".equals(op.trim())) {
			this.customerLogin(request, response);
		} else if ("exit".equals(op.trim())) {
			this.exit(request, response);
		} else if ("verifyemail".equals(op.trim())) {
			this.verifyEmail(request, response);
		} else if ("verifypwd".equals(op.trim())) {
			this.verifyPwd(request, response);
		} else if ("verifyislogin".equals(op.trim())) {
			this.verifyIsLogin(request, response);
		} else if ("getcustomerbyid".equals(op.trim())) {
			this.getCustomerById(request, response);
		} else if ("getloginverifycode".equals(op.trim())) {  //获取验证码
			this.getLoginVerifyCodeImg(request, response);
		} else if ("verifyloginverifycode".equals(op.trim())) {  //验证 验证码是否正确
			this.verifyLoginVerifyCodeIsTrue(request, response);
		} else if ("getregisterverifycode".equals(op.trim())) {  //用户注册获取验证码
			this.getRegisterVerifyCode(request, response);
		} else if ("removeRegisterVerifyCode".equals(op.trim())) {  //从session中删除过期验证码
			this.removeRegisterVerifyCode(request, response);
		}
	}
	
	
	public void customerDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String searchKey = request.getParameter("key");
		if (searchKey == null)
			searchKey = "";
		
		ArrayList<CustomerInfo> cList = new CustomerInfoDao().getAllCustomerList(searchKey);

		request.setAttribute("cList", cList);
		
		request.getRequestDispatcher("/admin/customerdetail.jsp").forward(request, response);
	}
	
	public void addCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		
		boolean flag = new CustomerInfoDao().isAddCustomer(email, pwd);
		
		if (flag) {
			//注册成功就删除验证码
			request.getSession().removeAttribute("verifycode");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		} else {
			System.out.println("error");
		}
	}
	
	public void customerLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		
		//获取用户详细信息的name字段值
		int customerId = new CustomerInfoDao().isVerifyCustomerEmailIsExist(email);
		CustomerDetailInfo customerDetail = new CustomerDetailInfoDao().getCustomerDetailInfoByCustomerId(customerId);
		String name = null;
		//如果用户还没有填写详细信息
		if (customerDetail == null) {
			name = email;
		} else {
			name = customerDetail.getName();
		}
		
		request.getSession().setAttribute("name", name);
		request.getSession().setAttribute("email", email);
		response.sendRedirect("index.jsp");
	}
	
	
	public void exit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.getSession().removeAttribute("name");
		response.sendRedirect("index.jsp");
	}
	
	public void verifyEmail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		
		Integer id = new CustomerInfoDao().isVerifyCustomerEmailIsExist(email);
		
		if (id == null)
			response.getWriter().println("notexists");
		else
			response.getWriter().println("exists");
	}
	
	
	public void verifyPwd(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		
		boolean flag = new CustomerInfoDao().isVerifyCustomerPwdIsTrueByName(email, pwd);
		
		if (flag)
			response.getWriter().println("t");
		else
			response.getWriter().println("f");
	}
	
	
	public void verifyIsLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Object customer = request.getSession().getAttribute("name");

		if (customer != null)
			response.getWriter().println("t");
		else
			response.getWriter().println("f");
	}
	
	public void getCustomerById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = (String) request.getSession().getAttribute("email");
		
		int customerId = new CustomerInfoDao().isVerifyCustomerEmailIsExist(email);
		
		CustomerInfo customerInfo = new CustomerInfoDao().getCustomerById(customerId);
		
		request.setAttribute("customer", customerInfo);
		
		request.getRequestDispatcher("/reception/wsinfo.jsp").forward(request, response);
	}
	
	//加载验证码
	public void getLoginVerifyCodeImg(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		VerifyCode verifyCode = new VerifyCode();
		verifyCode.createVrifyCode();
		BufferedImage bi = verifyCode.getImage();
		String code = verifyCode.getVerfiyCode();
		
		//保存图片
		verifyCode.output(bi, response.getOutputStream());
		//保存验证码
		request.getSession().setAttribute("verifycode", code);
	}
	
	public void verifyLoginVerifyCodeIsTrue(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String session_code = (String) request.getSession().getAttribute("verifycode");
		if (session_code == null) {
			session_code = "???~";
		}
		String verify_code = request.getParameter("code");
		if (session_code.toUpperCase().equals(verify_code.toUpperCase())) {
			response.getWriter().print("t");
		} else {
			response.getWriter().print("f");
		}
	}
	
	public void getRegisterVerifyCode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			VerifyCode verifyCode = new VerifyCode();
			String code = verifyCode.getVerfiyCode_();
			
			request.getSession().setAttribute("verifycode", code);
			//注册邮箱
			String registerEmail = request.getParameter("email");
			
			System.out.println(code);
			//发送验证码至用户邮箱
			Session session =  GetSession.getSession("smtp.163.com", true, "user_taohan", "taohan163");
			MimeMessage message = SetMimeMessage.setMessage(session, "user_taohan@163.com", registerEmail, "", "", "欢迎使用水果缤纷", "您此次的验证码为："+code);
			IsSend.isSend(message);
			System.out.println("发送成功");
			
			response.getWriter().print("t");
		} catch (Exception e) {
			response.getWriter().print("f");
			e.printStackTrace();
		}
	}
	
	public void removeRegisterVerifyCode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().removeAttribute("verifycode");
	}
}
