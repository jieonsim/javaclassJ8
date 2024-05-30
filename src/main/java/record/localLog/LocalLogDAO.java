package record.localLog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}
