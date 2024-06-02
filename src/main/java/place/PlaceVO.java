package place;

import java.sql.Timestamp;

public class PlaceVO {
	private int placeIdx;
	private String placeName;
	private String region1DepthName;
	private String region2DepthName;
	private int categoryIdx;
	private int createdBy;
	private Integer updatedBy; // 변경: Integer로 수정하여 null 허용
	private Timestamp createdAt;
	private Timestamp updatedAt;

	// 필드 추가
	private String categoryName;
	private String createdByNickname;

	public PlaceVO(int createdBy, String placeName, String region1DepthName, String region2DepthName, int categoryIdx) {
		this.createdBy = createdBy;
		this.placeName = placeName;
		this.region1DepthName = region1DepthName;
		this.region2DepthName = region2DepthName;
		this.categoryIdx = categoryIdx;
	}

	public String getCreatedByNickname() {
		return createdByNickname;
	}

	public void setCreatedByNickname(String createdByNickname) {
		this.createdByNickname = createdByNickname;
	}

	public PlaceVO() {
	}

	public int getPlaceIdx() {
		return placeIdx;
	}

	public void setPlaceIdx(int placeIdx) {
		this.placeIdx = placeIdx;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getRegion1DepthName() {
		return region1DepthName;
	}

	public void setRegion1DepthName(String region1DepthName) {
		this.region1DepthName = region1DepthName;
	}

	public String getRegion2DepthName() {
		return region2DepthName;
	}

	public void setRegion2DepthName(String region2DepthName) {
		this.region2DepthName = region2DepthName;
	}

	public int getCategoryIdx() {
		return categoryIdx;
	}

	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public Integer getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(Integer updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		return "PlaceVO [placeIdx=" + placeIdx + ", placeName=" + placeName + ", region1DepthName=" + region1DepthName + ", region2DepthName="
				+ region2DepthName + ", categoryIdx=" + categoryIdx + ", createdBy=" + createdBy + ", updatedBy=" + updatedBy + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", categoryName=" + categoryName + ", createdByNickname=" + createdByNickname + "]";
	}
}
