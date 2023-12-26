<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- ${paymentDetail } --%>

<div class="container">
	<div class="row">
		<div class="card mb-3">
			<div class="card-header ">
				<div class="row flex-between-end">
					<div class="col-auto align-self-center">
						<h3 class="mb-0">급여정보</h3>
						<p class="mb-0 pt-1 mt-2 mb-0"></p>
					</div>
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.realUser.empCd" var="loginId" />
			<sec:authentication property="principal.realUser.empNm" var="loginName" />
		</sec:authorize>

		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link active" id="payment-tab"
				data-bs-toggle="tab" href="#tab-payment" role="tab"
				aria-controls="tab-payment" aria-selected="true">지급내역확인</a></li>
			<li class="nav-item"><a class="nav-link" id="bank-tab"
				data-bs-toggle="tab" href="#tab-bank" role="tab"
				aria-controls="tab-bank" aria-selected="false">급여계좌</a></li>
		</ul>



		<!-- 지급내역확인 div -->
		<div class="tab-content border border-top-0 p-3" id="myTabContent"
			data-list='{"valueNames":["workDate","pay","totalPay","totalTax","payDate","selectYear"],"filter":{"key":"selectYear"}}'>
			<div class="tab-pane fade show active" id="tab-payment" role="tabpanel" aria-labelledby="payment-tab">

				<div class="form-group">
					<select class="form-select float-end  mb-3" style="width: 150px"
						aria-label="Bulk actions" data-list-filter="data-list-filter" name="myVacYear" id="myVacYear">
					</select>
				</div>
				<table
					class="table table-bordered align-middle text-align border border-2">
					<colgroup>
						<col width="17%">
						<col width="20%">
						<col width="18%">
						<col width="18%">
						<col width="18%">
						<col width="8%">
					</colgroup>
					<tbody id="dataRows">
						<tr>
							<td class="bg-primary-subtle text-center" data-sort="workDate">급여
								연월</td>
							
							<td class="bg-primary-subtle text-center" data-sort="pay">공제
								후 지급액</td>
							<td class="bg-primary-subtle text-center"
								data-sort="totalPay">지급 항목 합계</td>
							<td class="bg-primary-subtle text-center" data-sort="totalTax">공제
								항목 합계</td>
							<td class="bg-primary-subtle text-center" data-sort="payDate">지급일</td>
							<td class="bg-primary-subtle text-center detail">상세보기</td>
							<!-- <td class="bg-primary-subtle text-center"data-sort="payNo">급여명세번호</td> -->
						</tr>
						<c:forEach var="data" items="${data }" varStatus="stat">
							<tr class="btn-reveal-trigger">
								<td class="text-center workYm" id="workYm">${data.workDate }</td>
								<td class="text-center pay" id="pay"><fmt:formatNumber
										pattern="###,###,###">${data.pay }</fmt:formatNumber></td>
								<td class="text-center totalPay" id="totalPay"><fmt:formatNumber
										pattern="###,###,###">${data.totalPay }</fmt:formatNumber></td>
								<td class="text-center totalTax" id="totalTax"><fmt:formatNumber
										pattern="###,###,###">${data.totalTax }</fmt:formatNumber></td>
								<td class="text-center payDate" id="payDate">${data.payDate }</td>
								<td class="text-center detail"
									data-pay-no="${data.payNo}"><button
										class="fab fa-sistrix"></button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


				<!-- 상세 모달 시작-->
				<div class="modal fade pdfArea" id="viewData" data-keyboard="false"
					tabindex="-1" aria-labelledby="scrollinglongcontentLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content border-0">
							<div class="modal-header">
								<h5 class="modal-title" id="scrollinglongcontentLabel">인사정보_급여명세서</h5>
								<button class="btn-close" class="btn btn-secondary modalCloseBtn" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body modal-dialog modal-dialog-scrollable mx-0 mb-0" id="modalData">
								<h3 class="text-center mb-4">급여명세서</h3>
								<table class="table table-bordered align-middle text-align mb-3 border">
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>
									<tbody id="dataRowsPayment">
										<tr>
											<td class="bg-primary-subtle text-center ">부서</td>
											<td class=" text-center" id="deptNoNmModal"></td>
											<td class="bg-primary-subtle text-center ">직급</td>
											<td class=" text-center" id="hrGradeNmModal"></td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center ">성명</td>
											<td class=" text-center" id="empNmModal"></td>
											<td class="bg-primary-subtle text-center ">생년월일</td>
											<td class=" text-center" id="brthYmdModal"></td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center ">급여연월</td>
											<td class=" text-center" id="workYmModal"></td>
											<td class="bg-primary-subtle text-center ">급여지급일</td>
											<td class=" text-center" id="payDateModal"></td>
										</tr>
									</tbody>
								</table>
								<table
									class="table table-bordered align-middle text-align mb-3 border">
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>
									<tbody id="dataRowsPayment2" class="mb-2">
										<tr>
											<td class="bg-primary-subtle text-center " colspan="2">지급항목</td>
											<td class="bg-primary-subtle text-center " colspan="2">공제항목</td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center ">기본급</td>
											<td class=" text-center" id="roundSalModal"></td>
											<td class="bg-primary-subtle text-center ">국민연금</td>
											<td class=" text-center" id="npnModal"></td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center ">식대</td>
											<td class=" text-center" id="foodModal"></td>
											<td class="bg-primary-subtle text-center ">건강보험</td>
											<td class=" text-center" id="hlthInsModal"></td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center ">연장근로수당</td>
											<td class=" text-center" id="overWorkModal"></td>
											<td class="bg-primary-subtle text-center ">장기요양보험</td>
											<td class=" text-center" id="ltcModal"></td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center ">야간근로수당</td>
											<td class=" text-center">0</td>
											<td class="bg-primary-subtle text-center ">고용보험</td>
											<td class=" text-center" id="empInsModal"></td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center ">휴일근로수당</td>
											<td class=" text-center">0</td>
											<td class="bg-primary-subtle text-center ">소득세</td>
											<td class=" text-center" id="inTaxModal"></td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center "></td>
											<td class=" text-center"></td>
											<td class="bg-primary-subtle text-center ">지방소득세</td>
											<td class=" text-center" id="linTaxModal"></td>
										</tr>
										<tr>
											<td class="bg-primary-subtle text-center ">합계</td>
											<td class=" text-center" id="totalPayModal"></td>
											<td class="bg-primary-subtle text-center ">합계</td>
											<td class=" text-center" id="totalTaxModal"></td>
										</tr>
									</tbody>
								</table>
								<table class="table table-bordered align-middle text-align mb-3 border">
									<colgroup>
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="40%">
									</colgroup>
									<tbody id="dataRowsPayment3" class="mb-2">
										<tr>
											<td class="bg-primary-subtle text-center">연장근로시간</td>
											<td class="bg-primary-subtle text-center">야간근로시간</td>
											<td class="bg-primary-subtle text-center">휴일근로시간</td>
											<td class="bg-primary-subtle text-center">공제 후 실지급액</td>
										</tr>
										<tr>
											<td class=" text-center ">0</td>
											<td class=" text-center ">0</td>
											<td class=" text-center ">0</td>
											<td class=" text-center" id="payModal"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="d-flex justify-content-center" id="btnAreaPrint">
								<button class="btn btn-primary" type="button" onclick="startPrint()" id="btnPrint">인쇄</button>
