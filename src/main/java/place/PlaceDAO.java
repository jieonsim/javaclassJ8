package place;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.GetConnection;

public class PlaceDAO {
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

	public int savePlace(PlaceVO placeVO) {
		int placeIdx = 0;
		sql = "INSERT INTO places (placeName, region1DepthName, region2DepthName, categoryIdx, createdBy) VALUES (?, ?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, placeVO.getPlaceName());
			pstmt.setString(2, placeVO.getRegion1DepthName());
			pstmt.setString(3, placeVO.getRegion2DepthName());
			pstmt.setInt(4, placeVO.getCategoryIdx());
			pstmt.setInt(5, placeVO.getCreatedBy());
			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				placeIdx = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return placeIdx;
	}

	// 공간 이름으로 공간 검색
	public List<PlaceVO> searchPlacesByNameWithCategory(String placeName) {
		List<PlaceVO> places = new ArrayList<PlaceVO>();
		try {
			sql = "SELECT p.*, c.categoryName FROM places p JOIN categories c ON p.categoryIdx = c.categoryIdx WHERE p.placeName LIKE ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + placeName + "%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PlaceVO place = new PlaceVO();
				place.setPlaceName(rs.getString("placeName"));
				place.setRegion1DepthName(rs.getString("region1DepthName"));
				place.setRegion1DepthName(rs.getString("region2DepthName"));
				place.setCategoryName(rs.getString("categoryName"));
				places.add(place);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류1 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return places;
	}

}
