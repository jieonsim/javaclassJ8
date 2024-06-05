package guestBook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.GetConnection;

public class GuestBookDAO {
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

	// 방명록 작성
	public int saveGuestBook(GuestBookVO guestBookVO) {
		int result = 0;
		try {
			sql = "INSERT INTO guestBooks (userIdx, placeIdx, visitDate, content, companions, visibility, hostIp) VALUES (?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookVO.getUserIdx());
			pstmt.setInt(2, guestBookVO.getPlaceIdx());
			pstmt.setDate(3, guestBookVO.getVisitDate());
			pstmt.setString(4, guestBookVO.getContent());
			pstmt.setString(5, guestBookVO.getCompanions());
			pstmt.setString(6, guestBookVO.getVisibility());
			pstmt.setString(7, guestBookVO.getHostIp());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("saveGuestBook SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return result;
	}

	// userIdx로 해당 userIdx에 등록된 방명록 데이터 가져오기 / 아카이브-방명록
	public List<GuestBookVO> getGuestBooksByUserIdx(int userIdx, int startIndexNo, int pageSize) {
		List<GuestBookVO> guestBooks = new ArrayList<>();
		try {
//			sql = "SELECT gb.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " + "FROM guestBooks gb " + "JOIN places p ON gb.placeIdx = p.placeIdx "
//					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "WHERE gb.userIdx = ? " + "ORDER BY gb.createdAt DESC " + "LIMIT ?, ?";
			sql = "SELECT gb.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName, " +
                    "(SELECT COUNT(*) FROM likes_guestBook lg WHERE lg.guestBookIdx = gb.guestBookIdx) AS likeCount " +
                    "FROM guestBooks gb " +
                    "JOIN places p ON gb.placeIdx = p.placeIdx " +
                    "JOIN categories c ON p.categoryIdx = c.categoryIdx " +
                    "WHERE gb.userIdx = ? " +
                    "ORDER BY gb.createdAt DESC " +
                    "LIMIT ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				GuestBookVO guestBook = new GuestBookVO();
				guestBook.setGuestBookIdx(rs.getInt("guestBookIdx"));
				guestBook.setUserIdx(rs.getInt("userIdx"));
				guestBook.setPlaceIdx(rs.getInt("placeIdx"));
				guestBook.setVisitDate(rs.getDate("visitDate"));
				guestBook.setContent(rs.getString("content"));
				guestBook.setCompanions(rs.getString("companions"));
				guestBook.setVisibility(rs.getString("visibility"));
				guestBook.setCreatedAt(rs.getTimestamp("createdAt"));
				guestBook.setUpdatedAt(rs.getTimestamp("updatedAt"));
				guestBook.setHostIp(rs.getString("hostIp"));
				guestBook.setPlaceName(rs.getString("placeName"));
				guestBook.setRegion1DepthName(rs.getString("region1DepthName"));
				guestBook.setRegion2DepthName(rs.getString("region2DepthName"));
				guestBook.setCategoryName(rs.getString("categoryName"));
				guestBook.setLikeCount(rs.getInt("likeCount"));

				guestBooks.add(guestBook);
			}
		} catch (SQLException e) {
			System.out.println("getGuestBooksByUserIdx SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return guestBooks;
	}

	// 아카이브에서 본인 방명록 삭제
	public boolean deleteGuestBook(int guestBookIdx, int userIdx) {
		boolean result = false;
		try {
			sql = "DELETE FROM guestBooks WHERE guestBookIdx = ? AND userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookIdx);
			pstmt.setInt(2, userIdx);

			int rowCount = pstmt.executeUpdate();
			if (rowCount > 0) {
				result = true;
			}
		} catch (SQLException e) {
			System.out.println("deleteGuestBook SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return result;
	}

	// 방명록 전체공개/비공개 토글 처리
	public boolean toggleVisibility(int guestBookIdx, String visibility) {
		try {
			sql = "UPDATE guestBooks SET visibility = ? WHERE guestBookIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, visibility);
			pstmt.setInt(2, guestBookIdx);

			int result = pstmt.executeUpdate();
			return result == 1;
		} catch (SQLException e) {
			System.out.println("toggleVisibility SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return false;
	}

	// 본인 아카이브 - 방명록 메뉴 접속 시 방명록 개수 보여주기
	public int getGuestBookCountByUserIdx(int userIdx) {
		int count = 0;
		try {
			sql = "SELECT COUNT(*) FROM guestBooks WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("getGuestBookCountByUserIdx SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return count;
	}

	// 로컬로그 디테일에 방명록 뿌리기
	public List<GuestBookVO> getGuestBooksByPlaceIdx(int placeIdx) {
		List<GuestBookVO> guestBooks = new ArrayList<>();
		try {
			sql = "SELECT gb.guestBookIdx, gb.userIdx, gb.placeIdx, gb.content, gb.visitDate, gb.visibility, " + "u.nickname, u.profileImage "
					+ "FROM guestBooks gb " + "JOIN users2 u ON gb.userIdx = u.userIdx " + "WHERE gb.placeIdx = ? AND gb.visibility = 'public'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, placeIdx);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				GuestBookVO guestBook = new GuestBookVO();
				guestBook.setGuestBookIdx(rs.getInt("guestBookIdx"));
				guestBook.setUserIdx(rs.getInt("userIdx"));
				guestBook.setPlaceIdx(rs.getInt("placeIdx"));
				guestBook.setContent(rs.getString("content"));
				guestBook.setVisitDate(rs.getDate("visitDate"));
				guestBook.setVisibility(rs.getString("visibility"));
				guestBook.setNickname(rs.getString("nickname"));
				guestBook.setProfileImage(rs.getString("profileImage"));
				guestBooks.add(guestBook);
			}
		} catch (Exception e) {
			System.out.println("getGuestBooksByPlaceIdx SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return guestBooks;
	}


	public boolean isLikedByUser(int guestBookIdx, int userIdx) {
		boolean result = false;
		try {
			sql = "SELECT COUNT(*) FROM likes_guestBook WHERE guestBookIdx = ? AND userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookIdx);
			pstmt.setInt(2, userIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.out.println("isLikedByUser SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return result;
	}

	public void addLike(int guestBookIdx, int userIdx) {
		try {
			sql = "INSERT INTO likes_guestBook (guestBookIdx, userIdx) VALUES (?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookIdx);
			pstmt.setInt(2, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("addLike SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	public void removeLike(int guestBookIdx, int userIdx) {
		try {
			sql = "DELETE FROM likes_guestBook WHERE guestBookIdx = ? AND userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookIdx);
			pstmt.setInt(2, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("removeLike SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	public int getLikeCount(int guestBookIdx) {
		int likeCount = 0;
		try {
			sql = "SELECT COUNT(*) FROM likes_guestBook WHERE guestBookIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				likeCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("getLikeCount SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return likeCount;
	}

	public GuestBookVO getGuestBookByGuestBookIdx(int guestBookIdx) {
		GuestBookVO guestBook = null;
		try {
			sql = "SELECT * FROM guestBooks WHERE guestBookIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				guestBook = new GuestBookVO();
				guestBook.setGuestBookIdx(rs.getInt("guestBookIdx"));
				guestBook.setUserIdx(rs.getInt("userIdx"));
				guestBook.setPlaceIdx(rs.getInt("placeIdx"));
				guestBook.setVisitDate(rs.getDate("visitDate"));
				guestBook.setContent(rs.getString("content"));
				guestBook.setCompanions(rs.getString("companions"));
				guestBook.setVisibility(rs.getString("visibility"));
				guestBook.setCreatedAt(rs.getTimestamp("createdAt"));
				guestBook.setUpdatedAt(rs.getTimestamp("updatedAt"));
				guestBook.setHostIp(rs.getString("hostIp"));
			}
		} catch (SQLException e) {
			System.out.println("getGuestBookByGuestBookIdx SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return guestBook;
	}

	// 로컬로그 디테일 내 방명록 좋아요를 위한 메소드
	public List<GuestBookVO> getGuestBooksByPlaceIdx(int placeIdx, int sessionUserIdx) {
	    List<GuestBookVO> guestBooks = new ArrayList<>();
	    try {
	    	sql = "SELECT gb.guestBookIdx, gb.userIdx, gb.placeIdx, gb.content, gb.visitDate, gb.visibility, " +
                    "u.nickname, u.profileImage, " +
                    "(SELECT COUNT(*) FROM likes_guestBook lg WHERE lg.guestBookIdx = gb.guestBookIdx AND lg.userIdx = ?) AS likedByUser, " +
                    "(SELECT COUNT(*) FROM likes_guestBook lg WHERE lg.guestBookIdx = gb.guestBookIdx) AS likeCount " +
                    "FROM guestBooks gb " +
                    "JOIN users2 u ON gb.userIdx = u.userIdx " +
                    "WHERE gb.placeIdx = ? AND gb.visibility = 'public'";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, sessionUserIdx);
	        pstmt.setInt(2, placeIdx);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            GuestBookVO guestBook = new GuestBookVO();
	            guestBook.setGuestBookIdx(rs.getInt("guestBookIdx"));
	            guestBook.setUserIdx(rs.getInt("userIdx"));
	            guestBook.setPlaceIdx(rs.getInt("placeIdx"));
	            guestBook.setContent(rs.getString("content"));
	            guestBook.setVisitDate(rs.getDate("visitDate"));
	            guestBook.setVisibility(rs.getString("visibility"));
	            guestBook.setNickname(rs.getString("nickname"));
	            guestBook.setProfileImage(rs.getString("profileImage"));
	            guestBook.setLikedByUser(rs.getInt("likedByUser") > 0);
	            guestBook.setLikeCount(rs.getInt("likeCount"));
	            guestBooks.add(guestBook);
	        }
	    } catch (Exception e) {
	        System.out.println("getGuestBooksByPlaceIdx SQL 오류 : " + e.getMessage());
	    } finally {
	        rsClose();
	    }
	    return guestBooks;
	}
}