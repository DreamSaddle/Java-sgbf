package sgbf.entity;

public class SuperOrderInfo {

	//该类无实际作用
	private CustomerInfo customer;
	private OrderInfo order;
	private OrderGoodsInfo ordergood;
	public CustomerInfo getCustomer() {
		return customer;
	}
	public void setCustomer(CustomerInfo customer) {
		this.customer = customer;
	}
	public OrderInfo getOrder() {
		return order;
	}
	public void setOrder(OrderInfo order) {
		this.order = order;
	}
	public OrderGoodsInfo getOrdergood() {
		return ordergood;
	}
	public void setOrdergood(OrderGoodsInfo ordergood) {
		this.ordergood = ordergood;
	}
	public SuperOrderInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SuperOrderInfo(CustomerInfo customer, OrderInfo order,
			OrderGoodsInfo ordergood) {
		super();
		this.customer = customer;
		this.order = order;
		this.ordergood = ordergood;
	}
	
}
