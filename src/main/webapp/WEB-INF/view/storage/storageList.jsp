<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 8.       유선영      최초작성
  2023. 11. 9.       유선영      List출력준비
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
	.red-background {
         background-color: rgba(255, 0, 0, 0.2) !important;
    }
</style>
<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
			<br/>
				<h3 class="mb-0">창고 조회</h3>
				
			</div>
			<div class="col-auto ms-auto">
				<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
					role="tablist"></div>
			</div>
		</div>
	</div>
	<div class="card-body pt-0 ">
		<div class="tab-content">
			<div class="tab-pane preview-tab-pane active" role="tabpanel"
				aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
				id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">
				<div id="tableExample3">
				<div class="table-responsive scrollbar">
					<table class="table table-bordered  fs--1 mb-0" id="dataTable">
						<thead class="bg-200 text-900">
								<tr class="text-center">
									<th class="sort" data-sort="wareCd">창고코드</th>
									<th class="sort" data-sort="wareNm">창고명</th>
									<th class="sort" data-sort="wareItem" style="text-align: center;">창고구분</th>
									<th class="sort" data-sort="wareAddr">창고주소</th>
									<th class="sort" data-sort="empCd" style="text-align: center;">창고담당자</th>
									<th class="sort" style="text-align: center;">지도보기</th>
								</tr>
						</thead>
						<tbody class="list">
							
						</tbody>
						
					</table>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="insertBtn" style="margin-right: 10px;">신규등록</button>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" id='usageStatus'>미사용 창고 보기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 여기는 신규등록 모달  -->

<div class="modal fade" id="createWindow" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="createWindowLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0">
	      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
	        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" id="createClose"></button>
	      </div>
	      
      <div class="modal-body p-0">
	        <div class="bg-light rounded-top-3 py-3 ps-4 pe-6">
	          <h4 class="mb-1" id="createWindowLabel">창고 등록</h4>
	        </div>
        <div class="p-4">
          <div class="row">
          <c:url value="/stor" var="storUrl"/>
            <form action="${storUrl}" id="wareForm">	
				
				<div class="mb-3 w-100">
				    <label for="wareNmInput">창고명</label>
				    <input type="text" id="wareNmInput" name="wareNm" class="form-control" required="required"/>
				</div>
			 	<span id="wareNmError" class="error"></span> 
				<div class="mb-3 w-100">
				    <label for="wareInput">창고구분</label>
				    <div style="display: flex; align-items: center;">
				    	<input type="text" name="wareItem" class="form-control wareBtn" id="wareInput" data-bs-target="#wareWindow" data-bs-toggle="modal" required/>
				    	<button id="wareBtn" type="button" class="btn searchBtn p-1 wareBtn"><i class="bi bi-search"></i></button>
				    </div>
			    	<span id="wareItemError" class="error"></span> 
				</div>
				<div class="mb-3 w-100">
				    <label for="wareWidthInput">창고가로길이</label>
				    <input type="number" id="wareWidthInput" name="wareWidth" class="form-control" required/>    
				</div>
				<span id="wareWidthError" class="error"></span> 
				<div class="mb-3 w-100">
				    <label for="wareYInput">창고세로길이</label>
				    <input type="number" id="wareYInput" name="wareY" class="form-control" required/>
					<span id="wareYError" class="error"></span> 
				</div>
				<div class="mb-3 w-100">
				    <label for="empInput">담당자</label>
				    <div style="display: flex; align-items: center;">
				    	<input type="hidden" id="empInput" name="empCd" class="form-control" readonly="readonly"/>
				    	<input type="text" id="empNmInput" name="empNm" class="form-control empBtn" readonly="readonly"/>
				    	<button id="empBtn" type="button" class="btn searchBtn p-1 empBtn"><i class="bi bi-search"></i></button>
				    </div>
				    <span id="empCdError" class="error"></span>
				</div>
				
				<div class="mb-3 w-100">
				    <label for="sample4_roadAddress">창고주소</label>
				    <div style="display: flex; align-items: center;">
				        <input type="text" name="wareAddr" id="sample4_roadAddress" class="form-control" style="height: 40px; flex: 1;" />
				        <span id="guide" style="color:#999;display:none"></span>
				        <button type="button" onclick="sample4_execDaumPostcode()" style="border: 1px solid #ccc; background-color: #f0f0f0; color: #333; border-radius: 4px; cursor: pointer; height: 40px;">
				            주소검색
				        </button>
				    </div>
				</div>

				<span id="wareAddrError" class="error"></span>
				
				<div class="mb-3 w-100">
				    <label for="sample4_detailAddress">상세주소</label>
				    <input type="text" name="wareAddrDetail" id="sample4_detailAddress" class="form-control" />
				</div>
				<span id="wareAddrDetailError" class="error"></span>
				<div class="mb-3 w-100">
				    <label for="sample4_postcode">우편번호</label>
				    <input type="text" name="wareZip" id="sample4_postcode" class="form-control" />	    
				</div>
				<span id="wareZipError" class="error"></span>
				
				<input type="hidden" id="hiddenCode" name="wareCd"/>
				<input type="hidden" id="sample4_jibunAddress"/>
				<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
				
				<div class="mb-3 w-100" id="buttonSpace"> 
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mt-2" type="submit" id="resultBtn" style="margin-top: 10px;">저장하기</button>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mt-2" type="button" id="autoBtn" style="margin-top: 10px;">자동입력</button>
				</div>
			</form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 담당자그룹 모달창 -->
