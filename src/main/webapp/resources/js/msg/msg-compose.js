/**
 * 
 */


var text = $('#msg-text');
var title = $('#msg-title');
var csrfToken = $("input[name='_csrf']").val();

	// WebSocket을 사용하여 메시지를 보내는 부분
	// 매개변수 첫번째는 도착지, "/pub"은 spring controller로 보낸다는 stomp prefix 규칙. 즉 "/pub"뒤가 진짜 주소
	// 매개변수 두번째는 서버로 보낼 때 추가하고 싶은 stomp 헤더, 아무것도 안보내고 싶으면 {}
	// 매개변수 세번째는 서버로 보낼 때 추가하고 싶은 stomp 바디, 서버 컨트롤러에서는 mapping된 함수의 string 인자로 json stringify된 문자열을 받을 수 있음.
	
$("#msg-send").on("click", function(e) {

	$.ajax({
		url: '/msg/save',
		data: {
			sender: empCd,
			empCd: $('#receiver').val(),
			msgCont: text.val(),
			msgTitle: title.val()
		},
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'X-CSRF-TOKEN': csrfToken
		},
		type: 'post',
		success: (res) => {
			
			let domainName = location.href.split("/")[2];

			let alarmSocket =  new WebSocket(`ws://${domainName}/msg`);  // 클라이언트 소켓 <-> 서버소켓과 연결 통신하기 위함
			
			// 연결이 성공해서 커넥션이 열리면 자동으로 open 이벤트가 발생
			const fSocOpen = () =>{
				console.log("연결성공");
				//alarmSocket.send("서버야 내 메세지 받앙");
			
			}
			
			
			
			const fSocMsg = () => {
				
			/*   alert("mailSend.js 서버에서 온 메세지" + event.data);
			  document.querySelector("#toast-body").innerHTML += event.data;
			   var toast = new bootstrap.Toast(document.getElementById('liveToast'));
			   toast.show();*/
				
			}
			
			
			alarmSocket.onopen = fSocOpen;
			alarmSocket.onerror = (error) => {
			  console.error("WebSocket 오류:", error);
			}
			
			console.log("ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ")
			
			let fSend = function(res) {
						//alarmSocket.send(jbTxt.value);
						console.log("resres");
						console.log(res);
						
						
						var sender = res.sender;
						var reciever = res.empCd;
						var senNm = res.senNm;
						var recNm = res.recNm;
						console.log("아래 확인해봐ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ")
						console.log(senNm);
						console.log(recNm);
						
						alarmSocket.send(JSON.stringify({
						    cmd: "msg",
						    sender: sender,
						    receiver: reciever,
							senNm:senNm,
							recNm:recNm
						})); 
						
						
						
					}
			
			//서버에서 메세지가 오면 자동으로 onmessage 이벤트 발생
			alarmSocket.onmessage = fSocMsg;
			
			location.href = "/msg/inbox";
		},
	})
});

$('#jusorok').on('click', function() {
	$.ajax({
		url: '/address/book/popup',
		type: 'post',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
			'X-CSRF-TOKEN': csrfToken
		},
		success: function(res) {
			$('.modal-body').html(res);
			$('#exampleModal').modal('show');
		}
	});
});