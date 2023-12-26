<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />

<style>
img .dz-image {
	height: 50%;
}

.fa-stack-2x {
	font-size: 1em;
}

.no-underline {
	text-decoration: none !important;
}

.my-img-size {
	width: 40px;
	height: 40px;
}

.jstree-icon {
	margin-right: 5px;
	margin-left: 0px;
}
</style>

${draftSelect.drSttsCd}
<form name="frm1"
	action="/draft/form/post?${_csrf.parameterName}=${_csrf.token}"
	method="post" enctype="multipart/form-data">
	<div class="d-flex">
	${draftSelect.drStrg}
		

	</div>



	<sec:csrfInput />
</form>

<script type="text/javascript">
	// 데이터 검증 및 처리 스크립트
	// 오늘 날짜 계산
	var today = new Date();
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var formattedDate = year + '-' + month + '-' + day;
	var formattedDate2 = year + '' + month + '' + day;
	
	document.querySelector("#sysdate").setAttribute("value", formattedDate);
	document.querySelector(".sysdate").innerText = formattedDate;
	
	//제목 자동 설정
	document.querySelector("#draftTitle").innerText = $("#draftFormTitle")[0].innerText + "-" + $("#colFormLabel3")[0].value+ "-" + formattedDate2;
	
	// 오늘 날짜 계산
	
	//휴가 기간 오류 체크
	var vacDate = document.querySelectorAll(".datetimepicker");
	
	$(document).ready(function() {
		$("thead")
		
	$("#vacChose").on("click", function() {
			
			$.ajax({
				url: '/draft/vac/info',
				  method: 'post', // 요청 방식 (GET, POST, 등등)
				  dataType: 'json', // 서버로부터 받아올 데이터 형식 (JSON으로 받아올 경우)
				  beforeSend: function(xhr) {
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			        },
				  success: function(data) { // 성공 시 처리할 콜백 함수
					  $.ajax({
						  url: '/draft/vac/info/MngCd',
						  method: 'post', // 요청 방식 (GET, POST, 등등)
						  dataType: 'json', // 서버로부터 받아올 데이터 형식 (JSON으로 받아올 경우)
						  beforeSend: function(xhr) {
					            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					        },success: function(resp) {
								console.log(data)
							  	console.log(resp)
								 var vacAjax = $("#vacAjax");
									vacAjax.html("");
								  if(data.length <= 0){
									  vacAjax.html( `<tr><td>사용할 수 있는 휴가가 없습니다</td></tr>`);
								  }
								  var te = "";
								for(var i = 0; i < data.length; i++){
									te += `			
											<tr>
												<td class="bg-primary-subtle text-center">` + data[i].vacNm + `</td>
												<td class="bg-primary-subtle text-center">` + data[i].remainVacDays + ` 일</td>
											</tr>
										`
									for(var j = 0; j < resp.length; j++) {
										te += 
										`
											<tr>
												<td class="mb-2">
													<div class="form-check mb-0">
														<input class="form-check-input"
															id="flexRadioDefault`+ i +``+ j +`"
															type="radio" name="flexRadioDefault"
															value="`+ resp[j].mngCd +`"
															code-name="`+ resp[j].mngCdNm1 +`"
															remain-vac="`+ data[i].remainVacDays +`"
															vac-grnt-no="`+ data[i].vacGrntNo +`" /> <label
															class="form-check-label m-0"
															for="flexRadioDefault`+ i +``+ j +`">`+ resp[j].mngCdNm1 +`</label>
													</div>
												</td>

										`
										if(j == 0) {
											te += `<td class="mb-2 text-center">09:00 ~ 18:00</td></tr>`
										}
										if(j == 1) {
											te += `<td class="mb-2 text-center">09:00 ~ 14:00</td></tr>`
										}
										if(j == 2) {
											te += `<td class="mb-2 text-center">14:00 ~ 18:00</td></tr>`
										}
									}
								}
								vacAjax.html(te);	
					        }
					  });
				  	
				  }
				});
			
		});
		
		
		tinymce.init({
		    selector: "#draftClobContent",
		});
		
		$("#getApproval").on('click', function() {
			
			$("#drSttsCd")[0].value = 'DF003';
			
			var startDate = $("#datepicker");
			var endDate = $("#datepicker2");
			startDate.removeClass('is-valid');
			endDate.removeClass('is-valid');
			
			var docHtml = document.querySelector("#doc");
			var copyDocHtml = docHtml.cloneNode(true);
			
			
			tinymce.get('draftClobContent').setContent(copyDocHtml.outerHTML);
			
			
			frm1.submit();
			
		});
		
		$("#getImsi").on('click', function() {
			
			$("#drSttsCd")[0].value = 'DF001';
			
			var startDate = $("#datepicker");
			var endDate = $("#datepicker2");
			startDate.removeClass('is-valid');
			endDate.removeClass('is-valid');
					
			var docHtml = document.querySelector("#doc");
			var copyDocHtml = docHtml.cloneNode(true);
			
			tinymce.get('draftClobContent').setContent(copyDocHtml.outerHTML);
			
			
			frm1.submit();
			
		});
		
		
		var vacElements = document.querySelectorAll('.vac');
		vacElements.forEach(function(element) {
		  element.disabled = false;
		});
		
		
		var select = document.querySelector("#vacChose");
		
		
		// 날짜 계산 함수
		function dateCale(startDate, endDate) {
			if(typeof startDate == 'string') {
				startDate = new Date(startDate);
			}
			if(typeof endDate == 'string') {
				endDate = new Date(endDate);
			}
			var dateResult = endDate - startDate;
			var dateCount = Math.floor(dateResult / (1000 * 60 * 60 * 24));
			
			// 당일 포함 계산 처리
			if(dateCount >= 0) {
				dateCount = dateCount + 1;
			}
			return dateCount;
		};
		
		
		const alertPlaceholder = document.getElementById('liveAlertPlaceholder');

		// 날짜 틀렸을때 보여줄 알람창
		const alert = () => {
			alertPlaceholder.innerHTML = [
		    '<div class="alert alert-danger border-2 d-flex align-items-center" role="alert">',
		    '	<div class="bg-danger me-3 icon-item"><span class="fas fa-times-circle text-white fs-3"></span></div>',
		    '   <p class="mb-0 flex-1">시작일은 종료일 이후일 수 없습니다.</p>',
		    '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
		    '</div>'
		  ].join('');
			
			
		    setTimeout(() => {
		        alertPlaceholder.innerHTML = '';
		      }, 3000);
		}
		
		const alert2 = () => {
			alertPlaceholder.innerHTML = [
		    '<div class="alert alert-danger border-2 d-flex align-items-center" role="alert">',
		    '	<div class="bg-danger me-3 icon-item"><span class="fas fa-times-circle text-white fs-3"></span></div>',
		    '   <p class="mb-0 flex-1">가지고있는 휴가보다 많은 휴가를 선택하셨습니다.</p>',
		    '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
		    '</div>'
		  ].join('');
			
		    setTimeout(() => {
		        alertPlaceholder.innerHTML = '';
		      }, 3000);
		}
		
		
		const alert3 = () => {
			alertPlaceholder.innerHTML = [
		    '<div class="alert alert-warning border-2 d-flex align-items-center" role="alert">',
		    '	<div class="bg-warning me-3 icon-item"><span class="fas fa-exclamation-circle text-white fs-3"></span></div>',
		    '   <p class="mb-0 flex-1">반차는 하루만 선택할 수 있습니다.</p>',
		    '   <button type="button" class="btn-close"  data-bs-dismiss="alert" aria-label="Close"></button>',
		    '</div>'
		  ].join('');
			
		    setTimeout(() => {
		        alertPlaceholder.innerHTML = '';
		      }, 3000);
		}
	//휴가 기간 오류 체크
	
	
	// 휴가 종류 선택 모달에서 확인 버튼 클릭
		$('#vacSetBtn').on("click", function() {
			var selectedRadio = document.querySelector('input[name="flexRadioDefault"]:checked');
			console.log("test: ", selectedRadio)
			if(selectedRadio != null) {
				clearVac();
				// 체크된 휴가 사용 목록 항목의 코드(ex: AU001)
				var selectedValue = selectedRadio.value;
				
				
				
				// 코드의 이름
				var codeName = selectedRadio.getAttribute('code-name');
				// 선택한 휴가 종류의 남은 기간
				var remainVac = selectedRadio.getAttribute('remain-vac');
				// 사용할 휴가의 부여받은 관리 번호
				var vacGrntNo = selectedRadio.getAttribute('vac-grnt-no');
				
				$("#vacGrntNo").val(vacGrntNo);
				
				select.value = codeName + " (남은휴가:" + remainVac + "일)";
				select.setAttribute("value", codeName + " (남은휴가:" + remainVac + "일)");
				
				select.setAttribute('vac-code', selectedValue);
				$("#vacTp")[0].value = selectedValue;
				$("#vacTp")[0].setAttribute("value", selectedValue);
				
				select.setAttribute('remain-vac', remainVac);
				
				// 잠금해제
				vacElements.forEach(function(element) {
					  element.disabled = false;
					});
				
				
				var picker = flatpickr(".datetimepicker", {
				  // 옵션 설정
				  onChange: function() {
						if((vacDate[0].value != "") && (vacDate[1].value != "")){
							dateMissMatch(codeName);
						}
				  }
				});
				
				var vacReason = $("#vacReason");
				vacReason.off().on("change", function() {
					vacReason.attr("value", vacReason.val());
				})
			}
		});
	
		
		
		// 휴가기간 선택창들이 변경될때 이벤트 발생
		
	
		// 휴가 유효성 검증 함수
		function dateMissMatch(codeName) {
			// 휴가 시작 날짜
			var startDate = $("#datepicker");
			startDate.attr("value", startDate.val());
			// 휴가 종료 날짜
			var endDate = $("#datepicker2");
			endDate.attr("value", endDate.val());
			// 휴가 사용할 날짜
			var vacDayCount = $("#vacDayCount");
			
			
			// 사용자가 사용 가능한 휴가 일 수
			var canUseDayCount = select.getAttribute('remain-vac');
			
			// 선택날짜가 시작날짜보다 작을경우 틀렸다는 알람과 input 태그 클래스 변경
			if(!codeName.includes('반차')) {
				
				if(vacDate[1].value < vacDate[0].value) {
					alert();
					startDate.addClass('is-invalid');
					endDate.addClass('is-invalid');
					startDate.removeClass('is-valid');
					endDate.removeClass('is-valid');
					
					// 정상적인 날짜 선택이라면
				} else {
					startDate.addClass('is-valid');
					endDate.addClass('is-valid');
					startDate.removeClass('is-invalid');
					endDate.removeClass('is-invalid');
					
					// 연차 휴가 사용 시
					// 사용 날짜 계산
					var dateCount = dateCale(vacDate[0].value, vacDate[1].value);
					
					// 사용 날짜 계산
					vacDayCount[0].value = dateCount;
					vacDayCount[0].setAttribute("value", dateCount);
					
					vacDayCount[0].name = "draftVacVO.cnyDay";
					$("#vacTimeCount2")[0].name = "";
					
					// 가지고있는 휴가보다 선택된 휴가가 더 길 경우
					if(Number(vacDayCount[0].value) > Number(canUseDayCount)) {
						// 검증 실패 클래스 부여
						endDate.addClass('is-invalid');
						// 잘못된 휴가 일 수 선택 알람
						alert2();
					}
				}
				
				// 반차라면
			} else {
				
				if(vacDate[1].value != vacDate[0].value) {
					endDate[0].value = startDate[0].value;
					endDate[0].setAttribute('value', startDate[0].value);
					alert3();
					dateMissMatch(codeName)
					// 정상적인 날짜 선택이라면
				} else if(vacDate[1].value == vacDate[0].value) {
					startDate.addClass('is-valid');
					endDate.addClass('is-valid');
					startDate.removeClass('is-invalid');
					endDate.removeClass('is-invalid');
					
					// 사용 날짜 계산
					$("#vacTimeCount")[0].value = 4;
					$("#vacTimeCount")[0].setAttribute('value', 4);
					$("#vacTimeCount2")[0].name = "draftVacVO.cnyDay";
					$("#vacDayCount")[0].name = "";
					
					// 가지고있는 휴가보다 선택된 휴가가 더 길 경우
					if(Number(vacDayCount[0].value) > Number(canUseDayCount)) {
						// 검증 실패 클래스 부여
						endDate.addClass('is-invalid');
						// 잘못된 휴가 일 수 선택 알람
						alert2();
					}
				}
			}
			
		};
	
// 	휴가 종류 선택 모달에서 확인 버튼 클릭
	
	// 휴가 내용 지우기 버튼
		$('#delVac').on("click", function() {
			clearVac();
		});
	// 내용 지우기 버튼
	
		function clearVac() {
			$("#datepicker")[0].value = "";
			$("#datepicker")[0].setAttribute('value', "");
			
			$("#datepicker2")[0].value = "";
			$("#datepicker2")[0].setAttribute('value', "");
			
			$("#vacDayCount")[0].value = "";
			$("#vacDayCount")[0].setAttribute('value', "");
			
			$("#vacTimeCount")[0].value = "";
			$("#vacTimeCount")[0].setAttribute('value', "");
			
			$("#vacReason")[0].value = "";
			$("#vacReason")[0].setAttribute('value', "");
			
			var startDate = $("#datepicker");
			var endDate = $("#datepicker2");
			
			startDate.removeClass('is-valid');
			endDate.removeClass('is-valid');
			startDate.removeClass('is-invalid');
			endDate.removeClass('is-invalid');
			
			select.setAttribute('vac-code', "");
			select.setAttribute('remain-vac', "");
			select.value ="";
			select.setAttribute("value", "");
		}
		
		var count = 0;
		
		
	// 기안 의견 데이터 전달
	    $("#draftRegistOpnion").keyup(function(event) {
	        if (event.which === 13) {
	            $("#setOpnionBtn").click();
	        }
	    });
	    
		$("#setOpnionBtn").on("click", function() {
			var draftShowOpinion = document.querySelector("#draftShowOpinion");
			var draftRegistOpnion = document.querySelector("#draftRegistOpnion");
			
			var opinion = draftRegistOpnion.value;
			
			if(document.getElementById("opZero")){
				$("#opZero").remove();
			}
			var nowTime = new Date();
			
			var opinionTemp = `<input class="form-control-plaintext" name="draftOpnVOList[` + count + `].opnnCn" readonly value="${draftUserVO.userNm}: ` + opinion +  `"/>`
			opinionTemp += `<input type="hidden" name="draftOpnVOList[` + count + `].userId" value="${draftUserVO.userId}"/>`
			opinionTemp += `<input type="hidden" name="draftOpnVOList[` + count + `].drOpnnDt" value="`+ nowTime +`"/>`
			count++;
			draftShowOpinion.innerHTML += opinionTemp;
			
			draftRegistOpnion.value = "";
		});
	// 기안 의견 데이터 전달
	
	});

