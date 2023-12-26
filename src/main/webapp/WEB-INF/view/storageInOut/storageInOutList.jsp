<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 7.       유선영      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
			<br/>
				<h3 class="mb-0">출하 진행</h3>
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
				<div >
					<form method='POST' id='inOutForm'>
						<table class="table table-bordered  fs--1 mb-0"
							id="dataTable">
							<thead class="bg-200 text-900">
								<tr>
									<th class="rdrecCd">출하예정코드</th>
									<th class="rdrecReceive">보낸곳명</th>
									<th class="wareNm">창고명</th>
									<th class="secCd">구역코드</th>
									<th class="itemNm">품목명</th>
									<th class="rdrecDate">납기일자</th>
									<th class="rdrecQty">출고에정수량</th>
									<th class="rdrecRealQty">실제출고수량</th>
									<th class="itemNote">적요</th>
								</tr>
							</thead>
							<tbody class="list">
								 
							</tbody>
						</table>
						
						<div id='buttonDiv' style='display: flex; justify-content: center; align-items: center;'>></div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="rmstWindow" tabindex="-1"
	aria-labelledby="rmstWindowLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rmstWindowLabel">출하지시서 상세 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
				<div class="table-responsive scrollbar">
					<div class="modal-body">
							<div class="card-header ">
								<div class="row flex-between-end">
									<div class="col-auto ms-auto">
										<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
											role="tablist"></div>
									</div>
								</div>
							</div>
							<div class="card-body pt-0 ">
								<div class="tab-content">
									<div class="tab-pane preview-tab-pane active" role="tabpanel" aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
										id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">
										
										<div class="table-responsive scrollbar">
											<table class="table table-bordered  fs--1 mb-0">
												<thead class="bg-200 text-900">
													<tr>
														<th>일자</th>
														<td colspan="5">
															<input type="date" id="relsDate"  placeholder="작성일자"  style="width: 170px;" />
														</td>
													</tr>
													<tr>
														<th>담당자</th>
														<td colspan="5">
															<input type="text" id="empNm"  placeholder="담당자" style="width: 170px;"/>
														</td>
													</tr>
													<tr>
														<th>거래처</th>
														<td colspan="5">
															<input type="text" id="comNm" placeholder="거래처명" style="width: 170px;"/>
														</td>
													</tr>
													<tr>
														<th>납기일자</th>
														<td colspan="5">
															<input type="date" id="outDate" placeholder="납기일자" style="width: 170px;" />
														</td>
													</tr>
													
												</thead>
						
												<tbody id="detailList">
													
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						
						</div>
												
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
		</div>
	</div>
</div> 
 
    
<c:url value="/resources/js/inOut/storageInOut.js" var="urls" />
<script src="${urls}"></script> 