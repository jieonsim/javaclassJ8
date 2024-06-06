package bookmark;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

	public int getBookmarkCountByUserIdx(int userIdx) {
		int count = 0;
		try {
			sql = "SELECT COUNT(*) FROM bookmarks WHERE userIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("getBookmarkCountByUserIdx SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return count;
	}

	public List<BookmarkVO> getBookmarksByUserIdx(int userIdx, int startIndexNo, int pageSize) {
		List<BookmarkVO> bookmarks = new ArrayList<>();
		try {
			sql = "SELECT b.*, ll.photos, p.placeName, p.region1DepthName, p.region2DepthName, c.categoryName " 
					+ "FROM bookmarks b " + "JOIN localLogs ll ON b.localLogIdx = ll.localLogIdx "
					+ "JOIN places p ON ll.placeIdx = p.placeIdx " 
					+ "JOIN categories c ON p.categoryIdx = c.categoryIdx " 
					+ "WHERE b.userIdx = ? " 
					+ "ORDER BY b.createdAt DESC " + "LIMIT ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BookmarkVO bookmark = new BookmarkVO();
				bookmark.setBookmarkIdx(rs.getInt("bookmarkIdx"));
				bookmark.setUserIdx(rs.getInt("userIdx"));
				bookmark.setLocalLogIdx(rs.getInt("localLogIdx"));
				bookmark.setCreatedAt(rs.getTimestamp("createdAt"));
				bookmark.setPlaceName(rs.getString("placeName"));
				bookmark.setRegion1DepthName(rs.getString("region1DepthName"));
				bookmark.setRegion2DepthName(rs.getString("region2DepthName"));
				bookmark.setCategoryName(rs.getString("categoryName"));

				String[] photoArray = rs.getString("photos").split("/");
				if (photoArray.length > 0) {
					bookmark.setCoverImage(photoArray[0]);
				}

				bookmarks.add(bookmark);
			}
		} catch (SQLException e) {
			System.out.println("getBookmarksByUserIdx SQL 오류: " + e.getMessage());
		} finally {
			rsClose();
		}
		return bookmarks;
	}

	public boolean deleteBookmarks(String[] localLogIdxs) {
        boolean result = true;
        try {
            conn.setAutoCommit(false);
            String sql = "DELETE FROM bookmarks WHERE localLogIdx = ?";
            pstmt = conn.prepareStatement(sql);
            for (String localLogIdx : localLogIdxs) {
                pstmt.setInt(1, Integer.parseInt(localLogIdx));
                pstmt.addBatch();
            }
            pstmt.executeBatch();
            conn.commit();
        } catch (SQLException e) {
            System.out.println("deleteBookmarks SQL 오류 : " + e.getMessage());
            result = false;
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            pstmtClose();
        }
        return result;
    }
}
