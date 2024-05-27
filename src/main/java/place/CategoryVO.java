package place;

public class CategoryVO {
	private int categoryIdx;
	private String categoryName;
	private String categoryType;

	public int getCategoryIdx() {
		return categoryIdx;
	}

	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCategoryType() {
		return categoryType;
	}

	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
	}

	@Override
	public String toString() {
		return "CategoryVO [categoryIdx=" + categoryIdx + ", categoryName=" + categoryName + ", categoryType=" + categoryType + "]";
	}
}
