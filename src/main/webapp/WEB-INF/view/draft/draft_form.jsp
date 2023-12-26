<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<style>
  .no-underline {
    text-decoration: none !important;
  }
</style>

<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<h3 class="mb-0">기안 문서 양식</h3>
				<p class="mb-0 pt-1 mt-2 mb-0">
					기안 문서를 선택 후 기안을 진행해 주세요
				</p>
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
				<div id="tableExample3"
					data-list='{"valueNames":["no","name","text","regDt"],"page":10,"pagination":true}'>
					<div class="row justify-content-end g-0">
						<div class="col-auto col-sm-5 mb-3">
							<form>
								<div class="input-group">
									<input class="form-control form-control-sm shadow-none search"
										type="search" placeholder="양식검색하기" aria-label="search" />
									<div class="input-group-text bg-transparent">
										<span class="fa fa-search fs--1 text-600"></span>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="table-responsive scrollbar">
						<table class="table table-bordered table-striped fs--1 mb-0">
							<thead class="bg-200 text-900">
								<tr class="text-center">
									<th class="sort" width="10%"  data-sort="no">문서번호</th>
									<th class="sort" data-sort="name">문서명</th>
									<th class="sort" data-sort="text">양식설명</th>
									<th class="sort" data-sort="regDt">등록일자</th>
								</tr>
							</thead>
							<tbody class="list">
								<tr>
									<td class="no text-center">0</td>
									<td class="name"><a class="no-underline" href="/draft/empty">자유양식</a></td>
									<td class="text">새로운 양식을 작성할 수 있는 문서</td>
									<td class="regDt text-center">2023/11/17</td>
								</tr>
								<tr>
									<td class="no text-center">1</td>
									<td class="name"><a class="no-underline" href="/draft/order">발주서</a></td>
									<td class="text">발주를 하기 위한 문서</td>
									<td class="regDt text-center">2023/11/17</td>
								</tr>
								<tr>
									<td class="no text-center">2</td>
									<td class="name"><a class="no-underline" href="/draft/order">출하지시서</a></td>
									<td class="text">출하를 하기 위한 문서</td>
									<td class="regDt text-center">2023/11/23</td>
								</tr>
								<tr>
									<td class="no text-center">3</td>
									<td class="name"><a class="no-underline" href="/draft/order">거래명세서</a></td>
									<td class="text">거래내역을 확인하기 위한 문서</td>
									<td class="regDt text-center">2023/11/25</td>
								</tr>
								<tr>
									<td class="no text-center">4</td>
									<td class="name"><a class="no-underline" href="/draft/order">견적요청서</a></td>
									<td class="text">견적을 요청하기 위한 문서</td>
									<td class="regDt text-center">2023/11/30</td>
								</tr>
								<tr>
									<td class="no text-center">5</td>
									<td class="name"><a class="no-underline" href="/draft/vac">휴가신청서</a></td>
									<td class="text">휴가를 신청하기 위한 문서</td>
									<td class="regDt text-center">2023/12/01</td>
								</tr>
								<tr>
									<td class="no text-center">6</td>
									<td class="name"><a class="no-underline" href="/draft/vac">지출결의서</a></td>
									<td class="text">지출의 출납을 승인 받기 위한 문서</td>
									<td class="regDt text-center">2023/12/03</td>
								</tr>
								<tr>
									<td class="no text-center">7</td>
									<td class="name"><a class="no-underline" href="/draft/vac">사직서</a></td>
									<td class="text">퇴직처리를 승인 받기 위한 문서</td>
									<td class="regDt text-center">2023/12/06</td>
								</tr>
								<tr>
									<td class="no text-center">8</td>
									<td class="name"><a class="no-underline" href="/draft/vac">회의록</a></td>
									<td class="text">희의 내용 기록을 조회하기 위한 문서</td>
									<td class="regDt text-center">2023/12/11</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="d-flex justify-content-center mt-3">
						<button class="btn btn-sm btn-falcon-default me-1" type="button"
							title="Previous" data-list-pagination="prev">
							<span class="fas fa-chevron-left"></span>
						</button>
						<ul class="pagination mb-0"></ul>
						<button class="btn btn-sm btn-falcon-default ms-1" type="button"
							title="Next" data-list-pagination="next">
							<span class="fas fa-chevron-right"> </span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>