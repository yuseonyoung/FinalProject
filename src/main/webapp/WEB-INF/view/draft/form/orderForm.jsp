<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	


<style>
img .dz-image {
	height: 50%;
}

.fa-stack-2x {
	font-size: 1em;
}

.no-underline {
	text-decoration: none !important;
}

.my-img-size {
	width: 40px;
	height: 40px;
}

.jstree-icon {
	margin-right: 5px;
	margin-left: 0px;
}
</style>

<form name="frm1"
	action="/draft/form/post?${_csrf.parameterName}=${_csrf.token}"
	method="post" enctype="multipart/form-data">

	<div id="docTest" class="d-flex">
		<div id="doc" class="mx-auto">
			<div id="doc1" class="card my-3 p-4 border border-secondary" style="width: 820px;">
				<!-- 결재란 -->
				<div id="doc2" class="card-header me-3 pb-1">
					<div id="doc3" class="row flex-between-end">
						<div id="signBox" class="d-flex m-2">
							<div class="me-auto p-2 border-400 align-self-center"><h3 id="draftFormTitle">발주서</h3></div>
							<input type="hidden" name="drftStat" id="drftStat" value="L002">
							
							<div class="border-400 h-auto w-auto">
								<sec:authorize access="isAuthenticated()">
									<table class="table text-center" border="1">
										<thead>
											<tr>
												<th class="p-1" scope="col"><sec:authentication
														property="principal.realUser.hrGradeNm" /></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="p-1 " style="height: 5rem;"><img alt="서명이미지"
													src="<sec:authentication property="principal.realUser.empSign" />"
													style="width: 71px; height: 71px"></td>
											</tr>
											<tr>
												<td class="p-1"><sec:authentication
														property="principal.realUser.empNm" /></td>
											</tr>
											<tr>
												<td class="p-1 sysdate"
													style="font-size: 12px; font-weight: bold">날짜</td>
											</tr>
										</tbody>
									</table>
								</sec:authorize>
							</div>
						</div>
					</div>
				</div>
				<!-- 결재란 -->
				
			    <%-- <select name="selectedPordCd"  onchange="fgetPord(this)" width:20%; ">
			        <option value="default" selected>발주서를 선택하세요.</option>
			        <c:if test="${not empty selectPordCd}">
			            <c:forEach var="draftOrderVO" items="${selectPordCd}">
			                <option value="${draftOrderVO.pordCd}">${draftOrderVO.pordCd}</option>
			            </c:forEach>
			        </c:if>
			    </select> --%>
			    
				<div class="card-body position-relative pt-1">
					<sec:authorize access="isAuthenticated()">
						<table class="table table-bordered align-middle text-align mb-3 border">
							<colgroup>
					            <col width="20%">
					            <col width="30%">
					            <col width="20%">
					            <col width="30%">
					        </colgroup>
					        <tbody id="dataRowsPayment2" class="mb-2">
					            <tr>
					                <td class="bg-primary-subtle text-center ">부서</td>
					                <td class=" text-center" id="">
						                <input class="form-control-plaintext outline-none" id="colFormLabel1" type="text" 
						                	placeholder="col-form-label" readonly
											value="<sec:authentication property="principal.realUser.deptNm" />" />
									</td>
					                <td class="bg-primary-subtle text-center ">직급</td>
					                <td class=" text-center" id="">
					                	<input class="form-control-plaintext outline-none" id="colFormLabel2" type="text" 
						                	placeholder="col-form-label" readonly
											value="<sec:authentication property="principal.realUser.hrGradeNm" />" />
									</td>
					            </tr>
					            <tr>
					                <td class="bg-primary-subtle text-center ">기안자명</td>
					                <td class=" text-center" id="">
					                	<input class="form-control-plaintext outline-none"
											id="colFormLabel3" type="text" placeholder="기안자명" readonly
											value="<sec:authentication property="principal.realUser.empNm" />" />
									</td>
					                <td class="bg-primary-subtle text-center ">기안일</td>
					                <td class=" text-center" id="">
					                	<input class="form-control-plaintext outline-none" id="sysdate"
										type="date" placeholder="col-form-label" readonly value="" />
									</td>
					            </tr>
				            </tbody>
					    </table>
					</sec:authorize>
					<div id="tbl" class="table-responsive scrollbar border mt-4 text-center">
						<div class="min-vh-5">
						    <table class="table table-bordered align-middle text-align mb-3 border">
						        <colgroup>
						            <col width="20%">
						            <col width="30%">
						            <col width="20%">
						            <col width="30%">
						        </colgroup>
						        <tbody id="dataRowsPayment2" class="mb-2">
						            <tr><!-- data-bs-toggle="modal" data-bs-target="#pord-modal" style="cursor: pointer; "-->
						                <th class="bg-primary-subtle text-center" >
							                <select name="selectedPordCd"  onchange="fgetPord(this)" width:20%; ">
										        <option value="default" selected>발주서 선택</option>
										        <c:if test="${not empty selectPordCd}">
										            <c:forEach var="draftOrderVO" items="${selectPordCd}">
										                <option value="${draftOrderVO.pordCd}">${draftOrderVO.pordCd}</option>
										            </c:forEach>
										        </c:if>
										    </select>					              
						                </th>
						                <td class="text-center" id="selectPordCd" pord_cd></td>
						                <td class="bg-primary-subtle text-center ">사업자등록번호</td>
						                <td class=" text-center" com_no>${draftOrderList}</td>
						            </tr>
						            <tr>
						                <td class="bg-primary-subtle text-center ">납기일자</td>
						                <td class=" text-center" due_date></td>
						                <td class="bg-primary-subtle text-center ">회사명 / 대표</td>
						                <td class=" text-center" com_nmceo></td>
						            </tr>
						            <tr>
						                <td class="bg-primary-subtle text-center ">EMAIL</td>
						                <td class=" text-center" com_mail id=""></td>
						                <td class="bg-primary-subtle text-center ">주소</td>
						                <td class=" text-center" com_addr id=""></td>
						            </tr>
						            <tr>
						                <td class="bg-primary-subtle text-center ">FAX</td>
						                <td class=" text-center" com_fax ></td>
						                <td class="bg-primary-subtle text-center ">담당자 / 연락처</td>
						                <td class=" text-center" com_chargetel ></td>
						            </tr>
						        </tbody>
						    </table>
						    
						    <table id="itemTable" class="table table-bordered align-middle text-align mb-3 border">
						        <colgroup>
						            <col width="25%">
						            <col width="10%">
						            <col width="25%">
						            <col width="25%">
						            <col width="25%">
						        </colgroup>
						        <tbody id="itemTable tbody" class="mb-2">
						            <tr>
						                <td class="bg-primary-subtle text-center">품목명[규격]</td>
						                <td class="bg-primary-subtle text-center">단가</td>
						                <td class="bg-primary-subtle text-center">수량[단위]</td>
						                <td class="bg-primary-subtle text-center">공급가액</td>
						                <td class="bg-primary-subtle text-center">부가세</td>
						            </tr>
						            <tr class="wjb">
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							        </tr>
						            <tr class="wjb">
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							        </tr>
						            <tr class="wjb">
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							        </tr>
						            <tr class="wjb">
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							        </tr>
						            <tr class="wjb">
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							            <td class="text-center"></td>
							        </tr>
						        </tbody>
						    </table>
						    <table class="table table-bordered align-middle text-align mb-3 border">
						        <colgroup>
						            <col width="12%">
						            <col width="20%">
						            <col width="10%">
						            <col width="30%">
						            <col width="10%">
						            <col width="20%">
						        </colgroup>
						        <tbody id="dataRowsPayment2" class="mb-2">
						            <tr>
						                <td class="bg-primary-subtle text-center ">총수량</td>
						                <td class=" text-center" total_qty id=""></td>
						                <td class="bg-primary-subtle text-center ">공급가액</td>
						                <td class=" text-center" total_supp_prc id=""></td>
						                <td class="bg-primary-subtle text-center ">VAT</th>
						                <td class=" text-center" total_vat id=""></td>
						            </tr>
						        </tbody>
						    </table>
						    <table class="table table-bordered align-middle text-align mb-3 border">
						        <colgroup>
						            <col width="20%">
						            <col width="60%">
						            <col width="20%">
						        </colgroup>
						        <tbody id="dataRowsPayment2" class="mb-2">
						        	<tr>
						                <td class="bg-primary-subtle text-center ">합계</td>
						                <td class=" text-center" total_prc  id="total_prc"></td>
						                <td class="bg-primary-subtle text-center ">원(₩)</td>
						            </tr>
						            <tr>
						                <td class="bg-primary-subtle text-center ">금액</td>
						                <td class=" text-center" id="totalPrcKo"> &nbsp; </td>
						                <td class="bg-primary-subtle text-center ">원(₩)</td>
						            </tr>
						        </tbody>
						    </table>
						</div>
					</div>

					<div>
						<div class="min-vh-5 d-none">
							<textarea id="draftClobContent" class="tinymce"
								data-tinymce="data-tinymce" name="drftSave">test</textarea>
								
								
						</div>
						<br /> <br /> <br /> <br /> <br /> <br /> <br />
						<div id="liveAlertPlaceholder"></div>
					</div>
				</div>		
			</div>
		</div>

		<!-- 	결재선 잡는 부분 -->
		<div class="card col-4 ms-3 my-3 border border-secondary">
			<div class="card-body position-relative pt-4 ">
				<div class="btn-group col-12 mb-3" role="group" aria-label="draft">
					<button type="button" id="getApproval"
						class="btn btn-primary btn-lg">기안하기</button>
					<button type="button" id="getImsi" class="btn btn-secondary btn-lg">임시저장</button>
				</div>
				<div class="mb-3 row g-2">
					<span>기안서 제목</span>
					<textarea class="form-control" id="draftTitle" name="drftTitle"
						rows="3"></textarea>
				</div>
				<div class="d-grid gap-1">
					<button type="button" class="btn btn-outline-primary me-1 mb-1"
						data-bs-toggle="modal" data-bs-target="#draftLineConfig">결재선
						설정</button>
				</div>
				<hr class="opacity-75" style="border: solid 1px" />

				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item"><a class="nav-link active"
						id="approval-tab" data-bs-toggle="tab" href="#tab-approval"
						role="tab" aria-controls="tab-approval" aria-selected="true">결재선</a></li>
					<li class="nav-item"><a class="nav-link" id="opinion-tab"
						data-bs-toggle="tab" href="#tab-opinion" role="tab"
						aria-controls="tab-opinion" aria-selected="false">의견</a></li>
					<li class="nav-item"><a class="nav-link" id="attachment-tab"
						data-bs-toggle="tab" href="#tab-attachment" role="tab"
						aria-controls="tab-attachment" aria-selected="false">첨부파일</a></li>
				</ul>
				<div class="tab-content border border-top-0 p-3 pt-0"
					id="myTabContent">
					<div class="tab-pane fade show active" id="tab-approval"
						role="tabpanel" aria-labelledby="approval-tab">
						<!-- 결재선 선택시 나오는 부분 -->
						<div class="d-flex flex-column draftSideInfo" id="draftApproval">
							<sec:authorize access="isAuthenticated()">
								<table class="table my-3">
									<tbody>
										<tr class="bg-primary-subtle">
											<td>결재선 (결재순서)</td>
										</tr>
										<tr>
											<td class="align-middle p-0">
												<div>
													<div class="card my-3 shadow-sm dark__bg-1100">
														<div class="card-body border p-2">
															<div
																class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
																<div class="align-middle mx-auto">1</div>
																<div class="mx-auto">
																	<img alt="유저사진" class="rounded-circle my-img-size"
																		src="<sec:authentication 
																		property="principal.realUser.empImg" />">
																</div>
																<div class="mx-auto">
																	<sec:authentication property="principal.realUser.empNm" />
																</div>
																<div class="mx-auto">
																	<sec:authentication property="principal.realUser.deptNm" />
																</div>
																<div class="mx-auto">
																	<sec:authentication property="principal.realUser.hrGradeNm" />
																</div>
																<div class="mx-auto">
																	<span class="badge rounded-pill badge-subtle-secondary">기안자</span>
																</div>
																<div class="mx-auto">
																	<span class="fas fa-pen"></span>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div id="draftLineDisplay">
												</div>
											</td>
										</tr>

										<tr class="bg-primary-subtle">
											<td>
												<div class="float-start">수신자</div>
											</td>
										</tr>
										<tr>
											<td id="draftSusinDisplay">
													
											</td>
										</tr>
										
										<tr class="bg-primary-subtle">
											<td>
												<div class="float-start">회람자</div>
											</td>
										</tr>
										<tr>
											<td id="draftRamDisplay">
												
											</td>
										</tr>
									</tbody>
								</table>
							</sec:authorize>
						</div>
						<!-- 결재선 선택시 나오는 부분 -->
					</div>
					<div class="tab-pane fade" id="tab-opinion" role="tabpanel"
						aria-labelledby="opinion-tab">
						<!-- 의견 선택시 나오는 부분 -->
						<div class="row g-1 draftSideInfo" id="draftOpinion">
							<h5 class="mt-3">의견</h5>
							<hr class="opacity-75 mb-1" style="border: solid 1px" />
							<div id="draftShowOpinion" class="align-items-center">
								<input class="form-control-plaintext" id="opZero" readonly
									value="의견이 없습니다" />
							</div>
							<hr class="opacity-75" style="border: solid 1px" />
							<div class="col">
								<textarea class="form-control" id="draftRegistOpnion" rows="3"
									placeholder="의견 작성하기"></textarea>
								<button id="setOpnionBtn" type="button"
									class="btn btn-primary btn-sm float-end mt-3">작성</button>
							</div>
						</div>
						<!-- 의견 선택시 나오는 부분 -->
					</div>
					<div class="tab-pane fade" id="tab-attachment" role="tabpanel"
						aria-labelledby="attachment-tab">
						<!-- 첨부파일 선택시 나오는 부분 -->
						<div class="row g-1 draftSideInfo" id="draftAttachment">
							<h5 class="mt-3">첨부 파일</h5>
							<hr class="opacity-75" style="border: solid 1px" />
							<div class="mb-3">
								<label class="form-label" for="formFileMultiple"></label> <input
									class="form-control" type="file" multiple="multiple"
									name="attachFiles" />
							</div>
						</div>
						<!-- 첨부파일 선택시 나오는 부분 -->
					</div>
				</div>

			</div>
		</div>
		<!-- 결재선 잡는 부분 -->

		<!-- 결재선 설정 모달 -->
		<div class="modal fade" id="draftLineConfig" data-bs-keyboard="false"
			data-bs-backdrop="static" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">

			<div class="modal-dialog modal-xl mt-6" role="document"
				style="width: 60em">
				<div class="modal-content border-0">
					<!-- 모달 닫기 버튼 -->
					<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
						<button type="button"
							class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
							data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<!-- 모달 닫기 버튼 -->

					<div class="modal-body p-0">
						<!-- 결재선, 즐겨찾기 구분 -->
						<div class="bg-light rounded-top-3 py-3 ps-4 pe-6">
							<ul class="nav nav-tabs" id="myTab" role="tablist">
								<li class="nav-item"><a class="nav-link active"
									id="line-tab" data-bs-toggle="tab" href="#tab-line" role="tab"
									aria-controls="tab-line" aria-selected="true"> 결재선 설정하기 </a></li>

								<li class="nav-item"><a class="nav-link"
									id="line-favor-tab" data-bs-toggle="tab" href="#tab-line-favor"
									role="tab" aria-controls="tab-line-favor" aria-selected="false">
										결재선 불러오기 </a></li>
							</ul>
						</div>
						<!-- 결재선, 즐겨찾기 구분 -->

						<div class="tab-content border border-top-0 p-3" id="myTabContent">
							<!-- 결재선 설정 내용 -->
							<div class="tab-pane fade show active" id="tab-line"
								role="tabpanel" aria-labelledby="line-tab">
								<div class="d-flex mb-3 ">
									<!-- 조직도 -->
									<div class="p-3 border-end" style="width: 40%">
										<div class="row px-3">
											<div>
												<div class="input-group">
													<input
														class="form-control form-control-sm shadow-none search"
														id="search" type="search" placeholder="조직원 검색하기"
														aria-label="search" />
													<div class="input-group-text bg-transparent">
														<span class="fa fa-search fs--1 text-600"></span>
													</div>
												</div>
											</div>
											<hr class="opacity-50 float-none mt-2"
												style="border: solid 1px" />

											<div class="scrollbar-overlay" style="max-height: 21rem">
												<div class="" id="jstree"></div>
											</div>
										</div>
									</div>
									<!-- 조직도 -->

									<div class="p-3 m-1 d-flex flex-column m-auto "
										style="width: 20%">
										<button id="draftmy1" type="button"
											class="btn btn-primary mb-2">결재자</button>
										<button id="draftmy2" type="button" class="btn btn-success mb-2">수신자</button>
										<button id="draftmy3" type="button"
											class="btn btn-warning mb-2">회람자</button>
									</div>
									<div id="draftAllLineSpace" class="p-3 border-start"
										style="width: 40%">
										<!-- 결재선 -->
										<div>
											<sec:authorize access="isAuthenticated()">
												<div class="row">
													<div>
														<div class="d-flex">
															<div class="me-auto">결재순번</div>
														</div>
														<hr class="opacity-75 float-none"
															style="border: solid 1px" />
														<div class="scrollbar-overlay" style="max-height: 21rem">

															<div id="lineSpace"
																class="kanban-items-container bg-white dark__bg-1000 rounded-2 py-3 px-2"
																style="max-height: none;">
																<div class="card mb-3 shadow-sm dark__bg-1100">
																	<div class="card-body border p-2">
																		<div
																			class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
																			<div class="mx-auto">
																				<img alt="유저사진" class="rounded-circle my-img-size"
																					src="<sec:authentication 
																		property="principal.realUser.empImg" />">
																			</div>
																			<div class="mx-auto">
																				<sec:authentication
																					property="principal.realUser.empNm" />
																			</div>
																			<div class="mx-auto">
																				<sec:authentication
																					property="principal.realUser.deptNm" />
																			</div>
																			<div class="mx-auto">
																				<sec:authentication
																					property="principal.realUser.hrGradeNm" />
																			</div>
																		</div>
																	</div>
																</div>
															</div>

															<div>수신자</div>
															<hr class="opacity-75 float-none"
																style="border: solid 1px" />
															<div id="susin"
																class="kanban-items-container bg-white dark__bg-1000 rounded-2 py-1 px-2 mb-3"
																style="max-height: none;"></div>
																
															<div>회람자</div>
															<hr class="opacity-75 float-none"
																style="border: solid 1px" />
															<div id="ram"
																class="kanban-items-container bg-white dark__bg-1000 rounded-2 py-1 px-2 mb-3"
																style="max-height: none;"></div>

														</div>
													</div>
												</div>
											</sec:authorize>
										</div>
										<!-- 결재선 -->
									</div>
								</div>

							</div>
							<!-- 결재선 설정 내용 -->

							<!-- 결재선 즐겨찾기 내용 -->
							<div class="tab-pane fade" id="tab-line-favor" role="tabpanel"
								aria-labelledby="line-favor-tab">
								<div class="p-4">
									<div class="row">
										<div class="col-lg-9">
											<div class="d-flex">
												<div class="flex-1">
													<h5 class="mb-2 fs-0">즐겨찾기</h5>
															미완성
													<hr class="my-4" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 결재선 즐겨찾기 내용 -->
							<div class="text-center">
								<button id="lineSave" type="button" class="btn btn-primary"
									data-bs-dismiss="modal" aria-label="Close">등록</button>
								<button id="lineClose" type="button"
									class="btn btn-outline-primary" data-bs-dismiss="modal"
									aria-label="Close">취소</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 결재선 설정 모달 -->


	</div>



	<sec:csrfInput />
