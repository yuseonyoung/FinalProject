<%--
* [[개정이력(Modification Information)]]
* 수정일        수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 22.      범종      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<script>
	$(document).ready(function() {
		// 불량재고 조회 페이지에 들어갔을 때
		// 불량관리 버튼이 열려있도록 collapse 클래스에 show 클래스 추가
		$('#orderPlay').addClass('show');
	});

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
				<h3 class="mb-0">발주서 입력</h3>
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
				<c:url value="/orderPlay" var="orderPlayUrl"/>
				<form action="${orderPlayUrl}" id="orderPlayForm">
				<div class="table-responsive scrollbar">
					<table class="table table-bordered table-striped fs--1 mb-0" style="width : 100%" id="dataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>발주일자</th>
								<td colspan="5">
									<input type="date" id="pordDate" name="pordDate" class="pordDate" placeholder="처리일자"  style="width: 170px;" />
									<span id="defPordDate" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>납기일자</th>
								<td colspan="5">
									<input type="date" id="dueDate" name="dueDate" class="dueDate" placeholder="처리일자"  style="width: 170px;" />
									<span id="defDueDate" class="error"></span>
								</td>
							</tr>
							<tr>
								<th>거래처명</th>
								<td colspan="5">
									<input type="text" id="findComNm" class="findComNm"  name="comNm" placeholder="거래처" style="width: 170px;" />
									<span id="comNm" class="error"></span>
									<input type="hidden" id="findComCd" class="findComCd"  name="comCd"  />
								</td>
							</tr>
							<tr>
								<th>담당자</th>
								<td colspan="5">
									<input type="text" id="findEmpNm" class="findEmpNm"  name="empNm" placeholder="담당자" style="width: 170px;" />
									<span id="empNm" class="error"></span>
									<input type="hidden" id="findEmpCd" class="findEmpCd"  name="empCd"  />
								</td>
							</tr>
							<tr>
								<th>품목코드</th>
								<th>품목명</th>
								<th>단위</th>
								<th>단가</th>
								<th>수량</th>
								<th></th>
							</tr>
						</thead>

						<tbody class="itemList">
							<tr class="new-row" data-row="0">
					          <td><input type="text" class="iText" class="itemCd" name="itemCd"></td>
					          <td><input type="text" class="iText" name="itemNm"></td>
					          <td><input type="text" class="iText" name="itemUnit" disabled="disabled"></td>
					          <td><input type="text" class="iText" name="inUprc" disabled="disabled"></td>
					          <td><input type="number" class="iText" name="defQty" style="width: 120px"></td>
					          <td><button onclick="deleteRow(this)"  class="btn btn-outline-danger btn-sm deleteRowBtn">Delete</button></td>
					          </tr>
						</tbody>
					</table>
				</div>
				<br>
						<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="submit" id="addRow" style="float:right">행추가</button>
						<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="submit" id="insertBtn" style="float:right">저장</button>
						<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="reset"  style="float:right">ㅎㅎ</button>
			</form>
			</div>
		</div>
	</div>
	<div>
		<button id="autoBinding">
			    <i class="far fa-save"></i>
		</button>
	</div>
</div>


<!-- 회사 검색 모달 -->
<div class="modal fade" id="findDealComModal" tabindex="-1"aria-labelledby="findDealComModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findDealComModalLabel">거래처 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered table-striped fs--1 mb-0" id="findDealComDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th >거래처코드</th>
								<th >거래처명</th>
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
				<table class="table table-bordered table-striped fs--1 mb-0" id="findItemDataTable1">
						<thead class="bg-200 text-900">
							<tr>
								<th >품목코드</th>
								<th >품목명</th>
								<th >단가</th>
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

<div class="modal fade" id="findEmpModal" tabindex="-1"aria-labelledby="findEmpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findEmpModalLabel">사원 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered table-striped fs--1 mb-0" id="findEmpDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th >사원코드</th>
								<th >사원명</th>
								<th >부서명</th>
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
	
<c:url value="/resources/js/orderPlay/orderPlayEnroll.js" var="urls" />
<script src="${urls}">
	
</script>