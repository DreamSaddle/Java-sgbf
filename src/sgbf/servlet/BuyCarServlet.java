package sgbf.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sgbf.dao.GoodsInfoDao;
import sgbf.entity.GoodsInfo;
import sgbf.util.BuyCar;

public class BuyCarServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		
		if ("addgood".equals(op.trim())) {
			this.addGood(request, response);
		} else if ("changeNum2Session".equals(op.trim())) {  //修改Session中商品数量
			changeNumForSession(request, response);
		} else if ("delete2car".equals(op.trim())) {  //删除购物车中的商品记录
			deleteGoodToCar(request, response);
		}
	}
	
	
	public void addGood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String goodId = request.getParameter("goodId");
		if (goodId == null)
			goodId = "";
		
		int goodId_ = Integer.parseInt(goodId);
		GoodsInfo good = new GoodsInfoDao().getGoodByGoodId(goodId_);
		
		String goodNum = request.getParameter("goodNum");
		int goodNum_ = Integer.parseInt(goodNum);
		good.setNum(goodNum_);
		
		BuyCar buyCar = (BuyCar) request.getSession().getAttribute("buycar");
		if (buyCar == null)
			buyCar = new BuyCar();
		
		buyCar.addGood(good);
		//设置购物车中商品总数量
		buyCar.setMapSize(buyCar.getMapSize());
		request.getSession().setAttribute("buycar", buyCar);
		
		response.getWriter().println("suc");
	}
	
	public void changeNumForSession(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int newNum = Integer.parseInt(request.getParameter("newNum"));
		int goodId = Integer.parseInt(request.getParameter("goodId"));
		
		try {
			BuyCar buyCar = (BuyCar) request.getSession().getAttribute("buycar");
			if (buyCar == null) {
				buyCar = new BuyCar();
			}
			//设置新的数量
			buyCar.getGoodsMap().get(goodId).setNum(newNum);
			
			response.getWriter().print("1");
		} catch (Exception e) {
			response.getWriter().print("0");
			e.printStackTrace();
		}
	}
	
	public void deleteGoodToCar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		BuyCar buyCar = (BuyCar) request.getSession().getAttribute("buycar");
		if (buyCar == null) {
			buyCar = new BuyCar();
		}
		
		int goodId = Integer.parseInt(request.getParameter("goodId"));
		
		//根据编号移出购物车
		buyCar.getGoodsMap().remove(goodId);
		
		request.getSession().setAttribute("buycar", buyCar);
		
		request.getRequestDispatcher("/reception/buycar.jsp").forward(request, response);
	}
}
