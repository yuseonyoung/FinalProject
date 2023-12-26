<%--
* [[개정이력(Modification Information)]]
* 수정일         수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 30.      최광식      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <style>
.iText{
	border:none;
	background: transparent;
	text-align: center;
}
.text{
text-align: center;
}
.number{
text-align: right;
}
</style>
    
    <div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<br>
				<h3 class="mb-0">재고조회</h3>
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
		        <p id="searchDate" style="text-align:right;"/>
				<div id="searchUI"  class="row g-3 d-flex justify-content-center" style="float: right;margin-bottom: 10px;">
					<div class="col-auto">
						<select name="searchType" class="form-select">
							<option value>전체</option>
							<option value="itemCd">품목코드</option>
							<option value="itemNm">품목명</option>
							<option value="itemCate">품목그룹</option>
						</select>
					</div>
					<div class="col-auto">
						<input type="text" name="searchWord" placeholder="검색" class="form-control"/>
					</div>
					<div class="col-auto">
						<input type="button" value="검색" id="searchBtn" class="btn btn-primary"/>
					</div>
				</div>
					<table class="table table-bordered  fs--1 mb-0" style="width:100%" >
						<thead class="bg-200 text-900">
							<tr>
								<th class="text itemCd" style="width:10%;">품목코드</th>
								<th class="text itemNm" style="width:16%;">품목명</th>
								<th class="text itemCate" style="width:10%;">카테고리</th>
								<th class="text wareNm" style="width:10%;">창고명</th>
								<th class="text secCd" style="width:10%;">구역</th>
								<th class="text itemSafeQty" style="width:10%;">안전재고수량</th>
								<th class="text itemQty" style="width:8%;">재고수량</th>
								<th class="text itemYn" style="width:8%;">사용여부</th>
							</tr>
						</thead>
						<tbody class="listBody">
	
						</tbody>
						<tfoot>
							<tr><td colspan="8"><span id="pagingArea"></span></td></tr>
						</tfoot>
					</table>
			</div>
		</div>
	</div>
<form action="<c:url value='/item'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" readonly="readonly" placeholder="searchData"/>
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
</form>
	
</div>


<div class="modal fade" id="createWindow" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="createWindowLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" id="createClose"></button>
      </div>
      <div class="modal-body p-0">
        <div class="bg-light rounded-top-3 py-3 ps-4 pe-6">
          <h4 class="mb-1" id="createWindowLabel">품목 상세</h4>
        </div>
        <div class="p-4">
          <div class="row">
            <div class="col-md-6">
                <label for="itemCdInput">품목코드</label>
                <input type="text" id="itemCdInput" name="itemCd" class="form-control" disabled="disabled" />
             </div>
             
             <div class="col-md-6">
               <label for="itemNmInput">품목명</label>
               <input type="text" id="itemNmInput" name="itemNm" class="form-control" disabled="disabled" />
             </div>
            <div class="col-md-6">
                <label for="itemUnitInput">품목단위</label>
                <input type="text" id="itemUnitInput" name="itemUnit" class="form-control" disabled="disabled"  />
            </div>
            <div class="col-md-6">
                <label for="groupInput">품목그룹</label>
                <div style="display: flex; align-items: center;">
                   <input type="text" id="groupInput" name="itemCate" class="form-control" disabled="disabled" />
                </div>
            </div>
            <div class="col-md-6">
                <label for="itemSafeQtyInput">안전재고수량</label>
                <input type="number" id="itemSafeQtyInput" name="itemSafeQty"class="form-control" disabled="disabled" />
            </div>
            <div class="col-md-6">
                <label for="itMakerInput">제조사</label>
                <input type="text" id="itMakerInput" name="itMaker" class="form-control"  disabled="disabled" />
            </div>
            <div class="col-md-6">
                <label for="itWghtInput">무게</label>
                <input type="text" id="itWghtInput" name="itWght" class="form-control" disabled="disabled"  />
            </div>
            <div class="col-md-6">
                <label for="itColorInput">색상</label>
                <input type="text" id="itColorInput" name="itColor" class="form-control"  disabled="disabled" />
            </div>
            <div class="col-md-6">
                <label for="itemInprInput">입고단가</label>
                <input type="number" id="itemInprInput" name="itemInpr" class="form-control" disabled="disabled" />
            </div>
            <div class="col-md-6">
                <label for="itemOutprInput">출고단가</label>
                <input type="number" id="itemOutprInput" name="itemOutpr" class="form-control" disabled="disabled" />
            </div>
            <div class="col-md-6">
                <label for="itemNoteInput">품목적요</label>
                <input type="text" id="itemNoteInput"name="itemNote" class="form-control" disabled="disabled" />
            </div>
            <div class="col-md-6">
                <label for="itemWareInput">보유창고</label>
                <input type="text" id="itemWareInput"name="itemWare" class="form-control" disabled="disabled" />
            </div>
            <div class="col-md-6">
                <label for="itemSectInput">구역</label>
                <input type="text" id="itemSectInput"name="itemSec" class="form-control" disabled="disabled" />
            </div>
            <div class="col-md-12 mt-3 text-end" id="buttonSpace">
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="/resources/js/item/itemInvenCheck.js"></script>