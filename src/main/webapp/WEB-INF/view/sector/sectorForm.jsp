<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자      수정내용
* ----------  ---------  -----------------
* 2023. 11. 7.       유선영      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>



<div class="card mb-3 p-3">
<br/>
<h3 style="margin-bottom: 50px;">창고구역 등록</h3>
<form id="sectorCreate" action="/" method="post">
	<security:csrfInput />
	<div class="row mb-3">
		<label class="col-sm-3 col-form-label" for="inputFloor">도면 이미지 미리보기</label>
		<div class="col-sm-9">
			<input class="form-control" type="file" id="imageUpload" accept="image/*">
		</div>
	</div>
	<div class="row mb-3">
		<label class="col-sm-3 col-form-label" for="inputWareData">창고명</label>
		<div class="col-sm-9">
			<div style="display: flex; align-items: center;">
				<input class="form-control" id="inputWareData" type="text" autocomplete="off" required="required" /> <span id="wareCd"
					class="error"></span> <input type="hidden" id="wareCdData">
				<button id="wareBtn" type="button" class="btn searchBtn p-1">
					<i class="bi bi-search"></i>
				</button>
			</div>
		</div>
	</div>
	<div class="row mb-3">
		<label class="col-sm-3 col-form-label" for="inputFloor">floor</label>
		<div class="col-sm-9">
			<div style="display: flex; align-items: center;">
				<!-- 기본값을 1로 설정한 input 요소 -->
				<input class="form-control" id="inputFloor" min="1"
					type="number" value="1" style="margin-bottom: 0;" />
			</div>
		</div>
	</div>
	<div class="row mb-3">
		<label class="col-sm-3 col-form-label">창고크기(m)</label>
		<label class="col-sm-1 col-form-label">width</label>
		<span class="col-sm-3 col-form-label" id="wareWidthSpan" style="width:28.5% !important"></span>
		<label class="col-sm-1 col-form-label">height</label>
		<span class="col-sm-3 col-form-label" id="wareYSpan" style="width:28.5% !important"></span>
	</div>
	<div class="row mb-3">
		<label class="col-sm-3 col-form-label">섹터크기(m)</label>
		<label class="col-sm-1 col-form-label">width</label>
		<input class="col-sm-3 form-control" id="sectorWidthInput" style="width:28.5% !important" readonly/>
		<label class="col-sm-1 col-form-label">height</label>
		<input class="col-sm-3 form-control" id="sectorYInput"style="width:28.5% !important" readonly/>
	</div>
	<div class="row mb-3">
	<span style="color:blue; font-size:12px; display:none;" id="selectSector"></span>
	<span style="color:blue; font-size:12px; display:none;" id="itemWareSpan"></span>
	<span style="color:red; font-size:12px; display:none;" id="errorSpan">Rect의 크기가 작아 그릴 수 없습니다.</span>
	</div>
	<span style="color:red; font-size:15px;">※ 마우스를 드래그하여 섹터를 그릴수 있고, 가로길이와 세로길이를 이용하여 창고크기 대비 사이즈를 조절할 수 있습니다.</span>
	<canvas id="canvas" width="1160" height="580"
		style="border: 1px solid black; display: none; margin-bottom: 20px;"></canvas>
	<span id="wsecX1" class="error"></span> <span id="wsecX2" class="error"></span>
	<span id="wsecY1" class="error"></span> <span id="wsecY2" class="error"></span>
	<span id="wsecZ" class="error"></span>
	<br>
	<button class="btn btn-primary" type="submit" id="saveBtn"
		style="display: none;">저장</button>
	<button class="btn btn-primary" type="button" id="delBtn"
		style="display: none;">삭제</button>

</form>
</div>

<div class="modal fade" id="wareWindow" tabindex="-1"
	aria-labelledby="wareWindowModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="wareWindowModalLabel">창고 선택</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close" id="wareClose"></button>
			</div>
			<div class="modal-body" id="wareListContainer">
				<table class="table" id="wareTableData">
					<thead>
						<tr>
							<th>창고코드</th>
							<th>창고명</th>
						</tr>
					</thead>
					<tbody id="dataList">

						<c:forEach var="result" items="${wareSecList}">
							<tr>
								<td>${result.wareCd}</td>
								<td><a href="javascript:;" class="selectItem"
									data-selected-value="${result.wareNm}"> ${result.wareNm} </a>
								</td>
								<input type="hidden" class="hiddenWare"
									data-selected-data="${result.wareCd}" />
								<input type="hidden" class="hiddenWare" id="wareWidth"
									data-ware-width="${result.wareWidth}" />
								<input type="hidden" class="hiddenWare" id="wareY"
									data-ware-y="${result.wareY}" />
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>


<script src="<c:url value="/resources/js/sector/sectorCreate.js"/>"></script>