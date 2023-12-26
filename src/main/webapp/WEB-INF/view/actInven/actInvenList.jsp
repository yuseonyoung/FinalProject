<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 8.      최광식      최초작성
* 2023. 11. 21.     최광식      전체 리스트 및 상세조회
* 2023. 11. 22.     최광식      수정
* 2023. 11. 23.     최광식      등록
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
.iText{
	border:none;
	background: transparent;
	text-align: center;
}

.wd1200{
	width:1200px !important;
}
.text{
text-align: center;
}
.number{
text-align: right;
}
</style>

<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<br>
				<h3 class="mb-0">실사재고 조회</h3>
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
				<div id="searchUI"  class="row g-3 d-flex justify-content-center" style="float: right;margin-bottom: 10px;">
					<div class="col-auto">
						<select name="searchType" class="form-select">
							<option value>전체</option>
							<option value="wareNm">창고명</option>
							<option value="itemNm">품목명</option>
							<option value="empNm">담당자</option>
						</select>
					</div>
					<div class="col-auto">
						<input type="text" name="searchWord" placeholder="검색" class="form-control"/>
					</div>
					<div class="col-auto">
						<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
					</div>
				</div>
					
					<table class="table table-bordered fs--1 mb-0" style="width: 100%;">
						<thead class="bg-200 text-900">
							<tr>
								<th class="text realCd" style="width: 190px;">일련번호</th>
								<th class="text wareNm" style="width: 140px;">창고명</th>
								<th class="text itemNm" style="width: 300px;">품목명</th>
								<th class="text empNm" style="width: 90px;">담당자</th>
								<th class="text wareQty" style="width: 120px;">시스템수량</th>
								<th class="text rinvQty" style="width: 120px;">실사수량</th>
								<th class="text rinvQty" style="width: 120px;">오차여부</th>
							</tr>
						</thead>
						<tbody class="listBody" style="text-align: center;">

						</tbody>
						<tfoot>
							<tr><td colspan="7"><span id="pagingArea"></span></td></tr>
						</tfoot>

					</table>
				</div>
			</div>
		</div>
	<form action="<c:url value='/actInven/listView'/>" id="searchForm" class="border">
		<input type="hidden" name="searchType" readonly="readonly" placeholder="searchNm"/>
		<input type="hidden" name="searchWord" readonly="readonly" placeholder="searchData"/>
		<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
	</form>
</div>
	


<!-- 모달 -->
<div class="modal fade" id="actInvenModal" tabindex="-1" aria-labelledby="actInvenModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content" style="width:1300px; margin: 0 auto">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="actInvenModalLabel">실사재고 상세</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"	aria-label="Close"></button>
			</div>
			<form action="/actInven" id="actInvenForm">
				<div class="table-responsive scrollbar">
					<div class="modal-body">
						<!-- 모달 내용이 들어갈 자리 -->
					</div>
					<div class="modal-footer">
						<button	class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1"	type="submit" id="updateBtn" style="">수정</button>
						<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>


<!-- 창고 검색 모달 -->
<div class="modal fade" id="findStorageModal" tabindex="-1"aria-labelledby="findStorageModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findStorageModalLabel">창고 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered fs--1 mb-0" id="findStorageDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th >창고코드</th>
								<th >창고명</th>
								<th >주소</th>
								
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

<!-- 창고섹터 검색 모달 -->
<div class="modal fade" id="findStorageSectorModal" tabindex="-1"aria-labelledby="findStorageSectorModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xs" style=" margin-top: 163px;">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findStorageSectorModalLabel">구역 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered fs--1 mb-0" id="findStorageSertorDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th >구역코드</th>
								<th >층</th>
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
								<th >사원코드</th>
								<th >담당자명</th>
								<th >부서명</th>
								<th >연락처</th>
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


<!-- 품목정보 검색 모달1 품목코드 눌럿을 때 -->
<div class="modal fade" id="findItemModal1" tabindex="-1"
	aria-labelledby="findItemModalLabel1" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findItemModalLabel1">품목 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered fs--1 mb-0"
					id="findItemDataTable1">
					<thead class="bg-200 text-900">
						<tr>
							<th>품목코드</th>
							<th>품목명</th>
							<th>단위</th>
						</tr>
					</thead>
					<tbody class="list1">

					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 품목정보 검색 모달2 품목명 눌럿을 때 -->
<div class="modal fade" id="findItemModal2" tabindex="-1"
	aria-labelledby="findItemModalLabel2" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findItemModalLabel2">품목 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered fs--1 mb-0"
					id="findItemDataTable2">
					<thead class="bg-200 text-900">
						<tr>
							<th>품목코드</th>
							<th>품목명</th>
							<th>단위</th>
						</tr>
					</thead>
					<tbody class="list1">

					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script src="/resources/js/actInven/actInven.js"></script>