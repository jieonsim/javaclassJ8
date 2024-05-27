package record.guestBook;

import java.sql.Connection;
import java.sql.Date;
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

//	public void saveGuestBook(GuestBookVO guestBookVO) {
//		sql = "INSERT INTO guestBooks (userIdx, placeIdx, visitDate, content, companions, visibility, hostIp) VALUES (?, ?, ?, ?, ?, ?, ?)";
//
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, guestBookVO.getUserIdx());
//			pstmt.setInt(2, guestBookVO.getPlaceIdx());
//			pstmt.setDate(3, java.sql.Date.valueOf(guestBookVO.getVisitDate()));
//			pstmt.setString(4, guestBookVO.getContent());
//			pstmt.setString(5, guestBookVO.getCompanions());
//			pstmt.setString(6, guestBookVO.getVisibility());
//			pstmt.setString(7, guestBookVO.getHostIp());
//			pstmt.executeUpdate();
//		} catch (SQLException e) {
//			System.out.println("SQL 오류 : " + e.getMessage());
//		} finally {
//			pstmtClose();
//		}
//	}
	public void saveGuestBook(GuestBookVO guestBookVO) {
		sql = "INSERT INTO guestBooks (userIdx, placeIdx, visitDate, content, companions, visibility, hostIp) VALUES (?, ?, ?, ?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guestBookVO.getUserIdx());
			pstmt.setInt(2, guestBookVO.getPlaceIdx());
			pstmt.setDate(3, Date.valueOf(guestBookVO.getVisitDate()));
			pstmt.setString(4, guestBookVO.getContent());
			pstmt.setString(5, guestBookVO.getCompanions());
			pstmt.setString(6, guestBookVO.getVisibility());
			pstmt.setString(7, guestBookVO.getHostIp());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류2 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}
}
