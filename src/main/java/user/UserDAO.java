package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.GetConnection;
import common.SecurityUtil;

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

	// 로그인 시 아이디, 비밀번호 확인
//	public UserVO validateUser(String id, String password) {
//		UserVO userVO = null;
//	    try {
//	        conn = GetConnection.getConn();
//	        System.out.println("Database connection: " + (conn != null ? "Successful" : "Failed"));
//
//	        sql = "SELECT * FROM users2 WHERE id = ?";
//	        System.out.println("Executing query: " + sql);
//	        
//	        pstmt = conn.prepareStatement(sql);
//	        pstmt.setString(1, id);
//	        rs = pstmt.executeQuery();
//	        
//	        System.out.println("Query executed with ID: " + id);
//	        
//	        if (rs.next()) {
//	            String storedPassword = rs.getString("password");
//	            String salt = storedPassword.substring(0, 8);
//	            SecurityUtil security = new SecurityUtil();
//	            String hashedPassword = security.encryptSHA256(salt + password);
//	            
//	            System.out.println("Stored password: " + storedPassword);
//	            System.out.println("Computed hash: " + hashedPassword);
//	            
//	            if (storedPassword.equals(salt + hashedPassword)) {
//	                userVO = new UserVO();
//	                userVO.setUserIdx(rs.getInt("userIdx"));
//	                userVO.setId(rs.getString("id"));
//	                userVO.setPassword(storedPassword);
//	                userVO.setNickname(rs.getString("nickname"));
//	                userVO.setName(rs.getString("name"));
//	                userVO.setEmail(rs.getString("email"));
//	                userVO.setRole(rs.getString("role"));
//	                userVO.setIntroduction(rs.getString("introduction"));
//	                userVO.setCreatedAt(rs.getTimestamp("createdAt"));
//	                userVO.setUpdatedAt(rs.getTimestamp("updatedAt"));
//	                userVO.setProfileImage(rs.getString("profile_image"));
//	                userVO.setVisibility(rs.getString("visibility"));
//	            } else {
//	                System.out.println("Password does not match.");
//	            }
//	        } else {
//	            System.out.println("No user found with the provided ID.");
//	        }
//	    } catch (SQLException e) {
//	        System.out.println("SQL 오류 : " + e.getMessage());
//	    } finally {
//	        try {
//	            if (rs != null) rs.close();
//	            if (pstmt != null) pstmt.close();
//	            if (conn != null) conn.close();
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	        }
//	    }
//	    return userVO;
//	}

//	public UserVO validateUser(String id, String password) {
//	    UserVO userVO = null;
//	    try {
//	        sql = "SELECT * FROM users2 WHERE id = ? AND password = ?";
//	        pstmt = conn.prepareStatement(sql);
//	        pstmt.setString(1, id);
//	        pstmt.setString(2, password);
//	        rs = pstmt.executeQuery();
//	        if (rs.next()) {
//	        	userVO = new UserVO();
//	        	userVO.setUserIdx(rs.getInt("userIdx"));
//	        	userVO.setId(rs.getString("id"));
//	        	userVO.setPassword(rs.getString("password"));
//	        	userVO.setNickname(rs.getString("nickname"));
//	        	userVO.setName(rs.getString("name"));
//	        	userVO.setEmail(rs.getString("email"));
//	        	userVO.setRole(rs.getString("role"));
//	        	userVO.setIntroduction(rs.getString("introduction"));
//	        	userVO.setCreatedAt(rs.getTimestamp("createdAt"));
//	            userVO.setUpdatedAt(rs.getTimestamp("updatedAt"));
//	            userVO.setProfileImage(rs.getString("profileImage"));
//	            userVO.setVisibility(rs.getString("visibility"));
//	        }
//	    } catch (SQLException e) {
//	    	System.out.println("SQL 오류 : " + e.getMessage());
//	    } finally {
//	        rsClose();
//	    }
//	    return userVO;
//	}
	
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
}
