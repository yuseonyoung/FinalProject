<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<div class="col-lg-12 pe-lg-2">
	<div class="card mb-3">
		<div class="card-header">
		  <div class="row align-items-center">
		    <div class="col">
		      <h3 class="mb-0">로그 기록</h3>
		    </div>
		  </div>
		</div>
		<div class="card-body bg-light ">
			<div id="tableExample2" data-list='{"valueNames":["logNo","empCd","logStat","logDate","logIp","logNat"],"page":10,"pagination":true,"filter":{"key":"logStat"}}'>

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
			            <option selected="" value="">구분</option>
     				    <option value="SUCCESS">SUCCESS</option>
     				    <option value="FAIL">FAIL</option>
     				    <option value="LOCKED">LOCKED</option>
			          </select>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
			  <div class="table-responsive scrollbar">
			    <table class="table table-bordered table-striped fs--1 mb-0 border-2">
			      <thead class="bg-200 text-900">
			        <tr>
			          <th class="sort mb-1 text-center" data-sort="logNo">번호</th>
			          <th class="sort mb-1 text-center" data-sort="empCd">아이디</th>
			          <th class="sort mb-1 text-center" data-sort="logStat">로그상태</th>
			          <th class="sort mb-1 text-center" data-sort="logIp">아이피</th>
			          <th class="sort mb-1 text-center" data-sort="logDate">접속일시</th>
			          <th class="sort mb-1 text-center" data-sort="logNat">국가</th>
			          <th class="sort mb-1 text-center" >비고</th>
			        </tr>
			      </thead>
			      <tbody class="list">
			      	<c:forEach var="logVO" items="${logList}" varStatus="stat">
			        <tr>
			          <td class="mb-1 text-center logNo">${logVO.logNo}</td>
			          <td class="mb-1 text-center empCd">${logVO.empCd}</td>
			          <td class="mb-1 text-center logStat" data-fa-transform="shrink-2">${logVO.logStat}</td>
			          <td class="mb-1 text-center logIp">${logVO.logIp}</td>
			          <td class="mb-1 text-center logDate">${logVO.logTime}</td>
			          <td class="mb-1 text-center logNat">${logVO.logNat}</td>
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

