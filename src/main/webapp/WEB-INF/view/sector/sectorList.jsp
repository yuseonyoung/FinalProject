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



<div class="card mb-3 p-3">
<br/>
<h3 style="margin-bottom: 50px;">창고 구역 조회</h3>
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


<script src="<c:url value='/resources/js/sector/sector.js'/>"></script>





