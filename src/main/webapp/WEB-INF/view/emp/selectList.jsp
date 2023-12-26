<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="col-lg-12 pe-lg-2">
	<div class="card mb-3">
		<div class="card-header">
			<h3 class="mb-0">계정 목록</h3>
		</div>
		<div class="card-body pt-0 ">
			<div id="tableExample2" data-list='{"valueNames":["empCd","empNm","empMail","deptNm","hrGradeNm","hrChargeNm","empUse"],"page":10,"pagination":true}'>

			<!-- 검색 -->
			  <div class="row justify-content-end g-0">
			    <div class="col-auto col-sm-5 mb-3">
			      <form>
			        <div class="input-group">
			          <input class="form-control form-control-sm shadow-none search" type="search" placeholder="Search..." aria-label="search" />
			          <div class="input-group-text bg-transparent"><span class="fa fa-search fs--1 text-600"></span></div>
			        </div>
			      </form>
			    </div>
			  </div>

			  <div class="table-responsive scrollbar">
			    <table class="table table-bordered table-striped fs--1 mb-0">
				<colgroup>
					<col width="20%">
					<col width="10%">
					<col width="25%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
			      <thead class="bg-200 text-900">
			        <tr>
			          <th class="sort mb-1 text-center" data-sort="empCd">사원번호</th>
			          <th class="sort mb-1 text-center" data-sort="empNm">이름</th>
			          <th class="sort mb-1 text-center" data-sort="empMail">이메일</th>
			          <th class="sort mb-1 text-center" data-sort="deptNm">부서</th>
			          <th class="sort mb-1 text-center" data-sort="hrGradeNm">직급</th>
			          <th class="sort mb-1 text-center" data-sort="hrChargeNm">직책</th>
			        </tr>
			      </thead>
			      <tbody class="list">
			      	<c:forEach var="data" items="${empSelectList}" varStatus="stat">
			        <tr>
			          <td class="mb-1 text-center empCd"><a href="/emp/update/${data.empCd}">${data.empCd}</a></td>
			          <td class="mb-1 text-center empNm">${data.empNm}</td>
			          <td class="mb-1 text-center empMail">${data.empMail}</td>
			          <td class="mb-1 text-center deptNm">${data.deptNm}</td>
			          <td class="mb-1 text-center hrGradeNm">${data.hrGradeNm}</td>
			          <td class="mb-1 text-center hrChargeNm">${data.hrChargeNm}</td>
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
			  <input type="button" class="btn btn-success me-2 mb-2" onClick="location.href='/emp/create'" value="등록" />
			</div>
		</div>
	</div>
</div>
