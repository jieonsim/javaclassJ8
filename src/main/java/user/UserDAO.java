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

	public void pstmtClose(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// userIdx로 정보 조회
	public UserVO getUserByIdx(int userIdx) {
		UserVO userVO = null;
		try {
			sql = "SELECT * FROM users2 WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
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
			System.out.println("getUserByIdx SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return userVO;
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
			System.out.println("insertUser SQL 오류 : " + e.getMessage());
		}
		return result;
	}

	// 아이디 중복 확인 - 회원가입
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
			System.out.println("checkIdDuplicated SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return isDuplicated;
	}

	// 닉네임 중복 확인 - 회원가입
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
			System.out.println("checkNicknameDuplicated SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return isDuplicated;
	}

	// 이메일 중복 확인 - 회원가입
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
			System.out.println("checkEmailDuplicated SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return isDuplicated;
	}

	// 아이디로 계정 유무 조회 - 로그인
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
			System.out.println("validateUser SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return userVO;
	}

	// 이름 + 이메일로 계정 확인 - 아이디 찾기
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
			System.out.println("findUserIdByNameAndEmail SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return userVO;
	}

	// 아이디 + 이메일로 계정 확인 - 비밀번호 찾기
	public boolean checkUserByIdAndEmail(String id, String email) {
		boolean exists = false;
		try {
			sql = "SELECT COUNT(*) FROM users2 WHERE id = ? AND email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				exists = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.out.println("checkUserByIdAndEmail SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return exists;
	}

	// 아이디로 기존 비밀번호 조회 - 비밀번호 재설정 시 기존 비밀번호와 입력한 신규 비밀번호가 동일한지 확인
	public String getPasswordById(String id) {
		String storedPassword = null;
		try {
			sql = "SELECT password FROM users2 WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				storedPassword = rs.getString("password");
			}
		} catch (SQLException e) {
			System.out.println("getPasswordById SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return storedPassword;
	}

	// 신규 비밀번호 재설정 - 비밀번호 찾기 > 비밀번호 재설정
	public boolean updatePasswordById(String id, String storedPassword) {
		boolean isUpdated = false;
		try {
			sql = "UPDATE users2 SET password = ? WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, storedPassword);
			pstmt.setString(2, id);
			int rowsAffected = pstmt.executeUpdate();
			if (rowsAffected > 0) {
				isUpdated = true;
			}
		} catch (SQLException e) {
			System.out.println("updatePasswordById SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return isUpdated;
	}

	// 프로필 수정
	public int updateProfile(UserVO userVO) {
		int result = 0;
		try {
			sql = "UPDATE users2 SET password = ?, nickname = ?, name = ?, email = ?, role = ?, introduction = ?, updatedAt = ?, profileImage = ? WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userVO.getPassword());
			pstmt.setString(2, userVO.getNickname());
			pstmt.setString(3, userVO.getName());
			pstmt.setString(4, userVO.getEmail());
			pstmt.setString(5, userVO.getRole());
			pstmt.setString(6, userVO.getIntroduction());
			pstmt.setTimestamp(7, userVO.getUpdatedAt());
			pstmt.setString(8, userVO.getProfileImage());
			pstmt.setInt(9, userVO.getUserIdx());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateProfile SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return result;
	}

	// 유저가 작성한 로컬로그가 있는지 확인하는 메서드
	public boolean checkUserLocalLogs(int userIdx) {
		boolean result = false;
		try {
			sql = "SELECT COUNT(*) FROM localLogs WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.out.println("checkUserLocalLogs SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return result;
	}

	// 유저가 작성한 방명록이 있는지 확인하는 메서드
	public boolean checkUserGuestBooks(int userIdx) {
		boolean result = false;
		try {
			sql = "SELECT COUNT(*) FROM guestBooks WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.out.println("checkUserGuestBooks SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return result;
	}

	// 유저의 모든 로컬로그를 비공개로 전환하는 메서드
	public void updateLocalLogsVisibilityToPrivate(int userIdx) {
		try {
			sql = "UPDATE localLogs SET visibility = 'private' WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateLocalLogsVisibilityToPrivate SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 유저의 모든 방명록을 비공개로 전환하는 메서드
	public void updateGuestBooksVisibilityToPrivate(int userIdx) {
		try {
			sql = "UPDATE guestBooks SET visibility = 'private' WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateLocalLogsVisibilityToPrivate SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 유저 계정 비공개 전환
	public void updateUserVisibilityToPrivate(int userIdx) {
		try {
			sql = "UPDATE users2 SET visibility = 'private' WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateUserVisibilityToPrivate SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	public void updateLocalLogsVisibilityToPublic(int userIdx) {
		try {
			sql = "UPDATE localLogs SET visibility = 'public' WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateLocalLogsVisibilityToPublic SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	public void updateGuestBooksVisibilityToPublic(int userIdx) {
		try {
			sql = "UPDATE guestBooks SET visibility = 'public' WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateGuestBooksVisibilityToPublic SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 유저 계정 공개 전환
	public void updateUserVisibilityToPublic(int userIdx) {
		try {
			sql = "UPDATE users2 SET visibility = 'public' WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateUserVisibilityToPublic SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	public boolean deleteUserContentAndAccount(int userIdx) {
		// TODO Auto-generated method stub
		return false;
	}

//	public boolean deleteUserContentAndAccount(int userIdx) {
//		PreparedStatement pstmt1 = null;
//		PreparedStatement pstmt2 = null;
//
//		try {
//			conn.setAutoCommit(false); // 트랜잭션 시작
//
//			// 1. 유저의 모든 컨텐츠 삭제
//			String deleteGuestBooks = "DELETE FROM guestBooks WHERE userIdx = ?";
//			String deleteLocalLogs = "DELETE FROM localLogs WHERE userIdx = ?";
//			String deleteBookmarks = "DELETE FROM bookmarks WHERE userIdx = ?";
//			String deleteLikesLocalLog = "DELETE FROM likes_localLog WHERE userIdx = ?";
//			String deleteLikesGuestBook = "DELETE FROM likes_guestBook WHERE userIdx = ?";
//
//			pstmt1 = conn.prepareStatement(deleteGuestBooks);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmt1.close();
//
//			pstmt1 = conn.prepareStatement(deleteLocalLogs);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmt1.close();
//
//			pstmt1 = conn.prepareStatement(deleteBookmarks);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmt1.close();
//
//			pstmt1 = conn.prepareStatement(deleteLikesLocalLog);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmt1.close();
//
//			pstmt1 = conn.prepareStatement(deleteLikesGuestBook);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmt1.close();
//
//			// 2. 장소의 createdBy를 NULL로 업데이트
//			String updatePlaces = "UPDATE places SET createdBy = NULL WHERE createdBy = ?";
//			pstmt2 = conn.prepareStatement(updatePlaces);
//			pstmt2.setInt(1, userIdx);
//			pstmt2.executeUpdate();
//			pstmt2.close();
//
//			// 3. 유저 삭제
//			String deleteUser = "DELETE FROM users2 WHERE userIdx = ?";
//			pstmt2 = conn.prepareStatement(deleteUser);
//			pstmt2.setInt(1, userIdx);
//			pstmt2.executeUpdate();
//			pstmt2.close();
//
//			conn.commit(); // 트랜잭션 커밋
//			return true;
//
//		} catch (SQLException e) {
//			System.out.println("deleteUserContentAndAccount SQL 오류 : " + e.getMessage());
//			if (conn != null) {
//				try {
//					conn.rollback(); // 오류 발생 시 롤백
//				} catch (SQLException ex) {
//					ex.printStackTrace();
//				}
//			}
//			return false;
//		} finally {
//			if (pstmt1 != null)
//				try {
//					pstmt1.close();
//				} catch (SQLException e) {
//					System.out.println("deleteUserContentAndAccount pstmt1 SQL 오류 : " + e.getMessage());
//				}
//			if (pstmt2 != null)
//				try {
//					pstmt2.close();
//				} catch (SQLException e) {
//					System.out.println("deleteUserContentAndAccount pstmt2 SQL 오류 : " + e.getMessage());
//				}
//			if (conn != null)
//				try {
//					conn.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//		}
//	}
//	public boolean deleteUserContentAndAccount(int userIdx) {
//		Connection conn = null;
//		PreparedStatement pstmt1 = null;
//		PreparedStatement pstmt2 = null;
//
//		try {
//			conn = GetConnection.getConn(); // 연결 객체 초기화
//			conn.setAutoCommit(false); // 트랜잭션 시작
//
//			// 1. 유저의 모든 컨텐츠 삭제
//			String deleteGuestBooks = "DELETE FROM guestBooks WHERE userIdx = ?";
//			String deleteLocalLogs = "DELETE FROM localLogs WHERE userIdx = ?";
//			String deleteBookmarks = "DELETE FROM bookmarks WHERE userIdx = ?";
//			String deleteLikesLocalLog = "DELETE FROM likes_localLog WHERE userIdx = ?";
//			String deleteLikesGuestBook = "DELETE FROM likes_guestBook WHERE userIdx = ?";
//
//			pstmt1 = conn.prepareStatement(deleteGuestBooks);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmtClose(pstmt1);
//
//			pstmt1 = conn.prepareStatement(deleteLocalLogs);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmtClose(pstmt1);
//
//			pstmt1 = conn.prepareStatement(deleteBookmarks);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmtClose(pstmt1);
//
//			pstmt1 = conn.prepareStatement(deleteLikesLocalLog);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmtClose(pstmt1);
//
//			pstmt1 = conn.prepareStatement(deleteLikesGuestBook);
//			pstmt1.setInt(1, userIdx);
//			pstmt1.executeUpdate();
//			pstmtClose(pstmt1);
//
//			// 2. 장소의 createdBy를 NULL로 업데이트
//			String updatePlaces = "UPDATE places SET createdBy = NULL WHERE createdBy = ?";
//			pstmt2 = conn.prepareStatement(updatePlaces);
//			pstmt2.setInt(1, userIdx);
//			pstmt2.executeUpdate();
//			pstmtClose(pstmt2);
//
//			// 3. 유저 삭제
//			String deleteUser = "DELETE FROM users2 WHERE userIdx = ?";
//			pstmt2 = conn.prepareStatement(deleteUser);
//			pstmt2.setInt(1, userIdx);
//			pstmt2.executeUpdate();
//			pstmtClose(pstmt2);
//
//			conn.commit(); // 트랜잭션 커밋
//			return true;
//
//		} catch (SQLException e) {
//			System.out.println("deleteUserContentAndAccount SQL 오류 : " + e.getMessage());
//			if (conn != null) {
//				try {
//					conn.rollback(); // 오류 발생 시 롤백
//				} catch (SQLException ex) {
//					ex.printStackTrace();
//				}
//			}
//			return false;
//		} finally {
//			if (pstmt1 != null)
//				try {
//					pstmt1.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			if (pstmt2 != null)
//				try {
//					pstmt2.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			if (conn != null)
//				try {
//					conn.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//		}
//	}
}