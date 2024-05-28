package place;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.GetConnection;

public class CategoryDAO {
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

	public List<CategoryVO> getAllCategories() {
		List<CategoryVO> categoryList = new ArrayList<>();
		sql = "SELECT * FROM categories";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CategoryVO category = new CategoryVO();
				category.setCategoryIdx(rs.getInt("categoryIdx"));
				category.setCategoryName(rs.getString("categoryName"));
				category.setCategoryType(rs.getString("categoryType"));
				categoryList.add(category);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}

		return categoryList;
	}

	
	// PlaceVO 객체에 categoryName을 설정할 수 있도록 CategoryDAO에 getCategoryByIdx 메소드를 추가
	public CategoryVO getCategoryByIdx(int categoryIdx) {
		CategoryVO categoryVO = null;
		String sql = "SELECT * FROM categories WHERE categoryIdx = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryIdx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				categoryVO = new CategoryVO();
				categoryVO.setCategoryIdx(rs.getInt("categoryIdx"));
				categoryVO.setCategoryName(rs.getString("categoryName"));
				categoryVO.setCategoryType(rs.getString("categoryType"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return categoryVO;
	}
}
