package sgbf.entity;

public class BulletinInfo {

	private Integer id;
	private String title;
	private String content;
	private AdminInfo admin;
	private String createTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public AdminInfo getAdmin() {
		return admin;
	}
	public void setAdmin(AdminInfo admin) {
		this.admin = admin;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public BulletinInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BulletinInfo(Integer id, String title, String content,
			AdminInfo admin, String createTime) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.admin = admin;
		this.createTime = createTime;
	}
	public BulletinInfo(String title, String content, AdminInfo admin,
			String createTime) {
		super();
		this.title = title;
		this.content = content;
		this.admin = admin;
		this.createTime = createTime;
	}
}
