package sgbf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sgbf.dao.GoodsTypeDao;
import sgbf.entity.GoodsType;

public class GoodsTypeServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		
		if ("querytypes".equals(op.trim())) {
			queryTypes(request, response);
		} else if ("addtype".equals(op.trim())) {
			addType(request, response);
		} else if ("deletetype".equals(op.trim())) {
			deleteType(request, response);
		} else if ("querytypebyid".equals(op.trim())) {
			queryTypeById(request, response);
		} else if ("updatetype".equals(op.trim())) {
			updateType(request, response);
		}
	}

	public void queryTypes(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<GoodsType> tList = new GoodsTypeDao().getAllTypeList();
		
		request.setAttribute("tList", tList);
		
		request.getRequestDispatcher("/admin/goodstype.jsp").forward(request, response);
	}
	
	public void addType(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String typeName = request.getParameter("typeName");
		
		boolean flag = new GoodsTypeDao().isAddGoodsType(typeName);
		
		if (flag)
			request.getRequestDispatcher("goodsTypeServlet?op=querytypes").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void deleteType(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int typeId = Integer.parseInt(request.getParameter("id"));
		
		boolean flag = new GoodsTypeDao().isDeleteGoodsType(typeId);
		
		if (flag)
			request.getRequestDispatcher("goodsTypeServlet?op=querytypes").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void queryTypeById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int typeId = Integer.parseInt(request.getParameter("id"));
		
		GoodsType type = new GoodsTypeDao().getGoodsTypeByTypeId(typeId);
		
		request.setAttribute("type", type);
		
		request.getRequestDispatcher("/admin/updategoodstype.jsp").forward(request, response);
	}
	
	public void updateType(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String typeName = request.getParameter("typeName");
		int typeId = Integer.parseInt(request.getParameter("typeId"));
		
		GoodsType type = new GoodsType(typeId, typeName);
		
		boolean flag = new GoodsTypeDao().isUpdateGoodsTypeByTypeId(type);
		
		if (flag)
			request.getRequestDispatcher("goodsTypeServlet?op=querytypes").forward(request, response);
		else
			System.out.println("error");
	}
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}
	
	

}