</form>


<!-- 상세 모달 시작-->
<div class="modal fade" id="pord-modal" data-bs-backdrop="static" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true" >
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="modal-body p-0">
        <div class="rounded-top-3 py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1" id="modalExampleDemoLabel">대기중인 발주서</h4>
        </div>
        <div class="p-4 pb-0">
          <%-- <form>
		    <select name="selectedPordCd"  onchange="fgetPord(this)" >
		        <option value="default" selected>발주서를 선택하세요.</option>
		        <c:if test="${not empty selectPordCd}">
		            <c:forEach var="draftOrderVO" items="${selectPordCd}">
		                <option data-bs-dismiss="modal" value="${draftOrderVO.pordCd}">${draftOrderVO.pordCd}</option>
		            </c:forEach>
		        </c:if>
		    </select>
		  </form> --%>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 상세 모달 끝-->


<script type="text/javascript">

	// 데이터 검증 및 처리 스크립트
	// 오늘 날짜 계산
	var today = new Date();
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var formattedDate = year + '-' + month + '-' + day;
	var formattedDate2 = year + '' + month + '' + day;
	
	document.querySelector("#sysdate").setAttribute("value", formattedDate);
	document.querySelector(".sysdate").innerText = formattedDate;
	
	//제목 자동 설정
	document.querySelector("#draftTitle").innerText = $("#draftFormTitle")[0].innerText + "-" + $("#colFormLabel3")[0].value+ "-" + formattedDate2;
	
	
	$(document).ready(function() {
		
		tinymce.init({
		    selector: "#draftClobContent",
		});
		
		$("#getApproval").on('click', function() {
			
			const lineId = document.querySelector('.lineId');
			
			$("#drftStat")[0].value = 'L002';
			
			var docHtml = document.querySelector("#doc");
			var copyDocHtml = docHtml.cloneNode(true);
			
			tinymce.get('draftClobContent').setContent(copyDocHtml.innerHTML);
			
			
			frm1.submit();
			
		});
		
		$("#getImsi").on('click', function() {
			
			$("#drftStat")[0].value = 'L004';
			
			var docHtml = document.querySelector("#docTest");
			var copyDocHtml = docHtml.cloneNode(true);
			
			tinymce.get('draftClobContent').setContent(copyDocHtml.innerHTML);
			
			frm1.submit();
			
		});
			
		
	// 기안 의견 데이터 전달
	    $("#draftRegistOpnion").keyup(function(event) {
	        if (event.which === 13) {
	            $("#setOpnionBtn").click();
	        }
	    });
	    
		$("#setOpnionBtn").on("click", function() {
			var draftShowOpinion = document.querySelector("#draftShowOpinion");
			var draftRegistOpnion = document.querySelector("#draftRegistOpnion");
			var count = $("#draftShowOpinion > .alert").length;
			var opinion = draftRegistOpnion.value;
			
			$("#opZero").hide();
			
			var nowTime = new Date();
			
			var opinionTemp = `
					<div class="alert d-flex align-items-center p-0 mb-0">						
							<input class="form-control-plaintext"
							name="drftOpVOList[` + count + `].opCont"
							readonly value="${empInfoVO.empNm}: ` + opinion +  `"/>
						<button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close"></button>	
				`
				
			opinionTemp += `<input type="hidden" name="drftOpVOList[` + count + `].empCd" value="${empInfoVO.empCd}"/>`
			opinionTemp += `<input type="hidden" name="drftOpVOList[` + count + `].opWdate" value="`+ nowTime +`"/></div>`
			draftShowOpinion.innerHTML += opinionTemp;

			draftRegistOpnion.value = "";
		});
		
	// 기안 의견 데이터 전달
	
	});
	
	$(document).on("click", ".opn-del", function() {
		var count = $("#draftShowOpinion > .alert").length;
		if (count <= 0) {
			$("#opZero").show();
		}
	});

