<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h4>주소록 관리</h4>

<div class="w-75">
	<div class="d-flex justify-content-between mb-2">
		<div class="d-flex">
			<button class="col-auto btn btn-outline-secondary btn-sm"
				style="margin-right: 2px;">기존</button>
			<button class="col-auto btn btn-outline-secondary btn-sm">조직도</button>
		</div>
		<div class="d-flex">
			<input class="form-control" type="text" style="margin-right: 3px;"></input>
			<div class="col-auto d-flex order-md-0">
				<button class="btn btn-outline-primary btn-sm">
					<svg class="svg-inline--fa fa-plus fa-w-14 me-2" aria-hidden="true"
						focusable="false" data-prefix="fas" data-icon="plus" role="img"
						xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
						data-fa-i2svg="">
						<path fill="currentColor"
							d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"></path></svg>
					추가
				</button>
			</div>
		</div>
	</div>

	<div class="d-flex justify-content-between"></div>
	<div class="border border-gray bg-white" style="height: 400px;">
		<table class="w-100 table table-bordered border-secondary"
			style="height: 100%;">
			<thead>
				<tr>
					<th>이름</th>
					<th>Email</th>
					<th>직급</th>
					<th>부서</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="4" style="text-align: center;">아무도 없습니다</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>


<div class="w-75 mt-1 d-flex justify-content-end">
	<a href="javascript:history.back()"
		class="btn btn-outline-primary border mr-2">저장</a> <a
		href="javascript:history.back()"
		class="btn btn-outline-primary border cancle">취소</a>
</div>
