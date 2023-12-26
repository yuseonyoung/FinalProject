<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


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
<form name="frm2"
	action="/draft/doc/atrz/post?${_csrf.parameterName}=${_csrf.token}"
	method="post" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="pordCd" id="pordCdInput"/>
	<c:forEach var="mydraftAtrz" items="${myDraftLineList}" varStatus="stat">
		<c:if test="${mydraftAtrz.drftNo == selectDraft.drftNo}">
			<input type="hidden" id="maxDlineSq" name="drftLineVOList[0].maxDlineSq" value="${mydraftAtrz.drftLineVOList[0].maxDlineSq}">		
			<input type="hidden" id="dlineSq" name="drftLineVOList[0].dlineSq" value="${mydraftAtrz.drftLineVOList[0].maxDlineSq}">		
			<input type="hidden" id="drftStat" value="${mydraftAtrz.drftStat}">		
		</c:if>
	</c:forEach>
	
	<div class="d-flex" id="dDiv">
<!-- 	기안문서 불러오기-->
	${selectDraft.drftSave}
<!-- 	결재선 잡는 부분 -->
		<div class="card col-4 ms-3 my-3 border border-secondary">
			<div class="card-body position-relative pt-4 ">
					<div class="btn-group col-12 mb-3" role="group" aria-label="draft">
						<c:set var="ddid" value='<sec:authentication property="principal.realUser.empCd" />' />
							<c:if test="${selectDraft.empCd == draEmpCd && selectDraft.drftStat == 'L002'}">
								<button type="button" id="setCancel" class="btn btn-secondary btn-lg">회수</button>
							</c:if>
						<c:if test="${selectDraft.drftStat == 'L001'}">
							<div class="btn btn-primary btn-lg"> 결재완료 </div>
						</c:if>
						<c:if test="${selectDraft.drftStat == 'L003'}">
							<div class="btn btn-danger btn-lg"> 반려 </div>
						</c:if>
						<c:if test="${selectDraft.drftStat == 'L005'}">
							<div class="btn btn-secondary btn-lg"> 회수완료 </div>
						</c:if>
						<c:forEach var="mydraftAtrz" items="${myDraftLineList}" varStatus="stat">
							<c:if test="${mydraftAtrz.drftNo == selectDraft.drftNo}">
								<c:if test="${selectDraft.drftStat == 'L002'}">
									<button type="button" id="setAtrz" class="btn btn-primary btn-lg">결재</button>
									<button type="button" id="setReject" class="btn btn-danger btn-lg">반려</button>
								</c:if>
							</c:if>
						</c:forEach>
					</div>
				<div class="mb-3 row g-2">
					<span>기안서 제목</span>
					<div class="form-control-plaintext p-2 border border-200" id="draftTitle">${selectDraft.drftTitle}</div>
				</div>

				<hr class="opacity-75" style="border: solid 1px" />

				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item"><a class="nav-link active"
						id="approval-tab" data-bs-toggle="tab" href="#tab-approval"
						role="tab" aria-controls="tab-approval" aria-selected="true">결재선</a></li>
					<li class="nav-item"><a class="nav-link" id="opinion-tab"
						data-bs-toggle="tab" href="#tab-opinion" role="tab"
						aria-controls="tab-opinion" aria-selected="false">의견</a></li>
					<li class="nav-item"><a class="nav-link" id="attachment-tab"
						data-bs-toggle="tab" href="#tab-attachment" role="tab"
						aria-controls="tab-attachment" aria-selected="false">첨부파일</a></li>
				</ul>
				<div class="tab-content border border-top-0 p-3 pt-0"
					id="myTabContent">
					<div class="tab-pane fade show active" id="tab-approval"
						role="tabpanel" aria-labelledby="approval-tab">
						<!-- 결재선 선택시 나오는 부분 -->
						<div class="d-flex flex-column draftSideInfo" id="draftApproval">
								<table class="table my-3">
									<tbody>
										<tr class="bg-primary-subtle">
											<td>결재선 (결재순서)</td>
										</tr>
										<tr>
											<td class="align-middle p-0">
												<div>
													<div class="card my-3 shadow-sm dark__bg-1100">
														<div class="card-body border p-2">
															<div
																class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
																<div class="align-middle mx-auto">1</div>
																<div class="mx-auto">
																	<img alt="유저사진" class="rounded-circle my-img-size"
																		src="${empInfoVO.empImg}">
																</div>
																<div class="mx-auto">
																	${empInfoVO.empNm}
																	<input type="hidden" name="empCd" value="${empInfoVO.empCd}">
																	<input type="hidden" class="drftData" value="${empInfoVO.deptNo}">
																	<input type="hidden" class="drftData" value="${empInfoVO.hrGrade}">
																	<input type="hidden" class="drftData" value="${empInfoVO.empNm}">
																</div>
																<div class="mx-auto">
																	${empInfoVO.deptNm}
																</div>
																<div class="mx-auto">
																	${empInfoVO.hrGradeNm}
																</div>
																<div class="mx-auto">
																	<span class="badge rounded-pill badge-subtle-secondary">기안자</span>
																</div>
																<div class="mx-auto">
																	<span class="fas fa-pen"></span>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div id="draftLineDisplay">
													<c:forEach var="draftAtrzVO" items="${selectDraft.drftLineVOList}" varStatus="stat">
														<c:if test="${draftAtrzVO.dlineCd == 'M001'}">
															<div class="card my-3 shadow-sm dark__bg-1100">
															<div class="card-body border p-2">
																<div
																	class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
																		<div class="align-middle mx-auto">${draftAtrzVO.dlineSq + 1}</div>
																		<div class="mx-auto">
																			<img alt="유저사진" class="rounded-circle my-img-size"
																				src="${draftAtrzVO.empImg}">
																			<img alt="사인이미지" class="rounded-circle my-img-size d-none"
																				src="${draftAtrzVO.empSign}">
																		</div>
																		<div class="mx-auto">
																			${draftAtrzVO.empNm}
																		</div>
																		<div class="mx-auto">
																			${draftAtrzVO.deptNm}
																		</div>
																		<div class="mx-auto">
																			${draftAtrzVO.hrGradeNm}
																		</div>
																		<div class="mx-auto">
																			<c:if test="${draftAtrzVO.dlineStatCd eq null}">
																				<input type="hidden" class="users" value="${draftAtrzVO.empCd}">
																				<span code-name="${draftAtrzVO.dlineStatCd}" class="badge rounded-pill badge-subtle-warning">대기</span>																	
		 																	</c:if>
																			<c:if test="${draftAtrzVO.dlineStatCd eq 'N001'}">
																				<span when="${draftAtrzVO.getDlineDtForm()}" code-name="${draftAtrzVO.dlineStatCd}" class="badge rounded-pill badge-subtle-primary">결재완료</span>																	
																			</c:if>
																			<c:if test="${draftAtrzVO.dlineStatCd eq 'N002'}">
																				<span when="${draftAtrzVO.dlineDtFm}" code-name="${draftAtrzVO.dlineStatCd}" class="badge rounded-pill badge-subtle-danger">반려</span>																	
																			</c:if>
																		</div>
																		<div class="mx-auto invisible">
																			<span class="fas fa-pen"></span>
																		</div>
																	</div>
																</div>
															</div>
														</c:if>
													</c:forEach>
												</div>
											</td>
										</tr>

										<tr class="bg-primary-subtle">
											<td>
												<div class="float-start">수신자</div>
												
											</td>
										</tr>
										<tr class="invisible">
											<td></td>
										</tr>
										<tr>
											<td id="draftSusinDisplay" class="p-0">
												<c:forEach var="draftAtrzVO" items="${selectDraft.drftLineVOList}" varStatus="stat">
													<c:if test="${draftAtrzVO.dlineCd == 'M002'}">
														<div class="card my-3 shadow-sm dark__bg-1100" style="border: 0px">
															<div class="card-body border p-2">
																<div class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
																	<input type="hidden" id="lineId" value="` + empCd + `" />
																	<div class=" mx-auto">${draftAtrzVO.empNm}</div>
																	<div class=" mx-auto">${draftAtrzVO.hrGradeNm}</div>
																</div>
															</div>
														</div>
													</c:if>
												</c:forEach>	
											</td>
										</tr>
										
										<tr class="bg-primary-subtle">
											<td>
												<div class="float-start">회람자</div>
											</td>
										</tr>
										<tr>
											<td id="draftRamDisplay" class="p-0">
												<c:forEach var="draftAtrzVO" items="${draftSelect.drftLineVOList}" varStatus="stat">
													<c:if test="${draftAtrzVO.dlineCd == 'M003'}">
														<div class="card my-3 shadow-sm dark__bg-1100" style="border: 0px">
															<div class="card-body border p-2">
																<div class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
																	<input type="hidden" id="lineId" value="` + empCd + `" />
																	<div class=" mx-auto">${draftAtrzVO.empNm}</div>
																	<div class=" mx-auto">${draftAtrzVO.hrGradeNm}</div>
																</div>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</td>
										</tr>

									</tbody>
								</table>
								
							<div class="d-flex justify-content-center" id="btnAreaPrint">
								<button class="btn btn-primary" type="button" onclick="startPrint()" id="btnPrint">인쇄</button>
							</div>
						</div>
						<!-- 결재선 선택시 나오는 부분 -->
					</div>
					<div class="tab-pane fade" id="tab-opinion" role="tabpanel"
						aria-labelledby="opinion-tab">
						<!-- 의견 선택시 나오는 부분 -->
						<div class="row g-1 draftSideInfo" id="draftOpinion">
							<h5 class="mt-3">의견</h5>
							<hr class="opacity-75 mb-1" style="border: solid 1px" />
							<div id="draftShowOpinion" class="align-items-center">
								<c:forEach var="draftOpVO" items="${selectDraft.drftOpVOList}" varStatus="stat">
									<c:if test="${draftOpVO.opCont eq null || draftOpVO.opCont == ''}">
										<div class="form-control-plaintext" id="opZero">의견이 없습니다</div>
									</c:if>
									<c:if test="${draftOpVO.opCont ne null}">
										<div class="form-control-plaintext" id="opZero" style="display: none;">의견이 없습니다</div>
										<div class="alert d-flex align-items-center p-0 mb-0">						
											<input class="form-control-plaintext"
											readonly value="${draftOpVO.opCont}"/>
											<button class="btn-close opn-del invisible" type="button" data-bs-dismiss="alert" aria-label="Close"></button>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<hr class="opacity-75" style="border: solid 1px" />
							<div class="col">
							
							<c:forEach var="mydraftAtrz" items="${myDraftLineList}" varStatus="stat">
								<c:if test="${mydraftAtrz.drftNo == selectDraft.drftNo}">
									<c:if test="${mydraftAtrz.drftLineVOList[0].dlineStatCd eq null}">
										<textarea class="form-control" id="draftRegistOpnion" rows="3"
											placeholder="의견 작성하기"></textarea>
										<button id="setOpnionBtn" type="button"
											class="btn btn-primary btn-sm float-end mt-3">작성</button>
									</c:if>
								</c:if>
							</c:forEach>
							</div>
						</div>
						<!-- 의견 선택시 나오는 부분 -->
					</div>
					<div class="tab-pane fade" id="tab-attachment" role="tabpanel"
						aria-labelledby="attachment-tab">
						<!-- 첨부파일 선택시 나오는 부분 -->
						<div class="row g-1 draftSideInfo" id="draftAttachment">
							<h5 class="mt-3">첨부 파일</h5>
							<hr class="opacity-75" style="border: solid 1px" />
							<div class="mb-3">
							<c:forEach var="draftAttachVO" items="${selectDraft.drftAtchVOList}" varStatus="stat">
								<c:if test="${draftAttachVO.drftPath ne null}">
									<a href="/download?sort=draft&filename=${draftAttachVO.drftPath}">${draftAttachVO.drftOrgNm}</a>
								</c:if>
								<c:if test="${draftAttachVO.drftPath eq null}">
									<div>첨부파일이 없습니다.</div>
								</c:if>
							</c:forEach>
							</div>
						</div>
						<!-- 첨부파일 선택시 나오는 부분 -->
					</div>
					<div class="tab-pane fade" id="tab-schedule" role="tabpanel"
						aria-labelledby="schedule-tab">
					</div>
				</div>

			</div>
		</div>
		<!-- 결재선 잡는 부분 -->
	<input type="hidden" id="drftNo" name="drftNo" value="${selectDraft.drftNo}" />
	<input type="hidden" id="dlineStatCd" name="drftLineVOList[0].dlineStatCd" value="" />
