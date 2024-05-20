package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.GetConnection;

public class UserDAO {

    private Connection conn = GetConnection.getConn();
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private String sql = "";

    // Close PreparedStatement
    public void pstmtClose() {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Close ResultSet
    public void rsClose() {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                pstmtClose();
            }
        }
    }

    // 회원가입
    public int insertUser(UserVO userVO) {
        int result = 0;
        String sql = "INSERT INTO users2 (id, password, nickname, name, email) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userVO.getId());
            pstmt.setString(2, userVO.getPassword());
            pstmt.setString(3, userVO.getNickname());
            pstmt.setString(4, userVO.getName());
            pstmt.setString(5, userVO.getEmail());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("SQL 오류 : " + e.getMessage());
        }
        return result;
    }

    // Read
    public UserVO getUserById(int userIdx) {
        UserVO user = null;
        sql = "SELECT * FROM users WHERE userIdx = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userIdx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new UserVO(
                    rs.getInt("userIdx"),
                    rs.getString("id"),
                    rs.getString("password"),
                    rs.getString("nickname"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("role"),
                    rs.getString("introduction"),
                    rs.getTimestamp("createdAt"),
                    rs.getTimestamp("updatedAt"),
                    rs.getString("profileImage")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            rsClose();
        }
        return user;
    }

    // Update
    public int updateUser(UserVO user) {
        int result = 0;
        sql = "UPDATE users SET id = ?, password = ?, nickname = ?, name = ?, email = ?, role = ?, introduction = ?, updatedAt = ?, profileImage = ? WHERE userIdx = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getId());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getNickname());
            pstmt.setString(4, user.getName());
            pstmt.setString(5, user.getEmail());
            pstmt.setString(6, user.getRole());
            pstmt.setString(7, user.getIntroduction());
            pstmt.setTimestamp(8, user.getUpdatedAt());
            pstmt.setString(9, user.getProfileImage());
            pstmt.setInt(10, user.getUserIdx());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pstmtClose();
        }
        return result;
    }

    // Delete
    public int deleteUser(int userIdx) {
        int result = 0;
        sql = "DELETE FROM users WHERE userIdx = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userIdx);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pstmtClose();
        }
        return result;
    }
}
