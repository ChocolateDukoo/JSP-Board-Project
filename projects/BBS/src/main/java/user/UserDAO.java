package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; // Connection은 데이터베이스에 접근하게 해주는 하나의 객체
	private PreparedStatement pstmt;
	private ResultSet rs; // 어떠한 정보를 담을 수 있는 객체
	
	// mysql에 접속할 수 있게 해주는 부분 시작
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS"; //mysql의 3306포트의 BBS에 접속할 수 있게 해줌
			String dbID = "root";
			String dbPassword= "root";
			Class.forName("com.mysql.jdbc.Driver"); //mysql에 접속할 수 있도록 해주는 하나의 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// mysql에 접속할 수 있게 해주는 부분 끝
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); // pstmt에 정해진 SQL문을 데이터베이스에 삽입
			pstmt.setString(1, userID); //SQL 해킹 방지를 위해 PreparedStatement를 이용하는 것으로 위의 select 절에 미리 ?를 넣고 나중에 ?에 userID를 넣어줌 (실제 userID가 있는지 확인 후 그러면 그 비밀번호가 무엇인지 데이터를 가져옴)
			rs = pstmt.executeQuery(); // rs에 실행 결과를 넣어줌
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) { // userPassword가 동일하다면
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); // 해당 결과를 넣어준다.
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터 베이스 오류
	}
}
