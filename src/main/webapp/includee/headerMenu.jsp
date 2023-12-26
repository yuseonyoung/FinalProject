<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<style>
	#headertop{
		background-color: white;
	}
	#alarmIcon{
	color: #ffc324;
	}
	#msg-list{
	color:#b1cdf2;
	}
	#navbarDropdownNotification1{
		color:#73cee7;
	}
	#navbarDropdownNotification{
		color: #5db300;
	}
	
</style>
<nav class="navbar navbar-light navbar-glass navbar-top navbar-expand" id="headertop">

	<button
		class="btn navbar-toggler-humburger-icon navbar-toggler me-1 me-sm-3"
		type="button" data-bs-toggle="collapse"
		data-bs-target="#navbarVerticalCollapse"
		aria-controls="navbarVerticalCollapse" aria-expanded="false"
		aria-label="Toggle Navigation">
		<span class="navbar-toggle-icon"> <span class="toggle-line"></span>
		</span>
	</button>
	<a class="navbar-brand me-1 me-sm-3" href="/">
		<div class="d-flex align-items-center">
			<img class="me-2"
				src="/resources/images/logo/logo.png"
				alt="" width="50" /> <span class="font-sans-serif">AIM</span>
		</div>
	</a>
	<ul class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
		<li class="nav-item px-2">
			<div class="theme-control-toggle fa-icon-wait">
				<input
					class="form-check-input ms-0 theme-control-toggle-input"
					id="themeControlToggle" type="checkbox" data-theme-control="theme"
					value="dark" />
					<label
						class="mb-0 theme-control-toggle-label theme-control-toggle-light"
						for="themeControlToggle" data-bs-toggle="tooltip"
						data-bs-placement="left" title="Switch to light theme">
						<span class="fas fa-sun fs-0"></span>
					</label>
					<label
						class="mb-0 theme-control-toggle-label theme-control-toggle-dark"
						for="themeControlToggle" data-bs-toggle="tooltip"
						data-bs-placement="left" title="Switch to dark theme">
						<span class="fas fa-moon fs-0"></span>
					</label>
			</div>
		</li>
		<li class="nav-item dropdown">
		<div id="noti-alarm" ></div>
			<a class="nav-link px-0 fa-icon-wait" id="alarmIcon" onclick="alarmChk()" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-hide-on-body-scroll="data-hide-on-body-scroll">
				<span class="fas fa-bell" data-fa-transform="shrink-6" style="font-size: 33px;"></span>
			</a>
			<div class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-menu-notification dropdown-caret-bg" aria-labelledby="navbarDropdownNotification">
				<div class="card card-notification shadow-none">
					
					<div class="scrollbar-overlay" style="max-height: 19rem">
						<div class="list-group list-group-flush fw-normal fs--1">
							<div class="list-group-title border-bottom" id="alarm-new">새로운 알람</div>
									<div class="list-group-item" id="alarmCont">
								 	</div>
						</div>
					</div>
				</div>
			</div></li>
		<li class="nav-item dropdown">
		<a class="nav-link pe-0 ps-2"
			id="navbarDropdownUser" role="button" data-bs-toggle="dropdown"
			aria-haspopup="true" aria-expanded="false"
			>
				<div class="avatar avatar-xl">
					<sec:authorize access="isAuthenticated()">
						<div class="avatar avatar-2xl">
							<img class="rounded-circle"
								 src="<sec:authentication property="principal.realUser.empImg"/>"
								alt="회원이미지 떠야 함" />
						</div>
					</sec:authorize>
				</div>
		</a>
			<div
				class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end py-0"
				aria-labelledby="navbarDropdownUser">
				<div class="bg-white dark__bg-1000 rounded-2 py-2">
					<a class="dropdown-item fw-bold text-warning" href="#!"><span
						class="fas fa-crown me-1"></span>
						<span>
							<sec:authorize access="isAnonymous()">
							   <a class="dropdown-item" href="/login">로그인</a>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
							  <sec:authentication property="principal.realUser.empNm"/>
							</sec:authorize>
						</span></a>
					<div class="dropdown-divider"></div>

					<sec:authorize access="isAuthenticated()">
						<a class="dropdown-item" href="/mypage">마이페이지</a>
						<a class="dropdown-item" href="/organization/list">조직도</a>
						<a class="dropdown-item" href="/schedule/list">일정</a>
						<a class="dropdown-item" href="/mail/list">메일</a>
						<a class="dropdown-item" href="/msg/inbox">쪽지</a>
						<a class="dropdown-item" href="#"  onclick="document.getElementById('logout-form').submit();">로그아웃</a>
						<form id="logout-form" action='<c:url value='/logout'/>' method="POST">
						   <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
						</form>
					</sec:authorize>

				</div>
			</div>
		</li>
	</ul>
</nav>

<sec:authorize access="isAuthenticated()">
<script>
var empCd = `<%=request.getUserPrincipal().getName()%>`;
</script>
<script>

</script>
</sec:authorize>

<script>
	
</script>

<c:url value="/resources/js/alarm/alarm.js" var="urls" />
<script src="${urls}"></script> 