<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 08.      최광식      최초작성
* 2023. 11. 15.      최광식      등록
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
	
	function fn_paging(page) {
		searchItemForm.page.value = page;
		searchItemForm.requestSubmit();
		searchItemForm.page.value = "";
	}

</script>
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
			<br>
				<h3 class="mb-0">불량품목 입력</h3>
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
				<c:url value="/defect" var="defectUrl"/>
				<form action="${defectUrl}" id="defectForm">
				<div class="table-responsive scrollbar">
					<table class="table table-bordered fs--1 mb-0" id="dataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>일자</th>
								<td colspan="5">
<!-- 								<input type="text" id="defectDate" name="defProcdate" class="defectDate datetimepicker"  id="datepicker" placeholder="처리일자" data-options='{"dateFormat":"yyyy-mm-dd"}' style="width: 170px;"/> -->
									<input type="date" id="defectDate" name="defProcdate" class="defectDate" placeholder="처리일자"  style="width: 170px;" />
									<span id="defProcdate" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>발견창고</th>
								<td colspan="2">
									<input type="text" id="findStorage" class="findStorage" name="storage.wareCd" placeholder="발견창고" style="width: 170px;"/>
									<span id="wareCd" class="error"></span>
									<input type="hidden" id="findStorageCd" class="storage.wareCd" name="wareCd"/>
								</td>
							
								<th>구역</th>
								<td colspan="2">
									<input type="text" id="findStorageSector" class="findStorageSector" name="secCd" placeholder="구역" style="width: 170px;" readonly="readonly"/>
									<span id="secCd" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>담당자</th>
								<td colspan="2">
									<input type="text" id="findEmpNm" class="findEmpNm"  name="empNm" placeholder="담당자" style="width: 170px;" />
									<span id="empNm" class="error"></span>
									<input type="hidden" id="findEmpCd" class="empCd"  name="empCd"  />
								</td>
								<th>처리방법</th>
								<td colspan="2"> 
									<select id="defProc" class="defectAprch" name="defProc" style="width: 170px;" >
										<c:forEach items="${defectTypeList }" var="type">
											<option class="${type.commCd}" label="${type.commCdNm }" value="${type.commCdNm }" />
										</c:forEach>
									</select>
									<span id="defProc" class="error"></span>
								</td>
							</tr>
						</thead>

						<tbody>
							<tr>
								<th>품목코드</th>
								<th>품목명</th>
								<th>단위</th>
								<th>수량</th>
								<th>불량유형</th>
								<th>적요</th>
							</tr>
							<tr>
								<td>
									<input type="text" id="findItemCd" name="itemCd" class="iText findItemCd" />
									<span id="itemCd" class="error"></span> 
								</td>
								<td>
									<input type="text" id="findItemNm" class="iText findItemNm"  />
									<span id="item.itemNm" class="error"></span> 
								</td>
								<td>
									<input type="text" id="findItemUnit" class="iText findItemUnit" disabled="disabled" />
								</td>
								<td>
									<input type="number" id="count" name="defQty" class="iText" style="width: 120px" />
									<span id="defQty" class="error"></span>
								</td>
								<td>
									<input type="text" id="defectType" name="defNm" class="iText" />
									<span id="defNm" class="error"></span>
									<input type="hidden" id="defectTypeCd" name="defCd" class="iText" />
								</td>
								<td>
									<input type="text" id="defNote" name="defNote" class="note iText" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<br>
				
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="submit" id="insertBtn" style="float:right">저장</button>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="addItemBtn" style="float:right; margin-right: 5px;">일괄입력</button>
			</form>
			</div>
		</div>
	</div>
	<div id="searchUI"  class="row g-3 d-flex justify-content-center" style="float: right;margin-bottom: 10px;">
	</div>
<form action="<c:url value='/defect/listView'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" readonly="readonly" placeholder="searchData"/>
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
</form>
		
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

<!-- 불량유형 검색 모달 -->
<div class="modal fade" id="findDefectTypeModal" tabindex="-1"aria-labelledby="findDefectTypeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findDefectTypeModalLabel">불량유형 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered fs--1 mb-0" id="findDefectType">
						<thead class="bg-200 text-900">
							<tr>
								<th >불량코드</th>
								<th >불량명</th>
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
<div class="modal fade" id="findItemModal1" tabindex="-1"aria-labelledby="findItemModalLabel1" aria-hidden="true">
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
				<table class="table table-bordered fs--1 mb-0" id="findItemDataTable1">
						<thead class="bg-200 text-900">
							<tr>
								<th >품목코드</th>
								<th >품목명</th>
								<th >단위</th>
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

<!-- 품목정보 검색 모달1 품목명 눌럿을 때 -->
<div class="modal fade" id="findItemModal2" tabindex="-1"aria-labelledby="findItemModalLabel2" aria-hidden="true">
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
								<th >품목코드</th>
								<th >품목명</th>
								<th >단위</th>
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

	<script>
        document.addEventListener('DOMContentLoaded', function () {
            var defectDateInput = document.getElementById('defectDate');

            // 오늘 날짜 설정
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();

            today = yyyy + '-' + mm + '-' + dd;
            
            // 오늘 이전의 날짜만 선택 가능
            defectDateInput.setAttribute('max', today);

        });
    </script>
<script src="/resources/js/defect/defect.js"></script>
