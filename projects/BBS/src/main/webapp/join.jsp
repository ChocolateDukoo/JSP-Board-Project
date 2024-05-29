<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					<li><a href="bbs.jsp">게시판</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li class="active"><a href="login.jsp">로그인</a></li>						
							<li><a href="join.jsp">회원가입</a></li>						
					    </ul>	
					</li>
				</ul>
			</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top:20px;">
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align: center;">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20"> 
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20"> 
					</div>
					<!-- 새로 추가 시작 -->
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20"> 
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocompleted="off" value="남자" checked>남자
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocompleted="off" value="여자" checked>여자
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50"> 
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
					<!-- 새로 추가 끝 -->
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<!-- 애니메이션 담당 자바스크립트 참조(jquery를 특정 사이트에서 가져옴) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- bootstrap에서 기본적으로 제공하는 js 참조 -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>