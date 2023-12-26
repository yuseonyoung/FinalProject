<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 8.       유선영      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h1>창고 등록</h1>
<br><br>
<div class="card mb-3 px-3">
<form:form modelAttribute="wareData" method="post">
	
	<div class="mb-3 w-75">
	    <label for="wareNm">창고명</label>
	    <form:input type="text" path="wareNm" class="form-control" required="true" />
	    <form:errors path="wareNm" element="span" cssClass="error" />
	</div>
	<div class="mb-3 w-75">
	    <label for="wareItem">창고구분</label>
	    <div id="wrap">
	    	<form:input type="text" path="wareItem" class="form-control" required="true"/>
	    	<button type="button">찾기</button>
	    	
	    </div>
	    <form:errors path="wareItem" element="span" cssClass="error" />
	</div>
	<div class="mb-3 w-75">
	    <label for="wareWidth">창고가로길이</label>
	    <form:input type="number" path="wareWidth" class="form-control" required="true" />
	    <form:errors path="wareWidth" element="span" cssClass="error" />
	</div>
	<div class="mb-3 w-75">
	    <label for="wareY">창고세로길이</label>
	    <form:input type="number" path="wareY" class="form-control" required="true" />
	    <form:errors path="wareY" element="span" cssClass="error" />
	</div>
	<div class="mb-3 w-75">
	    <label for="empCd">담당자</label>
	    <form:input type="text" path="empCd" class="form-control" required="true" />
	    <form:errors path="empCd" element="span" cssClass="error" />
	</div>
	<%-- <div class="mb-3 w-75">
	    <label for="wareLatitude">위도</label>
	    <form:input type="text" path="wareLatitude" class="form-control" />
	    <form:errors path="wareLatitude" element="span" cssClass="error" />
	</div>
	<div class="mb-3 w-75">
	    <label for="wareLongitude">경도</label>
	    <form:input type="text" path="wareLongitude" class="form-control" />
	    <form:errors path="wareLongitude" element="span" cssClass="error" />
	</div> --%>
	<div class="mb-3 w-75">
	    <label for="wareAddr">창고주소</label>
	    <form:input type="text" path="wareAddr" id="sample4_roadAddress" class="form-control" />
	    <form:errors path="wareAddr" element="span" cssClass="error" />
	    <span id="guide" style="color:#999;display:none"></span>
	    <input type="button" onclick="sample4_execDaumPostcode()" value="주소 검색"><br>
	</div>
	
	<div class="mb-3 w-75">
	    <label for="wareAddrDetail">상세주소</label>
	    <form:input type="text" path="wareAddrDetail" id="sample4_detailAddress" class="form-control" />
	    <form:errors path="wareAddrDetail" element="span" cssClass="error" />
	</div>
	
	<div class="mb-3 w-75">
	    <label for="wareZip">우편번호</label>
	    <form:input type="text" path="wareZip" id="sample4_postcode" class="form-control" />	    
	    <form:errors path="wareZip" element="span" cssClass="error" />
	</div>
	<input type="hidden" id="sample4_jibunAddress"/>
	<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
	<div class="mb-3 w-75">
		<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="button" id="insertBtn">저장하기</button>
	</div>
</form:form>
</div>
<c:url value="/resources/js/storage/storage.js" var="baseUrl"/>
<script src="${baseUrl}"></script>
	
	
	

	
	

	
	
