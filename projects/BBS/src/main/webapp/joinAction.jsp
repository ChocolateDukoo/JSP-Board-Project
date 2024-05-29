<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- UserDAO를 그대로 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- JavaScript문 사용하기 위해 필요 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8으로 받을 수 있게 해줌 -->
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- 현재 페이지 안에서만 빈즈를 사용  -->
<jsp:setProperty name="user" property="userID" /> <!-- 받은 userID를 하나의 사용자의 userID에 넣어줌 --> 
<jsp:setProperty name="user" property="userPassword" /> <!-- 받은 userPassword를 하나의 사용자의 userPassword에 넣어줌 -->
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) { //세션에 userID가 존재한다면 해당 세션 값을 넣어준다.
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) { // 로그인되어 있는 상태라면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')"); 
			script.println("location.href = 'main.jsp'"); // main.jsp 페이지로 이동
			script.println("</script>");
		}
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
		|| user.getUserGender() == null || user.getUserEmail() == null) { // 사용자가 입력을 안 했을 모든 경우의 수 체크
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')"); 
			script.println("history.back()"); // 이전 페이지로 되돌아감
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO(); //인스턴스 생성
			int result = userDAO.join(user);
			if(result == -1) { // 동일한 아이디가 존재하는데 회원가입 시
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
		}
		else { 
			session.setAttribute("userID", user.getUserID()); //세션값으로 userID를 넣어줌
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'"); // 회원가입 성공 시 main.jsp로 이동
			script.println("</script>");
		}	
	}		
  %>
</body>
</html>