<!-- 	<input type="hidden" id="dlineStatCd" name="dlineStatCd" value="" /> -->

	</div>
	<sec:csrfInput />
	<sec:authorize access="isAuthenticated()">
		<input type="hidden" id="draftMyName" value="<sec:authentication property="principal.realUser.empNm" />">  
		<input type="hidden" id="draftMyId" name="drftLineVOList[0].empCd" value="<sec:authentication property="principal.realUser.empCd" />">  
	</sec:authorize>
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
	
	$(document).ready(function() {
		
		// 발주서 코드 찾기
// 		var selectedOptions = $("#dDiv").find("[name=selectedPordCd] option");
// 		for(var i = 0; i < selectedOptions.length; i++){
// 			if(selectedOptions[i].value != "default"){
// 				$("#pordCdInput").val(selectedOptions[i].value);
// 			}
// 		}	
		var selectPordCdVal = $("#dDiv").find("#selectPordCd").text();
		$("#pordCdInput").val(selectPordCdVal);
		
	 	$("#vacChose").attr("data-bs-target", "");
	 	$("#vacChose").attr("data-bs-toggle", "");
	 	$("#vacReason").attr("readonly", "readonly");
	
		tinymce.init({
		    selector: "#draftClobContent",
		});
		
		// 결재 승인
		$("#setAtrz").on('click', function() {
	
			var maxDlineSq = $("#maxDlineSq").val();
			var dlineSq = $("#dlineSq").val();
			
			console.log("결재상태:"+drftStat);
			// 최종 결재자 일 경우
			if(maxDlineSq === dlineSq) {
				console.log("결재상태:"+$("#drftStat")[0].value);
				//$("#drftStat")[0].value = 'L001';

				$("[name=drftStat]").val('L001');
				console.log("결재상태:"+$("#drftStat")[0].value);
				console.log("0",$("#drftStat")[0]);
				console.log("1",$("[name=drftStat]")[0]);
			}
			
			$("#dlineStatCd").val('N001');
			frm2.submit();
			
		});
		
		// 반려
		$("#setReject").on('click', function() {
			
			//기안 문서 번호 업데이트
			$("[name=drftStat]").val('L003');
			$("#dlineStatCd").val('N002');
			frm2.submit();
			
		});

		// 결재 회수
		$("#setCancel").on('click', function() {
			
			console.log("결재상태:"+drftStat);

			$("[name=drftStat]").val('L005');
			$("#dlineStatCd").val('N003');
			
			frm2.submit();
			
		});
	
		// 기안 의견 데이터 전달
	    $("#draftRegistOpnion").keyup(function(event) {
	        if (event.which === 13) {
	            $("#setOpnionBtn").click();
	        }
	    });
		var cnt = 0;
		$("#setOpnionBtn").on("click", function() {
			var draftShowOpinion = document.querySelector("#draftShowOpinion");
			var draftRegistOpnion = document.querySelector("#draftRegistOpnion");
			var count = $("#draftShowOpinion > .alert").length;
			var opinion = draftRegistOpnion.value;
			var myName = $("#draftMyName").val()
			var myId = $("#draftMyId").val()
			$("#opZero").hide();
			
			var nowTime = new Date();
			
			var opinionTemp = `
					<div class="alert d-flex align-items-center p-0 mb-0">						
							<input class="form-control-plaintext"
							name="drftOpVOList[` + cnt + `].opCont"
							readonly value="`+ myName + `: ` + opinion +  `"/>
						<button class="btn-close opn-del" type="button" data-bs-dismiss="alert" aria-label="Close"></button>
				`
			opinionTemp += `<input type="hidden" name="drftOpVOList[` + cnt + `].empCd" value="` + myId + `"/>`
			opinionTemp += `<input type="hidden" name="drftOpVOList[` + cnt + `].opWdate" value="` + nowTime + `"/></div>`
			draftShowOpinion.innerHTML += opinionTemp;
			cnt++;

			draftRegistOpnion.value = "";
		});
		
		$(document).on("click", ".opn-del", function() {
			var count = $("#draftShowOpinion > .alert").length;
			cnt--;
			if (count <= 0) {
				$("#opZero").show();
			}
		});

		
	// 기안 의견 데이터 전달
	
	});
	
	

