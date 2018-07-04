package sgbf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sgbf.dao.CustomerInfoDao;
import sgbf.dao.GoodsInfoDao;
import sgbf.dao.OrderInfoDao;
import sgbf.entity.CustomerInfo;
import sgbf.entity.GoodsInfo;
import sgbf.entity.OrderInfo;
import sgbf.util.BuyCar;

public class OrderInfoServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		
		if ("addorder".equals(op.trim())) {
			this.addOrder(request, response);
		} else if ("getSumOrders".equals(op.trim())) {
			this.getSumOrders(request, response);
		}
	}
	
	
	public void addOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = (String) request.getSession().getAttribute("email");
		int customerId = new CustomerInfoDao().isVerifyCustomerEmailIsExist(email);
		
		//获取系统当前时间
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");
		String time = sdf.format(date);
		
		CustomerInfo customerInfo = new CustomerInfo();
		customerInfo.setId(customerId);
		OrderInfo orderInfo = new OrderInfo(customerInfo, 0, time);
		
		boolean flag = new OrderInfoDao().addOrder(orderInfo);
		
		if (flag) {
			//订单中商品Map集合
			HashMap<GoodsInfo, Integer> orderGoodsMap = new HashMap<GoodsInfo, Integer>();
			//订单总计金额
			float sum = 0;
			//获取最后一次订单号
    		Integer lastOrderId = new OrderInfoDao().getCustomerLastOrderId(customerId);
    		if (lastOrderId == null) {
    			return;
    		}
    		//登录用户
    		CustomerInfo loginCustomer = new CustomerInfoDao().getCustomerById(customerId);
    		//操作
			String cz = request.getParameter("cz");
			
			//通过购物车添加订单
			if ("addorderBybuycar".equals(cz.trim())) {
			sum = Float.parseFloat(request.getParameter("sum"));
			//获取商品编号组合字符串
			String goodIds = request.getParameter("goodIds");
			//商品编号数组
			String[] idArr = goodIds.split(",");
			BuyCar buyCar = (BuyCar) request.getSession().getAttribute("buycar");
			//遍历数组，获取每个商品对象，存入集合
			for (String goodId : idArr) {
				GoodsInfo goodsInfo = new GoodsInfoDao().getGoodByGoodId(Integer.parseInt(goodId));
				//商品对应数量，从购物车中获取
				int num = buyCar.getGoodsMap().get(Integer.parseInt(goodId)).getNum();
				
				orderGoodsMap.put(goodsInfo, num);
			}
			} else if ("addorderBybuynow".equals(cz.trim())) {  //直接购买
				GoodsInfo goodsInfo = new GoodsInfoDao().getGoodByGoodId(Integer.parseInt(request.getParameter("goodId")));
				orderGoodsMap.put(goodsInfo, Integer.parseInt(request.getParameter("num")));
			}
		
			request.setAttribute("loginCustomer", loginCustomer);
			request.getSession().setAttribute("ordergoodsMap", orderGoodsMap);
			request.getSession().setAttribute("lastOrderId", lastOrderId);
			request.getSession().setAttribute("customerId", customerId);
			request.getSession().setAttribute("sum", sum);
			request.getRequestDispatcher("/reception/buynow.jsp").forward(request, response);
		} else {
			System.out.println("error");
		}
	}

	
	public void getSumOrders(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = (String) request.getSession().getAttribute("email");
		int customerId = new CustomerInfoDao().isVerifyCustomerEmailIsExist(email);
		
		Integer sumOrders = new OrderInfoDao().getCustomerSumOrders(customerId);
		if (sumOrders != null)
			response.getWriter().print(sumOrders);
		else
			response.getWriter().print(0);
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

}
