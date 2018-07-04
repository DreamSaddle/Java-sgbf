package sgbf.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class GoodsInfoAddUpdateServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	/*****废弃Servlet********/
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload sfu = new ServletFileUpload(factory);
		sfu.setFileSizeMax(1024 * 200);
		
		try {
			List<FileItem> fileList = sfu.parseRequest(request);
			
			String goodType = fileList.get(1).getString();
			String goodName = fileList.get(2).getString("UTF-8");
			float goodPrice = Float.parseFloat(fileList.get(3).getString());
			float goodDiscount = Float.parseFloat(fileList.get(4).getString());
			String isNew = fileList.get(5).getString();
			String isRecommed = fileList.get(6).getString();
			String status = fileList.get(7).getString();
			FileItem photo = fileList.get(8);
			String remark = fileList.get(9).getString("UTF-8");
			
			System.out.println(goodType+"--"+goodName+"--"+goodPrice+"--"
					+isNew+"--"+isRecommed+"--"+status);
		} catch (Exception e) {
			
		}
	}

}
