package bookmark;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.GetConnection;

public class BookmarkDAO {
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
	
    public boolean isBookmarked(int userIdx, int localLogIdx) {
        try {
        	sql = "SELECT COUNT(*) FROM bookmarks WHERE userIdx = ? AND localLogIdx = ?";
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setInt(1, userIdx);
        	pstmt.setInt(2, localLogIdx);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("isBookmarked SQL 오류 : " + e.getMessage());
        } finally {
        	rsClose();
		}
        return false;
    }

    public void addBookmark(int userIdx, int localLogIdx) {
        try {
        	sql = "INSERT INTO bookmarks (userIdx, localLogIdx) VALUES (?, ?)";
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setInt(1, userIdx);
        	pstmt.setInt(2, localLogIdx);
        	pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("addBookmark SQL 오류 : " + e.getMessage());
        } finally {
			pstmtClose();
		}
    }

    public void removeBookmark(int userIdx, int localLogIdx) {
        try {
        	sql = "DELETE FROM bookmarks WHERE userIdx = ? AND localLogIdx = ?";
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setInt(1, userIdx);
        	pstmt.setInt(2, localLogIdx);
        	pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("removeBookmark SQL 오류 : " + e.getMessage());
        } finally {
			pstmtClose();
		}
    }
}
