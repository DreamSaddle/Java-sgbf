package sgbf.entity;

public class OrderGoodsInfo {

	private OrderInfo order;
	private GoodsInfo good;
	private int quantity;
	public OrderInfo getOrder() {
		return order;
	}
	public void setOrder(OrderInfo order) {
		this.order = order;
	}
	public GoodsInfo getGood() {
		return good;
	}
	public void setGood(GoodsInfo good) {
		this.good = good;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public OrderGoodsInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderGoodsInfo(OrderInfo order, GoodsInfo good, int quantity) {
		super();
		this.order = order;
		this.good = good;
		this.quantity = quantity;
	}
}
