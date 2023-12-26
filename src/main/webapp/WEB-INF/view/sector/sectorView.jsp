<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 7.       유선영      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
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


<div class="card mb-3 p-3">
<br/>
<h3 style="margin-bottom: 50px;">품목이동</h3>
<form >
  <div class="row mb-3">
    <label class="col-sm-2 col-form-label" for="inputWare">창고명</label>
    <div class="col-sm-10">
     	<div style="display: flex; align-items: center;">
		      <input class="form-control" id="inputWare" type="text" autocomplete="off"/>
		      <button id="wareBtn" type="button" class="btn searchBtn p-1"><i class="bi bi-search"></i></button>
    	</div>
    </div>
  </div>
  <div class="row mb-3">
    <label class="col-sm-2 col-form-label" for="inputEmp">담당자</label>
    <div class="col-sm-10">
      <input class="form-control" id="inputEmp" type="text" readonly="readonly"/>		      
    </div>
  </div>
  
  <div id="canvasInput">
  	<!-- 탭 메뉴 -->
  	<div id="tabInput">
  	
  	</div>
  	
	<!-- canvas가 들어 가는곳 -->
	 <div class="tab-content" id="myTabContent">
	
	</div>
	  	 
  </div>
  <span style="color:blue; font-size:12px; display:none;" id="selectSector"></span>
  <div id="itemList">
  
  </div>
</form>
</div>

<div class="modal fade" id="wareWindow" tabindex="-1" aria-labelledby="wareWindowModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
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
	           	   <c:forEach var="result" items="${totalWareList}">
	           	  		<tr>
		           	  		<td>${result.wareCd}</td>
		           	  		<td><a href="javascript:;" class="selectItem" data-selected-value="${result.wareNm}">
		           	  			${result.wareNm}
		           	  		</a></td>
		           	  		<input type="hidden" class="hiddenEmp" data-selected-emp = "${result.empNm}"/>
	           	  		</tr>
	           	  </c:forEach> 
	          </tbody>
	        </table>
	      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="wareSelectWindow" tabindex="-1" aria-labelledby="wareWindowModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="wareSelectWindowModalLabel">창고 선택</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="wareClose"></button>
            </div>
            <div class="modal-body" id="wareSelectListContainer">
                <div id="cardsData">
                    <div class="container">
                        
                            <div class="row">
                                <div class="col-md-4">
                                    <div id="jstree">
                                        <!-- 왼쪽 열 -->
                                    </div>
                                </div>
                                <div class="col-md-6" style="border-left: 1px solid black; padding-top : 2vh; padding-left : 10vh;">
                                    <div id="treeValue">
                                        <!-- 오른쪽 열 -->
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="savedBtn" data-bs-dismiss="modal">저장</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="itemWindow" tabindex="-1"
	aria-labelledby="itemWindowModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="itemWindowModalLabel">품목 선택</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close" id="itemClose"></button>
			</div>
			<div id="searchUI"  class="row g-3 d-flex justify-content-center" style="float: right;margin-top: 5px;">
			<div class="col-auto">
					<select name="searchType" class="form-select">
						<option value="">전체</option>
						<option value="itemCd">품목코드</option>
						<option value="itemNm">품목명</option>
					</select>
				</div>
				<div class="col-auto">
					<input type="text" name="searchWord" placeholder="검색" class="form-control"/>
				</div>
				<div class="col-auto">
					<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
				</div>
			</div>
			<div class="modal-body" id="itemListContainer">
				<table class="table" id="itemTableData">
					<thead>
						<tr>
							<th>품목코드</th>
							<th>품목명</th>
						</tr>
					</thead>
					<tbody id="dataList">
					</tbody>
					<tfoot>
					    <tr><td colspan="2"><span id="pagingArea"></span></td></tr>
				    </tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
<form action="<c:url value='/sector/list'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" id="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" id="searchWord" readonly="readonly" placeholder="searchData"/>
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
</form>


<script src="<c:url value='/resources/js/sector/secItemCreate.js'/>"></script>

<script type="text/javascript">
function fn_paging(page) {
	searchForm.page.value = page;
	searchForm.requestSubmit();
	searchForm.page.value = "";
}
</script>
