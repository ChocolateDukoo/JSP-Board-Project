package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn; // Connection은 데이터베이스에 접근하게 해주는 하나의 객체
	private ResultSet rs; // 어떠한 정보를 담을 수 있는 객체
	
	// mysql에 접속할 수 있게 해주는 부분 시작
	public BbsDAO() {
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
	
	public String getDate() { //현재 시간을 가지고 옴
		// 각각의 함수끼리 마찰이 일어나지 않도록 PreparedStatement를 이쪽에 위치시킴
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public int getNext() { //현재 시간을 가지고 옴
		// 각각의 함수끼리 마찰이 일어나지 않도록 PreparedStatement를 이쪽에 위치시킴
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // 가장 마지막에 쓰인 게시글의 번호를 가지고온다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		// 각각의 함수끼리 마찰이 일어나지 않도록 PreparedStatement를 이쪽에 위치시킴
				String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; // 가장 마지막에 쓰인 게시글의 번호를 가지고온다.
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext());
					pstmt.setString(2, bbsTitle);
					pstmt.setString(3, userID);
					pstmt.setString(4, getDate());
					pstmt.setString(5, bbsContent);
					pstmt.setInt(6, 1);
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				return -1; // 데이터베이스 오류
	}
	// 1페이지 당 10개의 게시물만 보이도록
	public ArrayList<Bbs> getList(int pageNumber) {         
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); 
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 글이 10개 미만일 때 다음 페이지 버튼이 안 보이게끔
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true; // 게시글이 10개 이상일 때 다음 페이지 보이게
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // 게시글이 10개 미만일 때 다음 페이지 보이지 않게
	} 
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; // 번호에 해당하는 게시글 조회
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID); 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?" ; // 특정한 아이디에 해당하는 제목과 내용을 수정한다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	// 글을 삭제하더라도 데이터는 남아있도록 bbsAvailable 값만 0으로 변경한다.
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?" ; // 특정한 아이디에 해당하는 제목과 내용을 수정한다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
