<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 9.      최광식      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>

	$(document).ready(function() {
		// 불량재고 조회 페이지에 들어갔을 때
		// 불량관리 버튼이 열려있도록 collapse 클래스에 show 클래스 추가
		$('#defect').addClass('show');
		
		  // 현재 날짜 객체 생성
	    let currentDate = new Date();

	    // 현재 날짜를 rmstLdate에 설정 (YYYY-MM-DD 형식)
	    let rmstLdate = currentDate.toISOString().slice(0, 10);
	    $('#rmstLdate').val(rmstLdate);

	    // 1달 전 날짜 계산
	    let prevMonth = new Date(currentDate);
	    prevMonth.setMonth(prevMonth.getMonth() - 1);

	    // 1달 전 날짜를 rmstSdate에 설정 (YYYY-MM-DD 형식)
	    let rmstSdate = prevMonth.toISOString().slice(0, 10);
	    $('#rmstSdate').val(rmstSdate);
	});
	
	function fn_paging(page) {
		searchForm.page.value = page;
		searchForm.requestSubmit();
		searchForm.page.value = "";
	}
	
</script>
<style>
	#flexDiv {
	  display: flex;
	  justify-content: space-between;
	}
	
	.leftContent {
	  flex: 1; /* To make it take available space */
	}
	
	#itemWindow{
		position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.5); /* 배경색과 투명도 조절 */
	    z-index: 1050; /* 모달창 위에 표시되도록 z-index 설정 */
	    display: none; /* 기본적으로는 보이지 않게 설정 */
	}
</style>
<div id="totalPage">
	<div class="card mb-3 px-3" style="width: 100%; height: auto;">
	<br/>
			<h3>불량재고현황</h3>
			<br/><br/>
		<form class="row g-2"id="defectForm" method="post" action='<c:url value="/invenSituation"/>'>
			<div class="col-md-6">
				<label class="form-label" for="rmstSDate">시작일자</label> 
				    <input type="text" id="rmstSdate" name="rmstSdate" class="form-control datetimepicker"  id="datepicker" placeholder="yyyy-mm-dd" data-options='{"dateFormat":"yyyy-mm-dd"}'/>
			</div>
			<div class="col-md-6">
				<label class="form-label" for="rmstLDate">선택일자</label> 
				    <input type="text" id="rmstLdate" name="rmstLdate" class="form-control datetimepicker"  id="datepicker" placeholder="yyyy-mm-dd" data-options='{"dateFormat":"yyyy-mm-dd"}'/>
			</div>
			<div class="col-12">
				<label class="form-label" for="wareSearch">창고</label> 
				<div style="display: flex; align-items: center;">
					<input
						class="form-control" id="wareSearch" type="text"
						placeholder="창고검색" name ="wareCd" autocomplete="off"/>
					<button id="wareSearchBtn"  type="button" class="btn searchBtn p-1"><i class="bi bi-search"></i></button>		
				</div>
			</div>
			<div class="col-12">
				<label class="form-label" for="itemSearch">품목</label> 
				<div id="itemList" style="display: flex; align-items: center;">
					<input class="form-control" id="itemSearch" type="text" autocomplete="off" placeholder="품목검색"/>				
					<button id="itemSearchBtn"  type="button" class="btn searchBtn p-1"><i class="bi bi-search"></i></button>	
				</div>
				<br>
				<div id="spanSpace"></div>
			</div>
			    	
			<hr>		    
			<label class="form-label">사용중단품목 포함</label>
			<div class="col-12" style="display: flex; align-items: center;">
				<div class="form-check" style="margin-right:10px;">
					  <input class="form-check-input" id="flexCheckChecked" type="checkbox" name ="itemYn" value="Y" />
					  <label class="form-check-label" for="flexCheckChecked">사용중단품목 포함</label>
				</div> 
				<div class="form-check" style="margin-right:10px;">
					  <input class="form-check-input" id="flexCheckChecked" type="checkbox" name ="graph" value="Y" />
					  <label class="form-check-label" for="flexCheckChecked">그래프</label>
				</div> 
			</div>
				<div class="col-12" style="margin-bottom:10px;">
					<button class="btn btn-primary" type="submit" style="margin-top:10px;">검색</button>
				</div>
		</form>
	</div>
</div>
<br>
<div id='contentBody'></div>
<div class="card mb-3 px-3" style="width: 100%; height: auto;">
	<div id='graphBody'></div>
</div>



<div class="modal fade" id="itemWindow" tabindex="-1"
	aria-labelledby="itemWindowModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="itemWindowModalLabel">품목 조회</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close" id="itemClose"></button>
			</div>
			<div class="modal-body">
				<div id="searchUI"  class="row g-3 d-flex justify-content-end" style="float: right;margin-bottom: 10px;">
					<div class="col-auto">
						<select name="searchType" class="form-select">
							<option value>전체</option>
							<option value="itemCd">품목코드</option>
							<option value="itemNm">품목명</option>
							<option value="itemCate">품목그룹</option>
						</select>
					</div>
					<div class="col-auto">
						<input type="text" name="searchWord" placeholder="검색" class="form-control"/>
					</div>
					<div class="col-auto">
						<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
					</div>
				</div>
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table" id="itemDataTable">
		          <thead>
		            <tr>
		              <th>선택</th>
		              <th style="text-align: center;">품목코드</th>
		              <th style="text-align: left;">품목명</th>
		            </tr>
		          </thead>
		          <tbody class="list">
							
				  </tbody>
				  <tfoot>
					  <tr><td colspan="3"><span id="pagingArea"></span></td></tr>
				  </tfoot>
		          
		        </table>
			</div>
			<form action="<c:url value='/invenSituation/list'/>" id="searchForm" class="border">
				<input type="hidden" name="searchType" id="searchType" readonly="readonly" placeholder="searchNm"/>
				<input type="hidden" name="searchWord" id="searchWord" readonly="readonly" placeholder="searchData"/>
				<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
			</form>
			<div class="modal-footer">
				<button type="button" id="saveBtn" class="btn btn-secondary"
					data-bs-dismiss="modal">저장</button>
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="wareWindow" tabindex="-1" aria-labelledby="wareWindowModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="wareWindowModalLabel">창고 선택</h5>
       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="wareClose"></button>
      </div>
	      <div class="modal-body" id="wareListContainer">
	        <table class="table" id="wareTable">
	          <thead>
	            <tr>
	              <th>창고코드</th>
	              <th>창고명</th>
	            </tr>
	          </thead>
	          <tbody>
	           	   <c:forEach var="result" items="${wareList}">
	           	  		<tr>
		           	  		<td>${result.wareCd}</td>
		           	  		<td><a href="javascript:;" class="selectWare" data-selected-value="${result.wareNm}">
		           	  			${result.wareNm}
		           	  		</a></td>
	           	  		</tr>
	           	  </c:forEach> 
	          </tbody>
	        </table>
	      </div>
    </div>
  </div>
<script src="https://cdn.jsdelivr.net/npm/echarts@5"></script>  
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src='<c:url value="/resources/js/defect/defectCrntSttn.js"/>'></script>