<%--
* [[개정이력(Modification Information)]]
* 수정일        수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 24.      범종      최초작성
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
		$('#unitPrice').addClass('show');
	});
	
	//페이징 불러오기 ! 
	function fn_paging(data ,page) {
		console.log("data",data)
		if(data==2){
			searchForm.page.value = page;
			searchForm.requestSubmit();
			searchForm.page.value = "";
		}else{
			console.log("안녕");
		};
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
				<h3 class="mb-0">확정단가 등록</h3>
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
					<div class="itemList">
					
					</div>
				</div>
							
				
				<br>
						<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="submit" id="insertBtn" style="float:right">승인</button>
			</form>
			</div>
		</div>
	</div>
	<div>
		<c:url value="/orderUnitPrice" var="orderUnitPriceUrl"/>
		<form action="${orderUnitPriceUrl}" id="orderUnitPriceForm" >
		  <button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="submit" id="upFile">단가요청서</button>
		</form> 
		<button id="autoBinding">
		    <i class="far fa-save"></i>
		</button>
	</div>
<%-- 	<form action="${orderUnitPriceUrl}" id="orderUnitPriceExcelForm" enctype="multipart/form-data">
	  <p>데이터 업로드<br>엑셀파일만 업로드 가능(xls, xlsx)</p>
	  <input type="file" name="upFile" id="upFile" accept=".xlsx, .xls"/>
	</form>  --%>

</div>


<!-- 모달 -->
<div class="modal fade" id="orderUnitPriceUploadModal" tabindex="-1"
	aria-labelledby="orderUnitPriceUploadModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="orderUnitPriceUploadModalLabel">단가 요청서 목록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div id="searchUI"  class="row g-3 d-flex justify-content-end" style="float: right;margin-bottom: 10px;">
					<div class="col-auto">
						<select name="searchType" class="form-select">
							<option value>전체</option>
							<option value="pordCd">발주서코드</option>
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
			<%-- <c:url value="/orderUnitPriceUpload" var="orderUnitPriceUrl"/>
			<form action="${orderUnitPriceUrl}" id="orderUnitPriceUploadOneForm">
			</form> --%>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				
				
			</div>
			
			<span id="pagingArea"></span>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
	<form action="<c:url value='/orderUnitPrice/list2'/>" id="searchForm" class="border">
		<input type="hidden" name="searchType" readonly="readonly" placeholder="searchNm"/>
		<input type="hidden" name="searchWord" readonly="readonly" placeholder="searchData"/>
		<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
	</form>
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





<c:url value="/resources/js/orderUnitPrice/orderUnitPriceEnroll.js" var="urls" />
<script src="${urls}">
	
</script>