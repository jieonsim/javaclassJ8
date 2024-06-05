package localLog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import common.GetConnection;

public class LocalLogDAO {
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

	public void saveLocalLog(LocalLogVO localLogVO) {
		try {
			sql = "INSERT INTO localLogs (userIdx, placeIdx, content, photos, visitDate, community, visibility, hostIp) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogVO.getUserIdx());
			pstmt.setInt(2, localLogVO.getPlaceIdx());
			pstmt.setString(3, localLogVO.getContent());
			pstmt.setString(4, localLogVO.getPhotos());
			pstmt.setDate(5, localLogVO.getVisitDate());
			pstmt.setString(6, localLogVO.getCommunity());
			pstmt.setString(7, localLogVO.getVisibility());
			pstmt.setString(8, localLogVO.getHostIp());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("saveLocalLog SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// userIdx로 해당 userIdx에 등록된 로컬로그 개수 가져오기 / 아카이브-로컬로그
	public int getLocalLogCountByUserIdx(int userIdx) {
		int count = 0;
		try {
			sql = "SELECT COUNT(*) FROM localLogs WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogCountByUserIdx SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return count;
	}

	// userIdx로 해당 userIdx에 등록된 로컬로그 데이터 가져오기 / 아카이브-로컬로그
	public List<LocalLogVO> getLocalLogsByUserIdx(int userIdx, int startIndexNo, int pageSize) {
		List<LocalLogVO> localLogs = new ArrayList<>();
		try {
			sql = "SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " + "FROM localLogs ll " + "JOIN places p ON ll.placeIdx = p.placeIdx "
					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "WHERE ll.userIdx = ? " + "ORDER BY ll.visitDate DESC " + "LIMIT ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				LocalLogVO localLog = new LocalLogVO();
				localLog.setLocalLogIdx(rs.getInt("localLogIdx"));
				localLog.setUserIdx(rs.getInt("userIdx"));
				localLog.setPlaceIdx(rs.getInt("placeIdx"));
				localLog.setContent(rs.getString("content"));
				localLog.setPhotos(rs.getString("photos"));
				localLog.setVisitDate(rs.getDate("visitDate"));
				localLog.setCommunity(rs.getString("community"));
				localLog.setVisibility(rs.getString("visibility"));
				localLog.setCreatedAt(rs.getTimestamp("createdAt"));
				localLog.setUpdatedAt(rs.getTimestamp("updatedAt"));
				localLog.setHostIp(rs.getString("hostIp"));
				localLog.setPlaceName(rs.getString("placeName"));
				localLog.setRegion1DepthName(rs.getString("region1DepthName"));
				localLog.setRegion2DepthName(rs.getString("region2DepthName"));
				localLog.setCategoryName(rs.getString("categoryName"));

				// 커버 이미지를 설정합니다.
				String[] photoArray = rs.getString("photos").split("/");
				if (photoArray.length > 0) {
					localLog.setCoverImage(photoArray[0]);
				}

				localLogs.add(localLog);
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogsByUserIdx SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return localLogs;
	}

	// 로컬로그 디테일에서 게시글 하나씩 상세보기
	public LocalLogVO getLocalLogByIdx(int localLogIdx) {
		LocalLogVO localLog = null;
		try {
			sql = "SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " + "FROM localLogs ll " + "JOIN places p ON ll.placeIdx = p.placeIdx "
					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "WHERE ll.localLogIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogIdx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				localLog = new LocalLogVO();
				localLog.setLocalLogIdx(rs.getInt("localLogIdx"));
				localLog.setUserIdx(rs.getInt("userIdx"));
				localLog.setPlaceIdx(rs.getInt("placeIdx"));
				localLog.setContent(rs.getString("content"));
				localLog.setPhotos(rs.getString("photos"));
				localLog.setVisitDate(rs.getDate("visitDate"));
				localLog.setCommunity(rs.getString("community"));
				localLog.setVisibility(rs.getString("visibility"));
				localLog.setCreatedAt(rs.getTimestamp("createdAt"));
				localLog.setUpdatedAt(rs.getTimestamp("updatedAt"));
				localLog.setHostIp(rs.getString("hostIp"));
				localLog.setPlaceName(rs.getString("placeName"));
				localLog.setRegion1DepthName(rs.getString("region1DepthName"));
				localLog.setRegion2DepthName(rs.getString("region2DepthName"));
				localLog.setCategoryName(rs.getString("categoryName"));

				// 커버 이미지를 설정합니다.
				String[] photoArray = rs.getString("photos").split("/");
				if (photoArray.length > 0) {
					localLog.setCoverImage(photoArray[0]);
				}
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogByIdx SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return localLog;
	}

	// 아카이브에서 본인 로컬로그 삭제
	public boolean deleteLocalLog(int localLogIdx, int userIdx) {
		boolean result = false;
		try {
			sql = "DELETE FROM localLogs WHERE localLogIdx = ? AND userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogIdx);
			pstmt.setInt(2, userIdx);

			int rowCount = pstmt.executeUpdate();
			if (rowCount > 0) {
				result = true;
			}
		} catch (SQLException e) {
			System.out.println("deleteLocalLog SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return result;
	}

	// 아카이브에서 본인 로컬로그 수정
	public void updateLocalLog(LocalLogVO localLogVO) {
		try {
			String sql = "UPDATE localLogs SET placeIdx=?, visitDate=?, content=?, community=?, visibility=?, photos=? WHERE localLogIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogVO.getPlaceIdx());
			pstmt.setDate(2, localLogVO.getVisitDate());
			pstmt.setString(3, localLogVO.getContent());
			pstmt.setString(4, localLogVO.getCommunity());
			pstmt.setString(5, localLogVO.getVisibility());
			pstmt.setString(6, localLogVO.getPhotos());
			pstmt.setInt(7, localLogVO.getLocalLogIdx());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateLocalLog SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 로컬로그 삭제 시 사진 데이터 삭제되기 위한
	public List<String> getLocalLogPhotos(int localLogIdx, int userIdx) {
		List<String> photoFilenames = new ArrayList<>();
		try {
			sql = "SELECT photos FROM localLogs WHERE localLogIdx = ? AND userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogIdx);
			pstmt.setInt(2, userIdx);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				String photos = rs.getString("photos");
				if (photos != null && !photos.isEmpty()) {
					photoFilenames = Arrays.asList(photos.split("/"));
				}
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogPhotos SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return photoFilenames;
	}

	// 모든 로컬로그 개수 가져오기
	public int getLocalLogCount() {
		int count = 0;
		try {
			String sql = "SELECT COUNT(*) FROM localLogs";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogCount SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return count;
	}

	// 모든 로컬로그를 무작위로 가져오기
	public List<LocalLogVO> getRandomLocalLogs(int startIndexNo, int pageSize) {
		List<LocalLogVO> localLogs = new ArrayList<>();
		try {
			String sql = "SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " + "FROM localLogs ll " + "JOIN places p ON ll.placeIdx = p.placeIdx "
					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "WHERE ll.visibility = 'public' " + "ORDER BY RAND() " + "LIMIT ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				LocalLogVO localLog = new LocalLogVO();
				localLog.setLocalLogIdx(rs.getInt("localLogIdx"));
				localLog.setUserIdx(rs.getInt("userIdx"));
				localLog.setPlaceIdx(rs.getInt("placeIdx"));
				localLog.setContent(rs.getString("content"));
				localLog.setPhotos(rs.getString("photos"));
				localLog.setVisitDate(rs.getDate("visitDate"));
				localLog.setCommunity(rs.getString("community"));
				localLog.setVisibility(rs.getString("visibility"));
				localLog.setCreatedAt(rs.getTimestamp("createdAt"));
				localLog.setUpdatedAt(rs.getTimestamp("updatedAt"));
				localLog.setHostIp(rs.getString("hostIp"));
				localLog.setPlaceName(rs.getString("placeName"));
				localLog.setRegion1DepthName(rs.getString("region1DepthName"));
				localLog.setRegion2DepthName(rs.getString("region2DepthName"));
				localLog.setCategoryName(rs.getString("categoryName"));

				// Parse the photos field into a list of URLs
				String[] photoArray = rs.getString("photos").split("/");
				localLog.setPhotoUrls(Arrays.asList(photoArray));

				localLogs.add(localLog);
			}
		} catch (SQLException e) {
			System.out.println("getRandomLocalLogs SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return localLogs;
	}

	// 검색
	public List<LocalLogVO> searchLocalLogs(String query, int startIndexNo, int pageSize) {
		List<LocalLogVO> results = new ArrayList<>();
		try {
			sql = "SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName, c.categoryType " + "FROM localLogs ll " + "JOIN places p ON ll.placeIdx = p.placeIdx "
					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "WHERE p.placeName LIKE ? OR c.categoryName LIKE ? OR p.region1DepthName LIKE ? OR p.region2DepthName LIKE ? "
					+ "OR ll.content LIKE ? OR ll.community LIKE ? OR c.categoryType LIKE ? " + "ORDER BY ll.visitDate DESC " + "LIMIT ?, ?";
			pstmt = conn.prepareStatement(sql);

			String likeQuery = "%" + query + "%";
			pstmt.setString(1, likeQuery);
			pstmt.setString(2, likeQuery);
			pstmt.setString(3, likeQuery);
			pstmt.setString(4, likeQuery);
			pstmt.setString(5, likeQuery);
			pstmt.setString(6, likeQuery);
			pstmt.setString(7, likeQuery);
			pstmt.setInt(8, startIndexNo);
			pstmt.setInt(9, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				LocalLogVO localLog = new LocalLogVO();
				localLog.setLocalLogIdx(rs.getInt("localLogIdx"));
				localLog.setUserIdx(rs.getInt("userIdx"));
				localLog.setPlaceIdx(rs.getInt("placeIdx"));
				localLog.setContent(rs.getString("content"));
				localLog.setPhotos(rs.getString("photos"));
				localLog.setVisitDate(rs.getDate("visitDate"));
				localLog.setCommunity(rs.getString("community"));
				localLog.setVisibility(rs.getString("visibility"));
				localLog.setCreatedAt(rs.getTimestamp("createdAt"));
				localLog.setUpdatedAt(rs.getTimestamp("updatedAt"));
				localLog.setHostIp(rs.getString("hostIp"));
				localLog.setPlaceName(rs.getString("placeName"));
				localLog.setRegion1DepthName(rs.getString("region1DepthName"));
				localLog.setRegion2DepthName(rs.getString("region2DepthName"));
				localLog.setCategoryName(rs.getString("categoryName"));
				localLog.setCategoryType(rs.getString("categoryType"));

				// Parse the photos field into a list of URLs and set the cover image
				String[] photoArray = rs.getString("photos").split("/");
				if (photoArray.length > 0) {
					localLog.setCoverImage(photoArray[0]);
				}
				localLog.setPhotoUrls(Arrays.asList(photoArray));

				results.add(localLog);
			}
		} catch (SQLException e) {
			System.out.println("searchLocalLogs SQL 오류: " + e.getMessage());
		}
		return results;
	}

	// 검색
	public int getLocalLogCountByQuery(String query) {
		int count = 0;
		try {
			sql = "SELECT COUNT(*) " + "FROM localLogs ll " + "JOIN places p ON ll.placeIdx = p.placeIdx " + "JOIN categories c ON p.categoryIdx = c.categoryIdx "
					+ "WHERE p.placeName LIKE ? OR c.categoryName LIKE ? OR p.region1DepthName LIKE ? OR p.region2DepthName LIKE ? "
					+ "OR ll.content LIKE ? OR ll.community LIKE ? OR c.categoryType LIKE ?";
			pstmt = conn.prepareStatement(sql);

			String likeQuery = "%" + query + "%";
			pstmt.setString(1, likeQuery);
			pstmt.setString(2, likeQuery);
			pstmt.setString(3, likeQuery);
			pstmt.setString(4, likeQuery);
			pstmt.setString(5, likeQuery);
			pstmt.setString(6, likeQuery);
			pstmt.setString(7, likeQuery);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogCountByQuery SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return count;
	}

	// 안쓰임
	public List<LocalLogVO> getLocalLogs(int startIndexNo, int pageSize) {
		List<LocalLogVO> localLogs = new ArrayList<>();
		try {
			sql = "SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " + "FROM localLogs ll " + "JOIN places p ON ll.placeIdx = p.placeIdx "
					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "ORDER BY ll.visitDate DESC " + "LIMIT ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				LocalLogVO localLog = new LocalLogVO();
				localLog.setLocalLogIdx(rs.getInt("localLogIdx"));
				localLog.setUserIdx(rs.getInt("userIdx"));
				localLog.setPlaceIdx(rs.getInt("placeIdx"));
				localLog.setContent(rs.getString("content"));
				localLog.setPhotos(rs.getString("photos"));
				localLog.setVisitDate(rs.getDate("visitDate"));
				localLog.setCommunity(rs.getString("community"));
				localLog.setVisibility(rs.getString("visibility"));
				localLog.setCreatedAt(rs.getTimestamp("createdAt"));
				localLog.setUpdatedAt(rs.getTimestamp("updatedAt"));
				localLog.setHostIp(rs.getString("hostIp"));
				localLog.setPlaceName(rs.getString("placeName"));
				localLog.setRegion1DepthName(rs.getString("region1DepthName"));
				localLog.setRegion2DepthName(rs.getString("region2DepthName"));
				localLog.setCategoryName(rs.getString("categoryName"));

				// Parse the photos field into a list of URLs
				String[] photoArray = rs.getString("photos").split("/");
				localLog.setPhotoUrls(Arrays.asList(photoArray));

				localLogs.add(localLog);
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogs SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return localLogs;
	}

	// 안쓰임
	public List<LocalLogVO> getLocalLogsByPlaceIdx(int placeIdx) {
		List<LocalLogVO> localLogs = new ArrayList<>();
		try {
			sql = "SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " + "FROM localLogs ll " + "JOIN places p ON ll.placeIdx = p.placeIdx "
					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "WHERE ll.placeIdx = ? AND ll.visibility = 'public'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, placeIdx);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				LocalLogVO localLog = new LocalLogVO();
				localLog.setLocalLogIdx(rs.getInt("localLogIdx"));
				localLog.setUserIdx(rs.getInt("userIdx"));
				localLog.setPlaceIdx(rs.getInt("placeIdx"));
				localLog.setContent(rs.getString("content"));
				localLog.setPhotos(rs.getString("photos"));
				localLog.setVisitDate(rs.getDate("visitDate"));
				localLog.setCommunity(rs.getString("community"));
				localLog.setVisibility(rs.getString("visibility"));
				localLog.setCreatedAt(rs.getTimestamp("createdAt"));
				localLog.setUpdatedAt(rs.getTimestamp("updatedAt"));
				localLog.setHostIp(rs.getString("hostIp"));
				localLog.setPlaceName(rs.getString("placeName"));
				localLog.setRegion1DepthName(rs.getString("region1DepthName"));
				localLog.setRegion2DepthName(rs.getString("region2DepthName"));
				localLog.setCategoryName(rs.getString("categoryName"));

				localLogs.add(localLog);
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogsByPlaceIdx SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return localLogs;
	}

	// 로컬로그 좋아요를 했는지
	public boolean isLikedByUser(int userIdx, int localLogIdx) {
		boolean result = false;
		try {
			sql = "SELECT COUNT(*) FROM likes_localLog WHERE localLogIdx = ? AND userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogIdx);
			pstmt.setInt(2, userIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.out.println("isLocalLogLikedByUser SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return result;
	}

	// 로컬로그 좋아요
	public void addLike(int userIdx, int localLogIdx) {
		try {
			System.out.println("Inserting Like - localLogIdx: " + localLogIdx + ", userIdx: " + userIdx);
			sql = "INSERT INTO likes_localLog (localLogIdx, userIdx) VALUES (?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogIdx);
			pstmt.setInt(2, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("LocalLogaddLike SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 로컬로그 좋아요 취소
	public void removeLike(int userIdx, int localLogIdx) {
		try {
			System.out.println("Removing Like - localLogIdx: " + localLogIdx + ", userIdx: " + userIdx);
			sql = "DELETE FROM likes_localLog WHERE localLogIdx = ? AND userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogIdx);
			pstmt.setInt(2, userIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("LocalLogremoveLike SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 로컬로그 좋아요 카운트
	public int getLikeCount(int localLogIdx) {
		int likeCount = 0;
		try {
			sql = "SELECT COUNT(*) FROM likes_localLog WHERE localLogIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, localLogIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				likeCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("getLocalLogLikeCount SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return likeCount;
	}
}