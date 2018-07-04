package sgbf.util;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;


public class VerifyCode {
	private Random random = new Random();
	private int w = 140;
	private int h = 50;
	private String verfiyCode;  //验证码
	private BufferedImage image;  //验证码图片
	
	public void createVrifyCode() {
		BufferedImage bi = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
		//创建绘制环境
		Graphics2D g = (Graphics2D) bi.getGraphics();
		g.setColor(Color.WHITE);
		g.setFont(new Font(getRandomFont(), 23, 30));
		g.fillRect(0, 0, 270, 135);
		g.setColor(Color.RED);
		g.drawString(getVerfiyCode_(), w/2-35, h/2+10);
		
		//干扰线
		for (int i=0; i<5; i++) {
			int x1 = random.nextInt(w);
			int y1 = random.nextInt(h);
			int x2 = random.nextInt(w);
			int y2 = random.nextInt(h);
			g.setStroke(new BasicStroke(1.5F));
			g.setColor(Color.GREEN);
			g.drawLine(x1, y1, x2, y2);
		}
		this.image = bi;
	}
	
	
	//随机获取字体
	private String getRandomFont() {
		String[] fonts = {"宋体", "黑体", "微软雅黑", "隶书"};
		String font = fonts[random.nextInt(4)];
		return font;
	}
	
	//获取随机验证码
	public String getVerfiyCode_() {
		String s = "abcdefghijklmnopqrstuvwxyzQWERTYUIOPOPASDFGHJKLZXCVBNM1234567890";
		String verfiyCode_ = "";
		for (int i = 0; i < 4; i++) {
			int num = random.nextInt(s.length());
			verfiyCode_ += s.charAt(num);
		}
		this.verfiyCode = verfiyCode_;
		return verfiyCode;
	}

	//保存验证码图片到指定的流中
	public void output(BufferedImage image, OutputStream out) {
		try {
			ImageIO.write(image, "PNG", out);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String getVerfiyCode() {
		return verfiyCode;
	}

	public BufferedImage getImage() {
		return image;
	}
}