</script>


<!-- 사인박스 처리 -->
<script type="text/javascript">
$(function (){
	setSignBox();
});

function setSignBox() {
var signBox = $(".signBox");
	
	var draftLine = $("#draftLineDisplay > .card");
	
	draftLine.each(function(index1, value) {
	    var imgTag1 = $(this).find("img.d-none");
	    var imgSrc = imgTag1.attr("src");
	    
	    var artzDate = $(this).find("span")[0];
	    var artzYmd = artzDate.getAttribute('when');
	    var code = artzDate.getAttribute('code-name');
	    
	    if(artzYmd == null) {
	    	artzYmd = '날짜';
	    }
	    
		signBox.each(function(index2, value) {
		    var imgTag2 = $(this).find("img");
		    var signDate = $(this).find("td")[2];
		    
			if(index1 === index2 && code === 'N001') {
				imgTag2.attr("src", imgSrc);
				signDate.innerText = artzYmd;
			}
		    
		});
	});
}


var prtContent; // 프린트 하고 싶은 영역
var initBody; // body 내용 원본
//프린트하고 싶은 영역의 id 값을 통해 출력 시작
function startPrint(div_id) {
	prtContent = document.getElementById('doc1');
	window.onbeforeprint = beforePrint;
	window.onafterprint = afterPrint;
	window.print();
}

