package user;

import java.sql.Timestamp;

public class UserVO {
	private int userIdx;
	private String id;
	private String password;
	private String nickname;
	private String name;
	private String email;
	private String role;
	private String introduction;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private String profileImage;
	private String visibility;

	// 기본 생성자
	public UserVO() {
	}

	// Getters and setters
	public int getUserIdx() {
		return userIdx;
	}

	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
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

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getVisibility() {
		return visibility;
	}

	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}

	// toString
	@Override
	public String toString() {
		return "UserVO [userIdx=" + userIdx + ", id=" + id + ", password=" + password + ", nickname=" + nickname + ", name=" + name + ", email=" + email
				+ ", role=" + role + ", introduction=" + introduction + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", profileImage="
				+ profileImage + ", visibility=" + visibility + "]";
	}

}
