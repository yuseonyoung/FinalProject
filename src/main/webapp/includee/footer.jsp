<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
  #toast-body {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 50px;
  }

  #toast-body p {
    margin: 0; 
  }
</style>
<!-- footer 시작 -->
<footer class="footer">
	<div class="row g-0 justify-content-between fs--1 mt-4 mb-3">
		<div class="col-12 col-sm-auto text-center">
			<p class="mb-0 text-600">
				Auto Inventory Management <span class="d-none d-sm-inline-block">|
				</span><br class="d-sm-none" /> 2023 &copy; <a
					href="https://themewagon.com">1조</a>
			</p>
		</div>
	</div>
</footer>
<!-- footer 끝 -->



<!-- toast 알림 시작 -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
	<div id="liveToast" class="toast hide" role="alert"
		aria-live="assertive" aria-atomic="true">
		<div class="toast-header">
			<!--       <img src="#" class="rounded me-2" alt="..."> -->
			<strong class="me-auto alarm-ttl">알람</strong>
			<button type="button" class="btn-close" data-bs-dismiss="toast"
				aria-label="Close"></button>
		</div>
		<div id="toast-body" >
		</div>
	</div>
</div>
<!-- toast 알림 끝 -->

<script>

let domainName = location.href.split("/")[2];
console.log("domainname:",domainName);
let alarmSocket =  new WebSocket(`ws://\${domainName}/alarm`);  // 클라이언트 소켓 <-> 서버소켓과 연결 통신하기 위함
//연결이 성공해서 커넥션이 열리면 자동으로 open 이벤트가 발생
const fSocOpen = () =>{
	console.log("연결성공");
	alarmSocket.send("서버야 내 메세지 받아");

}

const fSocMsg = () => {
  console.log("서버에서 온 메세지" + event.data);
	
	$('#noti-alarm').addClass('notification-indicator notification-indicator-warning');

    document.querySelector("#toast-body").innerHTML = event.data;
    var toast = new bootstrap.Toast(document.getElementById('liveToast'));
    toast.show();
}





alarmSocket.onopen = fSocOpen;

//서버에서 메세지가 오면 자동으로 onmessage 이벤트 발생
alarmSocket.onmessage = fSocMsg;







</script>

