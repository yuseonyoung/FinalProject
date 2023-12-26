<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>




<body>
<div class="container">
	<div class="row">
		<div class="card mb-3">
			<div class="card-header ">
				<div class="row flex-between-end">
					<div class="col-auto align-self-center">
						<h3 class="mb-0" >인사정보</h3>
						<p class="mb-0 pt-1 mt-2 mb-0"></p>
					</div>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.realUser.empCd" var="loginId" />
				<sec:authentication property="principal.realUser.empNm"
					var="loginName" />
			</sec:authorize>
			<!-- border-primary 빼면 파란색 보더 사라짐 -->
			<table
				class="table table-bordered align-middle text-align border border-2">
				<colgroup>
					<col width="20%">
					<col width="15%">
					<col width="25%">
					<col width="15%">
					<col width="25%">
				</colgroup>
				<tbody>
					<tr>
						<td rowspan="4" class="text-center img-fluid m-1 p-1">
							<img src=${data.empImg } width="100%" height="100%">
						</td>
						<td class="bg-primary-subtle text-center">이름</td>
						<td colspan="3" >${data.empNm}</td>
					</tr>
					<tr>
						<td class="bg-primary-subtle text-center">소속</td>
						<td colspan="3">${data.deptNm}</td>
					</tr>
					<tr>
						<td class="bg-primary-subtle text-center">사번</td>
						<td class="text-center" >${data.empCd}</td>
						<td class="bg-primary-subtle text-center">휴대번호</td>
						<td class="text-center" id="phoneNo"></td>
					</tr>
					<tr>
						<td class="bg-primary-subtle text-center">직급/직무</td>
						<td class="text-center">${data.hrGradeNm} / ${data.hrChargeNm}</td>
						<td class="bg-primary-subtle text-center">메일주소</td>
						<td class="text-center">${data.empMail}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	</div>
	<div id="commentArea" class="card mb-3">
		<div class="card-body">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item"><a class="nav-link active"
					id="emp-info-basic-nav" data-bs-toggle="tab" href="#emp-info-basic"
					role="tab" aria-controls="emp-info-basic" aria-selected="true">기본정보</a>
				</li>
				<li class="nav-item"><a class="nav-link "
					id="emp-info-dept-nav" data-bs-toggle="tab" href="#emp-info-dept"
					role="tab" aria-controls="emp-info-dept" aria-selected="false">직무/담당</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					id="emp-info-family-nav" data-bs-toggle="tab"
					href="#emp-info-family" role="tab" aria-controls="tab-contact"
					aria-selected="false">가족정보</a></li>
			</ul>
			<div class="tab-content  border-top-0 p-3" id="myTabContent">
				<div class="tab-pane fade show active" id="emp-info-basic"
					role="tabpanel" aria-labelledby="emp-info-basic">
					<table
						class="table table-bordered align-middle text-align border border-2">
						<colgroup>
							<col width="15%">
							<col width="18%">
							<col width="15%">
							<col width="18%">
							<col width="15%">
							<col width="18%">
						</colgroup>
						<tbody>
							<tr>
								<td class="text-center bg-primary-subtle">입사일</td>
								<td class="text-center"><fmt:formatDate
										value="${data.hrSdate}" pattern="yyyy-MM-dd" /></td>
								<td class="text-center bg-primary-subtle">성별</td>
								<td class="text-center" id="empGend"></td>
								<td class="text-center bg-primary-subtle">병역이행여부</td>
								<td class="text-center">${data.hrMilYnNm }</td>
							</tr>
							<tr>
								<td class="text-center bg-primary-subtle">생년월일</td>
								<td class="text-center"><fmt:formatDate
										value="${data.empBirth}" pattern="yyyy-MM-dd" /></td>
								<td class="text-center bg-primary-subtle">재직상태</td>
								<td class="text-center">${data.hrStatNm}</td>
								<td class="text-center bg-primary-subtle">퇴사일</td>
								<td class="text-center">${data.hrEdate}</td>
							</tr>
							<tr class="empInfoPersonalDiv">
								<td class="text-center bg-primary-subtle">주소</td>
								<td class="text-center" colspan="5">(${data.empZip})
									${data.empAddr } ${data.empDaddr}</td>
							</tr>


							<tr class="regEmpInfoPersonalDiv" style="display: none;">
								<td class="text-center bg-primary-subtle">주소</td>
								<td class="text-center" colspan="5"><input id="regAddr"
									class="form-control" type="text" style="text-align: center;"
									value="(${data.empZip}) ${data.empAddr } ${data.empDaddr}">
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 카카오주소 -->
					<div class="kakao" style="display: none;">
						<input class="form-control kakao" type="text"
							id="sample4_postcode" placeholder="우편번호">
						<!-- 					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br> -->
						<input class="form-control kakao" type="text"
							id="sample4_roadAddress" placeholder="도로명주소"> <input
							class="form-control kakao" type="text" id="sample4_jibunAddress"
							placeholder="지번주소"> <span id="guide"
							style="color: #999; display: none"></span> <input
							class="form-control kakao" type="text" id="sample4_detailAddress"
							placeholder="상세주소"> <input class="form-control kakao"
							type="text" id="sample4_extraAddress" placeholder="참고항목">
					</div>
					<div class="d-flex justify-content-end">
						<button id="btnRegEmpInfoPersonal" class="btn btn-primary me-3">변경</button>

					</div>
					<div class="d-flex justify-content-between">
						<button id="cancleBtnRegEmpInfoPersonal"
							class="btn btn-secondary me-3" style="display: none;"
							onclick="location.href ='/empInfo/empInfo'">취소</button>
						<button id="submitBtnRegEmpInfoPersonal"
							class="btn btn-primary me-3" style="display: none;">저장</button>
					</div>
				</div>
				<div class="tab-pane fade" id="emp-info-dept" role="tabpanel"
					aria-labelledby="emp-info-dept">
					<div
						data-list='{"valueNames":["count","deptNoRec","hrGradeNmRec","hrChargeNmRec","hrRecSdate","hrRecEdate","hrRecNote"],"pagination":true}'>
						<table
							class="table table-bordered align-middle text-align table-bordered scrollbar border border-2">
							<colgroup>
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<td class="text-center bg-primary-subtle sort"
										data-sort="count">번호</td>
									<td class="text-center bg-primary-subtle sort"
										data-sort="deptNoRec">부서</td>
									<td class="text-center bg-primary-subtle sort"
										data-sort="hrGradeNmRec">직급</td>
									<td class="text-center bg-primary-subtle sort"
										data-sort="hrChargeNmRec">직책</td>
									<td class="text-center bg-primary-subtle sort"
										data-sort="hrRecSdate">시작일</td>
									<td class="text-center bg-primary-subtle sort"
										data-sort="hrRecEdate">종료일</td>
									<td class="text-center bg-primary-subtle sort"
										data-sort="hrRecNote">변경사유</td>
								</tr>
							</thead>
							<tbody class="list">
								<c:forEach var="hrRec" items="${data.hrRecVO}" varStatus="stat">
									<tr>
										<td class="text-center count">${stat.count}</td>
										<td class="text-center deptNoRec">${hrRec.deptNoRec}</td>
										<td class="text-center hrGradeNmRec">${hrRec.hrGradeNmRec}</td>
										<td class="text-center hrChargeNmRec">${hrRec.hrChargeNmRec}</td>
										<td class="text-center hrRecSdate"><fmt:formatDate
												value="${hrRec.hrRecSdate}" pattern="yyyy-MM-dd" /></td>
										<td class="text-center hrRecEdate"><fmt:formatDate
												value="${hrRec.hrRecEdate}" pattern="yyyy-MM-dd" /></td>
										<td class="text-center hrRecNote">${hrRec.hrRecNote}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<div class="tab-pane fade" id="emp-info-family" role="tabpanel"
					aria-labelledby="emp-info-family">

					<table
						class="table table-bordered align-middle text-align border border-2"
						id="famInfo">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<td class="text-center bg-primary-subtle">번호</td>
								<td class="text-center bg-primary-subtle">성명</td>
								<td class="text-center bg-primary-subtle">가족관계</td>
								<td class="text-center bg-primary-subtle">성별</td>
								<td class="text-center bg-primary-subtle">생년월일</td>
								<td class="text-center bg-primary-subtle">삭제</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="fam" items="${data.famVO}" varStatus="stat">
								<tr>
									<td class="text-center">${stat.count}</td>
									<td class="text-center">${fam.famNm}</td>
									<td class="text-center">${fam.famRelNm}</td>
									<c:if test="${fam.famGend == 'M'}">
										<td class="text-center ">남성</td>
									</c:if>
									<c:if test="${fam.famGend == 'F'}">
										<td class="text-center ">여성</td>
									</c:if>
									<td class="text-center" id="famBirth"><fmt:formatDate
											value="${fam.famBirth}" pattern="yyyy-MM-dd" /></td>
									<td class="text-center">
										<button data-fam-no="${fam.famNo}"
											class=" trashCanIcon far fa-trash-alt" type="button"
											data-bs-toggle="modal" data-bs-target="#deleteFamModal"></button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 가족 변경 테이블 -->
					<form id="frmFamily" name="frmFamily" action="/empInfo/updateFam"
						method="post">
						<input type="hidden" name="empCd" value="${data.empCd}" />
						<table
							class="table table-bordered align-middle text-align border border-2"
							style="display: none;" id="updateFam">
							<colgroup>

								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<td class="text-center bg-primary-subtle">성명</td>
									<td class="text-center bg-primary-subtle">가족관계</td>
									<td class="text-center bg-primary-subtle">성별</td>
									<td class="text-center bg-primary-subtle">생년월일</td>
								</tr>
							</thead>
							<tbody id="idTbody">
								<c:forEach var="fam" items="${data.famVO}" varStatus="stat0">
									<tr class="trFam">
										<td class="text-center famNm"><input class="form-control"
											type="text" name="famVO[${stat0.index}].famNm" id="famNm"
											style="text-align: center;" value="${fam.famNm}"> <input
											type="hidden" name="famVO[${stat0.index}].famNo" id="famNo"
											value="${fam.famNo}"> <input type="hidden"
											name="famVO[${stat0.index}].empCd" id="empCd"
											value="${data.empCd}"></td>
										<td class="text-center">
											<div class="form-group">
												<select class="form-select"
													name="famVO[${stat0.index}].famRel" id="famRel"
													data-options='{"placeholder":"관계를 선택해 주세요"}'>
													<c:forEach var="famCode" items="${famManageCode}"
														varStatus="stat">
														<option value="${famCode.commCd}"
															${fam.famRel == famCode.commCd ? 'selected' : ''}>${famCode.commCdNm}</option>
													</c:forEach>
												</select>
											</div>
										</td>
										<td class="text-center">
											<div class="form-group">
												<select class="form-select"
													name="famVO[${stat0.index}].famGend" id="gender"
													data-options='{"placeholder":" 성별을 선택하세요"}'>
													<c:if test="${fam.famGend == 'M'}">
														<option value="M" selected>남성</option>
														<option value="F">여성</option>
													</c:if>
													<c:if test="${fam.famGend == 'F'}">
														<option value="M">남성</option>
														<option value="F" selected>여성</option>
													</c:if>
												</select>
											</div>
										</td>
										<td class="text-center"><input class="form-control"
											type="date" name="famVO[${stat0.index}].famBirth"
											id="famBirth" style="text-align: center;"
											value="<fmt:formatDate value="${fam.famBirth}" pattern="yyyy-MM-dd"/>">

										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<sec:csrfInput />
					</form>

					<!-- 가족 삭제 모달 시작-->
					<div class="modal fade" id="deleteFamModal" data-keyboard="false"
						tabindex="-1" aria-labelledby="scrollinglongcontentLabel"
						aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="scrollinglongcontentLabel">인사정보_가족</h5>
									<button class="btn-close" type="button" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body modal-dialog modal-dialog-scrollable">
									<p style="">삭제하시겠습니까?</p>
								</div>
								<div class="modal-footer">
									<button class="btn btn-primary" type="button" id="btnDelFam">확인</button>
									<button class="btn btn-secondary" type="button"
										data-bs-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 가족 삭제 모달 끝-->
					<!-- 가족 수정 이동 -->
					<div class="d-flex justify-content-end">
						<button id="updatefampage" class="btn btn-primary me-3">수정</button>
					</div>
					<!-- 가족 추가 -->
					<div class="d-flex justify-content-between d-none">
						<button id="createFam" class="btn btn-primary me-3">추가</button>
						<div>
							<button id="btmUpdateFam" class="btn btn-primary me-3">저장</button>
							<button id="cancleUpdatefampage" class="btn btn-secondary me-3"
								onclick="location.href ='/empInfo/empInfo'"
								style="display: none;">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>