<!-- 								<button class="btn btn-primary" type="button" onclick="savePDF()" id="btnPrint">PDF저장</button> -->
							</div>
							<div class="modal-footer" id="btnAreaClose">
								<button class="btn btn-secondary modalCloseBtn" type="button" data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 상세 모달 끝-->
			</div>
			<!-- 지급내역확인 div 끝 -->
			
			
			
			<!-- 급여계좌 div 끝 -->
			<div class="tab-pane fade" id="tab-bank" role="tabpanel" aria-labelledby="bank-tab">
			
				<div>
					<table class="table table-bordered align-middle text-align mb-3 border">
					
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="30%">
						</colgroup>
						<tbody id="dataRowsBank" class="mb-2">
							<tr>
								<td class="bg-primary-subtle text-center">은행명</td>
								<td class="bg-primary-subtle text-center">계좌번호</td>
								<td class="bg-primary-subtle text-center">예금주</td>
							</tr>
							<tr id="bankDetail">
								<td class=" text-center hrBank" id="hrBank">${paymentVOBank.hrBank}</td>
								<td class=" text-center hrBankNo" id="hrBankNo">${paymentVOBank.hrBankNo}</td>
								<td class=" text-center">${paymentVOBank.empNm}</td>
							</tr>
							<!-- 수정 -->
							<tr id="bankDetailReg" style="display: none;">
								<td class=" text-center hrBank" id="hrBank">
