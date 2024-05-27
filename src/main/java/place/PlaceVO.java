package place;

import java.sql.Timestamp;

public class PlaceVO {
	private int placeIdx;
	private String placeName;
	private String region1DepthName;
	private String region2DepthName;
	private String categoryName;
	private int createdBy;
	private int updatedBy;
	private Timestamp createdAt;
	private Timestamp updatedAt;

	public PlaceVO(int createdBy, String placeName, String region1DepthName, String region2DepthName, String categoryName) {
        this.createdBy = createdBy;
        this.placeName = placeName;
        this.region1DepthName = region1DepthName;
        this.region2DepthName = region2DepthName;
        this.categoryName = categoryName;
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

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public int getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(int updatedBy) {
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
				+ region2DepthName + ", categoryName=" + categoryName + ", createdBy=" + createdBy + ", updatedBy=" + updatedBy + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + "]";
	}
}