<div class="modal fade" id="empWindow" tabindex="-1" aria-labelledby="empWindowModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="empWindowModalLabel">담당자 선택</h5>
       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="empClose"></button>
      </div>
	      <div class="modal-body" id="wareListContainer">
	        <table class="table" id="empTable">
	          <thead>
	            <tr>
	              <th>사원코드</th>
	              <th>담당자</th>
	            </tr>
	          </thead>
	          <tbody>
	           	  <c:forEach var="result" items="${empGroupList}">
	           	  		<tr>
		           	  		<td>${result.empCd}</td>
		           	  		<td><a href="javascript:;" class="selectItem" data-selected-value="${result.empNm}">
		           	  			${result.empNm}
		           	  		</a></td>
	           	  		</tr>
	           	  </c:forEach>
	          </tbody>
	        </table>
	      </div>
    </div>
  </div>
</div>

<!-- 창고그룹 모달창 -->
<div class="modal fade" id="wareWindow" tabindex="-1" aria-labelledby="wareWindowModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="wareWindowModalLabel">품목그룹 선택</h5>
       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="wareClose"></button>
      </div>
	      <div class="modal-body" id="wareListContainer">
	        <table class="table" id="wareTable">
	          <thead>
	            <tr>
	              <th>창고 그룹코드</th>
	              <th>창고 그룹명</th>
	            </tr>
	          </thead>
	          <tbody>
	           	  <c:forEach var="result" items="${wareGroupList}">
	           	  		<tr>
		           	  		<td>${result.commCd}</td>
		           	  		<td><a href="javascript:;" class="selectWare" data-selected-value="${result.commCdNm}">
		           	  			${result.commCdNm}
		           	  		</a></td>
	           	  		</tr>
	           	  </c:forEach>
	          </tbody>
	        </table>
	      </div>
    </div>
  </div>
</div>


<!-- 지도 모달창 -->
<div class="modal fade" id="mapWindow" tabindex="-1" aria-labelledby="mapWindowModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="wareWindowModalLabel">창고 지도 확인</h5>
       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="mapClose"></button>
      </div>
	      <div class="modal-body" id="mapListContainer">
	      	<div id="map" style="height:550px; width:100%;"></div>
	      </div>
    </div>
  </div>
</div>

<c:url value="/resources/js/storage/storage.js" var="urls" />
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBX-OXAyoqxDI1o3Un-ZRkcNGsB6jrpD0g&libraries=places&callback=initMap" async defer></script>
<script src="${urls}"></script> 