<%-- 								<input class="form-control" type="text" id="reghrBankNo" style="text-align: center;"value="${paymentVOBank.hrBank}" > --%>
									<div class="form-group">
									  <select class="form-select selectpicker" id="basic-example" data-options='{"은행을 선택해 주세요"}'>
									    <option value="국민">국민</option>
									    <option value="신한">신한</option>
									    <option value="농협">농협</option>
									    <option value="카카오뱅크">카카오뱅크</option>
									    <option value="토스뱅크">토스뱅크</option>
									    <option value="우리">우리</option>
									    <option value="하나">하나</option>
									  </select>
									</div>
								</td>
								
								<td class=" text-center hrBankNo" id="hrBankNo">
									<input class="form-control is-invalid" type="text" id="regActNm" style="text-align: center;" value="${paymentVOBank.hrBankNo}">
									<div id="hrBankNoValidation" class="invalid-feedback">	</div>
									
									</td>
									
								<td class=" text-center" data-bs-toggle="tooltip" data-bs-placement="top" title="예금주는 본인 명의만 가능합니다">${paymentVOBank.empNm}
								</td>
							</tr>
						</tbody>
					</table>
					<div class="d-flex justify-content-end" id="changeBank">
						<button class="btn btn-secondary" type="button" onclick="changeBank()" id="btnChangeBank">수정</button>
						<button class="btn btn-primary" type="button" id="changeBankAndSave" style="display: none;" data-bs-toggle="modal" data-bs-target="#scrollinglongcontent">저장</button>
					</div>
				<!-- 급여계좌 정보 변경 컨펌 모달 시작-->
					<div class="modal fade" id="scrollinglongcontent"
						data-keyboard="false" tabindex="-1"
						aria-labelledby="scrollinglongcontentLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="scrollinglongcontentLabel">급여계좌 정보 변경</h5>
									<button class="btn-close" type="button" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body modal-dialog modal-dialog-scrollable">
									<p style="">변경하시겠습니까?</p>
								</div>
								<div class="modal-footer">
									<button class="btn btn-primary" type="button" id="btnChngBank" onclick="btnChngBank()">확인</button>
									<button class="btn btn-secondary" type="button"
										data-bs-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 급여계좌 정보 변경 모달 끝-->
				</div>
			</div>
			
			<!-- 급여계좌 div 끝 -->
		</div>

</div>
</div>
</div>



	</div>
</div>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script>



var prtContent; // 프린트 하고 싶은 영역
var initBody; // body 내용 원본
//프린트하고 싶은 영역의 id 값을 통해 출력 시작
function startPrint(div_id) {
	prtContent = document.getElementById('modalData');
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




var loginIdSession = '${loginId}'
	console.log("세션에서 받아온 로그인아이디 : ", loginIdSession);


//수정에서 은행 변경하기!
//이전에 선택된 은행명
var selectedBank = "${paymentVOBank.hrBank}";

// 셀렉트 옵션 요소를 선택합니다.
var selectElement = $("#basic-example");

// 셀렉트 옵션을 돌면서 이전에 선택된 은행명과 일치하는 옵션을 선택합니다.
selectElement.find("option").each(function() {
  if ($(this).val() === selectedBank) {
    $(this).prop("selected", true); // 선택 상태로 설정
  }
});






//유효성검증
document.addEventListener('DOMContentLoaded', function() {
	  var hrBankNoInput = document.getElementById('regActNm');
	  var numericRegex = /^[0-9]+$/;
	  var validationMessage = document.getElementById('hrBankNoValidation');
	  var changeBankAndSave = document.getElementById('changeBankAndSave');

	  validateInput();

	  hrBankNoInput.addEventListener('input', validateInput);

	  function validateInput() {
	    var inputValue = hrBankNoInput.value.trim();
	    if (numericRegex.test(inputValue)) {
	      hrBankNoInput.classList.remove('is-invalid');
	      validationMessage.innerText = '';
	      changeBankAndSave.removeAttribute('disabled');
	    } else {
	      hrBankNoInput.classList.add('is-invalid');
	      validationMessage.innerText = '숫자만 입력할 수 있습니다.';
	      changeBankAndSave.setAttribute('disabled', 'disabled');
	    }
	  }
	});












//수정버튼 누를시 계좌 변경 폼 출력
function changeBank(){
	console.log("계좌수정!");
	$("#btnChangeBank").hide();
	$("#changeBankAndSave").show();
	$("#bankDetail").hide();
	$("#bankDetailReg").show();
	var hrBank = $("#hrBank").text();
	
	
}


//계좌정보 수정 모달
function btnChngBank(){
	console.log("난 계좌 수정 모달")
	
	//console.log("loginIdSession : " ,loginIdSession);
	var reghrBankNo = $("#regActNm").val();
	//console.log("reghrBankNo : " ,reghrBankNo);
	var reghrBank = $("#basic-example").val();
	//console.log("reghrBank : " ,reghrBank );
	
	var data = {
			"empCd" : loginIdSession,
			"hrBankNo" : reghrBankNo,
			"hrBank" : reghrBank,
		}
	
	console.log(data)
	
	$.ajax({
		url : "/empInfo/paymentUpdate",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data),
		type : "post",
		dataType : "text",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		success : function(result) {
// 			console.log("전송성공");
// 			console.log(result);
			location.href = "/empInfo/payment";
	

			
		},
		error : function(xhr, status, error) {
			console.log("에러 발생:", error);
		}
	}); //ajax

	
	
	
	
	
	
}


