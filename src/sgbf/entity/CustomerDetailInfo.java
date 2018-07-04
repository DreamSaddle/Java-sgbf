package sgbf.entity;

public class CustomerDetailInfo {

	private CustomerInfo customer;
	private String name;
	private String telphone;
	private String movePhone;
	private String address;
	public CustomerInfo getCustomer() {
		return customer;
	}
	public void setCustomer(CustomerInfo customer) {
		this.customer = customer;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelphone() {
		return telphone;
	}
	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}
	public String getMovePhone() {
		return movePhone;
	}
	public void setMovePhone(String movePhone) {
		this.movePhone = movePhone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public CustomerDetailInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CustomerDetailInfo(CustomerInfo customer, String name,
			String telphone, String movePhone, String address) {
		super();
		this.customer = customer;
		this.name = name;
		this.telphone = telphone;
		this.movePhone = movePhone;
		this.address = address;
	}
	public CustomerDetailInfo(String name, String telphone, String movePhone,
			String address) {
		super();
		this.name = name;
		this.telphone = telphone;
		this.movePhone = movePhone;
		this.address = address;
	}
}
