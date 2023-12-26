<%--
* [[개정이력(Modification Information)]]
* 수정일              수정자      수정내용
* ----------     ---------  -----------------
* 2023. 11. 14.      이수정      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- ===============================================-->
<!--    Document Title-->
<!-- ===============================================-->
<title>Auto Inventory Management</title>


<!-- ===============================================-->
<!--    Favicons-->
<!-- ===============================================-->
<link rel="apple-touch-icon" sizes="180x180"
	href="/resources/falcon/public/assets/img/favicons/grouub.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="/resources/falcon/public/assets/img/favicons/grouub.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/falcon/public/assets/img/favicons/grouub.png">
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/falcon/public/assets/img/favicons/grouub.png">
<link rel="manifest"
	href="/resources/falcon/public/assets/img/favicons/manifest.json">
<meta name="msapplication-TileImage"
	content="/resources/falcon/public/assets/img/favicons/mstile-150x150.png">
<meta name="theme-color" content="#ffffff">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="/resources/falcon/public/assets/js/config.js"></script>
<script
	src="/resources/falcon/public/vendors/simplebar/simplebar.min.js"></script>

<!-- Jquery -->
<script src="/resources/js/jquery-3.7.1.min.js"></script>
<script src="/resources/js/jquery.serializejson.js"></script>

<!-- websocket 통신관련 sockjs, stomp-->
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<!-- editor -->
<script src="/resources/falcon/public/vendors/tinymce/tinymce.min.js"></script>

<!-- chartJs -->
<script src="/resources/falcon/public/vendors/chart/chart.min.js"></script>

<!-- google font : 폰트 설정 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@500&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<!-- ===============================================-->
<!--    Stylesheets-->
<!-- ===============================================-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap"
	rel="stylesheet">
<link
	href="/resources/falcon/public/vendors/simplebar/simplebar.min.css"
	rel="stylesheet">
<link href="/resources/falcon/public/assets/css/theme-rtl.css"
	rel="stylesheet" id="style-rtl">
<link href="/resources/falcon/public/assets/css/theme.css"
	rel="stylesheet" id="style-default">
<link href="/resources/falcon/public/assets/css/user-rtl.css"
	rel="stylesheet" id="user-style-rtl">
<link href="/resources/falcon/public/assets/css/user.css"
	rel="stylesheet" id="user-style-default">
<link
	href="/resources/falcon/public/vendors/flatpickr/flatpickr.min.css"
	rel="stylesheet" />
<link href="/resources/falcon/public/vendors/fullcalendar/main.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css" />
<link href="/resources/falcon/public/vendors/dropzone/dropzone.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="/resources/falcon/public/vendors/select2/select2.min.css" />
<link rel="stylesheet"
	href="/resources/falcon/public/vendors/select2-bootstrap-5-theme/select2-bootstrap-5-theme.min.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/custom.css">
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-modal/2.2.6/css/bootstrap-modal.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-modal/2.2.6/js/bootstrap-modal.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-modal/2.2.6/js/bootstrap-modalmanager.min.js"></script> -->

<script>
	var isRTL = JSON.parse(localStorage.getItem('isRTL'));
	if (isRTL) {
		var linkDefault = document.getElementById('style-default');
		var userLinkDefault = document.getElementById('user-style-default');
		linkDefault.setAttribute('disabled', true);
		userLinkDefault.setAttribute('disabled', true);
		document.querySelector('html').setAttribute('dir', 'rtl');
	} else {
		var linkRTL = document.getElementById('style-rtl');
		var userLinkRTL = document.getElementById('user-style-rtl');
		linkRTL.setAttribute('disabled', true);
		userLinkRTL.setAttribute('disabled', true);
	}
</script>


<!-- 폰트 적용 -->
<style>
* {
	font-family: 'IBM Plex Sans KR', sans-serif;
}

.pageConversion body.modal-open {
	overflow: auto;
}
</style>
<security:csrfMetaTags />
</head>


