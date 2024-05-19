package user;

import java.sql.Timestamp;
import java.util.Objects;

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

    // 기본 생성자
    public UserVO() {
    }

    // 매개변수 생성
    public UserVO(int userIdx, String id, String password, String nickname, String name, String email, String role, String introduction, Timestamp createdAt, Timestamp updatedAt, String profileImage) {
        this.userIdx = userIdx;
        this.id = id;
        this.password = password;
        this.nickname = nickname;
        this.name = name;
        this.email = email;
        this.role = role;
        this.introduction = introduction;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.profileImage = profileImage;
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

    // toString method
    @Override
    public String toString() {
        return "UserVO{" +
                "userIdx=" + userIdx +
                ", id='" + id + '\'' +
                ", password='" + password + '\'' +
                ", nickname='" + nickname + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                ", introduction='" + introduction + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", profileImage='" + profileImage + '\'' +
                '}';
    }

    // equals and hashCode methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserVO userVO = (UserVO) o;
        return userIdx == userVO.userIdx &&
                Objects.equals(id, userVO.id) &&
                Objects.equals(password, userVO.password) &&
                Objects.equals(nickname, userVO.nickname) &&
                Objects.equals(name, userVO.name) &&
                Objects.equals(email, userVO.email) &&
                Objects.equals(role, userVO.role) &&
                Objects.equals(introduction, userVO.introduction) &&
                Objects.equals(createdAt, userVO.createdAt) &&
                Objects.equals(updatedAt, userVO.updatedAt) &&
                Objects.equals(profileImage, userVO.profileImage);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userIdx, id, password, nickname, name, email, role, introduction, createdAt, updatedAt, profileImage);
    }
}
