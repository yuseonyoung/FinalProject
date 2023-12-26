

<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 14.       김도현      최초작성
* 2023. 11. 20.		  김도현		상세조회 모달창 작성
* 2023. 11. 20. 	  김도현		상세조회 담당자, 품목 모달창 추가
* 2023. 11. 22.  	  김도현		엑셀 다운로드 버튼 및 POI script 코드 추가 
*
* Copyright (c) 2023 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script>
	$(document).ready(function() {
		// 불량재고 조회 페이지에 들어갔을 때
		// 불량관리 버튼이 열려있도록 collapse 클래스에 show 클래스 추가
		$('#sale').addClass('show');
	});
</script>

<style>
     #saleListDataTable th, #saleListDataTable td.saleCd,
     #saleListDataTable td.saleDate,
     #saleListDataTable td.empNm,
     #saleListDataTable td.itemNm,
     #saleListDataTable td.comNm{
        text-align: center;
    }
    
    .iText{
			border:none;
		}
</style>

<div class="card mb-3 px-3">
		<div class="card-header ">
				<div class="row flex-between-end">
					<div class="col-auto align-self-center">
					<br/>
						<h3 class="mb-0">판매 조회</h3>
					</div>
					<div class="col-auto ms-auto">
						<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2" role="tablist"></div>
					</div>
				</div>
			</div>
<div class="card-body pt-0 ">
		<div class="tab-content">
			<div class="tab-pane preview-tab-pane active" role="tabpanel" aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
				id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">
					<div class="table-responsive scrollbar">
						<table class="table table-bordered table fs--1 mb-0" id="saleListDataTable">
							<thead class="bg-200 text-900">
								<tr>
									<th class="saleCd text-center" style="width: 80px;">판매코드</th>
									<th class="saleDate">판매일자</th>
									<th class="comNm">거래처명</th>
									<th class="empNm">담당자</th>
									<th class="itemNm">품목</th>
									<th class="saleQty" style="width: 100px;">수량</th>
									<th class="saleUprc" style="width: 100px;">단가</th>
									<th class="saleAmount" style="width: 100px;">합계</th>
									<th class="saleStat">진행여부</th>
									
									
								</tr>
							</thead>
							<tbody class="list">
							
							</tbody>		
						</table>
						  <div >
        <button class="btn btn-primary" onclick="downloadExcel()">EXCEL</button>
    </div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 엑셀 다운로드 버튼 추가 -->
    <!-- <div class="card-footer">
        <button class="btn btn-primary" onclick="downloadExcel()">EXCEL</button>
    </div> -->

<!-- POI script 코드 -->
<script>
    function downloadExcel() {
        // JSP 페이지의 URL
        var downloadUrl = '/sale/downloadExcel';

        // 새로운 a 엘리먼트 생성
        var link = document.createElement('a');
        link.href = downloadUrl;
        link.target = '_blank';

        // 클릭 이벤트를 시뮬레이트하여 다운로드를 시작
        if (document.createEvent) {
            var event = document.createEvent('MouseEvents');
            event.initEvent('click', true, true);
            link.dispatchEvent(event);
        } else {
            link.click();
        }
    }
</script>

	<!-- 모달 -->
<div class="modal fade" id="saleModal" tabindex="-1" aria-labelledby="saleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <!-- 모달 내용 -->
            <div class="modal-header">
                <h5 class="modal-title" id="saleModalLabel">판매 상세 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" 
                aria-label="Close"></button>
            </div>
            <form action="/sale/saleUpdate" id="saleForm" action="post">
				<div class="table-responsive scrollbar">
					<div class="modal-body">
                <!-- 모달 내용이 들어갈 자리 -->
            </div>
            <div class="modal-footer">
            <button
				class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1"
				type="submit" id="updateBtn" style="">수정</button>
                <button type="button" class="btn btn-secondary" 
                data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
        	<sec:csrfInput/>
        </form>
    </div>