<body class="pageConversion"
	data-context-path="${pageContext.request.contextPath}">

	<!-- ===============================================-->
	<!--    Main Content-->
	<!-- ===============================================-->
	<main class="main" id="top">
		<div class="container" data-layout="container">
			<script>
				var isFluid = JSON.parse(localStorage.getItem('isFluid'));
				if (isFluid) {
					var container = document.querySelector('[data-layout]');
					container.classList.remove('container');
					container.classList.add('container-fluid');
				}
			</script>



			<script type="text/javascript"
				src="/resources/js/jquery-3.7.1.min.js"></script>
			<style>
@import 'https://fonts.googleapis.com/icon?family=Material+Icons|Roboto'
	;

.recorder_wrapper {
	width: 100%;
	display: -webkit-flex;
	display: -moz-flex;
	display: -ms-flex;
	display: -o-flex;
	display: flex;
	align-items: center;
	justify-content: center;
	width: 100%;
	height: 100%;
}

.recorder {
	display: inline-block;
	text-align: center;
	width: 500px;
	max-width: 100%;
}

.record_btn {
	width: 100px;
	height: 100px;
	font-family: 'Material Icons';
	font-size: 48px;
	color: #e74c3c;
	background: none;
	border: 2px solid #e74c3c;
	border-radius: 50%;
	cursor: pointer;
	transition: 0.15s linear;
}

.record_btn:hover {
	transition: 0.15s linear;
	transform: scale(1.05);
}

.record_btn:active {
	background: #f5f5f5;
}

.record_btn:after {
	content: '\E029';
}

.record_btn[disabled] {
	border: 2px solid #ccc;
}

.record_btn[disabled]:after {
	content: '\E02B';
	color: #ccc;
}

.record_btn[disabled]:hover {
	transition: 0.15s linear;
	transform: none;
}

.record_btn[disabled]:active {
	background: none;
}

.recording {
	animation: recording 2s infinite ease-in-out;
	position: relative;
}

.recording:before {
	content: '';
	display: inline-block;
	position: absolute;
	top: 50%;
	left: 50%;
	width: 0px;
	height: 0px;
	margin: 0px;
	border-radius: 50%;
	background: rgba(0, 0, 0, 0.05);
	animation: recording_before 2s infinite ease-in-out;
}

@
keyframes recording {from { transform:scale(1.1);
	
}

50




%
{
transform




:




none


;
}
to {
	transform: scale(1.1);
}

}
@
keyframes recording_before { 80% {
	width: 200px;
	height: 200px;
	margin: -100px;
	opacity: 0;
}

to {
	opacity: 0;
}

}
.record_canvas {
	width: 60px;
	height: 100px;
	display: inline-block;
}

