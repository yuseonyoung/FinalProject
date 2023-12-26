/**
 * <pre>
 * 
 * </pre>
 * @author 이수정
 * @since 2023. 12. 6.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 12. 6.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 


/**
 * <pre>
 * 
 * </pre>
 * @author 이수정
 * @since 2023. 12. 4.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 12. 4.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 


/*알람div*/
let makeAlarmList = function(rslt) {
	
	let alarmList =
		`
		
		<div class="list-group-item">
          <a class="notification notification-flush notification-unread" href="${rslt.alarmUrl}">
            <div class="notification-body">
              <p class="mb-1">${rslt.alarmCont}</p>
              <span class="notification-time">${rslt.alarmCdate}</span>
            </div>
          </a>

        </div>
		
		
	    `;
	return alarmList;
};


/* 알람 조회 */
function retrieveAlarmList() {
	console.log("9999997777777777");
	let baseUrl = `/alarm/mail`;
	$.ajax({
		url: baseUrl,
		method: "GET",
		dataType: "json",
		success: function(resp) {
		    var alarmVO = resp.alarmVO;
		    console.log(resp);
		    let alarmLists = "";
		    if (alarmVO?.length > 0) {
				if(alarmVO.length<=10){
					for(let i=0; i<alarmVO.length; i++){
						alarmLists += makeAlarmList(alarmVO[i]);
					}
				}else{
					for(let i=0; i<10; i++){
						alarmLists += makeAlarmList(alarmVO[i]);
					}
				}
		    } else {
		        alarmLists += `
		            <table>
		                <tr>
		                    <td style="padding: 20px" class="text-nowrap">알람이 없습니다.</td>
		                </tr>
		            </table>
		        `;
		    }
		
		    $('#alarmCont').html(alarmLists);

			for(let i=0; i<alarmVO.length; i++){
				if(alarmVO[i].alarmChk == 'N'){
					$('#noti-alarm').addClass('notification-indicator notification-indicator-warning');
				}
			}
		},
				error: function(xhr, status, error) {
					console.log(xhr);
					console.log(status);
					console.log(error);
				}
			});
		};
		
function alarmChk() {
	// AJAX를 사용하여 서버에 요청을 보냄
	$.ajax({
		url: '/alarm/chk', // 실행할 컨트롤러 매핑 경로
		method: 'PUT', // 또는 GET 등 사용할 HTTP 메서드
		success: function(resp) {
			console.log("메일알람체크");
			console.log(resp);
			$('#noti-alarm').removeClass('notification-indicator notification-indicator-warning');
		},
		error: function(xhr, status, error) {
			// 에러 처리
			console.error(xhr, status, error);
		}
	});
}


retrieveAlarmList();

$('#alarmIcon').on('click',()=>{
		$('#noti-alarm').removeClass('notification-indicator notification-indicator-warning');
		alarmChk();
	});
