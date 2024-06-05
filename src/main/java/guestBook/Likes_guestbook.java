package guestBook;

public class Likes_guestbook {
	private int likeIdx;
	private int userIdx;
	private int guestBookIdx;

	public int getLikeIdx() {
		return likeIdx;
	}

	public void setLikeIdx(int likeIdx) {
		this.likeIdx = likeIdx;
	}

	public int getUserIdx() {
		return userIdx;
	}

	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}

	public int getGuestBookIdx() {
		return guestBookIdx;
	}

	public void setGuestBookIdx(int guestBookIdx) {
		this.guestBookIdx = guestBookIdx;
	}

	@Override
	public String toString() {
		return "Likes_guestbook [likeIdx=" + likeIdx + ", userIdx=" + userIdx + ", guestBookIdx=" + guestBookIdx + "]";
	}
}
