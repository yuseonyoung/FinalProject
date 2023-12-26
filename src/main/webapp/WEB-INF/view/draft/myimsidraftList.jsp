<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>
.no-underline {
	text-decoration: none !important;
}
</style>
<div class="card mb-2">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<h3 class="mb-0">기안 임시 저장</h3>
			</div>
		</div>
	</div>
	<div class="card-body">
		<div class="card shadow-none">
			<div class="card-body p-0 pb-3">
				<div id="tableExample3"
					data-list='{"valueNames":["drNo","drftTitle","userNm","deptNm","drDt"],"page":10,"pagination":true}'>
					<div class="d-flex align-items-center my-3 justify-content-between">
						<div class="ms-3">
							<form>
								<div class="input-group">
									<input class="form-control form-control-sm shadow-none search"
										type="search" placeholder="부서명 또는 이름 검색" aria-label="search" />
									<div class="input-group-text bg-transparent">
										<span class="fa fa-search fs--1 text-600"></span>
									</div>
								</div>
							</form>
						</div>
						<div id="bulk-select-replace-element" class="ms-3">
							<button class="btn btn-falcon-danger btn-sm" type="button" id="allEmployees">
								<span class="fas fa-minus" data-fa-transform="shrink-3 down-2"></span>
								<span class="ms-1">전체 삭제하기</span>
							</button>
						</div>
						<div class="d-none ms-3 col-auto d-flex justify-content-end"
							id="bulk-select-actions">
							<div class="d-flex">
								<select class="form-select form-select-sm"
									aria-label="Bulk actions">
									<option selected="selected" id="someEmployees">
										선택 문서 삭제하기
									</option>
								</select>
								<button class="btn btn-falcon-danger btn-sm ms-2" type="button"
									id="apply">Apply</button>
							</div>
						</div>
					</div>
					<div class="table-responsive scrollbar border">
						<table class="table mb-0 table-bordered" id="myTable">
							<thead class="text-black bg-200">
								<tr class="align-middle">
									<th class="white-space-nowrap border-end">
										<div class="form-check mb-0">
											<input class="form-check-input" type="checkbox"
												data-bulk-select='{"body":"bulk-select-body","actions":"bulk-select-actions","replacedElement":"bulk-select-replace-element"}' />
										</div>
									</th>
									<th class="sort text-center" data-sort="drNo">기안번호</th>
									<th class="sort text-center" data-sort="drftTitle">제목</th>
									<th class="sort text-center" data-sort="userNm">작성자</th>
									<th class="sort text-center" data-sort="deptNm">부서명</th>
									<th class="sort text-center" data-sort="drDt">작성일</th>
								</tr>
							</thead>

							<tbody id="bulk-select-body" class="list">
								<c:if test="${draftSelectList.size() == 0}">
									<td colspan="6" class="text-center" >임시 저장 기안 문서가 없습니다.</td>
								</c:if>
								<c:forEach var="draft" items="${draftSelectList}" varStatus="stat">
									<tr>
										<td class="align-middle white-space-nowrap">
											<div class="form-check mb-0">
												<input class="form-check-input" type="checkbox"
													id="checkbox-1" data-bulk-select-row="data-bulk-select-row" />
											</div>
										</td>
										<td class="drNo text-center" >${draft.drNo}</td>
										<td class="drftTitle text-center"><a class="no-underline" href="/draft/doc/temp/${draft.drNo}">${draft.drftTitle}</a></td>
										<td class="userNm text-center">${draftUserVO.userNm}</td>
										<td class="deptNm text-center">${draftUserVO.deptNm}</td>
										<td class="drDt text-center">${draft.drDtFm2}</td>
									</tr>
								</c:forEach>

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
							<span class="fas fa-chevron-right"></span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>