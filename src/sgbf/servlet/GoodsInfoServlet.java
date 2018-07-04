package sgbf.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import sgbf.dao.GoodsInfoDao;
import sgbf.dao.GoodsTypeDao;
import sgbf.entity.GoodsInfo;
import sgbf.entity.GoodsType;
import th.uploadeasy.SaveFileDispose;

public class GoodsInfoServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		
		if (op == null) {
			addOrupdateGood(request, response);
		} else if ("querygoods".equals(op.trim())) {
			queryGoods(request, response);
		} else if ("deletegoodbyid".equals(op.trim())) {
			deleteGoodById(request, response);
		} else if ("editgoodbyid".equals(op.trim())) {
			editGoodById(request, response);
		} else if ("updategoodbyid".equals(op.trim())) {
			addOrupdateGood(request, response);
		} else if ("addgood".equals(op.trim())) {
			addOrupdateGood(request, response);
		} else if ("preaddgood".equals(op.trim())) {  //预添加商品
			preAddGood(request, response);
		} else if ("detailgoodinfo".equals(op.trim())) {
			detailGoodInfo(request, response);
		} else if ("indexgoodsinfo".equals(op.trim())){  //首页
			indexGoodsInfo(request, response);
		}
	}
	
	public void queryGoods(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<GoodsInfo> gList = new GoodsInfoDao().getAllGoodsList();
		
		request.setAttribute("gList", gList);
		
		request.getRequestDispatcher("/admin/goodsinfo.jsp").forward(request, response);
	}
	
	public void deleteGoodById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int goodId = Integer.parseInt(request.getParameter("id"));
		
		boolean flag = new GoodsInfoDao().isDeleteGoodByGoodId(goodId);
		
		if (flag)
			request.getRequestDispatcher("goodsInfoPageBeanServlet?op=querygoods").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void editGoodById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int goodId = Integer.parseInt(request.getParameter("id"));
		
		GoodsInfo good = new GoodsInfoDao().getGoodByGoodId(goodId);
		request.setAttribute("good", good);
		
		ArrayList<GoodsType> goodstype = new GoodsTypeDao().getAllTypeList();
		request.setAttribute("types", goodstype);
		
		request.getRequestDispatcher("/admin/updategoodinfo.jsp").forward(request, response);
	}
	
	public void addOrupdateGood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload sfu = new ServletFileUpload(factory);
		sfu.setFileSizeMax(1024 * 200);
		
		try {
			List<FileItem> fileList = sfu.parseRequest(request);
			
			//添加或修改根据op值进行判断
			String op = fileList.get(0).getString();
			//根据类型编号获取类型对象
			GoodsType goodType = new GoodsTypeDao().getGoodsTypeByTypeId(Integer.parseInt(fileList.get(1).getString()));
			String goodName = fileList.get(2).getString("UTF-8");
			float goodPrice = Float.parseFloat(fileList.get(3).getString());
			float goodDiscount = Float.parseFloat(fileList.get(4).getString());
			int isNew = Integer.parseInt(fileList.get(5).getString());
			int isRecommend = Integer.parseInt(fileList.get(6).getString());
			int status = Integer.parseInt(fileList.get(7).getString());
			FileItem photo = fileList.get(8);
			String photoName = photo.getFieldName();
			String remark = fileList.get(9).getString("UTF-8");
			String goodId = fileList.get(10).getString();
			
			GoodsInfo good = null;
			//没有编号就是添加，有编号就是修改
			if (goodId == null || "".equals(goodId.trim()))
				good = new GoodsInfo(goodType, goodName, goodPrice, goodDiscount, isNew, isRecommend, status, photoName, remark);
			else
				good = new GoodsInfo(Integer.parseInt(goodId), goodType, goodName, goodPrice, goodDiscount, isNew, isRecommend, status, photoName, remark);
			
			//上传商品图片文件
			String rootPath = this.getServletContext().getRealPath("/reception/images/");
			SaveFileDispose sfd = new SaveFileDispose(rootPath);
			String savlyPath = sfd.saveFile(photo);
			
			//将上传后的文件路径设置为图片名称
			good.setPhoto(savlyPath);
			
			//添加
			if ("addgood".equals(op.trim())) {
				addGood(request, response, good);
			} else if ("updategood".equals(op.trim())) {
				updateGoodById(request, response, good, fileList, photo);
			}
			
		} catch (Exception e) {
			if (e instanceof FileSizeLimitExceededException) {
				request.setAttribute("msg", "商品图片不能大于200KB");
				request.getRequestDispatcher("/admin/addgoodinfo.jsp").forward(request, response);
			}
			e.printStackTrace();
		}
	}
	
	public void addGood(HttpServletRequest request, HttpServletResponse response, GoodsInfo good)
			throws ServletException, IOException {
		boolean flag = new GoodsInfoDao().isAddGood(good);
		
		if (flag)
			request.getRequestDispatcher("goodsInfoPageBeanServlet?op=querygoods").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void updateGoodById(HttpServletRequest request, HttpServletResponse response, GoodsInfo good, List<FileItem> fiList, FileItem photo)
			throws ServletException, IOException {
		String beforePhotoName = fiList.get(11).getString("UTF-8");
		//如果没有修改商品图片，那么商品图片就为之前的
		if (photo.getSize() == 0) {
			good.setPhoto(beforePhotoName);
		}
		
		boolean flag = new GoodsInfoDao().isUpdateGoodByGoodId(good);
		
		if (flag)
			request.getRequestDispatcher("goodsInfoPageBeanServlet?op=querygoods").forward(request, response);
		else
			System.out.println("error");
	}
	
	public void preAddGood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取所有商品类型
		ArrayList<GoodsType> goodstype = new GoodsTypeDao().getAllTypeList();
		
		request.setAttribute("types", goodstype);
		
		request.getRequestDispatcher("/admin/addgoodinfo.jsp").forward(request, response);
	}
	
	public void detailGoodInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int goodId = Integer.parseInt(request.getParameter("id"));
		
		GoodsInfo good = new GoodsInfoDao().getGoodByGoodId(goodId);
		
		request.setAttribute("good", good);
		
		request.getRequestDispatcher("/admin/detailgoodinfo.jsp").forward(request, response);
	}
	
	public void indexGoodsInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取销量前六商品集合
		ArrayList<GoodsInfo> gListSex = new GoodsInfoDao().getSalesBeforeSexGoodsList();
		request.setAttribute("gListSex", gListSex);
		
		
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
