package sgbf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sgbf.dao.BulletinInfoDao;
import sgbf.dao.CustomerInfoDao;
import sgbf.dao.OrderDetailInfoDao;
import sgbf.entity.BulletinInfo;
import sgbf.entity.GoodsInfo;
import sgbf.entity.OrderDetailInfo;
import sgbf.util.BuyCar;
import sgbf.util.PageBean;

public class OrderDetailInfoServlet extends HttpServlet {

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		
		if ("queryorderdetails".equals(op.trim())) {
			queryOrderDetails(request, response);
		} else if("buynow".equals(op.trim())) {  //立即购买
			this.buyNow(request, response);
		} else if("getcustomerallorders".equals(op.trim())) { 
			this.getCustomerAllOrders(request, response);
		} else if("isaffrimorder".equals(op.trim())) { 
			this.isAffrimOrder(request, response);
		}
	}
	
	public void queryOrderDetails(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        String Page = request.getParameter("currentPage");
        if (Page == null || "".equals(Page.trim()))
            Page = "1";

        int currentPage = Integer.parseInt(Page);
        
        String searchKey = request.getParameter("p");
        if (searchKey == null)
        	searchKey = "";
        searchKey = new String(searchKey.getBytes("ISO-8859-1"), "UTF-8");
        
        PageBean<OrderDetailInfo> pageBean = new OrderDetailInfoDao().getPageBean(currentPage, searchKey);

        pageBean.setCurrentPage(currentPage);

        request.setAttribute("pageBean", pageBean);
        
        request.getRequestDispatcher("/admin/orderinfo.jsp").forward(request, response);
	}
	
	
	/**
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void buyNow(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取session中的订单中的商品信息
		HashMap<GoodsInfo, Integer> orderGoodsMap = (HashMap<GoodsInfo, Integer>) request.getSession().getAttribute("ordergoodsMap");
		//获取最后一次订单号
		int lastOrderId = (Integer) request.getSession().getAttribute("lastOrderId");
		int customerId = (Integer) request.getSession().getAttribute("customerId");
		
		boolean flag = new OrderDetailInfoDao().addOrderDetailInfo(orderGoodsMap, lastOrderId);
		
		if (flag) {
			//添加成功，情况session
			request.getSession().removeAttribute("ordergoodsMap");
			request.getSession().removeAttribute("lastOrderId");
			request.getSession().removeAttribute("customerId");
			
			//删除购物车中已经购买的商品
			Set<GoodsInfo> orderGoodIdSet = orderGoodsMap.keySet();  //订单中的商品集合
			BuyCar buyCar = (BuyCar) request.getSession().getAttribute("buycar");  //购物车
			//如果是直接购买商品 就不会有购物车
			if (buyCar != null) {
				HashMap<Integer, GoodsInfo> buyGoodsMap = buyCar.getGoodsMap();  //购物车中商品Map集合
				Set<Integer> buycarGoodIdSet = buyGoodsMap.keySet();  //购物车中的key(商品编号)集合
				/**
				 * 不能直接使用set的remove方法移除
				 * 需要先将所有要删除的id放入到一个List集合中，最后使用set的removeAll方法移除
				 * 
				 * --
				 * 迭代器是工作在一个独立的线程中，并且有一个mutex锁，所以，在迭代器工作时，不允许被迭代对象被改变
				 * 删除第一个没有问题，因为第一个是第一次迭代
				 * 当迭代删除第二个时，迭代器时单向不可变的，当第一次删除后，迭代器中的数据就放声了改变，迭代器就不能正常共工作了
				 */
				List delList = new ArrayList();  //需要删除的id集合
				for (GoodsInfo goodsInfo : orderGoodIdSet) {
					if (buycarGoodIdSet != null) {
						for (Integer integer : buycarGoodIdSet) {
							if(goodsInfo.getGoodsId().equals(integer)) {  //当前商品id等于购物车的键
								delList.add(integer);
							}
						}
					}
				}
				//从购物车删除已经购买的商品
				buycarGoodIdSet.removeAll(delList);
			}
			
			request.getSession().setAttribute("buycar", buyCar);
			response.sendRedirect("reception/buysuc.jsp");
		} else {
			System.out.println("error");
		}
	}
	
	public void getCustomerAllOrders(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = (String) request.getSession().getAttribute("email");
		int customerId = new CustomerInfoDao().isVerifyCustomerEmailIsExist(email);
		
		ArrayList<OrderDetailInfo> ordersList = new OrderDetailInfoDao().getCustomerOrders(customerId);
		
		request.setAttribute("orders", ordersList);
		
		request.getRequestDispatcher("/reception/orders.jsp").forward(request, response);
	}
	
	public void isAffrimOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		
		boolean flag = new OrderDetailInfoDao().isAffirmOrder(orderId);
		
		if (flag)
			this.getCustomerAllOrders(request, response);
		else
			System.out.println("error");
	}
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

}
