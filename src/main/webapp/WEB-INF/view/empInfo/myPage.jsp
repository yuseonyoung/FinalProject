<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	
<style>
@import 'https://fonts.googleapis.com/icon?family=Material+Icons|Roboto';

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
none;
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


<div class="container">
	<input id="mem_id" type="hidden" value="<sec:authentication property="principal.username"/>" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.realUser.empCd" var="loginId" />
		<sec:authentication property="principal.realUser.empNm" var="loginName" />
	</sec:authorize>
	<div class="row">
		<div class="col-md-9">
			<div class="card mb-2" id="card-container">
	    		<!-- 내정보 메인 -->
				<div class="card-body" id="contentHome">
					<h5 class="card-title">기본정보</h5>
					<table class="table">
						<colgroup>
							<col style="width: 25%">
							<col style="width: 35%">
							<col style="width: 40%">
						</colgroup>
						<tbody>
							<tr>
								<td class="align-middle">이름</td>
								<td class="align-middle">${empVO.empNm }</td>
								<td rowspan="5"><img class="rounded-3" src="${empVO.empImg}" width="100%" height="220px" style="object-fit: cover;" /></td>
							</tr>
	
							<tr>
								<td class="align-middle">사번</td>
								<td id="trUsrId" class="align-middle">${empVO.empCd }</td>
							</tr>
							
							<tr>
								<td class="align-middle">핸드폰번호</td>
								<td id="userTelno" class="align-middle">${empVO.empTelNo }</td>
							</tr>
							
							<tr>
								<td class="align-middle">성별</td>
								<c:if test="${empVO.empGend == 'M'}">
									<td class="align-middle ">남성</td>
								</c:if>
								<c:if test="${empVO.empGend == 'F'}">
									<td class="align-middle ">여성</td>
								</c:if>
							</tr>
	
							<tr>
								<td class="align-middle">생일</td>
								<td class="align-middle">${empVO.empBirth }</td>
							</tr>
	
							<tr>
								<td class="align-middle">입사일</td>
								<td id="trJoinYmd" class="align-middle">${empVO.hrSdate }</td>
								<td rowspan="4"><img class="rounded-3" src="${empVO.empSign}" width="100%" style="object-fit: cover;">
							</tr>
							
							<tr>
								<td class="align-middle">부서</td>
								<td class="align-middle">${empVO.deptNm }</td>
							</tr>
							
							<tr>
								<td class="align-middle">직급</td>
								<td class="align-middle">${empVO.hrGradeNm }</td>
							
							</tr>
							<tr>
								<td class="align-middle">직무</td>
								<td class="align-middle">${empVO.hrChargeNm }</td>
				            </tr>
	       			   </tbody>
	        	</table>
	        </div> 
	        <!-- 내정보 메인 끝 -->
	      
	        <!-- 사진정보변경에 대한 카드 내용 시작 -->
	        <div class="card-body" id="content1" style="display: none;">
	        	<h5 class="card-title">사진 정보 변경</h5>
	        	<table class="table text-center" >
	          		<tbody>
	            		<tr> 
	             			<td><img class="rounded-3" src="${empVO.empImg}" width="50%"  style="object-fit: cover;"></td>
	            		</tr>
	            		<tr> 
	              			<td>
								<form id="personpicForm" action="/mypage/personpic" method="post" enctype="multipart/form-data">
									<input class="form-control" id="personpic" name="personpic" type="file" />
									<button id="btnRegPersonPic" class="btn btn-secondary me-3 text-center mt-3" type="submit">저장</button>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								</form>
	              			</td>
	            		</tr>
					</tbody>
				</table>
	        </div>
	        <!-- 사진정보변경에 대한 카드 내용 끝  -->
	        
	        <!-- 서명정보변경에 대한 카드 내용 시작 -->
	        <div class="card-body" id="content5" style="display: none;">
	        	<h5 class="card-title">서명 정보 변경</h5>
	        	
	        	<table class="table text-center" >
	          		<tbody>
	            		<tr> 
	            			<!-- 원본 이미지 -->
	             			<td><img id="originalImage" class="rounded-3" src="${empVO.empSign}" width="50%"  style="object-fit: cover;"></td>
	             			<!-- 새 이미지 -->
	             			<td><img id="newImage" class="rounded-3" src='"\resources\images\emp\empSign\sign"+${empVO.empSign}+".png"' width="50%" style="object-fit: cover;"></td>
	            		</tr>
	            		<tr> 
	              			<td>
								<form id="signForm" action="/mypage/regSign" method="post" enctype="multipart/form-data">
									<input class="form-control" id="regSign" name="regSign" type="file" />
									<button id="btnRegSign" class="btn btn-primary me-3 text-center mt-3" type="submit">저장</button>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<button id="btnDrawSign" data-bs-toggle="modal" data-bs-target="#drawSign" class="btn btn-outline-primary me-3 text-center mt-3" type="button">서명하기</button>
								</form>
	              			</td>
	            		</tr>
					</tbody>
				</table>
	        </div>
	        <!-- 서명정보변경에 대한 카드 내용 끝  -->
	        
	        <!-- 사인그리기 모달 -->
			<div class="modal fade" id="drawSign" data-bs-keyboard="false"
				data-bs-backdrop="static" tabindex="-1" data-bs-target="#btnDrawSign"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog mt-6" role="document">
					<div class="modal-content border-0">
						<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
							<button type="button"
								class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
								data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body p-0">
							<div class="bg-light rounded-top-3 py-3 ps-4 pe-6">
								<h4 class="mb-1" id="staticBackdropLabel">서명란</h4>
							</div>
								<!-- 서명 공간 -->
								<div style="width:500px; height:300px;" style="z-index: 99999">
								  <canvas id="canvas"  style="border:1px solid black" style="z-index: 9999999"></canvas>
								</div>
								<!-- 서명 공간 -->
							<div class="p-4">
								<div class="text-center">
									<button type="button" id="save" class="btn btn-primary"
										data-bs-dismiss="modal" aria-label="Close">저장</button>
									<button type="button" id="clear" class="btn btn-outline-primary"
										aria-label="Close">초기화</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 사인그리기 모달 -->
	        
	        <!-- 비밀번호변경에 대한 카드 내용 시작 -->
	        <div class="card-body" id="content2" style="display: none;">
	        	<h5 class="card-title mb-4">비밀번호 변경</h5>
	       		<div class="row mb-3">
					<div>
						<label class="col-form-label" for="passwordNow">현재 비밀번호</label>
					</div>
					<div>
						<input class="form-control" id="passwordNow" type="password" required="required"/>
					</div>
				</div>
	       		<div class="row mb-3">
					<div>
						<label class="col-form-label" for="passwordNew">새로운 비밀번호</label>
					</div>
					<div>
						<input class="form-control" id="passwordNew" type="password" required="required" />
					</div>
				</div>
	       		<div class="row mb-3">
					<div>
						<label class="col-form-label" for="passwordNewCheck">비밀번호 확인</label>
					</div>
					<div>
						<input class="form-control" id="passwordNewCheck" type="password" required="required"/>
					</div>
				</div>
				<button id="btnRegPersonPic" class="btn btn-secondary me-3 text-center mt-3" onclick="changePw()" type="submit">저장</button>
				<div id="liveAlertPlaceholderPassword"></div>
	        </div>
	        <!-- 비밀번호변경에 대한 카드 내용 끝 -->
	        
	      </div><!-- card-container 끝 -->
	    </div><!-- class="col-md-9 끝 -->
	    
	    
	    
		<div class="col-md-3">
			<div class="card mb-2">
	    		<div class="card-body">
					<!-- 사이드바 항목 -->
					<div class="table-responsive">
	        			<table class="table">
							<colgroup>
								<col style="width: 30%">
								<col style="width: 70%">
							</colgroup>
							<tbody>
								<tr>
									<td style="padding: 0; margin: 0; display: flex; justify-content: center; align-items: center; vertical-align: middle;">
										<div style="width: 60px; height: 60px; overflow: hidden;">
											<img class="rounded-circle" src="${empVO.empImg}" width="100%" height="100%" style="object-fit: cover;">
								  		</div>
									</td>
									<td class="cursor-pointer" style="vertical-align: middle;" onclick="goToContentHome()">${empVO.empNm}</td>
								</tr>
		          			</tbody>
	        			</table>
	      			</div>
	
					<ul class="list-group cursor-pointer">
						<li class="list-group-item sidebar-item border-0" data-content="content1">사진 정보 변경</li>
						<li class="list-group-item sidebar-item border-0" data-content="content5">서명 정보 변경</li>
						<li class="list-group-item sidebar-item border-0" data-content="content2">비밀번호 변경</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
