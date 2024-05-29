<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- BbsDAO를 그대로 가져옴 -->
<%@ page import="bbs.Bbs" %> <!-- Bbs를 그대로 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- JavaScript문 사용하기 위해 필요 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8으로 받을 수 있게 해줌 -->
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
		} 
		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) { //넘어온 정보에서 게시물 번호가 존재한다면,
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유호하지 않은 글입니다.')"); 
			script.println("location.href = 'bbs.jsp'"); // bbs.jsp 페이지로 이동
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID); // 글 작성자인지 확인
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')"); 
			script.println("location.href = 'bbs.jsp'"); // bbs.jsp 페이지로 이동
			script.println("</script>");
		} else { // 자바 빈즈가 없어졌으므로 getParameter를 통해 update.jsp에서 받은 Title과 Content를 가져온다.
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
					|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("") ) { // 사용자가 입력을 안 했을 모든 경우의 수 체크
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 안 된 사항이 있습니다.')"); 
						script.println("history.back()"); // 이전 페이지로 되돌아감
						script.println("</script>");
					} else {
						BbsDAO bbsDAO = new BbsDAO(); //인스턴스 생성
						int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
						if(result == -1) { 
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글 수정에 실패했습니다.')");
							script.println("history.back()");
							script.println("</script>");
					}
					else { 
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'"); // 글 수정 성공 시 bbs.jsp로 이동
						script.println("</script>");
					}	
				}		
			
			}		
  %>
</body>
</html>