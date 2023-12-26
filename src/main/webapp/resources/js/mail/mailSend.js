/**
 * <pre>
 * 
 * </pre>
 * @author ``
 * @since 2023. 11. 24.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 24.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */


let domainName = location.href.split("/")[2];

let alarmSocket =  new WebSocket(`ws://${domainName}/mail`);  // 클라이언트 소켓 <-> 서버소켓과 연결 통신하기 위함

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


let fSend = function(res) {
			console.log("resres");
			console.log(res);
			
			
			var sender = res.mailSen;
			var reciever = res.mailRec;
			var senNm = res.senNm;
			var recNm = res.recNm;
			console.log("아래 확인해봐ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ")
			console.log(senNm);
			console.log(recNm);
			
			alarmSocket.send(JSON.stringify({
			    cmd: "mail",
			    sender: sender,
			    receiver: reciever,
				senNm:senNm,
				recNm:recNm
			})); 
			
			
			
		}

//서버에서 메세지가 오면 자동으로 onmessage 이벤트 발생
alarmSocket.onmessage = fSocMsg;







function fileRemove(event) {
	console.log("jj");
	console.log(event.target.closest("#file"));
	console.log(document.querySelector('#file'));

	event.target.closest("#file").remove();
}



const sjFilelist = [];  // 파일 객체를 담을 배열
let sjFilePre = `
        <div class="border px-2 rounded-3 d-flex flex-between-center bg-white dark__bg-1000 my-1 fs--1" id="file">
          <span class="fs-1 far fa-file-archive"></span>
          <span class="ms-2">
      `;

let sjFilePost = `
         </span><a onclick="fileRemove(event);" class="text-300 p-1 ms-6" data-bs-toggle="tooltip" data-bs-placement="right" title="Detach"><span class="fas fa-times"></span></a></div>
      `;

function sjFile(pThis) {
	let fileList = pThis.files;
	let tmpHtml = "";
	for (let i = 0; i < fileList.length; i++) {
		sjFilelist.push(fileList[i]);
		tmpHtml += sjFilePre + `${fileList[i].name}(${fileList[i].size})` + sjFilePost;
	}

	$(".fileview").first().html($(".fileview").first().html() + tmpHtml);
	console.log("체킁킁:", sjFilelist);




}

// send(submit) 버튼, 전송 전에 선택한 파일들 담아주기
document.forms[0].onsubmit = function() {
	$("input[name=mailFile]")[0].files = sjFilelist;
}

//모달창 show
function mailAddr() {
	$("#mailAddr").modal("show");
};



let chkmap = new Map([

])

$(selMail).on("click", "#resultBtn", function(event) {
	console.log("서치버튼 클릭됨");
	let html = "";
	var check = $("#mailRecInput")[0].querySelectorAll('input[type="checkbox"]');
	var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
	checkboxes.forEach(function(checkbox) {

		for (let i = 0; i < check.length; i++) {
			let chkboolean = check[i].checked;
			let cmail = check[i].value;
			let empCd = check[i].dataset.value;
			console.log(i, chkboolean);
			if (chkboolean == true) {
				chkmap.set(cmail, empCd);
			} else {
				chkmap.delete(cmail);
			}

		}
		console.log(chkmap);
		$("#mailAddr").modal("hide");
	});



	const keysArray = [...chkmap.keys()];
	console.log(keysArray);

	const valuesArray = [...chkmap.values()];
	``

	emps = valuesArray.toString();
	console.log(emps);
	html += keysArray;
	console.log("html이다" + html);
	console.log($("#email-to"));
	//$("#email-to").text(html);
	$("#email-to")[0].value = html;
	$("#mailRec").attr('value', emps);
	console.log($("#mailRec"));



});




let chk = 0;
var emps = "";

function selectAll(selectAll) {
	const checkboxes
		= document.querySelectorAll('input[type="checkbox"]');

	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked
	})
}


function selMailRec(event) {
	var deptNo = event.value; // 이벤트 객체에서 부서 번호 가져오기
	console.log(deptNo);
	console.log("/mail/addr?what=" + deptNo);
	$.ajax({
		url: "/mail/addr?what=" + deptNo,
		contentType: "application/json; charset=UTF-8",
		data: JSON.stringify(deptNo), // 데이터 전송
		success: function(res) {
			console.log("이거 아래 알이에스!!!");
			console.log(res);
			var html = "";
			for (var i = 0; i < res.empVO.length; i++) {
				html +=
					`  
	  	             <ul class="user_list">
	  	               <li class="user_item">
		  	               <div class="button_checkbox_wrap">
		  	                <input name="mailRecCmail" data-value=${res.empVO[i].empCd} value=${res.empVO[i].empCmail} type="checkbox" id="selection${i}" class="button_checkbox blind" >
							<input type="hidden" name="recNm" id="recNm" value="${res.empVO[i].empNm}" />
							<input type="hidden" name="senNm" id="senNm" value="${res.sendMail.senNm}" />
							<label for="selection_1" >${res.empVO[i].empNm}</label>
						   </div>
					   </li>
	  	             </ul>
					
  	              `;
			}
			$("#mailRecInput").html(html);
		},
		error: function(xhr, status, error) {
			console.error(xhr.responseText);
		}
	});
}

var file = null;
var fileData = [];
$("#email-attachment").on("change", function(event){
	file = event.target.files;
});

$("#mailSendBtn").on('click', function() {
		var formData = new FormData();
		/*$("#mailSenInput").val()*/
		formData.append("mailRec", $("#mailRec").val());
		formData.append("mailTitle", $("#mailTitle").val());
		formData.append("mailCont", $("#mailCont").val());
		console.log(fileData);
		if(file!=null){
			for(var i = 0; i < file.length; i++){
			formData.append("mailFile", file[i]);
			}
		}
		
		$.ajax({
			url: "/mail/send",
			type: "POST",
			processData: false,  // 너 디폴트로 데이타 처리 하지마 
			contentType: false,  // 디폴트값 application/x-www-form-urlencoded 설정하지마 
			data: formData,
			success: function(res) {
				console.log(res);
				fSend(res);
				Swal.fire({
	                icon: 'success',
	                title: '성공',
	                text: '메일이 성공적으로 발송되었습니다.'
	            }).then(function(){
					location.href="/mail/slist";                   
				})
			},
			error: function(error) {
				console.error('Ajax 요청 실패:', error);
			}
		});
	});


$('#autoBtn').on('click',function(){
	document.querySelector('#mailTitle').value="구매부 전원 확인해주세요.";
});

