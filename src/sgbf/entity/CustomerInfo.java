package sgbf.entity;

public class CustomerInfo {

	private Integer id;
	private String email;
	private String pwd;
	private String registerTime;
	private String name;
	private String telphone;
	private String movePhone;
	private String address;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getRegisterTime() {
		return registerTime;
	}
	public void setRegisterTime(String registerTime) {
		this.registerTime = registerTime;
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
	public CustomerInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CustomerInfo(String email, String pwd, String registerTime,
			String name, String telphone, String movePhone, String address) {
		super();
		this.email = email;
		this.pwd = pwd;
		this.registerTime = registerTime;
		this.name = name;
		this.telphone = telphone;
		this.movePhone = movePhone;
		this.address = address;
	}
	public CustomerInfo(Integer id, String email, String pwd,
			String registerTime, String name, String telphone,
			String movePhone, String address) {
		super();
		this.id = id;
		this.email = email;
		this.pwd = pwd;
		this.registerTime = registerTime;
		this.name = name;
		this.telphone = telphone;
		this.movePhone = movePhone;
		this.address = address;
	}
}