var empPw = "${empInfoVO.empPw}";
//유저 비밀번호 변경
function changePw() {
    var passwordNowInput = document.getElementById('passwordNow');
    var passwordNow = passwordNowInput.value;
    var passwordNew = document.getElementById('passwordNew').value;
    var passwordNewCheck = document.getElementById('passwordNewCheck').value;
    

    var correctPassword = empPw; // 실제로는 현재 비밀번호를 가져와야 합니다
    console.log("입력비밀번호:"+passwordNow);
    console.log("입력비밀번호:"+correctPassword);
    
    // 비밀번호 공백 검사
    if (passwordNow.length === 0) {
        console.log("현재 비밀번호를 입력해주세요.");
        pwAlert();
        return;
    } 

 	/* // 현재 비밀번호 일치 여부 검증
    if (passwordNow !== correctPassword) {
        console.log("현재 비밀번호가 일치하지 않습니다.");
        pwAlert2();
        return;
    }  */
    

    
 // 비밀번호 확인 유효성 검사
    if (passwordNew === '') {
        console.log("새로운 비밀번호를 입력해주세요.");
        pwAlert3();       
        return;
    }
 
    // 새로운 비밀번호 유효성 검사
    var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,25}$/;
    if (!reg.test(passwordNew)) {
        console.log("영문자와 숫자를 조합하여 4~25자리로 입력해주세요.");
        pwAlert4();   
        return;
    }
    
 // 비밀번호 확인 유효성 검사
    if (passwordNewCheck === '') {
        console.log("비밀번호 확인을 입력해주세요.");
        pwAlert5();   
        return;
    }
    
 
    // 비밀번호 일치 여부 검증
    if (passwordNew !== passwordNewCheck) {
        console.log("새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        pwAlert6();   
        return;
    }
    
	console.log("비밀번호 변경 완료");
    console.log(passwordNew)
    
    var loginIdSession = '${loginId}'
    console.log("로그인아이디!" ,loginIdSession );
    var data = {
    	"empCd" : loginIdSession,
    	"empPw" : passwordNew,
    	"empPpw" : passwordNow
    }
    console.log("나는 보낼 데이터!! : " ,data)
    
	$.ajax({
		url : "/mypage/changePw",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data),
		type : "post",
		dataType : "text",
		success : function(result) {
			console.log("나는 돌아온 아작스!!")
			console.log(result)
		    pwAlert7(); 
			
			if(result==="success"){
				pwAlert7();
			}else{
				pwAlert6();  
			}
	
		},
		error : function(xhr, status, error) {
			console.log("에러 발생:", error);
		}
	
	}); //ajax
   
}


