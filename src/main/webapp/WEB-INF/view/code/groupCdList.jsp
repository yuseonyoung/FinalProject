<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>



<div class="col-lg-12 pe-lg-2">
	<div class="card mb-3">
		<div class="card-header">
			<h3 class="mb-0">공통코드</h3>
		</div>
		<div class="card-body pt-1 ">
			<div id="tableExample2" data-list='{"valueNames":["rownum","grCd","grNm","grYn","category"],"page":10,"pagination":true,"filter":{"key":"category"}}'>

			<!-- 검색 -->
			<div class="container">
			  <div class="row">
			    <div class="col">
			      <div class="row justify-content-start">
			        <div class="col-auto col-sm-10 mb-3">
			          <form>
			            <div class="input-group">
			              <input class="form-control form-control-sm shadow-none search" type="search" placeholder="Search..." aria-label="search" />
			              <div class="input-group-text bg-transparent"><span class="fa fa-search fs--1 text-600"></span></div>
			            </div>
			          </form>
			        </div>
			      </div>
			    </div>
			    <div class="col">
			      <div class="row justify-content-end">
			        <div class="col-auto px-3">
			          <select class="form-select form-select-sm mb-3" aria-label="Bulk actions" data-list-filter="data-list-filter">
			            <option selected="" value="">코드분류 선택</option>
			            <option value="MANAGE">공통코드</option>
			            <option value="CUSTOME">사용자코드</option>
			          </select>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>

			  <div class="table-responsive scrollbar">
			    <table class="table table-bordered table-striped fs--1 mb-0">
			      <thead class="bg-200 text-900">
			        <tr>
			          <th class="sort mb-1 text-center" data-sort="rownum">번호</th>
			          <th class="sort mb-1 text-center" data-sort="grCd">공통코드</th>
			          <th class="sort mb-1 text-center" data-sort="grNm">공통코드명</th>
			          <th class="sort mb-1 text-center" data-sort="category">코드분류</th>
			          <th class="sort mb-1 text-center" data-sort="grYn">사용여부</th>
			        </tr>
			      </thead>
			      <tbody class="list">
			      	<c:forEach var="data" items="${codeList}" varStatus="stat">
			        <tr>
			          <td class="mb-1 text-center rownum">${data.rownum}</td>
			          <td class="mb-1 text-center grCd">${data.grCd}</td>
			          <td class="mb-1 text-center grNm">${data.grNm}</td>
			          <td class="mb-1 text-center category">${data.category}</td>
			          <td class="mb-1 text-center category">
		          	  <c:choose>
				          <c:when test="${data.grYn == 'Y'}">
					          <span class="badge badge rounded-pill badge-subtle-success">사용중
					          <span class="ms-1" data-fa-transform="shrink-2"></span></span>
				          </c:when>
				          <c:otherwise>
					          <span class="badge badge rounded-pill badge-subtle-danger">미사용
					          <span class="ms-1" data-fa-transform="shrink-2"></span></span>
				          </c:otherwise>
			          </c:choose>

			        </tr>
			        </c:forEach>
			      </tbody>
			    </table>
			  </div>
			  <div class="d-flex justify-content-center mt-3">
			    <button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			    <ul class="pagination mb-0"></ul>
			    <button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
			  </div>
			</div>
		</div>
	</div>
</div>