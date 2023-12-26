<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class=" d-flex justify-content-between">
<h4>주소록</h4>
<button id="book-manage" class="btn btn-outline-primary border border-white btn-sm">주소록 관리</button>
</div>
<div class="d-flex mr-3 mt-1">
	<div class="" style="width: 350px;">
		<div class="card mb-1">
			<div class="card-body d-flex justify-content-between bg-light">
				<div>
					<select class="form-control">
						<option>전체</option>
						<option>사용자 정의</option>
					</select>
				</div>
			</div>
		</div>
		<div id="certificate" class="border border-gray bg-white"
			style="width: 100%; height: 448px;"></div>
	</div>

	<div class="mt-2" style="width: 410px;">

		<div class="d-flex align-items-center">
			<div class="d-flex flex-column mx-auto">
				<button class="btn btn-outline-secondary btn-sm mb-1"> > </button>
				<button class=" btn btn-outline-secondary btn-sm"> < </button>
			</div>
			<div class="w-75">
				<div class="card mb-1">
					<div class="card-body d-flex justify-content-between bg-light">
						<div>받는 사람</div>
					</div>
				</div>
				<div id="tech" class="border border-gray bg-white"
					style="height: 100px;"></div>
			</div>
		</div>

		<div class="d-flex align-items-center">
			<div class="d-flex flex-column mx-auto">
				<button class="btn btn-outline-secondary btn-sm mb-1"> > </button>
				<button class=" btn btn-outline-secondary btn-sm"> < </button>
			</div>
			<div class="w-75 mt-2">
				<div class="card mb-1">
					<div class="card-body d-flex justify-content-between bg-light">
						<div>참조</div>
					</div>
				</div>
				<div id="tech" class="border border-gray bg-white"
					style="height: 100px;"></div>
			</div>
		</div>

		<div class="d-flex align-items-center">
			<div class="d-flex flex-column mx-auto">
				<button class="btn btn-outline-secondary btn-sm mb-1"> > </button>
				<button class=" btn btn-outline-secondary btn-sm"> < </button>
			</div>
			<div class="w-75 mt-2">
				<div class="card mb-1">
					<div class="card-body d-flex justify-content-between bg-light">
						<div>숨은 참조</div>
					</div>
				</div>
				<div id="tech" class="border border-gray bg-white"
					style="height: 100px;"></div>
			</div>
		</div>

	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="address-manage" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 600px;" role="document">
		<div class="modal-content">
			<div class="modal-body">...</div>
		</div>
	</div>
</div>

<div class="d-flex justify-content-center align-items-center mt-2">
	<button class="btn btn-outline-primary btn-sm border" style="margin-right: 2px;">저장</button>
	<button id="book-cancle" class="btn btn-outline-warning border btn-sm">취소</button>
</div>

<script>
	$('#book-cancle').on('click',()=>{
		$('#exampleModal').modal('hide');
	});
	
	$('#book-manage').on('click',()=>{
// 		window.open('/address/manage','_blank','width=600,height=500')
		location.href="/address/manage"
	});
</script>