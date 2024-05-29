<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- UserDAO를 그대로 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- JavaScript문 사용하기 위해 필요 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8으로 받을 수 있게 해줌 -->
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- 현재 페이지 안에서만 빈즈를 사용  -->
<jsp:setProperty name="user" property="userID" /> <!-- 받은 userID를 하나의 사용자의 userID에 넣어줌 --> 
<jsp:setProperty name="user" property="userPassword" /> <!-- 받은 userPassword를 하나의 사용자의 userPassword에 넣어줌 --> 
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
		UserDAO userDAO = new UserDAO(); //인스턴스 생성
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); //로그인 시도(각각의 값들이 result에 담김)
		if(result == 1) {
			session.setAttribute("userID", user.getUserID()); //세션값으로 userID를 넣어줌
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'"); // 로그인 성공 시 main.jsp로
			script.println("</script>");
		} 
		else if(result == 0) { // 비밀번호 틀렸을 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')"); 
			script.println("history.back()"); // 이전 페이지로 되돌아감
			script.println("</script>");
		}	
		else if(result == -1) { // 아이디가 존재하지 않을 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')"); 
			script.println("history.back()"); // 이전 페이지로 되돌아감
			script.println("</script>");
		}	
		else if(result == -2) { 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')"); 
			script.println("history.back()"); // 이전 페이지로 되돌아감
			script.println("</script>");
		}	
	%>
</body>
</html>