.txt_btn {
	color: #000;
	text-decoration: none;
	transition: 0.15s linear;
	animation: text_btn 0.3s ease-in-out;
}
</style>


			<div class="row flex-center min-vh-100 py-6">
				<div class="col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
					<div class="card">
						<a class="d-flex flex-center mb-4" href="/"><img class="me-2"
							src="resources/images/aim/aimlogo.jpg" alt="" width="200" /><span
							class="font-sans-serif fw-bolder fs-5 d-inline-block"></span></a>
						<div class="card-body p-4 p-sm-5">
							<div class="row flex-between-center mb-2">
								<div class="col-auto">
									<h5>Log in</h5>
								</div>
							</div>
							<form:form modelAttribute="EmpVO" action="/login" method="post">
								<sec:csrfInput />
								<div class="mb-3">
									<input id="userIdLogin" class="form-control" name="empCd"
										type="text" placeholder="사원번호" value="${empCd}" required
										maxlength="20" />
								</div>
								<div class="mb-3">
									<input id="userPswdLogin" class="form-control" name="empPw"
										type="password" placeholder="비밀번호" required />
								</div>


								<div class="row flex-between-center">

									<c:if test="${not empty error}">
										<script>
											Swal.fire({
							                    icon: 'error',
							                    title: '실패',
							                    text: '${exception}'
							                }).then(function(){
												location.href="/";                   
											})
										 </script>
									</c:if>

									<div class="col-auto">
										<div class="form-check mb-0">
											<input class="form-check-input" name="remember-me"
												type="checkbox" id="remember" /> <label
												class="form-check-label mb-0" for="remember">자동 로그인</label>
										</div>
									</div>
									<div class="col-auto">
										<button type="button" class="btn btn-link fs--1"
											data-bs-toggle="modal" data-bs-target="#findPw">비밀번호를
											잊으셨나요?</button>
									</div>
								</div>
								<div class="mb-3">
									<button id="frmBtn" class="btn btn-primary d-block w-100 mt-3"
										type="submit" name="submit">Log in</button>
								</div>
								<sec:csrfInput />
							</form:form>
							<div class="row g-2 mt-2">
							<button id="userChange1" class="btn btn-outline-primary me-1 mb-1" type="button">
							관리자: 유선영</button>
							<button id="userChange5" class="btn btn-outline-warning me-1 mb-1" type="button">
							관리자: 최희연</button>
							<button id="userChange2" class="btn btn-outline-secondary me-1 mb-1" type="button">
							사무직: 이수정</button>
							<button id="userChange3" class="btn btn-outline-success me-1 mb-1" type="button">
							현장직: 김도현</button>
							<button id="userChange4" class="btn btn-outline-danger me-1 mb-1" type="button">
							퇴사자: 이건창</button>
							</div>
						</div>
					</div>
				</div>


				<!--임시 비번 모달-->
				<div class="modal fade" id="findPw" tabindex="-1" role="dialog"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document"
						style="max-width: 500px">
						<div class="modal-content position-relative">
							<div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
								<button
									class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
									data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="rounded-top-3 py-3 ps-4 pe-6 bg-light">
									<h5 class="mb-0">임시비밀번호</h5>
								</div>
								<div class="p-4 pb-0">
									<form class="mt-4" name="findPwEmail" method="post">
										<sec:csrfInput />
										<label class="form-label" for="findPwUserId">아이디</label> <input
											class="form-control" name="empCd" id="findPwUserId"
											type="text" placeholder="사원번호" required /> <label
											class="form-label" for="findPwUserEmail">이메일</label> <input
											class="form-control" name="empMail" id="findPwUserEmail"
											type="email" placeholder="이메일 주소" required />
										<div class="mb-3"></div>
										<small>사원번호와 인증된 이메일을 입력하십시오</small><br> <small>사원번호는
											인사처(042-123-4567)로 문의하십시오</small>
										<button id="checkEmail" type="button"
											class="btn btn-primary d-block w-100 mt-3">임시비밀번호 발송</button>
											<br>
										<button id="findPwBtn1" class="btn btn-outline-primary me-1 mb-1" type="button">
										틀린것</button>
										<button id="findPwBtn2" class="btn btn-outline-primary me-1 mb-1" type="button">
										옳은것</button>
										<sec:csrfInput />
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>


				<!-- ===============================================-->
				<!--    JavaScripts-->
				<!-- ===============================================-->
				<c:if test="${not empty message }">
					<script>
					Swal.fire({
	                    icon: 'error',
	                    title: '실패',
	                    text: '${message}'
	                })
					<c:remove var="message" scope="session"/>
				</script>
				</c:if>

				<script>
			   const CSRFPARAMNAME = $("meta[name='_csrf_parameter']").attr("content");
			   const CSRFHEADERNAME = $("meta[name='_csrf_header']").attr("content");
			   const CSRFTOKEN = $("meta[name='_csrf']").attr("content");
			   $.ajaxSetup({
			      headers : {
			         [CSRFHEADERNAME] : CSRFTOKEN
			      }
			   });
			</script>


				<script
					src="/resources/falcon/public/vendors/bootstrap/bootstrap.min.js"></script>
				<script
					src="/resources/falcon/public/vendors/anchorjs/anchor.min.js"></script>
				<script src="/resources/falcon/public/vendors/is/is.min.js"></script>
				<script
					src="/resources/falcon/public/vendors/echarts/echarts.min.js"></script>
				<script
					src="/resources/falcon/public/vendors/fontawesome/all.min.js"></script>
				<script src="/resources/falcon/public/vendors/lodash/lodash.min.js"></script>
				<script
					src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
				<script src="/resources/falcon/public/vendors/list.js/list.min.js"></script>
				<script src="/resources/falcon/public/assets/js/theme.js"></script>
				<script src="/resources/falcon/public/assets/js/flatpickr.js"></script>
				<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
				<script
					src="/resources/falcon/public/vendors/fullcalendar/main.min.js"></script>
				<script
					src="/resources/falcon/public/vendors/dropzone/dropzone.min.js"></script>
				<script
					src="/resources/falcon/public/vendors/draggable/draggable.bundle.legacy.js"></script>
				<!-- <script src="/resources/falcon/public/vendors/jquery/jquery.min.js"></script> -->
				<script
					src="/resources/falcon/public/vendors/select2/select2.min.js"></script>
				<script
					src="/resources/falcon/public/vendors/select2/select2.full.min.js"></script>

				<script
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb220a45abe792f033fbc010f5b30024&libraries=services"></script>
				<!-- <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    		<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script> -->

				<script
					src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
				<script
					src="https://cdn.datatables.net/v/bs5/dt-1.13.7/b-2.4.2/datatables.min.js"></script>
				<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
				<script src="/resources/js/storage/address.js"></script>
				<script
					src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script src="/resources/falcon/public/vendors/popper/popper.min.js"></script>


			</div>
	</main>
