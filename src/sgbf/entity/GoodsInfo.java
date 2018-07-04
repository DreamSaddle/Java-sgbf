package sgbf.entity;

public class GoodsInfo {

	private Integer goodsId;
	private GoodsType type;
	private String goodsName;
	private float price;
	private float discount;
	private int isNew;
	private int isRecommend;
	private int STATUS;
	private String photo;
	private String remark;
	private int num;
	public Integer getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}
	public GoodsType getType() {
		return type;
	}
	public void setType(GoodsType type) {
		this.type = type;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public float getDiscount() {
		return discount;
	}
	public void setDiscount(float discount) {
		this.discount = discount;
	}
	public int getIsNew() {
		return isNew;
	}
	public void setIsNew(int isNew) {
		this.isNew = isNew;
	}
	public int getIsRecommend() {
		return isRecommend;
	}
	public void setIsRecommend(int isRecommend) {
		this.isRecommend = isRecommend;
	}
	public int getSTATUS() {
		return STATUS;
	}
	public void setSTATUS(int sTATUS) {
		STATUS = sTATUS;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public GoodsInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public GoodsInfo(Integer goodsId, GoodsType type, String goodsName,
			float price, float discount, int isNew, int isRecommend,
			int sTATUS, String photo, String remark) {
		super();
		this.goodsId = goodsId;
		this.type = type;
		this.goodsName = goodsName;
		this.price = price;
		this.discount = discount;
		this.isNew = isNew;
		this.isRecommend = isRecommend;
		STATUS = sTATUS;
		this.photo = photo;
		this.remark = remark;
	}
	public GoodsInfo(GoodsType type, String goodsName, float price,
			float discount, int isNew, int isRecommend, int sTATUS,
			String photo, String remark) {
		super();
		this.type = type;
		this.goodsName = goodsName;
		this.price = price;
		this.discount = discount;
		this.isNew = isNew;
		this.isRecommend = isRecommend;
		STATUS = sTATUS;
		this.photo = photo;
		this.remark = remark;
	}
	
	
}
