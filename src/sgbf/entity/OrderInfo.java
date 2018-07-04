package sgbf.entity;

public class OrderInfo {

	private Integer orderId;
	private CustomerInfo customer;
	private int status;
	private String orderTime;
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public CustomerInfo getCustomer() {
		return customer;
	}
	public void setCustomer(CustomerInfo customer) {
		this.customer = customer;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
	public OrderInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderInfo(Integer orderId, CustomerInfo customer, int status,
			String orderTime) {
		super();
		this.orderId = orderId;
		this.customer = customer;
		this.status = status;
		this.orderTime = orderTime;
	}
	public OrderInfo(CustomerInfo customer, int status, String orderTime) {
		super();
		this.customer = customer;
		this.status = status;
		this.orderTime = orderTime;
	}
	
}
