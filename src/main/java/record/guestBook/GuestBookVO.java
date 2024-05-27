package record.guestBook;

import java.sql.Timestamp;

public class GuestBookVO {
	private int guestBookIdx;
	private int userIdx;
	private int placeIdx;
	private String visitDate;
	private String content;
	private String companions;
	private String visibility;
	private Timestamp createdAt;
	private String hostIp;

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

	public String getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(String visitDate) {
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

	public String getHostIp() {
		return hostIp;
	}

	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}

	@Override
	public String toString() {
		return "GuestBookVO [guestBookIdx=" + guestBookIdx + ", userIdx=" + userIdx + ", placeIdx=" + placeIdx + ", visitDate=" + visitDate + ", content="
				+ content + ", companions=" + companions + ", visibility=" + visibility + ", createdAt=" + createdAt + ", hostIp=" + hostIp + "]";
	}

}