</div>
</div>
<!-- 담당자 검색 모달 -->
<div class="modal fade" id="findEmpModal" tabindex="-1"aria-labelledby="findEmpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findEmpModalLabel">담당자 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered table fs--1 mb-0" id="findEmpDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>사원코드</th>
								<th>담당자명</th>
								<th>부서</th>
								<th>연락처</th>
							</tr>
						</thead>
						<tbody class="list">
						
						</tbody>
							
					</table>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 거래처명 검색 모달 -->
<div class="modal fade" id="findComModal" tabindex="-1"aria-labelledby="findComModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findComModalLabel">거래처명 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<table class="table table-bordered table fs--1 mb-0" id="findComDataTable">
						<thead class="bg-200 text-900">
							<tr>
								<th>거래처코드</th>
								<th>거래처명</th>
							</tr>
						</thead>
						<tbody class="list">
						
						</tbody>
							
					</table>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<!-- 품목정보 검색 모달1 품목코드 눌럿을 때 -->
<!-- <div class="modal fade" id="findItemModal1" tabindex="-1"aria-labelledby="findItemModalLabel1" aria-hidden="true"> -->
<!-- 	<div class="modal-dialog modal-lg"> -->
<!-- 		<div class="modal-content"> -->
			<!-- 모달 내용 --> 
<!-- 			<div class="modal-header"> -->
<!-- 				<h5 class="modal-title" id="findItemModalLabel1">품목 검색</h5> -->
<!-- 				<button type="button" class="btn-close" data-bs-dismiss="modal" -->
<!-- 					aria-label="Close"></button> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body"> -->
<!-- 				모달 내용이 들어갈 자리 -->
<!-- 				<table class="table table-bordered table-striped fs--1 mb-0" id="findItemDataTable1"> -->
<!-- 						<thead class="bg-200 text-900"> -->
<!-- 							<tr> -->
<!-- 								<th >품목코드</th> -->
<!-- 								<th >품목명</th> -->
								
<!-- 							</tr> -->
<!-- 						</thead> -->
<!-- 						<tbody class="list"> -->
						
<!-- 						</tbody> -->
<!-- 					</table> -->
<!-- 			</div> -->
<!-- 			<div class="modal-footer"> -->
<!-- 				<button type="button" class="btn btn-secondary" -->
<!-- 					data-bs-dismiss="modal">닫기</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<!-- 품목정보 검색 모달2 품목명 눌럿을때 -->
<div class="modal fade" id="findItemModal2" tabindex="-1"aria-labelledby="findItemModalLabel2" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- 모달 내용 -->
			<div class="modal-header">
				<h5 class="modal-title" id="findItemModalLabel2">품목 검색</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<!-- 모달 내용이 들어갈 자리 -->
				<div id="searchUI"  class="row g-3 d-flex justify-content-center" style="float: right;margin-top: 5px;">
			<div class="col-auto">
					<select name="searchType" class="form-select">
						<option value="">전체</option>
						<option value="itemCd">품목코드</option>
						<option value="itemNm">품목명</option>
					</select>
				</div>
				<div class="col-auto">
					<input type="text" name="searchWord" placeholder="검색" class="form-control"/>
				</div>
				<div class="col-auto">
					<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
				</div>
			</div>
				<table class="table table-bordered table fs--1 mb-0" id="findItemDataTable2">
						<thead class="bg-200 text-900">
							<tr>
								<th >품목코드</th>
								<th >품목명</th>
								<th >재고수량</th>
							</tr>
						</thead>
						<tbody class="itemList">
						
						</tbody>
						<tfoot class="pagingHtml">
							<tr><td colspan="2"><span id="pagingArea"></span></td></tr>
						</tfoot>
					</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<form action="<c:url value='/sale/listView'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" id="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" id="searchWord" readonly="readonly" placeholder="searchData"/>
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
</form>
<script src="/resources/js/sale/sale.js"></script>

<script>
function fn_paging(page) {
	searchForm.page.value = page;
	searchForm.requestSubmit();
	searchForm.page.value = "";
}
</script>