</body>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	window.onload = function() {

		//세션에서 받아온 아이디
		var loginIdSession = '${loginId}'
		console.log("세션에서 받아온 로그인아이디 : ", loginIdSession);

		var loginId = '${data.empCd}'
		console.log("컨트롤러에서 받아온 로그인아이디 : ", loginId);

		if (loginIdSession == loginId) {
			console.log("동일인 로그인")
		}

		//아이디에서 사번 추출하기
		var splitUserId = '${data.empCd}';
		splitUserId = splitUserId.split("_");

		$("#splitUserId").text(splitUserId[1]);

		//휴대폰번호 하이픈 넣기
		var phoneNo = '${data.empTelNo}'
		phoneNo = phoneNo.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
		//console.log(phoneNo)
		$("#phoneNo").text(phoneNo);

		//성별 가져오기
		var empGend = '${data.empGend}'
		//console.log(empGend)

		if (empGend == 'M') {
			$("#empGend").text("남성");
		} else if (empGend == 'F') {
			$("#empGend").text("여성");
		}

		

		//신상정보 수정하기
		$("#btnRegEmpInfoPersonal").click(function() {
			$(".regEmpInfoPersonalDiv").show();
			$(".empInfoPersonalDiv").hide();
			$("#btnRegEmpInfoPersonal").hide(); //수정하기들어오는 버튼
			$("#submitBtnRegEmpInfoPersonal").show(); //저장버튼
			$("#cancleBtnRegEmpInfoPersonal").show(); //취소버튼

			$("#regAddr").click(function() {
				var regAddr = $(this).val();
				$("#regAddr").val("");
				sample4_execDaumPostcode();
				$(".kakao").show();
				$("#regAddr").prop("disabled", true); //다시 주소입력 누르기 방지

			});

		});//btnRegEmpInfoPersonal

		//삭제버튼(휴지통)
		var famNo;
		$(".trashCanIcon").click(function() {
			famNo = $(this).data("fam-no");

			console.log(famNo);

		})
		
		//가족추가입력
		$("#createFam").click(function() {
			let famCnt = $(".trFam").length;
			let empCd = "${data.empCd}";
			
			//var updateFam = $("#updateFam")
			console.log("가족 입력폼추가 : " + famCnt);
			
			let newTr = "<tr class='trFam'><td class='text-center famNm'><input class='form-control' type='text' name='famVO["+famCnt+"].famNm' id='famNm' style='text-align: center;' value='' required /><input type='hidden' name='famVO["+famCnt+"].famNo' id='famNo' value='"+(Number(famCnt)+1)+"'><input type='hidden' name='famVO["+famCnt+"].empCd' id='empCd' value='"+empCd+"'></td>";
				newTr += "<td class='text-center'><div class='form-group'>";
				newTr += "<select class='form-select ' name='famVO["+famCnt+"].famRel' id='famRel' data-options='{&quot;placeholder&quot;:&quot;관계를 선택해 주세요&quot;}'>";
				newTr += "<option value='O001'>부</option><option value='O002'>모</option><option value='O003'>형제</option>";
				newTr += "<option value='O004' selected=''>자매</option><option value='O005'>조부</option><option value='O006'>조모</option>";
				newTr += "<option value='O007'>자녀</option><option value='O008'>배우자</option></select>";
				newTr += "</div></td>";
				newTr += "<td class='text-center'>";
				newTr += "<div class='form-group'>";
				newTr += "<select class='form-select' name='famVO["+famCnt+"].famGend' id='gender' data-options='{&quot;placeholder&quot;:&quot; 성별을 선택하세요&quot;}' required>";
				newTr += "<option value='M'>남성</option><option value='F' selected=''>여성</option>";
				newTr += "</select></div></td>";
				newTr += "<td class='text-center'><input class='form-control' type='date' name='famVO["+famCnt+"].famBirth' id='famBirth' style='text-align: center;' value=''>";
				newTr += "</td></tr>";
		
				$("#idTbody").append(newTr);
			
				famCnt++;
		});

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		$("#updatefampage").click(function() {
			console.log("가족수정페이지이동");
			$("#BtnUpdateFam").parent().removeClass('d-none');
			$("#updatefampage").hide();
			$("#cancleUpdatefampage").show();
			$("#updateFam").show();
			$("#createFam").parent().removeClass('d-none');
			$("#famInfo").hide();
		});

		//가족 수정양식에서 값 가져오기!
		$("#btmUpdateFam")
				.click(
						function() {

							var table = document.getElementById("updateFam");
							var rowList = table.rows;

							for (var i = 1; i < rowList.length; i++) {
								var row = rowList[i];

								var famNo = row.querySelector("#famNo").value;
								var famNm = row.querySelector("#famNm").value;

								var famRelSelect = row
										.querySelector("#famRel");
								var selectedOption = famRelSelect.options[famRelSelect.selectedIndex];
								var famRel = selectedOption.value;

								var famBirth = row
										.querySelector("#famBirth").value;

								var famGendSelect = row
										.querySelector("#gender");
								var selectedOption2 = famGendSelect.options[famGendSelect.selectedIndex];
								var famGend = selectedOption2.value;

								console.log("기본키", famNo);
								console.log("이름", famNm);
								console.log("가족공통코드", famRel);
								console.log("생일", famBirth);
								console.log("성별", famGend);

							}
							$("#frmFamily").submit();
						});

		// 가족 모달 확인버튼
		$("#btnDelFam").click(
				function() {
					console.log("나는 삭제 모달 확인버튼")
					console.log("famNo", famNo);
					console.log("data", data);
					var data = {
						"famNo" : famNo
					};
					$.ajax({
						url : "/empInfo/deleteFam",
						contentType : "application/json;charset=utf-8",
						data : JSON.stringify(data),
						type : "post",
						dataType : "text",
						beforeSend : function(xhr) {
							xhr.setRequestHeader("${_csrf.headerName}",
									"${_csrf.token}");
						},
						success : function(result) {
							location.href = "/empInfo/empInfo";

						},
						error : function(xhr, status, error) {
							console.log("에러 발생:", error);
						}

					}); //ajax
				});

		//신상정보 수정	
		$("#submitBtnRegEmpInfoPersonal").click(
				function() {

					var postcodeKakao = $("#sample4_postcode").val();
					var roadAddressKakao = $("#sample4_roadAddress").val();
					var detailAddressKakao = $("#sample4_detailAddress").val();

					if (postcodeKakao == "") {
						console.log("기존 주소임")
						var empZip = '${data.empZip}';
						var empAddr = '${data.empAddr}';
						var empDaddr = '${data.empDaddr}';
					} else {
						var empZip = $("#sample4_postcode").val();
						var empAddr = $("#sample4_roadAddress").val();
						var empDaddr = $("#sample4_detailAddress").val();
					}

					var data = {
						"empCd" : loginIdSession,
						"empZip" : empZip,
						"empAddr" : empAddr,
						"empDaddr" : empDaddr
					}
					console.log(data);

					$.ajax({
						url : "/empInfo/updatePersonal",
						contentType : "application/json;charset=utf-8",
						data : JSON.stringify(data),
						type : "post",
						dataType : "text",
						beforeSend : function(xhr) {
							xhr.setRequestHeader("${_csrf.headerName}",
									"${_csrf.token}");
						},
						success : function(result) {
							location.href = "/empInfo/empInfo";

						},
						error : function(xhr, status, error) {
							console.log("에러 발생:", error);
						}

					}); //ajax

				});

	}//onload

	//카카오 주소
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample4_postcode').value = data.zonecode;
						document.getElementById("sample4_roadAddress").value = roadAddr;
						document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("sample4_extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("sample4_extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}

				}).open();
	}
</script>