<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 29.     유선영      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>

	$(document).ready(function() {
		// 불량재고 조회 페이지에 들어갔을 때
		// 불량관리 버튼이 열려있도록 collapse 클래스에 show 클래스 추가
		$('#defect').addClass('show');
	});
	
</script>
<style>
.iText{
	border:none;
	background: transparent;
}
.lessQty {
    background-color: rgba(255, 0, 0, 0.2) !important;
}
</style>

<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
			<br/>
				<h3 class="mb-0">발주요청 등록</h3>
				<br/><br/>
			</div>
			<div class="col-auto ms-auto">
				<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
					role="tablist"></div>
			</div>
		</div>
	</div>
	<div class="card-body pt-0 ">
		<div class="tab-content">
			<div class="tab-pane preview-tab-pane active" role="tabpanel" aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
				id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">
				<c:url value="/pur/create" var="purUrl"/>
				<form action="${purUrl}" id="purForm">
				<div class="table-responsive scrollbar">
					<table class="table table-bordered fs--1 mb-0" id="purTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>납기일자</th>
								<td colspan="2">
									<input type="date" id="findPreqDueDate" name="preqDueDate" required class="preqDueDate" placeholder="납기일자"  style="width: 170px;" required/>
									<span id="preqDueDateError" class="error"></span>
								</td>
								<th>담당자</th>
								<td colspan="2">
									<input type="text" id="findEmpNm" class="findEmpNm" name="empNm" autocomplete="off" placeholder="담당자" style="width: 170px;" required/>
									<span id="empCdError" class="error"></span>
									<input type="hidden" id="findEmpCd" class="empCd"  name="empCd"  />
									<input type="hidden" id="findDeptNm" class="deptNm"  name="deptNm"  />
								</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>선택</th>
								<th>품목코드</th>
								<th colspan="2">품목명</th>
								<th>수량</th>
								<th colspan="2">적요</th>
							</tr>
							<tr class="purOrderRow">
								<td>
									<input type="checkbox" name="checking">
								</td>
								<td>
	                                <input type="text" required class="iText findItemCd" autocomplete="off" readonly id="${itemCdId}" name="itemCd" style="width: 100%" value="${itemCd}"/>
									<span id="itemNullError" class="error"></span> 
	                            </td>
	                            <td colspan="2">
	                                <input type="text" required class="iText findItemNm" autocomplete="off" readonly id="findItemNm" name="itemNm" style="width: 100%" value="${itemNm}"/>
	                                <span id="itemNmError" class="error"></span> 
	                            </td>
	                            <td>
	                                <input type="number" required class="iText findReqItemQty" id="findReqItemQty" autocomplete="off" name="reqItemQty" style="width: 100%" min=0 value="${reqItemQty}"/>
	                                <span id="reqItemQtyError" class="error"></span>
	                            </td>
	                            <td colspan="2">
	                                <input type="text" class="iText findReqNote" id="findReqNote" name="reqNote" style="width: 100%" value="${reqNote}"/>
	                            </td>
							</tr>
						</tbody>
					</table>
				</div>
				<br>
				<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="insertBtn" style="float:right;">저장</button>
				<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="uploadBtn" style="float:right; margin-right:10px;">재고불러오기</button>
				<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="selectBtn" style="float:right; margin-right:10px;">선택삭제</button>
				<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="createTrBtn" style="float:right; margin-right:10px;">행추가</button>
			</form>
			</div>
		</div>
	</div>
</div>

<!-- 담당자 검색 모달 -->
<div class="modal fade" id="findEmpModal" tabindex="-1"aria-labelledby="findEmpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findEmpModalLabel">담당자 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered fs--1 mb-0" id="findEmpDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>사원코드</th>
								<th>담당자명</th>
								<th>부서명</th>
								<th>연락처</th>
							</tr>
						</thead>
						<tbody class="list">
						
						</tbody>
					</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 품목정보 검색 모달 -->
<div class="modal fade" id="itemWindow" tabindex="-1"
	aria-labelledby="itemWindowModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog modal-lg">
	<form action="<c:url value='/sector/list'/>" id="searchForm" class="border">
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
	<input type="hidden" id="orderFrag" name="orderFrag" />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="itemWindowModalLabel">품목 선택</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close" id="itemClose"></button>
			</div>
			<div id="searchUI"  class="row g-3 d-flex justify-content-center" style="float: right;margin-top: 5px;">
			<div class="col-auto">
					<select name="searchType" class="form-select">
						<option value="">전체</option>
						<option value="itemCd">품목코드</option>
						<option value="itemNm">품목명</option>
					</select>
				</div>
				<div class="col-auto">
					<input type="text" name="searchWord" placeholder="검색" class="form-control"/>
				</div>
				<div class="col-auto">
					<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
				</div>
			</div>
			<div class="modal-body" id="itemListContainer">
				<table class="table" id="itemTableData">
					<thead>
						<tr id="trPlus">
							<th class='hide'>선택</th>
							<th>품목코드</th>
							<th>품목명</th>
							<th class='hide'>재고수량</th>
							<th class='hide'>안전재고</th>
						</tr>
					</thead>
					<tbody id="dataList">
					</tbody>
					<tfoot>
					    <tr><td colspan="5"><span id="pagingArea"></span></td></tr>
				    </tfoot>
				</table>
		    	<div id="divData"></div>
			</div>
		</div>
		</form>
	</div>
</div>

<script src="/resources/js/purOrder/purOrderForm.js"></script>