// 웹페이지 body 내용을 프린트하고 싶은 내용으로 교체
function beforePrint() {
	initBody = document.body.innerHTML;
	document.body.innerHTML = prtContent.innerHTML;
	document.body.style.backgroundColor = "white";
}

// 프린트 후, 웹페이지 body 복구
function afterPrint() {
	document.body.innerHTML = initBody;
	document.body.style.backgroundColor = "";
	
	$(document).on("click", ".modalCloseBtn", function(){
		$("div.modal-backdrop").hide();
// 		$("body").removeClass("modal-open").removeAttr("style");
		$("#viewData")
// 		.removeClass("show")
// 		.removeAttr("role")
		.hide();
	})
}



//pdf저장 및 인쇄
function doPrint(){
	// 프린트를 보이는 그대로 나오기위한 셋팅
    window.onbeforeprint = function(ev) {
	    // 프린트 전에 내용을 복사하여 새 창에 적용
		var btnAreaPrint = document.getElementById('btnAreaPrint');
		var btnAreaClose = document.getElementById('btnAreaClose');
		btnAreaPrint.classList.remove('d-flex');
		btnAreaPrint.classList.add('d-none');
		btnAreaClose.style.display = 'none';
	
		
			
		var printWindow = window.open('', '_blank');
		printWindow.document.write('<html><head><title>인쇄</title>');
		printWindow.document.write('</head><body>');
		printWindow.document.write('</body></html>');
		printWindow.document.close();
		
		};

    window.print();
    location.reload();
		
	}



</script>
<!-- 사인박스 처리	 -->

<!-- 받아온 기안 의견 처리 -->
<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
<!-- 받아온 기안 의견 처리 -->