const alertPlaceholderPW = document.getElementById('liveAlertPlaceholderPassword');
//비밀번호변경 오류 띄울 알림창
const pwAlert = () => {
	alertPlaceholderPW.innerHTML = [
  '<div class="alert alert-danger border-2 d-flex align-items-center" role="alert">',
  '	<div class="bg-danger me-3 icon-item"><span class="fas fa-times-circle text-white fs-3"></span></div>',
  '   <p class="mb-0 flex-1">현재 비밀번호를 입력해주세요.</p>',
  '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
  '</div>'
].join('');	
	
  setTimeout(() => {
	  alertPlaceholderPW.innerHTML = '';
    }, 2000);
}

const pwAlert2 = () => {
	alertPlaceholderPW.innerHTML = [
  '<div class="alert alert-danger border-2 d-flex align-items-center" role="alert">',
  '	<div class="bg-danger me-3 icon-item"><span class="fas fa-times-circle text-white fs-3"></span></div>',
  '   <p class="mb-0 flex-1">현재 비밀번호가 일치하지 않습니다.</p>',
  '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
  '</div>'
].join('');
	
	
  setTimeout(() => {
	  alertPlaceholderPW.innerHTML = '';
    }, 2000);
}

const pwAlert3 = () => {
	alertPlaceholderPW.innerHTML = [
  '<div class="alert alert-danger border-2 d-flex align-items-center" role="alert">',
  '	<div class="bg-danger me-3 icon-item"><span class="fas fa-times-circle text-white fs-3"></span></div>',
  '   <p class="mb-0 flex-1">새로운 비밀번호를 입력해주세요.</p>',
  '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
  '</div>'
].join('');
	
	
  setTimeout(() => {
	  alertPlaceholderPW.innerHTML = '';
    }, 2000);
}

