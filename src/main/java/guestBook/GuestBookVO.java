package guestBook;

import java.sql.Date;
import java.sql.Timestamp;

public class GuestBookVO {
	private int guestBookIdx;
	private int userIdx;
	private int placeIdx;
	private Date visitDate;
	private String content;
	private String companions;
	private String visibility;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private String hostIp;

	// 필드 추가
	private String placeName;
	private String region1DepthName;
	private String region2DepthName;
	private String categoryName;
	private String nickname;
	private String profileImage;
	private int likeIdx;
	private boolean isLikedByUser;
	private int likeCount;

	public int getGuestBookIdx() {
		return guestBookIdx;
	}

	public void setGuestBookIdx(int guestBookIdx) {
		this.guestBookIdx = guestBookIdx;
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

	public Date getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(Date visitDate) {
		this.visitDate = visitDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCompanions() {
		return companions;
	}

	public void setCompanions(String companions) {
		this.companions = companions;
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

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public int getLikeIdx() {
		return likeIdx;
	}

	public void setLikeIdx(int likeIdx) {
		this.likeIdx = likeIdx;
	}

	public boolean isLikedByUser() {
		return isLikedByUser;
	}

	public void setLikedByUser(boolean isLikedByUser) {
		this.isLikedByUser = isLikedByUser;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	@Override
	public String toString() {
		return "GuestBookVO [guestBookIdx=" + guestBookIdx + ", userIdx=" + userIdx + ", placeIdx=" + placeIdx + ", visitDate=" + visitDate + ", content="
				+ content + ", companions=" + companions + ", visibility=" + visibility + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", hostIp="
				+ hostIp + ", placeName=" + placeName + ", region1DepthName=" + region1DepthName + ", region2DepthName=" + region2DepthName + ", categoryName="
				+ categoryName + ", nickname=" + nickname + ", profileImage=" + profileImage + ", likeIdx=" + likeIdx + ", isLikedByUser=" + isLikedByUser
				+ ", likeCount=" + likeCount + "]";
	}
}
