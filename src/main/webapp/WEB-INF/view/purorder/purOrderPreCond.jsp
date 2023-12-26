<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 30.       유선영      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<style>
	#flexDiv {
	  display: flex;
	  justify-content: space-between;
	}
	
	.leftContent {
	  flex: 1; 
	}
	
	.boderNone{
		border: none;
	}
	
</style>

<div id="totalPage">
	<div class="card mb-3 px-3" style="width: 100%; height: auto;">
	<br/>
	<h3>발주요청 현황</h3>
	<br/>        
		<form class="row g-2" style="padding-top:30px;" id="purOrderForm" method="post" action='<c:url value="/pur/retrieve"/>'>
			<div class="col-md-6">
				<label class="form-label" for="preqSDate">시작일자</label> 
				    <input type="text" id="preqSdate" name="preqSdate" class="form-control datetimepicker"  id="datepicker" placeholder="yyyy-mm-dd" data-options='{"dateFormat":"yyyy-mm-dd"}'/>
			</div>
			<div class="col-md-6">
				<label class="form-label" for="preqLDate">선택일자</label> 
				    <input type="text" id="preqLdate" name="preqLdate" class="form-control datetimepicker"  id="datepicker" placeholder="yyyy-mm-dd" data-options='{"dateFormat":"yyyy-mm-dd"}'/>
			</div>
			<div class="col-md-6">
				<label class="form-label" for="itemSearch">담당자</label> 
				<div id="empList" style="display: flex; align-items: center;">
					<div class="input-group">
					    <input class="form-control" id="findEmpNm" type="text" autocomplete="off" placeholder="담당자검색"/>
					</div>
					<input type="hidden" name="empCd" id="findEmpCd">
					<button id="empSearchBtn" type="button" class="btn searchBtn p-1"><i class="bi bi-search"></i></button>	
				    <span id='removeEmp'></span>
				</div>
			</div>
			<div class="col-md-6">
				<label class="form-label" for="itemSearch">상태</label> 
				<div id="itemList">
					<select class="form-select" id="stat" name="preqStat">
						<option value="">선택하세요</option>
			            <option value="T001">진행중</option>
			            <option value="T002">완료</option>
			        </select>		
				</div>
			</div>
			<div class="col-12">
				<label class="form-label" for="itemSearch">품목</label> 
				<div id="itemList" style="display: flex; align-items: center;">
					<input class="form-control" id="findItemNm" type="text" autocomplete="off" 
						placeholder="품목검색"/>
					<button id="itemSearchBtn"  type="button" class="btn searchBtn p-1"><i class="bi bi-search" ></i></button>	
				</div>
				<div id="spanSpace"></div>
			</div>
			<div class="col-12" style="margin-bottom:10px; text-align:right;">
				<button class="btn btn-primary" type="submit" style="margin-top:10px;" id="searchBtn">검색</button>
			</div>
		</form>
	</div>
	<div class="card mb-3 px-3" style="display:none;" id="tableDiv">
		<p id="searchDate" class="pt-3" style="text-align:right; margin-bottom:5px;"/>
		<div class="table-responsive scrollbar pb-3">
			<table class="table table-bordered fs--1 mb-0" id="purListDataTable">
				<thead class="bg-200 text-900">
					<tr>
						<th>발주요청일자</th>
						<th>납기일자</th>
						<th>품목명</th>
						<th>요청수량</th>
						<th>진행상태</th>
						<th>적요</th>
					</tr>
				</thead>
				<tbody class="tableList">
						
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- 품목 모달 -->
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
							<option value="">전체</option>
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
				<table class="table table-bordered fs--1 mb-0" id="itemDataTable">
		          <thead class="bg-200 text-900">
		            <tr>
		              <th style="width: 80px;">선택</th>
		              <th>품목코드</th>
		              <th>품목명</th>
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
<!-- 요청 상세 모달 -->
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
					
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>




<script src='<c:url value="/resources/js/purOrder/purOrderPreCond.js"/>'></script>