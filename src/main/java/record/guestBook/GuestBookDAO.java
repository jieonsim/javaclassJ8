package record.guestBook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

	public int saveGuestBook(GuestBookVO guestBookVO) {
		int result = 0;
		try {
			sql = "INSERT INTO guestBooks (userIdx, placeIdx, visitDate, content, companions, visibility, hostIp) VALUES (?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookVO.getUserIdx());
			pstmt.setInt(2, guestBookVO.getPlaceIdx());
			pstmt.setString(3, guestBookVO.getVisitDate());
			pstmt.setString(4, guestBookVO.getContent());
			pstmt.setString(5, guestBookVO.getCompanions());
			pstmt.setString(6, guestBookVO.getVisibility());
			pstmt.setString(7, guestBookVO.getHostIp());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return result;
	}
}