</script>

<!-- 결재선 설정 자바스크립트 -->
<script>
  var jQuery1x = jQuery.noConflict();
</script>

<script type="text/javascript">

const pThis = document.getElementById('selectPordCd');

// 발주서 호출
function fgetPord(pThis){
	console.log("this",pThis.value);

	jQuery.ajax({
		type:"get",
		url:`/draft/order/\${pThis.value}`,
		dataType:"json",
		success:function(rslt){
			console.log("pord:", rslt);
			$("[pord_cd]").html(rslt[0].PORD_CD);
			$("[com_no]").html(rslt[0].COM_NO);
			$("[due_date]").html(rslt[0].DUE_DATE);
			$("[com_nmceo]").html(rslt[0].COM_NM +" / "+ rslt[0].COM_CEO);
			$("[com_chargetel]").html(rslt[0].COM_MN +" / "+ rslt[0].COM_TEL);
			$("[com_addr]").html(rslt[0].COM_ADDR +" "+ rslt[0].COM_DADDR);
			$("[com_fax]").html(rslt[0].COM_FAX);
			$("[com_mn]").html(rslt[0].COM_mn);
			$("[com_mail]").html(rslt[0].COM_MAIL);
			
			let totalQty = 0;
			let totalSuppPrc = 0;
			let totalVat = 0;
			
			$(".wjb").remove();
			for (let i = 0; i < rslt.length; i++) {
				
				let uprc = rslt[i].PORD_UPRC;
				let qty = rslt[i].PORD_QTY;
				let suppPrc = rslt[i].PORD_UPRC * rslt[i].PORD_QTY;
				let vat = (rslt[i].PORD_UPRC * rslt[i].PORD_QTY) / 10;
				
				totalQty += qty;
				totalSuppPrc += suppPrc;
				totalVat += vat;
				
			    var itemTable = `
			        <tr class="wjb">
			            <td class="text-center">\${rslt[i].ITEM_NM}</td>
			            <td class="text-center">\${uprc.toLocaleString()}</td>
			            <td class="text-center">\${qty.toLocaleString() + rslt[i].ITEM_UNIT}</td>
			            <td class="text-center">\${suppPrc.toLocaleString()}</td>
			            <td class="text-center">\${vat.toLocaleString()}</td>
			        </tr>
			    `;
			    $("#itemTable tbody").append(itemTable);
			}
			
			const totalPrc = totalSuppPrc + totalVat;
			
			$("[total_qty]").html(totalQty.toLocaleString()+"개(EA)");
			$("[total_supp_prc]").html(totalSuppPrc.toLocaleString());
			$("[total_vat]").html(totalVat.toLocaleString());
			$("[total_prc]").html(totalPrc.toLocaleString());
			
			convertToKoreanNumber(totalPrc);
			
			closeModals();

		},
		error:function(xhr){
			console.log("error:",xhr.state);
		}
	})
}



