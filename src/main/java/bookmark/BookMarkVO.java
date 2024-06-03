package bookmark;

import java.sql.Timestamp;

public class BookMarkVO {
	private int bookMarkIdx;
	private int userIdx;
	private int localLogIdx;
	private Timestamp createdAt;

	public int getBookMarkIdx() {
		return bookMarkIdx;
	}

	public void setBookMarkIdx(int bookMarkIdx) {
		this.bookMarkIdx = bookMarkIdx;
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

	@Override
	public String toString() {
		return "BookMarkVO [bookMarkIdx=" + bookMarkIdx + ", userIdx=" + userIdx + ", localLogIdx=" + localLogIdx + ", createdAt=" + createdAt + "]";
	}
}
