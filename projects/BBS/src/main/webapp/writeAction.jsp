<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- BbsDAO를 그대로 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- JavaScript문 사용하기 위해 필요 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8으로 받을 수 있게 해줌 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> <!-- 현재 페이지 안에서만 빈즈를 사용  -->
<jsp:setProperty name="bbs" property="bbsTitle" /> 
<jsp:setProperty name="bbs" property="bbsContent" />
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
		if (userID == null) { // 로그인되어 있지 않는 상태라면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')"); 
			script.println("location.href = 'login.jsp'"); // login.jsp 페이지로 이동
			script.println("</script>");
		} else {
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) { // 사용자가 입력을 안 했을 모든 경우의 수 체크
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 안 된 사항이 있습니다.')"); 
						script.println("history.back()"); // 이전 페이지로 되돌아감
						script.println("</script>");
					} else {
						BbsDAO bbsDAO = new BbsDAO(); //인스턴스 생성
						int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
						if(result == -1) { 
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패했습니다.')");
							script.println("history.back()");
							script.println("</script>");
					}
					else { 
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'"); // 글쓰기 성공 시 bbs.jsp로 이동
						script.println("</script>");
					}	
				}		
			
			}		
  %>
</body>
</html>