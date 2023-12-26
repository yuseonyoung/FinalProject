<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<!-- <script type="text/javascript" src="/resources/js/jquery.min.js"></script> -->
<script type="text/javascript">
 <!--  [[개정이력(Modification Information)]]       -->
<!--  수정일        수정자     수정내용               -->
<!--  ==========   ======    ==============        -->
<!--  2023. 11. 21.}     황수빈     최초작성               -->
<!--  Copyright (c) 2023 by DDIT All right reserved -->
<!-- 게시판에서 공지사항 누르면 나오는 리스트 페이지  -->


$(function(){
	dataType:"json",
	sucess:function(rsult){
		
		console.log("result8 : ",result);
		
		$.each(result,function(index,noticeVO){
			console.log(noticeVO)
		});
	}
	
});

$('#dataTable').DataTable({
    paging: true,
    searching: true,
    lengthChange: false,
    info: false,
    ordering: false,
    
});
})
		
	
	<!-- 페이징 끝 -->
	
</script>
<div id="listBody">



	<style>
input {
	border: none;
}
.btn btn-info btn-flat{
	height: 30px;
}
</style>
	<div class="card mb-3 px-3">
		<div class="card-header ">
			<div class="row flex-between-end">
				<div class="col-auto align-self-center">
					<br>
					<h3 class="mb-0">공지사항</h3>
					<sec:authorize access="isAuthenticated()">
						<!-- 로그인 정보를 realUser 변수에 저장 -->
						<sec:authentication property="principal.realUser" var="realUser" />
					</sec:authorize>
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
					<div>
						<div id="relsList" class="dataTables_wrapper dt-bootstrap5 no-footer">
							<div class="row">
								<div class="col-sm-12 col-md-6"></div>
								<div class="col-sm-12 col-md-6">
								<form id="frm" name="frm" action="/notice/list" method="get">
									<div id="relsListDataTable_filter" class="dataTables_filter">
										<label>Search:
											<input type="hidden" id="currentPage" name="currentPage" value="1" />
											<input type="text" name="keyword" class="form-control form-control-sm" 
											value="${param.keyword}" placeholder="검색어를 입력해주세요"
											aria-controls="relsListDataTable" />
											<button type="submit" class="btn btn-info btn-flat">검색</button>
										</label>
									</div>
								</form>
								</div>
							</div>
							<div class="row dt-row" style="text-align: center;">
								<div class="col-sm-12">
									<table class="table table-bordered fs--1 mb-0 dataTable no-footer"
										id="rels">
										<thead class="bg-200 text-900">
											<tr>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width:15%;text-align:center;">번호</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 30%;text-align:center;">제목</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 10%;text-align:center;">등록날짜</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 10%;text-align:center;">조회수</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 15%;text-align:center;">작성자</th>
											</tr>
										</thead>
										<tbody class="list2">
											<!-- data : paging -->
											<c:forEach var="noticeExVO" items="${data.dataList}">
											<tr class="odd">
												<td class="pordCdValue">${noticeExVO.rnum1}</td>
												<td><a
		href="/notice/pageDetail?ntcNo=${noticeExVO.ntcNo }"
		style="color: gray; text-decoration: none;">
			${noticeExVO.ntcTitle}</a></td>
												<td>${noticeExVO.ntcRdate }</td>
												<td>${noticeExVO.ntcHit }</td>
												<td>
<c:if test="${noticeExVO.empAuth eq 'admin' }">
	관리자
</c:if>
<c:if test="${noticeExVO.empAuth ne 'admin' }">
	${noticeExVO.empNm }
</c:if>
												</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="card-footer clearfix">
								
								<div style="float: left;justify-content;left;display:flex;" id="btnCreate">
								<c:if test="${realUser.empAuth=='admin'}">
									<a href="/notice/pageCreate" 
										class="btn btn-primary px-4 ms-2" type="button"
										data-list-pagination="next"><span>등록</span></a>
								</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

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
								<div class="tab-pane preview-tab-pane active" role="tabpanel"
									aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
									id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">

									<div class="table-responsive scrollbar">
										<table class="table table-bordered fs--1 mb-0">
											<thead class="bg-200 text-900">
												<tr>
													<th>일자</th>
													<td><input type="date" id="pordDate"
														placeholder="작성일자" style="width: 170px;"></td>
													<th>담당자</th>
													<td><input type="text" id="empNm" placeholder="담당자"
														style="width: 170px;"></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<th>거래처</th>
													<td><input type="text" id="comNm" placeholder="거래처명"
														style="width: 170px;"></td>
													<th>납기일자</th>
													<td><input type="date" id="dueDate" placeholder="납기일자"
														style="width: 170px;"></td>
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
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="/resources/js/scheduledStock/inScheduledStock.js"></script>
</div>
<hr />
<!-- 폼태그 -->
<!-- 
요청URI : /notice/list3?gubun=subinNm&keyword=P101
요청파라미터 : gubun=&keyword=
요청방식 : get
 -->
