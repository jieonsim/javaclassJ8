package record.localLog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
	public List<LocalLogVO> getLocalLogsByUserIdx(int userIdx) {
		List<LocalLogVO> localLogs = new ArrayList<>();
		try {
			sql = "SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " + "FROM localLogs ll "
					+ "JOIN places p ON ll.placeIdx = p.placeIdx " + "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "WHERE ll.userIdx = ? "
					+ "ORDER BY ll.visitDate DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
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
				localLog.setCreatedAt(rs.getTimestamp("created_at"));
				localLog.setUpdatedAt(rs.getTimestamp("updated_at"));
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

	public LocalLogVO getLocalLogByIdx(int localLogIdx) {
		LocalLogVO localLog = null;
		try {
			String sql = "SELECT ll.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " + "FROM localLogs ll "
					+ "JOIN places p ON ll.placeIdx = p.placeIdx " + "JOIN categories c ON p.categoryIdx = c.categoryIdx " + "WHERE ll.localLogIdx = ?";
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
				localLog.setCreatedAt(rs.getTimestamp("created_at"));
				localLog.setUpdatedAt(rs.getTimestamp("updated_at"));
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
}
