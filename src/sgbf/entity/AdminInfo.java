package sgbf.entity;

public class AdminInfo {

	private Integer id;
	private String adminName;
	private String adminPwd;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminPwd() {
		return adminPwd;
	}
	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd;
	}
	public AdminInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public AdminInfo(Integer id, String adminName, String adminPwd) {
		super();
		this.id = id;
		this.adminName = adminName;
		this.adminPwd = adminPwd;
	}
	public AdminInfo(String adminName, String adminPwd) {
		super();
		this.adminName = adminName;
		this.adminPwd = adminPwd;
	}
	public AdminInfo(Integer id, String adminPwd) {
		super();
		this.id = id;
		this.adminPwd = adminPwd;
	}
}