<h2 style="display:none;">공지 사항</h2>
<!-- <h3> ${param.gubun}</h3> -->
<!-- <h3> ${param.keyword}</h3>-->
<!-- 
요청URI : /notice/list
요청파라미터 : keyword=개똥이
요청방식 : get
 -->
<form style="display:none;" id="frm" name="frm" action="/notice/list" method="get">
	<%-- <p>${data}</p> --%>
	<!-- 폼데이터 -->
	<div class="input-group input-group-sm">
		<input type="hidden" id="currentPage" name="currentPage" value="1" />
		<input type="text" name="keyword" class="form-control"
			value="${param.keyword}" placeholder="검색어를 입력해주세요" /> <span
			class="input-group-append">
			<button type="submit" class="btn btn-info btn-flat">검색</button>
		</span>
	</div>
	<hr />

	<div class="card">
		<div class="card-header">
			<h3 class="card-title"></h3>
		</div>
		<div class="card-body">
			<!-- model.addAttribute("data", data) -->

			<table class="table table-bordered" id="dataTable">
				<thead>
					<tr>
						<th style="width: 20%; text-align: center;">번호</th>
						<th style="width: 40%; text-align: center;">제 목</th>
						<th style="width: 10%; text-align: center;">등록 날짜</th>
						<th style="width: 10%; text-align: center;">조회수</th>
						<th style="width: 15%; text-align: center;">작성자</th>
					</tr>
				</thead>
				<tbody>
					<!-- data : paging -->
					<c:forEach var="noticeExVO" items="${data.dataList}">
						<tr>

							<td style="text-align: center;">${noticeExVO.ntcNo }</td>


							<td id="" style="text-align: center;"><a
								href="/notice/pageDetail?ntcNo=${noticeExVO.ntcNo }"
								style="color: gray; text-decoration: none;">
									${noticeExVO.ntcTitle}</a></td>
							<td style="text-align: center;">${noticeExVO.ntcRdate }</td>
							<td style="text-align: center;">${noticeExVO.ntcHit }</td>
							<c:if test="${noticeExVO.empAuth eq 'admin' }">
								<td style="text-align: center;">관리자</td>
							</c:if>
							<c:if test="${noticeExVO.empAuth ne 'admin' }">
								<td style="text-align: center;">${noticeExVO.empNm }</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="card-footer clearfix">
			${data.getPagingHTML()}
			<div style="float: right;">
					<a href="/notice/pageCreate"
						class="btn btn-sm btn-primary px-4 ms-2" type="button"
						data-list-pagination="next"><span>등록</span></a>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">
function fn_paging(currentPage){
	console.log("currentPage : " + currentPage);
	
	$("#currentPage").val(currentPage);
	
	$("#frm").submit();
}


	<!-- 여기가 등록 버튼 사용자에 따라 숨겨지는거 -->
	$("#btnCreate").css("visibility", "visible"); // 일단 버튼을 숨김

	// 사용자의 권한을 비동기적으로 얻어옴
	$.ajax({
	    url: "/board/pageDetailUpdatePost",
	    contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
	    success: function(result){
			console.log("result : ",result);
	        // result에 사용자의 권한이 들어있다고 가정

	        // 권한에 따라 버튼을 표시하거나 숨김
	        if (result.empAuth == "admin") {
	            $("#btnCreate").css("visibility", "visible");
	        }
	    },
	    error: function (error) {
	        console.error('Failed to fetch user permission:', error);
	    }
	});

	<!-- 여기까지가 등록 버튼 사용자에 따라 숨겨지는거 -->
</script>

