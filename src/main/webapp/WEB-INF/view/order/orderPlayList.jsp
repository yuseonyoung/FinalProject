<%--
* [[개정이력(Modification Information)]]
* 수정일        수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 21.      범종      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>


<script>
	$(document).ready(function() {
		$('#orderPlay').addClass('show');
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
<!-- 
<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<h3 class="mb-0">발주서 조회</h3>
			</div>
			<div class="col-auto ms-auto">
				<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
					role="tablist"></div>
			</div>
		</div>
	</div>
	<div class="table-responsive scrollbar">
		<table class="table table-bordered table-striped fs--1 mb-0"
			id="dataTable">
			<thead class="bg-200 text-900">
				<tr>
					<th class="pordCd">발주서코드</th>
					<th class="itemNm">품목명</th>
					<th class="pordDate">발주일자</th>
					<th class="dueDate">납기일자</th>
					<th class="pordStat">발주진행여부</th>
				</tr>
			</thead>
			<tbody class="list">

			</tbody>
		</table>
		
	</div>
</div>
 -->
<!--  -->
<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<br>
				<h3 class="mb-0">발주서 조회</h3>
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
				<div id="searchUI"  class="row g-3 d-flex justify-content-center" style="float: right;margin-bottom: 10px;">
					<div class="col-auto">
						<select name="searchType" class="form-select">
							<option value>전체</option>
							<option value="pordCd">발주서코드</option>
							<option value="itemNm">품목명</option>
							<option value="empNm">담당자</option>
						</select>
					</div>
					<div class="col-auto">
						<input type="text" name="searchWord" autocomplete="off" placeholder="검색" class="form-control"/>
					</div>
					<div class="col-auto">
						<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
					</div>
				</div>
					
					<table class="table table-bordered table-striped fs--1 mb-0" >
						<thead class="bg-200 text-900">
							<tr>
								<th class="pordCd">발주서코드</th>
								<th class="itemNm">품목명</th>
								<th class="pordDate">발주일자</th>
								<th class="dueDate">납기일자</th>
								<th class="pordStat">발주진행여부</th>
							</tr>
						</thead>
						<tbody class="list">

						</tbody>
						<tfoot>
							<tr><td colspan="7"><span id="pagingArea"></span></td></tr>
						</tfoot>

					</table>
				</div>
			</div>
		</div>
	</div>
	
	<form action="<c:url value='/orderPlay/list2'/>" id="searchForm" class="border">
		<input type="hidden" name="searchType" readonly="readonly" placeholder="searchNm"/>
		<input type="hidden" name="searchWord" readonly="readonly" placeholder="searchData"/>
		<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
	</form>

<!-- 모달 -->
<div class="modal fade" id="orderPlayListModal" tabindex="-1"
	aria-labelledby="orderPlanEnrollModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="orderPlanEnrollModalLabel">발주서 상세 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<c:url value="/orderPlay" var="orderPlayUrl"/>
			<form action="${orderPlayUrl}" id="orderPlayListForm">
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
			</div>
			</form>
			
			<div class="modal-footer d-flex justify-content-between">
			    <div>
			        <input type="button" class="btn btn-primary" id="rejectBtn" value="반려" />
			    </div>
			    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>	
	
<!-- ************************************************************************* -->
<%-- <div class="modal fade" id="orderPlayListModal" tabindex="-1"
	aria-labelledby="orderPlanEnrollModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="orderPlanEnrollModalLabel">발주서 상세 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<c:url value="/orderPlay" var="orderPlayUrl"/>
			<form action="${orderPlayUrl}" id="orderPlayListForm">
				<div class="table-responsive scrollbar">
					<div class="modal-body">
							<div class="card-header ">
								<div class="row flex-between-end">
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
										
										<div class="table-responsive scrollbar">
											<table class="table table-bordered table-striped fs--1 mb-0">
												<thead class="bg-200 text-900">
													<tr>
														<th>일자</th>
														<td colspan="5">
															<input type="date" id="pordDate"  placeholder="작성일자"  style="width: 170px;" />
														</td>
													</tr>
													<tr>
														<th>담당자</th>
														<td colspan="5">
															<input type="text" id="empNm"  placeholder="담당자" style="width: 170px;"/>
														</td>
													</tr>
													<tr>
														<th>거래처</th>
														<td colspan="5">
															<input type="text" id="comNm" placeholder="거래처명" style="width: 170px;"/>
														</td>
													</tr>
													<tr>
														<th>납기일자</th>
														<td colspan="5">
															<input type="date" id="dueDate" placeholder="납기일자" style="width: 170px;" />
														</td>
													</tr>
												</thead>
												<tbody class="modal-body">
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						
						</div>
												
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
				</form>
		</div>
	</div>
</div> 
	 --%>
	
	
	
	
	
<!-- ************************************************************************* -->
	
<c:url value="/resources/js/orderPlay/orderPlay.js" var="urls" />
<script src="${urls}">
	
</script>