const pwAlert4 = () => {
	alertPlaceholderPW.innerHTML = [
  '<div class="alert alert-danger border-2 d-flex align-items-center" role="alert">',
  '	<div class="bg-danger me-3 icon-item"><span class="fas fa-times-circle text-white fs-3"></span></div>',
  '   <p class="mb-0 flex-1">영문자와 숫자를 조합하여 5~25자리로 입력해주세요.</p>',
  '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
  '</div>'
].join('');
	
	
  setTimeout(() => {
	  alertPlaceholderPW.innerHTML = '';
    }, 2000);
}
const pwAlert5 = () => {
	alertPlaceholderPW.innerHTML = [
  '<div class="alert alert-danger border-2 d-flex align-items-center" role="alert">',
  '	<div class="bg-danger me-3 icon-item"><span class="fas fa-times-circle text-white fs-3"></span></div>',
  '   <p class="mb-0 flex-1">비밀번호 확인을 입력해주세요.</p>',
  '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
  '</div>'
].join('');
	
	
  setTimeout(() => {
	  alertPlaceholderPW.innerHTML = '';
    }, 2000);
}
const pwAlert6 = () => {
	alertPlaceholderPW.innerHTML = [
  '<div class="alert alert-danger border-2 d-flex align-items-center" role="alert">',
  '	<div class="bg-danger me-3 icon-item"><span class="fas fa-times-circle text-white fs-3"></span></div>',
  '   <p class="mb-0 flex-1">새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다.</p>',
  '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
  '</div>'
].join('');
	
	
  setTimeout(() => {
	  alertPlaceholderPW.innerHTML = '';
    }, 2000);
}


const pwAlert7 = () => {
	alertPlaceholderPW.innerHTML = [
  '<div class="alert alert-success border-2 d-flex align-items-center" role="alert">',
  '<div class="bg-success me-3 icon-item"><span class="fas fa-check-circle text-white fs-3"></span></div>',
  '<p class="mb-0 flex-1">비밀번호 변경 완료.</p>',
  '<button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close"></button>',
'</div>'
  
].join('');	
	
  setTimeout(() => {
	  alertPlaceholderPW.innerHTML = '';
    }, 2000);
}









//전화번호 하이픈
var phoneNo = '${empVO.empTelNo}'
	phoneNo = phoneNo.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	//console.log(phoneNo)
	$("#empTelNo").text(phoneNo);


//인물사진 변경
$('#personpicForm').submit(function(event) {
    event.preventDefault(); // 폼 제출 기본 동작 막기

    var formData = new FormData(this); // 폼 데이터 생성

    $.ajax({
        url: $(this).attr('action'), // 폼의 action 속성 값으로 URL 지정
        type: $(this).attr('method'), // 폼의 method 속성 값으로 요청 메서드 지정
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
        	 setTimeout(function() {
        	        location.reload();
        	    }, 3000); // 1초(1000밀리초) 지연 후 페이지 새로고침
            // 파일 업로드 성공 시 페이지 새로고침
            location.reload();
        },
        error: function(xhr, status, error) {
        }
    });
});


//서명사진 변경
$('#signForm').submit(function(event) {
    event.preventDefault(); // 폼 제출 기본 동작 막기

    var formData = new FormData(this); // 폼 데이터 생성

    $.ajax({
        url: $(this).attr('action'), // 폼의 action 속성 값으로 URL 지정
        type: $(this).attr('method'), // 폼의 method 속성 값으로 요청 메서드 지정
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
        	 setTimeout(function() {
        	        location.reload();
        	    }, 3000); // 1초(1000밀리초) 지연 후 페이지 새로고침
            // 파일 업로드 성공 시 페이지 새로고침
            location.reload();
        },
        error: function(xhr, status, error) {
        }
    });
});


//메인화면보이기
document.getElementById('contentHome').style.display = 'block';

