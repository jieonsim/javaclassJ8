package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GetConnection {
    private static Connection connection = null;

    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/javaclass8";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";

    private static GetConnection instance;

    private GetConnection() {
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("드라이버 검색 실패 : " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("데이터베이스 연결 실패 : " + e.getMessage());
        }
    }

    public static synchronized GetConnection getInstance() {
        if (instance == null) {
            instance = new GetConnection();
        }
        return instance;
    }

    public static Connection getConn() {
        return connection;
    }
}
