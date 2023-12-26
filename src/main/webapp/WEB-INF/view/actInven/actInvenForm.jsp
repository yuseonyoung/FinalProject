<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 8.      최광식      최초작성
* 2023. 11. 12.      최광식     등록폼 생성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- <script> -->
<!-- // 	$(document).ready(function() { -->
<!-- // 		$('#actInven').addClass('show'); -->
<!-- // 	}); -->
<!-- // 	function fn_paging(page) { -->
<!-- // 		searchItemForm.page.value = page; -->
<!-- // 		searchItemForm.requestSubmit(); -->
<!-- // 		searchItemForm.page.value = ""; -->
<!-- // 	} -->
<!-- </script> -->

<style>
.iText{
	border:none;
	background: transparent;
	text-align: center;
}

.wd1200{
	width:1200px !important;
}
</style>

<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
			<br>
				<h3 class="mb-0">실사재고 입력</h3>
			</div>
			<div class="col-auto ms-auto">
				<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
					role="tablist"></div>
			</div>
		</div>
	</div>
	<br/><br/>
	<div class="card-body pt-0 ">
		<div class="tab-content">
			<div class="tab-pane preview-tab-pane active" role="tabpanel" aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
				id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">
				<c:url value="/actInven" var="actInvenUrl"/>
				<form action="${actInvenUrl}" id="actInvenForm">
					<div class="table-responsive scrollbar">
						<table class="table table-bordered fs--1 mb-0"
							id="dataTable">
							<thead class="bg-200 text-900">
								<tr>
									<th>일자</th>
									<td >
										<input type="date" id="actInvenDate" name="rinvDate" class="rinvDate" placeholder="조사일자" style="width: 170px;" /> 
										<span id="rinvDate" class="error"></span>
									</td>
									<th>담당자</th>
									<td colspan="2">
										<input type="text" id="findEmpNm" class="findEmpNm" name="empNm" placeholder="담당자"	style="width: 170px;" /> 
										<span id="empNm" class="error"></span>
										<input type="hidden" id="findEmpCd" class="findEmpCd" name="empCd" />
									</td>
								</tr>
								<tr>
									<th>창고명</th>
									<td >
										<input type="text" id="findStorage" class="findStorage" name="wareNm" placeholder="창고명" style="width: 170px;" /> 
										<span id="wareCd" class="error"></span>
										<input type="hidden" id="findStorageCd" class="wareCd"	name="wareCd" />
									</td>

									<th>구역</th>
									<td colspan="2">
										<input type="text" id="findStorageSector" class="findStorageSector" name="secCd" placeholder="구역" style="width: 170px;" readonly="readonly" /> 
										<span id="secCd" class="error"></span>
									</td>
								</tr>
								<tr>
							</thead>

							<tbody id='itemBody' style='text-align: center;'>
								<tr>
									<th>품목코드</th>
									<th>품목명</th>
									<th>단위</th>
									<th>실사수량</th>
								</tr>
								<tr>
									<td>
										<input type="text" id="findItemCd" name="itemCd" class="iText findItemCd"  />
										<span id="itemCd" class="error"></span> 
										<input type="hidden" class="hiddenItemCd" name="itemCd"  />
									</td>
									<td>
										<input type="text" id="findItemNm"	class="iText findItemNm" name="itemNm"  />
										<span id="itemNm" class="error"></span>
									</td>
									<td>
										<input type="text" id="findItemUnit" class="iText findItemUnit" disabled="disabled" />
									</td>
									<td>
										<input type="number" id="findRinvQty" name="rinvQty" class="iText findRinvQty"  /> 
										<span id="rinvQty" class="error"></span>
									</td>
									<td>
										<button class="btn btn-outline-danger btn-sm deleteRowBtn" data-item-code="${item.item.itemCd}">삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<br>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="submit" id="insertBtn" style="float:right">저장</button>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="addRowBtn" style="float:right; margin-right: 5px;">품목 추가</button>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="addItemBtn" style="float:right; margin-right: 5px;">일괄입력</button>
			</form>
			</div>
		</div>
	</div>
</div>
<div id="searchUI" class="row g-3 d-flex justify-content-center">
</div>
<form action="<c:url value='/item'/>" id="searchForm" class="border">
<input type="hidden" name="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" readonly="readonly" placeholder="searchData"/>
<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
</form>



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
				<table class="table table-bordered fs--1 mb-0" id="findItemDataTable2">
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


<script>
        document.addEventListener('DOMContentLoaded', function () {
            var actInvenDateInput = document.getElementById('actInvenDate');

            // 오늘 날짜 설정
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();

            today = yyyy + '-' + mm + '-' + dd;
            
            // 오늘 이전의 날짜만 선택 가능
            actInvenDateInput.setAttribute('max', today);

        });
</script>
<script src="/resources/js/actInven/actInven.js"></script>