//이름 클릭시 상세정보 모달 띄우기
$(document).on("click",".detail",function(){
	let payNo = $(this).data("payNo");
	console.log("payNo : " + payNo);
	var data = {
			"payNo" : payNo
		}
	
	$.ajax({
		url : "/empInfo/paymentDetail",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data),
		type : "post",
		dataType : "JSON",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		success : function(result) {
			console.log(result);
			$("#viewData").modal("show");
			
			
			//생년월일
			var birthDate = new Date(result.empBirth);
			var birYear = birthDate.getFullYear();
			var birMonth = birthDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줌
			var birDay = birthDate.getDate();
			
			
			//급여지급일
			var payDate = result.payDate;
			var payDateYear = payDate.substring(0, 4);
			var payDateMonth = payDate.substring(4, 6);
			var payDateDay = payDate.substring(6, 8);
			
			
			//급여 연월
			var workYm = result.workDate;
			var workYmYear = workYm.substring(0, 4);
			var workYmMonth = workYm.substring(4, 6);
	
			//값 넣기
			$("#deptNoNmModal").text(result.deptNoNm);
			$("#hrGradeNmModal").text(result.hrGradeNm);
			$("#empNmModal").text(result.empNm);
			$("#brthYmdModal").text(birYear + "년 " + birMonth + "월 " + birDay + "일");
			$("#workYmModal").text(workYmYear + "년 " +workYmMonth + "월");
			$("#payDateModal").text(payDateYear + "년 " +payDateMonth + "월" + payDateDay + "일");
			
			$("#roundSalModal").text(result.roundSal.toLocaleString());
			$("#npnModal").text(result.npn.toLocaleString());
			$("#foodModal").text(result.food.toLocaleString());
			$("#hlthInsModal").text(result.hlthIns.toLocaleString());
			
			$("#overWorkModal").text(result.overWork.toLocaleString());
			$("#ltcModal").text(result.ltc.toLocaleString());
			$("#empInsModal").text(result.empIns.toLocaleString());
			$("#inTaxModal").text(result.inTax.toLocaleString());
			$("#linTaxModal").text(result.linTax.toLocaleString());
			$("#totalPayModal").text(result.totalPay.toLocaleString());
			$("#totalTaxModal").text(result.totalTax.toLocaleString());
			
			$("#payModal").text(result.pay.toLocaleString());
			
		},
		error : function(xhr, status, error) {
			console.log("에러 발생:", error);
		}
	}); //ajax

});

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
	
		
			
		var printContent = document.getElementById('modalData').innerHTML;
		var printWindow = window.open('', '_blank');
		printWindow.document.write('<html><head><title>인쇄</title>');
		printWindow.document.write('</head><body>');
		printWindow.document.write(printContent);
		printWindow.document.write('</body></html>');
		printWindow.document.close();
		
		};

    window.print();
    location.reload();
		
	}



// 갭쳐해서 하는 방식
	function savePDF(){
	    //저장 영역 div id
	    html2canvas($('.pdfArea')[0] ,{	
	      //logging : true,		// 디버그 목적 로그
	      //proxy: "html2canvasproxy.php",
	      allowTaint : true,	// cross-origin allow 
	      useCORS: true,		// CORS 사용한 서버로부터 이미지 로드할 것인지 여부
	      scale : 2			// 기본 96dpi에서 해상도를 두 배로 증가
	      
	    }).then(function(canvas) {	
	      // 캔버스를 이미지로 변환
	      var imgData = canvas.toDataURL('image/png');

	      var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
	      var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
	      var imgHeight = canvas.height * imgWidth / canvas.width;
	      var heightLeft = imgHeight;
	      var margin = 5; // 출력 페이지 여백설정
	      var doc = new jsPDF('p', 'mm');
	      var position = 0;

	      // 첫 페이지 출력
	      doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
	      heightLeft -= pageHeight;

	      // 한 페이지 이상일 경우 루프 돌면서 출력
	      while (heightLeft >= 20) {			// 35
	      position = heightLeft - imgHeight;
	      position = position - 20 ;		// -25

	      doc.addPage();
	      doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
	      heightLeft -= pageHeight;
	      }

	      // 파일 저장
	      doc.save('filename.pdf');
	    });
	  }



