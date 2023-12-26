<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 8.      최광식      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
	$(document).ready(function() {
		// 불량재고 조회 페이지에 들어갔을 때
		// 불량관리 버튼이 열려있도록 collapse 클래스에 show 클래스 추가
		$('#actInven').addClass('show');
	});
</script>

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
table thead,table tbody tr{display:table;width:100%;}
table td{width:10%}
</style>


<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<br>
				<h3 class="mb-0">재고조정</h3>
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
					<div class="col-auto">
						<input type="button" value="조정" id="updateBtn" class="btn btn-outline-primary"/>
					</div>
				</div>
<!-- 				<div style="width: 100%; height: 800px;"> -->
					<table class="table table-bordered fs--1 mb-0" style="width:100%" >
						<thead class="bg-200 text-900">
							<tr>
							<th class="text checkBox" style="width:5%;"><input type="checkbox"  name="select" class="checkAll"></th>
								<th class="text realCd" style="width:15%;">일련번호</th>
								<th class="text itemCd" style="width:10%;">품목코드</th>
								<th class="text itemNm" style="width:16%;">품목명</th>
								<th class="text wareNm" style="width:10%;">창고명</th>
								<th class="text secCd" style="width:10%;">구역</th>
								<th class="text empNm" style="width:10%;">담당자</th>
								<th class="text wareQty" style="width:8%;">시스템수량</th>
								<th class="text rinvQty" style="width:8%;">실사수량</th>
								<th class="text errorQty" style="width:8%;">오차수량</th>
							</tr>
						</thead>
						<tbody class="listBody" style="display:block; max-height:500px; width:100%; overflow-y:auto">
	
						</tbody>
					</table>
<!-- 				</div> -->
			</div>
		</div>
	</div>
</div>
	
<form action="<c:url value='/invenAdjust/listView'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" readonly="readonly" placeholder="searchData"/>
</form>


<script src="/resources/js/invenAdjust/invenAdjust.js"></script>