//자식 모달이 닫힐 때 실행되는 함수
function closeModals() {
    // 부모 모달을 가져와서 닫기
    var parentModal = document.getElementById('parent-modal-id'); // 부모 모달의 ID로 변경
    var childModal = document.getElementById('pord-modal');

    // 부모 모달이 존재하고 열려있을 경우에만 닫기
    if (parentModal && parentModal.classList.contains('show')) {
        var parentModalInstance = new bootstrap.Modal(parentModal);
        parentModalInstance.hide();
    }

    // 자식 모달 닫기
    var childModalInstance = new bootstrap.Modal(childModal);
    childModalInstance.hide();
}

// 모달 닫기 버튼에 이벤트 핸들러 등록
//var closeModalButton = document.getElementById('close-modal-button-id'); // 닫기 버튼의 ID로 변경
//closeModalButton.addEventListener('click', closeModals);




function convertToKoreanNumber(totalPrc) {
	console.log("총합계금액",totalPrc)
    var num = totalPrc;
	var result = '';
	var digits = [ '영', '일', '이', '삼', '사', '오', '육', '칠', '팔', '구' ];
	var units = [ '', '십', '백', '천', '만', '십만', '백만', '천만', '억', '십억',
			'백억', '천억', '조', '십조', '백조', '천조' ];
	
	var numStr = num.toString(); // 문자열로 변환
	var numLen = numStr.length; // 문자열의 길이

	for (var i = 0; i < numLen; i++) {
		var digit = parseInt(numStr.charAt(i)); // i번째 자릿수 숫자
		var unit = units[numLen - i - 1]; // i번째 자릿수 단위

		// 일의 자리인 경우에는 숫자를 그대로 한글로 변환
		if (i === numLen - 1 && digit === 1 && numLen !== 1) {
			result += '일';
		} else if (digit !== 0) { // 일의 자리가 아니거나 숫자가 0이 아닐 경우
			result += digits[digit] + unit;
		} else if (i === numLen - 5) { // 십만 단위에서는 '만'을 붙이지 않습니다.
			result += '만';
		}
		console.log("붙어가는모습:",result);
	}
	$("#totalPrcKo").text(result);
}

