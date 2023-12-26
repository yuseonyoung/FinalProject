<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 28.       유선영      최초작성
* 2023. 11. 28.       유선영      조회및 상세조회 완료
* 2023. 11. 28.       유선영      입고확정 완료
* Copyright (c) 2023 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.inputNoneBorder {
    	border: none; 
	}
	.jstree-node, .jstree-anchor {
	    margin-bottom: 10px;
	}
		
</style>

<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
			<br/>
				<h3 class="mb-0">입고 확정</h3>
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
					<form method='POST' id='inForm'>
						<table class="table table-bordered  fs--1 mb-0" id="inTable">
							<thead class="bg-200 text-900">
								<tr>
									<th>입고예정코드</th>
									<th>보낸곳명</th>
									<th>품목명</th>
									<th>납기일자</th>
									<th>입고에정수량</th>
									<th>실제입고수량</th>
									<th>입고될창고</th>
									<th>창고구역</th>
									<th>적요</th>
								</tr>
							</thead>
							<tbody class="list">
								 
							</tbody>
						</table>
						
						<div id='buttonDiv' style='display: flex; justify-content: center; align-items: center;'></div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 발주서 상세 모달 -->
<div class="modal fade" id="purWindow" tabindex="-1"
	aria-labelledby="purWindowLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" style="max-width: 90%;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="purWindowLabel">발주서 상세 정보</h5>
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
											<table class="table table-bordered fs--1 mb-0">
												<thead class="bg-200 text-900">
													<tr>
										                <th>일자</th>
										                <td>
										                    <input type="date" id="pordDate" placeholder="작성일자" style="width: 170px;" />
										                </td>
										                <th>담당자</th>
										                <td>
										                    <input type="text" id="empNm" placeholder="담당자" style="width: 170px;" />
										                </td>
										                <td></td>
										                <td></td>
										            </tr>
										            <tr>
										                <th>거래처</th>
										                <td>
										                    <input type="text" id="comNm" placeholder="거래처명" style="width: 170px;" />
										                </td>
										                <th>납기일자</th>
										                <td>
										                    <input type="date" id="dueDate" placeholder="납기일자" style="width: 170px;" />
										                </td>
										                <td></td>
										                <td></td>
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
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
		</div>
	</div>
</div> 



<!-- 창고모달 -->

<!-- 
	데이터를 미리 찍어놓고 부르는게 좋을거같음 그럼 값을 로딩하자마자 찍어와야함
	그럼 먼저 jsp로 오는 부분에다 값을 담아와서 먼저 찍어버려 그냥 알겠지 
	
 -->
<div class="modal fade" id="wareWindow" tabindex="-1" aria-labelledby="wareWindowModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="wareWindowModalLabel">창고 선택</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="wareClose"></button>
            </div>
            <div class="modal-body" id="wareListContainer">
                <div id="cardsData">
                    <div class="container">
                        
                            <div class="row">
                                <div class="col-md-4">
                                    <div id="jstree">
                                        <!-- 왼쪽 열 -->
                                    </div>
                                </div>
                                <div class="col-md-6" style="border-left: 1px solid black; padding-top : 9vh; padding-left : 10vh;">
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

 <c:url value="/resources/js/inOut/storageInCofirmed.js" var="urls"/>
 <script src="${urls}"></script> 