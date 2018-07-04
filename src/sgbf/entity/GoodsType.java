package sgbf.entity;

public class GoodsType {

	private Integer typeId;
	private String typeName;
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public GoodsType() {
		super();
	}
	public GoodsType(Integer typeId, String typeName) {
		this.typeId = typeId;
		this.typeName = typeName;
	}
	public GoodsType(String typeName) {
		this.typeName = typeName;
	}
	
	
}
