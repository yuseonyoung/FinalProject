<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 7.       유선영      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="card mb-3 px-3">
	<div class="card-header ">
		<div class="row flex-between-end">
			<div class="col-auto align-self-center">
				<h3 class="mb-0">품목 조회</h3>
			</div>
			<div id="searchUI"  class="row g-3 d-flex justify-content-end" style="float: right; margin-top:5px;">
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
				<div id="tableExample3">
				<div class="table-responsive scrollbar">
					<table class="table table-bordered  fs--1 mb-0">
						<thead class="bg-200 text-900">
								<tr>
									<th class="sort">품목코드</th>
									<th class="sort">품목명</th>
									<th class="sort">품목단위</th>
									<th class="sort">품목그룹</th>
									<th class="sort">입고단가</th>
									<th class="sort">출고단가</th>
								</tr>
						</thead>
						<tbody class="list">
							
						</tbody>
						<tfoot>
							<tr><td colspan="6"><span id="pagingArea"></span></td></tr>
						</tfoot>
					</table>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1 mt-3 float-end" type="button" id="createBtn">신규등록</button>
					<button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1 mt-3 float-end" type="button" id='unUsebtn'>미사용 품목 조회</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<form action="<c:url value='/item'/>" id="searchForm" class="border">
	<input type="hidden" name="searchType" id="searchType" readonly="readonly" placeholder="searchNm"/>
	<input type="hidden" name="searchWord" id="searchWord" readonly="readonly" placeholder="searchData"/>
	<input type="hidden" id="currpage" name="page" readonly="readonly" placeholder="page"/>
	<input type="hidden" id="itemYnData" name="itemYn" value="Y">
</form>

<div class="modal fade" id="createWindow" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="createWindowLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close" id="createClose"></button>
      </div>
      <div class="modal-body p-0">
        <div class="bg-light rounded-top-3 py-3 ps-4 pe-6">
          <h4 class="mb-1" id="createWindowLabel">품목 등록</h4>
        </div>
        <div class="p-4">
          <div class="row">
          <c:url value="/item" var="itemUrl"/>
            <form class="row g-2" action="${itemUrl}" id="itemForm">   
            <div class="col-md-6">
                <label for="itemCdInput">품목코드</label>
                <input type="text" id="itemCdInput" name="itemCd" class="form-control" required/>
                <span id="itemCdError" class="error"></span>
             </div>
             
             <div class="col-md-6">
               <label for="itemNmInput">품목명</label>
               <input type="text" id="itemNmInput" name="itemNm" class="form-control" required/>
               <span id="itemNmError" class="error"></span>
             </div>
            <div class="col-md-6">
                <label for="itemUnitInput">품목단위</label>
                <input type="text" id="itemUnitInput" name="itemUnit" class="form-control" required />
                <span id="itemUnitError" class="error"></span>
            </div>
            <div class="col-md-6">
                <label for="groupInput">품목그룹</label>
                <div style="display: flex; align-items: center;">
                   <input type="text" id="groupNmInput" name="itCateNm" class="form-control" required/>
                   <input type="hidden" id="groupCdInput" name="itemCate" class="form-control" required/>
                   <button type='button' id="groupBtn" class="btn searchBtn p-1"><i class="bi bi-search"></i></button>
                </div>
                <span id="itemCateError" class="error"></span>
            </div>
            <div class="col-md-6">
                <label for="itemSafeQtyInput">안전재고수량</label>
                <input type="number" id="itemSafeQtyInput" name="itemSafeQty"class="form-control"/>
                <span id="itemSafeQtyError" class="error"></span>
            </div>
            <div class="col-md-6">
                <label for="itMakerInput">제조사</label>
                <input type="text" id="itMakerInput" name="itMaker" class="form-control" />
                <span id="itMakerError" class="error"></span>
            </div>
            <div class="col-md-6">
                <label for="itWghtInput">무게</label>
                <input type="text" id="itWghtInput" name="itWght" class="form-control" />
                <span id="itWghtError" class="error"></span>
            </div>
            <div class="col-md-6">
                <label for="itColorInput">색상</label>
                <input type="text" id="itColorInput" name="itColor" class="form-control" />
                <span id="itColorError" class="error"></span>
            </div>
            <div class="col-md-6">
                <label for="itemInprInput">입고단가</label>
                <input type="text" id="itemInprInput" name="itemInpr" class="form-control"/>
                <span id="itemInprError" class="error"></span>
            </div>
            <div class="col-md-6">
                <label for="itemOutprInput">출고단가</label>
                <input type="text" id="itemOutprInput" name="itemOutpr" class="form-control"/>
                <span id="itemOutprError" class="error"></span>
            </div>
            <div class="col-md-12">
                <label for="itemNoteInput">품목적요</label>
                <input type="text" id="itemNoteInput" name="itemNote" class="form-control" />
                 <span id="itemNoteError" class="error"></span>
            </div>
            <div class="col-md-12 mt-3 text-end" id="buttonSpace">
               <button class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1" type="submit" id="insertBtn">저장하기</button>
            </div>
         </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 품목그룹 모달창 -->
<div class="modal fade" id="groupWindow" tabindex="-1" aria-labelledby="groupWindowModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="groupWindowModalLabel">품목 그룹 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="groupClose"></button>
      </div>
      <div class="modal-body" id="codeListContainer">
        <table class="table">
          <thead>
            <tr>
              <th>코드</th>
              <th>이름</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="commcode" items="${commcodeList}">
              <tr>
                <td class='commCd'>${commcode.commCd}</td>
                <td>
		            <a href="javascript:;" class="selectItem" data-selected-value="${commcode.commCdNm}">
		               ${commcode.commCdNm}
		            </a>
		        </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.serializeJSON/3.2.1/jquery.serializejson.min.js"></script>
 -->
<c:url value="/resources/js/item/item.js" var="urls" />
<script src="${urls}">

</script>