// 사이드바 항목 클릭 이벤트 핸들러
var sidebarItems = document.getElementsByClassName('sidebar-item');
for (var i = 0; i < sidebarItems.length; i++) {
	sidebarItems[i].addEventListener('click', function() {
	    var contentId = this.getAttribute('data-content');
	    var cardContainer = document.getElementById('card-container');
	    var contentElements = cardContainer.getElementsByClassName('card-body');
	    for (var j = 0; j < contentElements.length; j++) {
	      if (contentElements[j].id === contentId) {
	        contentElements[j].style.display = 'block';
	      } else {
	        contentElements[j].style.display = 'none';
	      }
	    }
  });
}

//메인화면다시클릭
function goToContentHome() {
    var cardContainer = document.getElementById('card-container');
    var contentElements = cardContainer.getElementsByClassName('card-body');
    for (var i = 0; i < contentElements.length; i++) {
	    if (contentElements[i].id === 'contentHome') {
	      contentElements[i].style.display = 'block';
	    } else {
	      contentElements[i].style.display = 'none';
	    }
    }
  }



  
/* //사번 가져오기
 var trUsrIdElement = document.getElementById('trUsrId');
 var trUsrId = trUsrIdElement.innerText;
 trUsrId = trUsrId.split('_')[1];
 trUsrIdElement.innerText = trUsrId; */
 
 //입사일 가져오기
 var trJoinYmdElement = document.getElementById('trJoinYmd');
 var trJoinYmd = trJoinYmdElement.innerText;
 trJoinYmd = trJoinYmd.split(' ')[0];
 trJoinYmdElement.innerText = trJoinYmd;

</script>

<script>
//초기에는 새 이미지를 숨깁니다.
$("#newImage").hide();

(function(obj){
    obj.init();
    $(obj.onLoad);
  })((function(){
    var canvas = $("#canvas");
    var div = canvas.parent("div");
    // 캔버스의 오브젝트를 가져옵니다.
    var ctx = canvas[0].getContext("2d");
    var drawble = false;
    var initialPosition = {
    	    X: canvas[0].width / 2, // 캔버스의 가로 중앙
    	    Y: canvas[0].height / 2 // 캔버스의 세로 중앙
    	};
    
    function canvasResize(){
      canvas[0].height = div.height();
      canvas[0].width = div.width();
    }
    // pc에서 서명을 할 경우 사용되는 이벤트입니다.
    function draw(e){
      function getPosition(){
    	var rect = canvas[0].getBoundingClientRect();
        return {
        	 X: e.clientX - rect.left - canvas[0].width / 2 + 250,
             Y: e.clientY - rect.top - canvas[0].height / 2 + 150
        }
      }
      switch(e.type){
        case "mousedown":{
          drawble = true;
          ctx.beginPath();
          ctx.moveTo(getPosition().X, getPosition().Y);
        }
        break;
        case "mousemove":{
          if(drawble){
            ctx.lineTo(getPosition().X, getPosition().Y);
            ctx.stroke();
          }
        }
        break;
        case "mouseup":
        case "mouseout":{
          drawble = false;
          ctx.closePath();
        }
        break;
      }
    }
    
    // mousedown은 touchstart와 mousemove는 touchmove, mouseup은 touchend와 같음
    return {
      init: function(){
        // 캔버스 사이즈 조절
        $(window).on("resize", canvasResize);
        
        canvas.on("mousedown", draw);
        canvas.on("mousemove", draw);
        canvas.on("mouseup", draw);
        canvas.on("mouseout", draw);
        // save 버튼을 누르면 imageupload.php로 base64코드를 보내서 이미지로 변환합니다.
        $("#save").on("click", function(){
        	
        	
          // a 태그를 만들어서 다운로드를 만듭니다.
          var link = document.createElement('a'); 
          // base64데이터 링크 달기
          link.href = canvas[0].toDataURL("Sign"+${empVO.empCd }); 
          // 다운로드시 파일명 지정
          link.download = ${empVO.empCd }+"Sign"; 
          // body에 추가
          document.body.appendChild(link); 
          link.click(); 
          document.body.removeChild(link); 
          // 다운로드용 a 태그는 다운로드가 끝나면 삭제합니다.
          form.remove();
        });
        
        $("#clear").on("click", function(){
        	ctx.clearRect(0, 0, canvas[0].width, canvas[0].height); // 캔버스를 초기화합니다.
        });
      },
      onLoad: function(){
        // 캔버스 사이즈 조절
        canvasResize();
      }
    }
  })());
</script>