$(function (){
	
	// DB에서 조직 정보 가져오기
	jQuery1x.ajax({
		url:"/organization/jsonList",
		type:"post",
		dataType:"json",
		beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(result){
		 	const data = [];
		 	let nodes = result;
		 	
		 	// parent 기준으로 데이터 정리
		 	const parents = {};
		 	nodes.forEach(node => {
		 	  if (!parents[node.parent]) {
		 	    parents[node.parent] = [];
		 	  }
			  // idCard를 가져올 때 index가 아니라 id를 가져와야 함!!
		 	  parents[node.parent].push({name : node.child, id : node.id, jbgdCd : node.grade, empImg: node.img, deptNm : node.dept});
		 	});
			
		 	// jstree에서 사용할 수 있는 형태로 데이터 변환
		 	Object.keys(parents).forEach(parent => {
		 	  const children = parents[parent].map(child => {
		 	    return {text: child.name + " " + child.jbgdCd, type: "file", id : child.id, empImg : child.empImg, deptNm : child.deptNm};
		 	  });
		 	  data.push({
		 	    text: parent,
		 	    children: children
		 	  });
		 	});
		 	
		 	// ajax data 받아오기 
		 	jQuery1x('#jstree').jstree({
		 		'core': {
		 			"check_callback" : true,
		 			'data': data
		 			},
		 		"types" :{
		 			"default" : {
		 				"icon" : "fa-solid fa-folder"
		 			},
		 			"file" : {
		 				"icon" : "fa-solid fa-address-card"
		 			}
		 		},	
		 		"plugins" : ["types", "dnd", "search"]
		 		
		 		
		 		//children node 클릭했을때 hidden 처리 해제
		 	}).on('select_node.jstree', function(event, data) {
		 		
				var selectedNode = data.node;
				// 자식 노드(사원 정보)일 경우 이벤트 실행
				if(selectedNode.parent != '#') {
					//중복 실행 방지
					$("#draftmy1").off().on('click', function() {
						lineEdit(selectedNode);
					})
					
					$("#draftmy2").off().on('click', function() {
						susinEdit(selectedNode);
					})
					
					$("#draftmy3").off().on('click', function() {
						ramEdit(selectedNode);
					})
					
							
					//취소 버튼
					$("#lineClose").off().on("click", function() {
						$(".draft-line, .draft-susin, .draft-ram").remove();
						$(".draft-div").removeClass("d-none");
					
					});

					// 확인 버튼
					$("#lineSave").off().on("click", function() {
						// 확정이 난 데이터에서 수정할 데이터라는 뜻을 가진 클래스를 지워줌
						$(".draft-line, .draft-susin, .draft-ram").removeClass("draft-line draft-susin draft-ram");
						// 삭제버튼을 눌러 d-none 처리했던 태그들을 지워줌
						$(".draft-div.d-none, .draft-div.d-none, .draft-div.d-none").remove();
						
						// 확인 누르면 기존에 등록된 html을 초기화
						$("#draftLineDisplay, #draftSusinDisplay, #draftRamDisplay").html("");
						
						$(".signBox").remove();
					
						//추가로 생성됬던 태그들을 결재선 설정 밖으로 보내줌
						$("#lineSpace > .alert").each(function(index, value) {
							changeDisplay(index, value);
								
						});
						
						// 수신자 처리
						$("#susin > .alert").each(function(index, value) {
							chageDisplay2(index, value);
						});
						
						// 회람자 처리
						$("#ram > .alert").each(function(index, value) {
							chageDisplay3(index, value);
						});
											
					})
				}
		 	});
			 	
		}
		 	
	});
	var lineIndexNum = 0;
	function chageDisplay2(index, value) {
		var content = value.cloneNode(true);
		
		var draftLineContent = content.querySelector('.card-body > .d-flex')
		content.classList.remove('kanban-item');
		content.classList.add('col');
		
		var btnDelDraft = content.querySelector('.draft-del-btn');
		btnDelDraft.remove();
		
	// form에 전달할 empCd 생성
		var atrzUserId = content.querySelector('#lineId').value;
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'drftLineVOList[' + lineIndexNum + '].empCd');
		inputHiddenId.setAttribute('value', atrzUserId);
		
		draftLineContent.prepend(inputHiddenId);
	// form에 전달할 empCd 생성
	
	// form에 전달할 dlineSq 생성
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'drftLineVOList[' + lineIndexNum + '].dlineSq');
		inputHiddenId.setAttribute('value', 0);
		
		draftLineContent.prepend(inputHiddenId);
	// form에 전달할 dlineSq 생성
	
	// form에 전달할 dlineCd 생성
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'drftLineVOList[' + lineIndexNum + '].dlineCd');
		inputHiddenId.setAttribute('value', 'M002');
		
		draftLineContent.prepend(inputHiddenId);
		
		lineIndexNum++;
	// form에 전달할 dlineCd 생성
		
		$("#draftSusinDisplay").append(content);
	}
	
	function chageDisplay3(index, value) {
		var content = value.cloneNode(true);
		
		var draftLineContent = content.querySelector('.card-body > .d-flex')
		content.classList.remove('kanban-item');
		content.classList.add('col');
		
		var btnDelDraft = content.querySelector('.draft-del-btn');
		btnDelDraft.remove();
		
	// form에 전달할 userId 생성
		var atrzUserId = content.querySelector('#lineId').value;
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].userId');
		inputHiddenId.setAttribute('value', atrzUserId);
		
		draftLineContent.prepend(inputHiddenId);
	// form에 전달할 userId 생성
	
	// form에 전달할 atrzSn 생성
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].atrzSn');
		inputHiddenId.setAttribute('value', 0);
		
		draftLineContent.prepend(inputHiddenId);

	// form에 전달할 atrzSn 생성
	
	// form에 전달할 atrzCd 생성
		var inputHiddenId = document.createElement('input');
		inputHiddenId.setAttribute('type', 'hidden');
		inputHiddenId.setAttribute('name', 'draftAtrzVOList[' + lineIndexNum + '].atrzCd');
		inputHiddenId.setAttribute('value', 'DR003');
		
		draftLineContent.prepend(inputHiddenId);
	// form에 전달할 atrzCd 생성
		lineIndexNum++;
		$("#draftRamDisplay").append(content);
	}
	
	// 결제선 설정 모달 밖으로 결제선 생성 
	function changeDisplay(index, value){
		var content = value.cloneNode(true);
		// 결재 라인 내용 태그
			var draftLineContent = content.querySelector('.card-body > .d-flex')
			content.classList.remove('kanban-item');
		// 기안 순서 번호 넣기
			var seqCount = document.createElement('div');
			seqCount.classList.add('align-middle', 'mx-auto');
			seqCount.textContent = (index + 2).toString();
			
			draftLineContent.prepend(seqCount);
		// 기안 순서 번호 넣기	
		
		// form에 전달할 empCd 생성
			var atrzUserId = content.querySelector('#lineId').value;
			var inputHiddenId = document.createElement('input');
			inputHiddenId.setAttribute('type', 'hidden');
			inputHiddenId.setAttribute('name', 'drftLineVOList[' + lineIndexNum + '].empCd');
			inputHiddenId.setAttribute('value', atrzUserId);
			
			draftLineContent.prepend(inputHiddenId);
		// form에 전달할 empCd 생성
		
		// form에 전달할 dlineSq 생성
			var inputHiddenId = document.createElement('input');
			inputHiddenId.setAttribute('type', 'hidden');
			inputHiddenId.setAttribute('name', 'drftLineVOList[' + lineIndexNum + '].dlineSq');
			inputHiddenId.setAttribute('value', index + 1);
			
			draftLineContent.prepend(inputHiddenId);
		// form에 전달할 dlineSq 생성
		
		// form에 전달할 dlineCd 생성
			var inputHiddenId = document.createElement('input');
			inputHiddenId.setAttribute('type', 'hidden');
			inputHiddenId.setAttribute('name', 'drftLineVOList[' + lineIndexNum + '].dlineCd');
			inputHiddenId.setAttribute('value', 'M001');
			
			draftLineContent.prepend(inputHiddenId);
			lineIndexNum++;
		// form에 전달할 dlineCd 생성
		
		// 삭제 버튼(X) 지우고 해당 자리에 뱃지 넣기
			var btnDelDraft = content.querySelector('.draft-del-btn');
			btnDelDraft.remove();
			
			var draftBadge = document.createElement('div');
			draftBadge.classList.add('mx-auto');
			draftBadge.innerHTML = '<span class="badge rounded-pill badge-subtle-primary">결재자</span>';

			draftLineContent.append(draftBadge);
		// 삭제 버튼(X) 지우기 해당 자리에 뱃지 넣기

			$("#draftLineDisplay").append(content);
		
		// 결재 사인 박스 생성
			var myttemp = content.querySelectorAll(".mx-auto");
			
			var empNm = myttemp[2].textContent // 이름
			var hrGradeNm = myttemp[4].textContent // 직급
			
			var signBox = document.querySelector("#signBox");
			var tempSignBox = document.createElement('div');
			tempSignBox.classList.add('border-400', 'signBox');
			tempSignBox.innerHTML = `
				<table class="table text-center" border="1">
					<thead>
						<tr>
							<th class="p-1" scope="col">` + hrGradeNm + `</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="p-1" style="height: 5rem;">
							<img alt="서명이미지" src="\\resources\\images\\emp\\empSign\\nosign.png" 
								style="width: 71px; height: 71px"></td>
						</tr>
						<tr>
							<td class="p-1">`+ empNm + `</td>
						</tr>
						<tr>
							<td class="p-1" style="font-size: 12px; font-weight: bold">날짜</td>
						</tr>
					</tbody>
				</table>`;
				

			signBox.append(tempSignBox);  // 요소를 추가
	}
	
	
	function lineEdit(selectedNode) {
		var empNm = selectedNode.text.split(" ")[0];
		var hrGradeNm = selectedNode.text.split(" ")[1];
		var empCd = selectedNode.id;
		var empImg = selectedNode.original.empImg;
		var deptNm = selectedNode.original.deptNm;
		var line =
				`<div class="alert card mb-3 kanban-item shadow-sm dark__bg-1100 p-0 draft-div draft-line" style="border: 0px">
					<div class="card-body border p-2">
						<div class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
							<div class=" mx-auto">` + `<img alt="유저사진" class="rounded-circle my-img-size" src="` +  empImg + `"></div>
							<input type="hidden" class="lineId" id="lineId" value="` + empCd + `" />
							<div class=" mx-auto">` + empNm + `</div>
							<div class=" mx-auto">` + deptNm + `</div>
							<div class=" mx-auto">` + hrGradeNm + `</div>
							<button class="btn-close close-card draft-del-btn" type="button"></button>
						</div>
					</div>
				</div>`
			$("#lineSpace").append(line);
			
	}

	function susinEdit(selectedNode) {
		var empNm = selectedNode.text.split(" ")[0];
		var hrGradeNm = selectedNode.text.split(" ")[1];
		var empCd = selectedNode.id;
		var empImg = selectedNode.original.empImg;
		var deptNm = selectedNode.original.deptNm;
		var line =
				`<div class="alert card mb-3 kanban-item shadow-sm dark__bg-1100 p-0 draft-div draft-line" style="border: 0px">
					<div class="card-body border p-2">
						<div class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
							<div class=" mx-auto">` + `<img alt="유저사진" class="rounded-circle my-img-size" src="` +  empImg + `"></div>
							<input type="hidden" class="lineId" id="lineId" value="` + empCd + `" />
							<div class=" mx-auto">` + empNm + `</div>
							<div class=" mx-auto">` + deptNm + `</div>
							<div class=" mx-auto">` + hrGradeNm + `</div>
							<button class="btn-close close-card draft-del-btn" type="button"></button>
						</div>
					</div>
				</div>`
			$("#susin").append(line);
	}
	
		
	function ramEdit(selectedNode) {
		var empNm = selectedNode.text.split(" ")[0];
		var hrGradeNm = selectedNode.text.split(" ")[1];
		var empCd = selectedNode.id;
		var empImg = selectedNode.original.empImg;
		var deptNm = selectedNode.original.deptNm;
		var line =
				`<div class="alert card mb-3 kanban-item shadow-sm dark__bg-1100 p-0 draft-div draft-line" style="border: 0px">
					<div class="card-body border p-2">
						<div class="d-flex align-items-center fs--1 fw-medium font-sans-serif mb-0">
							<div class=" mx-auto">` + `<img alt="유저사진" class="rounded-circle my-img-size" src="` +  empImg + `"></div>
							<input type="hidden" class="lineId" id="lineId" value="` + empCd + `" />
							<div class=" mx-auto">` + empNm + `</div>
							<div class=" mx-auto">` + deptNm + `</div>
							<div class=" mx-auto">` + hrGradeNm + `</div>
							<button class="btn-close close-card draft-del-btn" type="button"></button>
						</div>
					</div>
				</div>`
			$("#ram").append(line);
	}

	 	// 조직도 내 검색 기능
	 	$('#search').on('keyup', function () {
	 	    var searchString = $(this).val();
	 	   jQuery1x('#jstree').jstree(true).search(searchString);
	 	    
	 	});
	 	
	 	//삭제 버튼(x버튼) 클릭 시 요소를 삭제하는것이 아닌 안보이게 바꿈
 		$("#draftAllLineSpace").on("click", ".draft-del-btn", function() {
 		    $(this).closest(".alert").addClass('d-none');
 		  });

});




</script>

<!-- 결재선 설정 자바스크립트 -->

