<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 16.      유선영      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<style>
.iText{
	border:none;
	background: transparent;
}
</style>
<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
			<br/>
				<h3 class="mb-0">발주요청 조회</h3>
				<br/>
			</div>
			<div class="col-auto ms-auto">
				<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2" role="tablist"></div>
			</div>
		</div>
	</div>
	<div class="card-body pt-0 ">
		<div class="tab-content">
			<div class="tab-pane preview-tab-pane active" role="tabpanel" aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
				id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">
				<p id="searchDate" style="text-align:right;"/>
				<div class="table-responsive scrollbar">
					<table class="table table-bordered fs--1 mb-0" id="purListDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>발주요청일자</th>
								<th>납기일자</th>
								<th>품목명</th>
								<th>수량</th>
								<th>진행상태</th>
								<th>적요</th>
							</tr>
						</thead>
						<tbody class="list">

						</tbody>

					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 모달 -->
<div class="modal fade" id="purOrderModal" tabindex="-1"
	aria-labelledby="purOrderModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content" style="width: 1200px; margin: 0 auto">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="purOrderModalLabel">발주요청 상세 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<form action="/pur/update" id="purOrderForm">
				<div class="table-responsive scrollbar">
					<div class="modal-body">
						<!-- 모달 내용이 들어갈 자리 -->
					</div>
					<div class="modal-footer">
						<button
							class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1"
							type="button" id="updateBtn" style="">수정</button>
						<button
							class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1"
							type="button" id="deleteBtn" style="">삭제</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- 담당자 검색 모달 -->
<div class="modal fade" id="findEmpModal" tabindex="-1" aria-labelledby="findEmpModalLabel" aria-hidden="true">
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
	<div class="modal-dialog">
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
						<tr>
							<th>품목코드</th>
							<th>품목명</th>
						</tr>
					</thead>
					<tbody id="dataList">
					</tbody>
					<tfoot>
					    <tr><td colspan="2"><span id="pagingArea"></span></td></tr>
				    </tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
<form action="<c:url value='/sector/list'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" id="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" id="searchWord" readonly="readonly" placeholder="searchData"/>
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
</form>
<script src="/resources/js/purOrder/purOrder.js"></script>
