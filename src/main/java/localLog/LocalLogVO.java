package localLog;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class LocalLogVO {
	private int localLogIdx;
	private int userIdx;
	private int placeIdx;
	private String content;
	private String photos;
	private Date visitDate;
	private String community;
	private String visibility;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private String hostIp;

	// 추가
	private String placeName;
	private String region1DepthName;
	private String region2DepthName;
	private String coverImage;
	private String categoryName;
	private List<String> photoUrls;

    public List<String> getPhotoUrls() {
        return photoUrls;
    }

    public void setPhotoUrls(List<String> photoUrls) {
        this.photoUrls = photoUrls;
    }

	public int getLocalLogIdx() {
		return localLogIdx;
	}

	public void setLocalLogIdx(int localLogIdx) {
		this.localLogIdx = localLogIdx;
	}

	public int getUserIdx() {
		return userIdx;
	}

	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}

	public int getPlaceIdx() {
		return placeIdx;
	}

	public void setPlaceIdx(int placeIdx) {
		this.placeIdx = placeIdx;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPhotos() {
		return photos;
	}

	public void setPhotos(String photos) {
		this.photos = photos;
	}

	public Date getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(Date visitDate) {
		this.visitDate = visitDate;
	}

	public String getCommunity() {
		return community;
	}

	public void setCommunity(String community) {
		this.community = community;
	}

	public String getVisibility() {
		return visibility;
	}

	public void setVisibility(String visibility) {
		this.visibility = visibility;
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

	public String getHostIp() {
		return hostIp;
	}

	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
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

	public String getCoverImage() {
		return coverImage;
	}

	public void setCoverImage(String coverImage) {
		this.coverImage = coverImage;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		return "LocalLogVO [localLogIdx=" + localLogIdx + ", userIdx=" + userIdx + ", placeIdx=" + placeIdx + ", content=" + content + ", photos=" + photos
				+ ", visitDate=" + visitDate + ", community=" + community + ", visibility=" + visibility + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + ", hostIp=" + hostIp + ", placeName=" + placeName + ", region1DepthName=" + region1DepthName + ", region2DepthName="
				+ region2DepthName + ", coverImage=" + coverImage + ", categoryName=" + categoryName + "]";
	}
}
