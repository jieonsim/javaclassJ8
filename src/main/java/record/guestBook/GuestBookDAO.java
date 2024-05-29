package record.guestBook;

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
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return result;
	}

	// userIdx로 해당 userIdx에 등록된 방명록 데이터 가져오기 / 아카이브-방명록
	public List<GuestBookVO> getGuestBooksByUserIdx(int userIdx) {
		List<GuestBookVO> guestBooks = new ArrayList<>();
		try {
			sql = "SELECT gb.*, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " 
					+ "FROM guestBooks gb " + "JOIN places p ON gb.placeIdx = p.placeIdx "
					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " 
					+ "WHERE gb.userIdx = ? " + "ORDER BY gb.createdAt DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
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
				guestBook.setHostIp(rs.getString("hostIp"));
				guestBook.setPlaceName(rs.getString("placeName"));
				guestBook.setRegion1DepthName(rs.getString("region1DepthName"));
				guestBook.setRegion2DepthName(rs.getString("region2DepthName"));
				guestBook.setCategoryName(rs.getString("categoryName"));

				guestBooks.add(guestBook);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return guestBooks;
	}
}
