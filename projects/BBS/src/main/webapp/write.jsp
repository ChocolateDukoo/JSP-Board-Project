<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- bootstrap은 모바일,pc 상관 없이 각각에 맞는 해상도를 지원하는 디자인 프레임워크로 meta 태그 사용 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- css폴더 안의 bootstrap.css 기본 디자인을 사용하겠다 명시 -->
<link rel="stylesheet" href="css/bootstrap.css"> 
<link rel="stylesheet" href="css/custom.css">  
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<% //로그인한 사용자들 로그인 정보 담을 수 있게 만들어줌
		String userID = null;
		if (session.getAttribute("userID") != null) { //세션에 ID값이 존재한다면 그 ID값을 받아 관리
			userID = (String)session.getAttribute("userID"); // 세션에 있는 값을 가지고 옴
		}
	%>
	<!-- 네비게이션 생성 - 기능 표현 -->
	<nav class="navbar navbar-default">
		<!-- 헤더 생성 - 홈페이지의 로고 등 -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 크기가 줄었을 때 icon-bar(줄)가 3개 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP게시판 웹 사이트</a>
		</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<!-- list 보여주기 -->
				<ul class="nav navbar-nav">
					<li><a href="main.jsp">메인</a></li>
					<li class="active"><a href="bbs.jsp">게시판</a></li>
				</ul>
				<%
					if(userID == null) { // 로그인이 되어 있지 않다면 아래의 기능이 표시
				%>
				<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">접속하기<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="login.jsp">로그인</a></li>						
								<li><a href="join.jsp">회원가입</a></li>						
						    </ul>	
						</li>
				</ul>	
				<% 
					} else { //로그인 되어 있으면 보이는 기능
				%>
				<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">회원관리<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="logoutAction.jsp">로그아웃</a></li>											
						    </ul>	
						</li>
				</ul>	
				<%		
					}
				%>						
				
			</div>
	</nav>
	<div class="container">
		<div class="row">
		<form method="post" action="writeAction.jsp">
			<!-- table의 디자인적 요소로 홀수/짝수로 나누어 색상을 다르게 해줌 -->
			<table class="table table-striked" style="text-align: center; border: 1px solid #dddddd">
				<!-- table의 헤더 부분으로 속성 등을 보여줌 -->
				<thead>
					<!-- 테이블의 하나의 행 -->
					<tr>
						<th colspan="2" style="background:color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>				
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
					</tr>
				</tbody>
			</table>
				<!-- 글쓰기 버튼 생성 -->
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
		  </form>	
		</div>
	</div>
	<!-- 애니메이션 담당 자바스크립트 참조(jquery를 특정 사이트에서 가져옴) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- bootstrap에서 기본적으로 제공하는 js 참조 -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>