//값 숨기기
var payNo = document.getElementsByClassName(".payNo");
for (var i = 0; i < payNo.length; i++) {
 //  payNo[i].style.display = "none";
}

//셀렉트창 값을 위한 입사년도구하기
var myJoinYear = '${findJoinYear.joinYear}'
	console.log("입사년도 : ",myJoinYear)
	let today = new Date();   
	let year = today.getFullYear(); // 년도
	//console.log(year)
	var arr=[]
	
	for(var i=year; i>=myJoinYear;i-- ){
		arr.push(i)
	}
	console.log(arr)
	
	
var a = $("#myVacYear");
for (var i = 0; i < arr.length; i++) {
  var option = $("<option></option>").val(arr[i]).text(arr[i]);
  a.each(function() {
    $(this).append(option);
  });
}
	
	
//옵션 선택값 받기
$('select[name="myVacYear"]').on('change', function() {
    var selectedValue = $(this).val();
    console.log("선택된 값:", selectedValue);
	
    var loginIdSession= '${loginId}'
	var data = {
		"empCd" : loginIdSession,
		"selectYear" : selectedValue,
	};
	//console.log(data);
	

	$.ajax({
	    	    url: "/empInfo/paymentPost",
	    	    contentType: "application/json;charset:utf-8",
	    	    data: JSON.stringify(data),
	    	    type: "post",
	    	    dataType: "json",
	    	    beforeSend: function(xhr) {
	    	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	    },
	    	    success: function(result) {
	    	        console.log("성공!");
	    	        console.log(result);
	    	        
	    	        var mytbody = $("#dataRows");
	    	        mytbody.empty();

	    	        
    	        	var header = $("<tr></tr>");
    	        	
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>급여 연월</td>");
    	        	header.append("<td class='bg-primary-subtle ' style='text-align: center;'>상세보기</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>공제 후 지급액</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>지급 항목 합계</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>공제 항목 합계</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>지급일</td>");
	    	        
          	mytbody.append(header);
          			
	    	        $.each(result, function(index, item) {
                   	var row = $("<tr></tr>");
           			 // 데이터 행 생성
					row.append("<td class='text-center'>" + formatDate(item.workDate) + "</td>");
					row.append("<td class='text-center detail' data-pay-no='"+item.payNo+"'><button class='fab fa-sistrix'></button></td>");
					row.append("<td class='text-center'>" + item.pay.toLocaleString() + "</td>");
					row.append("<td class='text-center'>" + item.totalPay.toLocaleString() + "</td>");
					row.append("<td class='text-center'>" + item.totalTax.toLocaleString() + "</td>");
					row.append("<td class='text-center'>" + formatDateAndYear(item.payDate) + "</td>");

            // tbody에 행 추가
            mytbody.append(row);
        });
	    	      //reloadDivArea();
	    	    },
	    	    error: function(xhr, status, error) {
	    	        console.log("에러 발생:", error);
	    	    }
	    	});


        });


    	
//아작스 데이터 연월일        
function formatDate(dateString) {
	var year = dateString.substring(0, 4);
    var month = dateString.substring(4, 6);
    return year + "년 " + month + "월";
}
//아작스 데이터 연월    
function formatDateAndYear(dateString) {
	var year = dateString.substring(0, 4);
    var month = dateString.substring(4, 6);
    var day = dateString.substring(6, 8);
    return year + "년 " + month + "월 " + day + "일";
}


//급여 연월에 년과 월 넣기
var workYmElements = document.getElementsByClassName("workYm");

for (var i = 0; i < workYmElements.length; i++) {
  var inputDate = workYmElements[i].textContent;
  let year = inputDate.substring(0, 4);
  var month = inputDate.substring(4, 6);
  var formattedDate = year + "년 " + month + "월";
  workYmElements[i].textContent = formattedDate;
}
//지급일에 / 넣기
var payDateElements = document.getElementsByClassName("payDate");

for (var i = 0; i < payDateElements.length; i++) {
  var inputDate = payDateElements[i].textContent;
  let year = inputDate.substring(0, 4);
  var month = inputDate.substring(4, 6);
  var day = inputDate.substring(6, 8);
  var formattedDate = year + "년 " + month + "월" + day + "일";
  payDateElements[i].textContent = formattedDate;
}
</script>