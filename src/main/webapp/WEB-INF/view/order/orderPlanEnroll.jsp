<%--
* [[개정이력(Modification Information)]]
* 수정일        수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 15.      범종      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<script>

	$(document).ready(function() {
		$('#orderPlan').addClass('show');
	});
	
	//페이징 불러오기 ! 
	function fn_paging(data, page) {
		console.log("data", data)
		if (data == 2) {
			searchForm.page.value = page;
			searchForm.requestSubmit();
			searchForm.page.value = "";
		} else {
			console.log("안녕");
		}
		;
	}

</script>

<!--  -->

<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
			<br/>
				<h3 class="mb-0">발주계획서 등록</h3>
			</div>
			<div class="col-auto ms-auto">
				<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
					role="tablist"></div>
			</div>
		</div>
	</div>
	<div >
	<div id="searchUI" class="row g-3 d-flex justify-content-center"
		style="float: right; margin-bottom: 10px;">
		<div class="col-auto">
			<select name="searchType" class="form-select">
				<option value>전체</option>
				<option value="preqCd">발주계획서코드</option>
				<option value="itemNm">품목명</option>
			</select>
		</div>
		<div class="col-auto">
			<input type="text" name="searchWord" placeholder="검색"
				class="form-control" />
		</div>
		<div class="col-auto">
			<input type="button" value="검색" id="searchBtn"
				class="btn btn-primary" />
		</div>
	</div>
	<div>
		<table class="table table-bordered table-striped fs--1 mb-0"
			id="dataTable" style="width : 100%;">
			<thead class="bg-200 text-900">
				<tr>
					<th>선택</th>
					<th class="preqCd">발주요청코드</th>
					<th class="itemNm">품목명</th>
					<th class="preqDate">발주요청일자</th>
					<th class="preqDueDate">납기일자</th>
					<th class="preqStat">진행여부</th>
				</tr>
			</thead>
			<tbody class="list">
			
				
			</tbody>
			<tfoot>
				<tr style="border-bottom: none;">
					<td colspan="7"><span id="pagingArea"></span></td>
				</tr>
			</tfoot>
		</table>
	</div>
	</div>
	<div style="border: none; text-align: right;">
		<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1"  data-bs-toggle="modal" data-bs-target="#createWindow" type="button" id="insertBtn" style="margin-bottom:10px;">발주계획등록</button>
	</div>
</div>

<form action="<c:url value='/orderPlan/enroll2'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" readonly="readonly" placeholder="searchNm" /> 
	<input type="hidden" name="searchWord" readonly="readonly" placeholder="searchData" /> 
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page" />
</form>



<!-- 모달 -->
<div class="modal fade" id="orderPlanEnrollModal" tabindex="-1"
	aria-labelledby="orderPlanEnrollModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="orderPlanEnrollModalLabel">발주 요청 상세 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<c:url value="/orderPlan" var="orderPlanUrl"/>
			<form action="${orderPlanUrl}" id="orderPlanForm">
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
			</div>
			</form>
			
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>




<c:url value="/resources/js/orderPlan/orderPlanEnroll.js" var="urls" />

<script src="${urls}">

</script>