</script>

<!-- 결재선 설정 자바스크립트 -->
<script>
  var jQuery1x = jQuery.noConflict();
</script>

<script type="text/javascript">
$(function (){
	
	// DB에서 조직 정보 가져오기
	jQuery1x.ajax({
		url:"/organization/jsonList",
		type:"post",
		dataType:"json",
		beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(result){
			//[{"userId":"NAVER_2023060009","userNm":"김윤아","userTelno":"01029949383","userEml":"2023060009@naver.com","userImg":"NULL","deptNo":1,"jbgdCd":"JG001","jbtlCd":"JT001"}
		 	const data = [];
		 	let nodes = result;
		 	
		 	// parent 기준으로 데이터 정리
		 	const parents = {};
		 	nodes.forEach(node => {
		 	  if (!parents[node.parent]) {
		 	    parents[node.parent] = [];
		 	  }
			  // idCard를 가져올 때 index가 아니라 id를 가져와야 함!!
		 	  parents[node.parent].push({name : node.child, id : node.id, jbgdCd : node.jbgdCd, userImg: node.img, deptNm : node.dept});
		 	});
			
		 	// jstree에서 사용할 수 있는 형태로 데이터 변환
		 	Object.keys(parents).forEach(parent => {
		 	  const children = parents[parent].map(child => {
		 	    return {text: child.name + " " + child.jbgdCd, type: "file", id : child.id, userImg : child.userImg, deptNm : child.deptNm};
		 	  });
		 	  data.push({
		 	    text: parent,
		 	    children: children
		 	  });
		 	});
		 	
		 	// ajax data 받아오기 
		 	jQuery1x('#jstree').jstree({
		 		'core': {
		 			"check_callback" : true,
		 			'data': data
		 			},
		 		"types" :{
		 			"default" : {
		 				"icon" : "fa-solid fa-folder"
		 			},
		 			"file" : {
		 				"icon" : "fa-solid fa-address-card"
		 			}
		 		},	
		 		"plugins" : ["types", "dnd", "search"]
		 		
		 		
		 		//children node 클릭했을때 hidden 처리 해제
		 	}).on('select_node.jstree', function(event, data) {
		 		
				var selectedNode = data.node;
				// 자식 노드(사원 정보)일 경우 이벤트 실행
				if(selectedNode.parent != '#') {
					//중복 실행 방지
					$("#draftmy1").off().on('click', function() {
						lineEdit(selectedNode);
					})
					
					$("#draftmy2").off().on('click', function() {
						susinEdit(selectedNode);
					})
					
					$("#draftmy3").off().on('click', function() {
						ramEdit(selectedNode);
					})
					
							
					//취소 버튼
					$("#lineClose").off().on("click", function() {
						$(".draft-line, .draft-susin, .draft-ram").remove();
						$(".draft-div").removeClass("d-none");
					
					});

					// 확인 버튼
					$("#lineSave").off().on("click", function() {
						// 확정이 난 데이터에서 수정할 데이터라는 뜻을 가진 클래스를 지워줌
						$(".draft-line, .draft-susin, .draft-ram").removeClass("draft-line draft-susin draft-ram");
						// 삭제버튼을 눌러 d-none 처리했던 태그들을 지워줌
						$(".draft-div.d-none, .draft-div.d-none, .draft-div.d-none").remove();
						
						// 확인 누르면 기존에 등록된 html을 초기화
						$("#draftLineDisplay, #draftSusinDisplay, #draftRamDisplay").html("");
						
						$(".signBox").remove();
					
						//추가로 생성됬던 태그들을 결재선 설정 밖으로 보내줌
						$("#lineSpace > .alert").each(function(index, value) {
							changeDisplay(index, value);
								
						});
						
						// 수신자 처리
						$("#susin > .alert").each(function(index, value) {
							chageDisplay2(index, value);
						});
						
						// 회람자 처리
						$("#ram > .alert").each(function(index, value) {
							chageDisplay3(index, value);
						});
						
						
					})
				}
		 	});
		}
	});
	
	
	//여기다 DB에서 가져온 값을 모델에 넣고 버튼 클릭 이벤트 발생 시키면 자동으로 데이터 들어가짐
// 	var draftAtrzVO = JSON.parse(test22
// 		.replace(/(\w+)\(/g, '{')   // 객체 이름 제거
// 		.replace(/\(/g, '{')            // 객체 시작 중괄호로 변경
// 		.replace(/\)/g, '}')            // 객체 종료 중괄호로 변경
// 		.replace(/(\w+)=(\w+)/g, '"$1":"$2"') // 속성 이름과 값을 따옴표로 감싸기
// 	);
// 	console.log(draftAtrzVO.atrzSn);
// 	console.log(draftAtrzVO.drNo);
// 	console.log(draftAtrzVO.userId);	
        
	var lineIndexNum = 0;
	function chageDisplay2(index, value) {
		var content = value.cloneNode(true);
		
		var draftLineContent = content.querySelector('.card-body > .d-flex')
		content.classList.remove('kanban-item');
		content.classList.add('col');
		
		var btnDelDraft = content.querySelector('.draft-del-btn');
		btnDelDraft.remove();
		
	// form에 전달할 userId 생성
		var atrzUserId = content.querySelector('#lineId').value;
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].userId');
		inputHiddenId.setAttribute('value', atrzUserId);
		
		draftLineContent.prepend(inputHiddenId);
	// form에 전달할 userId 생성
	
	// form에 전달할 atrzSn 생성
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].atrzSn');
		inputHiddenId.setAttribute('value', 0);
		
		draftLineContent.prepend(inputHiddenId);
	// form에 전달할 atrzSn 생성
	
	// form에 전달할 atrzCd 생성
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].atrzCd');
		inputHiddenId.setAttribute('value', 'DR002');
		
		draftLineContent.prepend(inputHiddenId);
		
		lineIndexNum++;
	// form에 전달할 atrzCd 생성
		
		$("#draftSusinDisplay").append(content);
	}
	
	function chageDisplay3(index, value) {
		var content = value.cloneNode(true);
		
		var draftLineContent = content.querySelector('.card-body > .d-flex')
		content.classList.remove('kanban-item');
		content.classList.add('col');
		
		var btnDelDraft = content.querySelector('.draft-del-btn');
		btnDelDraft.remove();
		
	// form에 전달할 userId 생성
		var atrzUserId = content.querySelector('#lineId').value;
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].userId');
		inputHiddenId.setAttribute('value', atrzUserId);
		
		draftLineContent.prepend(inputHiddenId);
	// form에 전달할 userId 생성
	
	// form에 전달할 atrzSn 생성
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].atrzSn');
		inputHiddenId.setAttribute('value', 0);
		
		draftLineContent.prepend(inputHiddenId);

	// form에 전달할 atrzSn 생성
	
	// form에 전달할 atrzCd 생성
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].atrzCd');
		inputHiddenId.setAttribute('value', 'DR003');
		
		draftLineContent.prepend(inputHiddenId);
	// form에 전달할 atrzCd 생성
		lineIndexNum++;
		$("#draftRamDisplay").append(content);
	}
	
	// 결제선 설정 모달 밖으로 결제선 생성 
	function changeDisplay(index, value){
		var content = value.cloneNode(true);
		// 결재 라인 내용 태그
			var draftLineContent = content.querySelector('.card-body > .d-flex')
			content.classList.remove('kanban-item');
		// 기안 순서 번호 넣기
			var seqCount = document.createElement('div');
			seqCount.classList.add('align-middle', 'mx-auto');
			seqCount.textContent = (index + 2).toString();
			
			draftLineContent.prepend(seqCount);
		// 기안 순서 번호 넣기	
		
		// form에 전달할 userId 생성
			var atrzUserId = content.querySelector('#lineId').value;
			var inputHiddenId = document.createElement('input');
			inputHiddenId.setAttribute('type', 'hidden');
			inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].userId');
			inputHiddenId.setAttribute('value', atrzUserId);
			
			draftLineContent.prepend(inputHiddenId);
		// form에 전달할 userId 생성
		
		// form에 전달할 atrzSn 생성
			var inputHiddenId = document.createElement('input');
			inputHiddenId.setAttribute('type', 'hidden');
			inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].atrzSn');
			inputHiddenId.setAttribute('value', index + 1);
			
			draftLineContent.prepend(inputHiddenId);
		// form에 전달할 atrzSn 생성
		
		// form에 전달할 atrzCd 생성
			var inputHiddenId = document.createElement('input');
			inputHiddenId.setAttribute('type', 'hidden');
			inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].atrzCd');
			inputHiddenId.setAttribute('value', 'DR001');
			
			draftLineContent.prepend(inputHiddenId);
			lineIndexNum++;
		// form에 전달할 atrzCd 생성
		
		// 삭제 버튼(X) 지우고 해당 자리에 뱃지 넣기
			var btnDelDraft = content.querySelector('.draft-del-btn');
			btnDelDraft.remove();
			
			var draftBadge = document.createElement('div');
			draftBadge.classList.add('mx-auto');
			draftBadge.innerHTML = '<span class="badge rounded-pill badge-subtle-primary">결재자</span>';

			draftLineContent.append(draftBadge);
		// 삭제 버튼(X) 지우기 해당 자리에 뱃지 넣기
		
		
		// 수정 권한 체크
			var isMody = content.querySelector('#isMody');
			var isModyFather = isMody.closest(".mx-auto");
			if(isMody.checked) {
				isModyFather.remove();
				
				var modiOn = document.createElement('div');
				modiOn.classList.add('mx-auto'); 
				modiOn.innerHTML = '<span class="fas fa-pen"></span>'; 
				
				draftLineContent.append(modiOn);
			} else {
				isModyFather.remove();
				var modiOn = document.createElement('div');
				
				modiOn.classList.add('mx-auto', 'invisible'); 
				modiOn.innerHTML = '<span class="fas fa-pen"></span>'; 
				draftLineContent.append(modiOn);
			}
		// 수정 권한 체크
			
			$("#draftLineDisplay").append(content);
		
		// 결재 사인 박스 생성
			var myttemp = content.querySelectorAll(".mx-auto");
			
			var userNm = myttemp[2].textContent // 이름
			var userjbgd = myttemp[4].textContent // 직급
			
			var signBox = document.querySelector("#signBox");
			var tempSignBox = document.createElement('div');
			tempSignBox.classList.add('border-400', 'signBox');
			tempSignBox.innerHTML = `
				<table class="table text-center" border="1">
					<thead>
						<tr>
							<th class="p-1" scope="col">` + userjbgd + `</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="p-1" style="height: 5rem;">
							<img alt="서명이미지" src="\\resources\\image\\user\\sign\\nosign.png" 
								style="width: 71px; height: 71px"></td>
						</tr>
						<tr>
							<td class="p-1">`+ userNm + `</td>
						</tr>
						<tr>
							<td class="p-1" style="font-size: 12px; font-weight: bold">날짜</td>
						</tr>
					</tbody>
				</table>`;
				

			signBox.append(tempSignBox);  // 요소를 추가
	}
	
	
	function lineEdit(selectedNode) {
		var userNm = selectedNode.text.split(" ")[0];
		var jbgdNm = selectedNode.text.split(" ")[1];
		var userId = selectedNode.id;
		var userImg = selectedNode.original.userImg;
		var deptNm = selectedNode.original.deptNm;
		var line =
				`<div class="alert card mb-3 kanban-item shadow-sm dark__bg-1100 p-0 draft-div draft-line" style="border: 0px">
					<div class="card-body border p-2">
						<div class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
							<div class=" mx-auto">` + `<img alt="유저사진" class="rounded-circle my-img-size" src="` +  userImg + `"></div>
							<input type="hidden" id="lineId" value="` + userId + `" />
							<div class=" mx-auto">` + userNm + `</div>
							<div class=" mx-auto">` + deptNm + `</div>
							<div class=" mx-auto">` + jbgdNm + `</div>
							<div class=" mx-auto">
								<input class="form-check-input" id="isMody"
									type="checkbox" value="" />
							</div>
							<button class="btn-close close-card draft-del-btn" type="button"></button>
						</div>
					</div>
				</div>`
			$("#lineSpace").append(line);
			
	}

	function susinEdit(selectedNode) {
		var userNm = selectedNode.text.split(" ")[0];
		var jbgdNm = selectedNode.text.split(" ")[1];
		var userId = selectedNode.id;
		var userImg = selectedNode.original.userImg;
		var deptNm = selectedNode.original.deptNm;
		
		var line =
				`<div class="alert card mb-3 kanban-item shadow-sm dark__bg-1100 p-0 draft-div draft-susin" style="border: 0px">
					<div class="card-body border p-2">
						<div class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
							<input type="hidden" id="lineId" value="` + userId + `" />
							<div class=" mx-auto">` + userNm + `</div>
							<div class=" mx-auto">` + jbgdNm + `</div>
							<button class="btn-close close-card draft-del-btn" type="button"></button>
						</div>
					</div>
				</div>`
			$("#susin").append(line);
	}
	
	function ramEdit(selectedNode) {
		var userNm = selectedNode.text.split(" ")[0];
		var jbgdNm = selectedNode.text.split(" ")[1];
		var userId = selectedNode.id;
		var userImg = selectedNode.original.userImg;
		var deptNm = selectedNode.original.deptNm;
		
		var line =
				`<div class="alert card mb-3 kanban-item shadow-sm dark__bg-1100 p-0 draft-div draft-ram" style="border: 0px">
					<div class="card-body border p-2">
						<div class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
							<input type="hidden" id="lineId" value="` + userId + `" />
							<div class=" mx-auto">` + userNm + `</div>
							<div class=" mx-auto">` + jbgdNm + `</div>
							<button class="btn-close close-card draft-del-btn" type="button"></button>
						</div>
					</div>
				</div>`
			$("#ram").append(line);
	}
		
		 	
	
		
	 	// 조직도 내 검색 기능
	 	$('#search').on('keyup', function () {
	 	    var searchString = $(this).val();
	 	   jQuery1x('#jstree').jstree(true).search(searchString);
	 	    
	 	});
	 	
	 	//삭제 버튼(x버튼) 클릭 시 요소를 삭제하는것이 아닌 안보이게 바꿈
 		$("#draftAllLineSpace").on("click", ".draft-del-btn", function() {
 		    $(this).closest(".alert").addClass('d-none');
 		  });
		 	
		 	
			
});
</script>
