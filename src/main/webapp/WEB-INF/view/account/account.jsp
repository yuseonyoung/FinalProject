<%--
* [[개정이력(Modification Information)]]
* 수정일              수정자      수정내용
* ----------     ---------  -----------------
* 2023. 11. 13.      이수정      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<h3 class="mb-0">계정 조회</h3>

			</div>

			<div class="col-auto ms-auto">

				<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
					role="tablist"></div>
			</div>
		</div>
	</div>
	<form id="searchUI" class="row g-3 d-flex justify-content-left"
		style="float: right; margin-left: 15px; margin-bottom: 10px;">
		<div class="col-auto">
			<form:select path="simpleCondition.searchType" class="form-select">
				<form:option label="전체" value="" />
				<form:option label="사번" value="empcd" />
				<form:option label="이름" value="name" />
				<form:option label="부서" value="department" />
			</form:select>
		</div>
		<div class="col-auto">
			<form:input path="simpleCondition.searchWord" class="form-control" />
		</div>
		<div class="col-auto">
			<input type="button" value="검색" id="searchBtn"
				class="btn btn-primary" />
		</div>

	</form>
	<div class="card-body pt-0 ">

		<div class="tab-content">

			<div class="tab-pane preview-tab-pane active" role="tabpanel"
				aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
				id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">

				<div id="tableExample3">
					<div class="table-responsive scrollbar" id="empTable">
						<table class="table table-bordered table-striped fs--1 mb-0">
							<thead class="bg-200 text-900">
								<tr class="text-center">
									<th class="sort" data-sort="empCd" style="text-align: left;">사번</th>
									<th class="sort" data-sort="empNm" style="text-align: left;">사원명</th>
									<th class="sort" data-sort="deptNm" style="text-align: left;">부서명</th>
									<th class="sort" data-sort="empAuth" style="text-align: left;">권한</th>
									<th class="sort" data-sort="hrCharge" style="text-align: left;">직책</th>
									<!-- <th class="sort" data-sort="empUse" style="text-align: left;" >사용여부</th> -->
									<th class="sort" data-sort="" style="text-align: left;"></th>
								</tr>
							</thead>
							<tbody class="list">
								<c:choose>
									<c:when test="${empty empList }">
										<tr>
											<td colspan="7">조회하신 회원정보가 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${empList }" var="emp">
											<tr>
												<td>${emp.empCd }</td>
												<td>${emp.empNm }</td>
												<td>${emp.deptNm }</td>
												<td><select name="empAuth"
													class="form-select form-select-sm" style="width: 120px">
														<option value="admin"
															<c:if test="${emp.empAuth eq 'admin' }">selected</c:if>>관리자</option>
														<option value="office"
															<c:if test="${emp.empAuth eq 'office' }">selected</c:if>>사무직</option>
														<option value="field"
															<c:if test="${emp.empAuth eq 'field' }">selected</c:if>>현장직</option>
														<option value="N"
															<c:if test="${emp.empAuth eq 'N' }">selected</c:if>>사용안함</option>
												</select></td>
												<td>${emp.hrGradeNm }</td>
												<%-- 	<td>
												<select name="empUse" class="form-select form-select-sm" style="width:120px">
													<option value="Y" <c:if test="${emp.empUse eq 'Y' }">selected</c:if>>사용</option>
													<option value="N" <c:if test="${emp.empUse eq 'N' }">selected</c:if>>사용안함</option>
												</select>
											</td> --%>
												<td>
													<button type="button" class="btn btn-primary udtBtn"
														data-cd="${emp.empCd }">수정</button>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>

							<tfoot style="text-align: center;">
								<tr>
									<td colspan="7">
										<nav aria-label="...">
											<ul class="pagination justify-content-center">
												${paging.pagingHTML }
											</ul>
										</nav>
									</td>
								</tr>
							</tfoot>
						</table>
						<form action="/account/edit" method="post" id="editForm">
							<security:csrfInput />
						</form>
						<button
							class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1"
							type="button" id="insertBtn">신규등록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form id="searchForm" modelAttribute="simpleCondition" method="get">
	<input type="hidden" path="searchType" name="searchType"
		readonly="readonly" /> <input type="hidden" path="searchWord"
		name="searchWord" readonly="readonly" /> <input type="hidden"
		name="page" />
</form>
<!-- 여기는 신규등록 모달  -->

<div class="modal fade" id="createWindow" data-bs-keyboard="false"
	data-bs-backdrop="static" tabindex="-1"
	aria-labelledby="createWindowLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg mt-6" role="document">
		<div class="modal-content border-0">
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
				<button
					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
					data-bs-dismiss="modal" aria-label="Close" id="createClose"></button>
			</div>

			<div class="modal-body p-0">
				<div class="bg-light rounded-top-3 py-3 ps-4 pe-6">
					<h4 class="mb-1" id="createWindowLabel">계정 등록</h4>
				</div>
				<div class="p-4">
					<div class="row">
						<c:url value="/account/form" var="accountUrl" />
						<form action="${accountUrl}" method="post" id="empForm">
							<security:csrfInput />
							<div class="mb-3 w-75">
								<label for="empCdInput">사원명</label> <select class="form-control"
									name="empCd" id="empCdInput">
								</select>
							</div>
							<span id="empCd" class="error"></span>

							<div class="mb-3 w-75">
								<label for="empPpwInput">패스워드</label> <input type="password"
									id="empPpwInput" name="empPpw" class="form-control" required />
							</div>
							<span id="empPpw" class="error"></span>

							<div class="mb-3 w-75">
								<label for="empAuthInput">권한</label> <select
									class="form-control" name="empAuth" id="empAuthInput">
									<option>선택</option>
									<option value="admin">관리자</option>
									<option value="office">사무직</option>
									<option value="field">현장직</option>
								</select>
							</div>
							<span id="empAuth" class="error"></span>

							<!-- <div class="mb-3 w-75">
				    <label for="empUseInput">사용여부</label>
				    <select id="empUseInput" name="empUse" class="form-control">
				    	<option >선택</option>
					    <option value="Y">사용</option>
						<option value="N">사용안함</option>
				    </select>
					<span id="empUse" class="error"></span> 
				</div> -->

							<div class="mb-3 w-75" id="buttonSpace">
								<button
									class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1"
									type="submit" id="resultBtn">저장하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<c:url value="/resources/js/account/account.js" var="urls" />
<script src="${urls}"></script>
<script>
	function fn_paging(page) {
		searchForm.page.value = page;
		searchForm.requestSubmit();
	}

	$(searchUI).on(
			"click",
			"#searchBtn",
			function(event) {
				console.log("서치버튼 클릭됨");
				console.log($(searchForm));
				console.log($(searchForm).find(":input[name='searchType']"));
				let inputs = $(this).parents("#searchUI").find(":input[name]");
				$.each(inputs, function(idx, ipt) {
					console.log(idx);
					console.log(ipt);
					let name = ipt.name;
					let value = $(ipt).val();
					console.log("namename", name);
					console.log("valuevalue", value);
					console.log("밑에보기");
					console.log($(searchForm).find(`:input[name=\${name}]`)
							.val(value));
					$(searchForm).find(`:input[name=\${name}]`).val(value);
					$(searchForm).submit();
				});
			});
</script>