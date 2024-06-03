package bookmark;

import java.sql.Timestamp;

public class BookmarkVO {
	private int bookmarkIdx;
	private int userIdx;
	private int localLogIdx;
	private Timestamp createdAt;
	private String placeName;
	private String region1DepthName;
	private String region2DepthName;
	private String categoryName;
	private String coverImage;

	public int getBookmarkIdx() {
		return bookmarkIdx;
	}

	public void setBookmarkIdx(int bookmarkIdx) {
		this.bookmarkIdx = bookmarkIdx;
	}

	public int getUserIdx() {
		return userIdx;
	}

	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}

	public int getLocalLogIdx() {
		return localLogIdx;
	}

	public void setLocalLogIdx(int localLogIdx) {
		this.localLogIdx = localLogIdx;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
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

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCoverImage() {
		return coverImage;
	}

	public void setCoverImage(String coverImage) {
		this.coverImage = coverImage;
	}

	@Override
	public String toString() {
		return "BookmarkVO [bookmarkIdx=" + bookmarkIdx + ", userIdx=" + userIdx + ", localLogIdx=" + localLogIdx + ", createdAt=" + createdAt + ", placeName=" + placeName + ", region1DepthName="
				+ region1DepthName + ", region2DepthName=" + region2DepthName + ", categoryName=" + categoryName + ", coverImage=" + coverImage + "]";
	}
}
