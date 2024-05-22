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

	public void pstmtClose() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

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

	// 아이디 중복 확인
	public boolean checkIdDuplicated(String id) {
		boolean isDuplicated = false;
		try {
			sql = "SELECT COUNT(*) FROM users2 WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isDuplicated = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return isDuplicated;
	}

	// 닉네임 중복 확인
	public boolean checkNicknameDuplicated(String nickname) {
		boolean isDuplicated = false;
		try {
			sql = "SELECT COUNT(*) FROM users2 WHERE nickname = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isDuplicated = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return isDuplicated;
	}

	// 이메일 중복 확인
	public boolean checkEmailDuplicated(String email) {
		boolean isDuplicated = false;
		try {
			sql = "SELECT COUNT(*) FROM users2 WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				isDuplicated = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return isDuplicated;
	}

	// 아이디(계정 존재 유무) 조회
	public UserVO validateUser(String id) {
		UserVO userVO = null;
		try {
			sql = "SELECT * FROM users2 WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userVO = new UserVO();
				userVO.setUserIdx(rs.getInt("userIdx"));
				userVO.setId(rs.getString("id"));
				userVO.setPassword(rs.getString("password"));
				userVO.setNickname(rs.getString("nickname"));
				userVO.setName(rs.getString("name"));
				userVO.setEmail(rs.getString("email"));
				userVO.setRole(rs.getString("role"));
				userVO.setIntroduction(rs.getString("introduction"));
				userVO.setCreatedAt(rs.getTimestamp("createdAt"));
				userVO.setUpdatedAt(rs.getTimestamp("updatedAt"));
				userVO.setProfileImage(rs.getString("profileImage"));
				userVO.setVisibility(rs.getString("visibility"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return userVO;
	}

	// 아이디 찾기
	public UserVO findUserIdByNameAndEmail(String name, String email) {
		UserVO userVO = null;
		try {
			sql = "SELECT * FROM users2 WHERE name = ? AND email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userVO = new UserVO();
				userVO.setUserIdx(rs.getInt("userIdx"));
				userVO.setId(rs.getString("id"));
				userVO.setPassword(rs.getString("password"));
				userVO.setNickname(rs.getString("nickname"));
				userVO.setName(rs.getString("name"));
				userVO.setEmail(rs.getString("email"));
				userVO.setRole(rs.getString("role"));
				userVO.setIntroduction(rs.getString("introduction"));
				userVO.setCreatedAt(rs.getTimestamp("createdAt"));
				userVO.setUpdatedAt(rs.getTimestamp("updatedAt"));
				userVO.setProfileImage(rs.getString("profileImage"));
				userVO.setVisibility(rs.getString("visibility"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return userVO;
	}
}