</body>
</html>

<script type="text/javascript">
	Dropzone.autoDiscover = false;
    flatpickr.localize(flatpickr.l10ns.ko);
    flatpickr(".datetimepicker");
</script>


<script type="text/javascript">


$("#error-modal").on("hidden.bs.modal", function() {
    var video = document.getElementById('video');
   faceBtn.innerText = "로그인";
    if (videoStream) {
        var tracks = videoStream.getTracks();
        tracks.forEach(function(track) {
            track.stop(); // 비디오 스트림의 트랙을 중지
        });
    }
    video.srcObject = null;
});
</script>


<!-- 임시비밀번호 발송 처리 script -->
<script>
    $("#checkEmail").click(function () {
    	const cPath = document.body.dataset.contextPath;
		const baseurl = `${cPath}/findpw`;
        const findUserId  = $("#findPwUserId").val();
        console.log(findUserId);
        const findUserEmail = $("#findPwUserEmail").val();
        console.log(findUserEmail);
        const findSendEmail = document.forms["findPwEmail"];
      	var csrfToken = document.querySelector("input[name='_csrf']").value;
        $.ajax({
            method: 'post',
            url: baseurl,
            data: {
                "empCd": findUserId,
                "empMail": findUserEmail
            },
         headers: {
               'Content-Type': 'application/x-www-form-urlencoded',
               'X-CSRF-TOKEN': csrfToken
           },
            dataType: "text",
            success: function (result) {
                if(result == "yes"){
                	Swal.fire({
                        icon: 'success',
                        title: '성공',
                        text: '임시비밀번호를 전송했습니다.'
                    }).then(function(){
                    location.href="/login";                   
                 })
                    //findSendEmail.submit();
                } else if (result == "noMatch"){
                	Swal.fire({
                        icon: 'warning',
                        title: '확인',
                        text: '이메일이 일치하지 않습니다.'
                    })
                } else if (result == "no") {
                	Swal.fire({
                        icon: 'warning',
                        title: '확인',
                        text: '아이디가 존재하지 않습니다.'
                    })
                }
				console.log(result);
            },error: function () {
            	Swal.fire({
                    icon: 'error',
                    title: '실패',
                    text: '다시 시도해주세요.'
                })
                console.log('에러 체크!!')
            }
        })
    });
    
    
const empCd = $("#userIdLogin")[0];

	$("#userChange1").on("click", function() {
		userIdLogin.value = '2013020001';
		userPswdLogin.value='java1';
	});
	$("#userChange2").on("click", function() {
		userIdLogin.value = '2015020002';
		userPswdLogin.value='java1';
	});
	$("#userChange3").on("click", function() {
		userIdLogin.value = '2017020002';
		userPswdLogin.value='java';
	});
	$("#userChange4").on("click", function() {
		userIdLogin.value = '2021050001';
		userPswdLogin.value='java';
	});
	$("#userChange5").on("click", function() {
		userIdLogin.value = '2007010001';
		userPswdLogin.value='java';
	});
	

	$("#findPwBtn1").on("click", function() {
		findPwUserId.value = '2013020001';
		findPwUserEmail.value = 'hsb2908888@naver.com';
	});
	
	$("#findPwBtn2").on("click", function() {
		findPwUserId.value = '2013020001';
		findPwUserEmail.value = 'hsb2907@naver.com';
	});
	
	
	

</script>