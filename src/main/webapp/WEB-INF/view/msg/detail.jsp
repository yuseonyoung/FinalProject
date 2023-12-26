<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set value="${msg}" var="msg" />
<div class="card mb-3">
	<div class="card-header border border-light">
		<h3>쪽지보기</h3>
	</div>
	<div class="card-body d-flex justify-content-between">
		<div>
			<a class="btn btn-falcon-default btn-sm" href="/msg/inbox" data-bs-toggle="tooltip"
				data-bs-placement="top" aria-label="뒤로가기"
				data-bs-original-title="뒤로가기"><svg
					class="svg-inline--fa fa-arrow-left fa-w-14" aria-hidden="true"
					focusable="false" data-prefix="fas" data-icon="arrow-left"
					role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
					data-fa-i2svg="">
					<path fill="currentColor"
						d="M257.5 445.1l-22.2 22.2c-9.4 9.4-24.6 9.4-33.9 0L7 273c-9.4-9.4-9.4-24.6 0-33.9L201.4 44.7c9.4-9.4 24.6-9.4 33.9 0l22.2 22.2c9.5 9.5 9.3 25-.4 34.3L136.6 216H424c13.3 0 24 10.7 24 24v32c0 13.3-10.7 24-24 24H136.6l120.5 114.8c9.8 9.3 10 24.8.4 34.3z"></path></svg>
			</a><span class="mx-1 mx-sm-2 text-300">|</span>
			<c:if test="${msg.msgStat!='V003'||msg.msgStat!='V004'}">
				<button class="btn btn-falcon-default btn-sm ms-1 ms-sm-2" id="msg-delete"
					type="button" data-bs-toggle="tooltip" data-bs-placement="top"
					aria-label="Delete" data-bs-original-title="Delete">
					<svg class="svg-inline--fa fa-trash-alt fa-w-14" aria-hidden="true"
						focusable="false" data-prefix="fas" data-icon="trash-alt"
						role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
						data-fa-i2svg="">
						<path fill="currentColor"
							d="M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V128H32zm272-256a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zM432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16z"></path></svg>
				</button>
			</c:if>
			
		</div>
		<div class="d-flex">
			<div class="dropdown font-sans-serif">
				<button id="msg-set"
					class="btn btn-falcon-default text-600 btn-sm dropdown-toggle dropdown-caret-none ms-2"
					type="button" id="email-settings" data-bs-toggle="dropdown"
					data-boundary="viewport" aria-haspopup="true" aria-expanded="false">
					<svg class="svg-inline--fa fa-cog fa-w-16" aria-hidden="true"
						focusable="false" data-prefix="fas" data-icon="cog" role="img"
						xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
						data-fa-i2svg="">
						<path fill="currentColor"
							d="M487.4 315.7l-42.6-24.6c4.3-23.2 4.3-47 0-70.2l42.6-24.6c4.9-2.8 7.1-8.6 5.5-14-11.1-35.6-30-67.8-54.7-94.6-3.8-4.1-10-5.1-14.8-2.3L380.8 110c-17.9-15.4-38.5-27.3-60.8-35.1V25.8c0-5.6-3.9-10.5-9.4-11.7-36.7-8.2-74.3-7.8-109.2 0-5.5 1.2-9.4 6.1-9.4 11.7V75c-22.2 7.9-42.8 19.8-60.8 35.1L88.7 85.5c-4.9-2.8-11-1.9-14.8 2.3-24.7 26.7-43.6 58.9-54.7 94.6-1.7 5.4.6 11.2 5.5 14L67.3 221c-4.3 23.2-4.3 47 0 70.2l-42.6 24.6c-4.9 2.8-7.1 8.6-5.5 14 11.1 35.6 30 67.8 54.7 94.6 3.8 4.1 10 5.1 14.8 2.3l42.6-24.6c17.9 15.4 38.5 27.3 60.8 35.1v49.2c0 5.6 3.9 10.5 9.4 11.7 36.7 8.2 74.3 7.8 109.2 0 5.5-1.2 9.4-6.1 9.4-11.7v-49.2c22.2-7.9 42.8-19.8 60.8-35.1l42.6 24.6c4.9 2.8 11 1.9 14.8-2.3 24.7-26.7 43.6-58.9 54.7-94.6 1.5-5.5-.7-11.3-5.6-14.1zM256 336c-44.1 0-80-35.9-80-80s35.9-80 80-80 80 35.9 80 80-35.9 80-80 80z"></path></svg>
					<!-- <span class="fas fa-cog"></span> Font Awesome fontawesome.com -->
				</button>
				<div class="dropdown-menu dropdown-menu-end border py-2" id="msg-setting"
					aria-labelledby="email-settings">
					<a class="dropdown-item" href="#!">Configure inbox</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#!">Settings</a><a
						class="dropdown-item" href="#!">Themes</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#!">Send feedback</a><a
						class="dropdown-item" href="#!">Help</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="card">
	<div class="card-header">
		<div class="row">
			<div class="col-md d-flex">
				<div class="avatar avatar-2xl">
					<img class="rounded-circle" src="${msg.empImg}"
						alt="">
				</div>
				<div class="flex-1 ms-2">
					<h5 class="mb-0">${msg.msgTitle}</h5>
					<a class="text-800 fs--1" href="/msg/compose?empCd=${msg.empCd}">
						<span class="fw-semi-bold">${msg.deptNm} ${msg.hrGradeNm} ${msg.empNm}</span>
						<span class="ms-1 text-500">&lt; ${msg.sender}&gt;</span>
					</a>
				</div>
			</div>
			<div
				class="col-md-auto ms-auto d-flex align-items-center ps-6 ps-md-3">
				<small>${msg.msgDate}</small>
			</div>
		</div>
	</div>
	<div class="card-body border border-light" style="height: 50vh; overflow-x: hidden; overflow-y: auto">
		<div class="row justify-content">
			<div class="col-lg-8 col-xxl-6">
				<div class="card shadow-none mb-3">
					<img class="card-img-top"
						src="../../assets/img/icons/spot-illustrations/international-women-s-day-2.png"
						alt="">
					<div class="card-body">
					${msg.msgCont}
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="card-footer">
		<div class="row justify-content-between">
			<div class="col">
				<a class="btn btn-falcon-default btn-sm" id="msg-answer" data-bs-toggle="modal" data-bs-target="#exampleModal"> <span
					class="d-none d-sm-inline-block ms-1">답장하기</span></a><a
					class="btn btn-falcon-default btn-sm ms-2"
					href="../../app/email/compose.html"><svg
						class="svg-inline--fa fa-location-arrow fa-w-16"
						data-fa-transform="down-2" aria-hidden="true" focusable="false"
						data-prefix="fas" data-icon="location-arrow" role="img"
						xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
						data-fa-i2svg="" style="transform-origin: 0.5em 0.625em;">
						<g transform="translate(256 256)">
						<g transform="translate(0, 64)  scale(1, 1)  rotate(0 0 0)">
						<path fill="currentColor"
							d="M444.52 3.52L28.74 195.42c-47.97 22.39-31.98 92.75 19.19 92.75h175.91v175.91c0 51.17 70.36 67.17 92.75 19.19l191.9-415.78c15.99-38.39-25.59-79.97-63.97-63.97z"
							transform="translate(-256 -256)"></path></g></g></svg> <!-- <span class="fas fa-location-arrow" data-fa-transform="down-2"></span> Font Awesome fontawesome.com -->
					<span class="d-none d-sm-inline-block ms-1">전달하기</span></a>
			</div>
			<div class="col-auto d-flex align-items-center">
				<a class="btn btn-falcon-default btn-sm"
					href="javascript:history.back()"><svg
						class="svg-inline--fa fa-reply fa-w-16" data-fa-transform="down-2"
						aria-hidden="true" focusable="false" data-prefix="fas"
						data-icon="reply" role="img" xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 512 512" data-fa-i2svg=""
						style="transform-origin: 0.5em 0.625em;">
						<g transform="translate(256 256)">
						<g transform="translate(0, 64)  scale(1, 1)  rotate(0 0 0)">
						<path fill="currentColor"
							d="M8.309 189.836L184.313 37.851C199.719 24.546 224 35.347 224 56.015v80.053c160.629 1.839 288 34.032 288 186.258 0 61.441-39.581 122.309-83.333 154.132-13.653 9.931-33.111-2.533-28.077-18.631 45.344-145.012-21.507-183.51-176.59-185.742V360c0 20.7-24.3 31.453-39.687 18.164l-176.004-152c-11.071-9.562-11.086-26.753 0-36.328z"
							transform="translate(-256 -256)"></path></g></g></svg> <!-- <span class="fas fa-reply" data-fa-transform="down-2"></span> Font Awesome fontawesome.com -->
					<span class="d-none d-sm-inline-block ms-1">뒤로가기</span></a>

			</div>
		</div>
	</div>
</div>

<script>

	var csrfToken = $("input[name='_csrf']").val();
	
	$('#msg-answer').on('click',()=>{
		location.href="/msg/compose?empCd=${msg.empCd}"
	});
	
	$('#msg-delete').on('click',()=>{
		$.ajax({
			url:'/msg/trashSet',
			type:'post',
			data:{
				memoNo: `${msg.msgNo}`
			},
			headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	            'X-CSRF-TOKEN': csrfToken
	        },
	        success:(res)=>{
	        	location.href="/msg/inbox";
	        },
		});
	});
	
	$('#msg-set').on('click',()=>{
		if(`${msg.msgStat}`=='V003'){
			var html = "";
			html += `<a class="dropdown-item" href="#!" id="restore">복원하기</a>`;
			$('#msg-setting').html(html);
		}
		
		$('#restore').on('click',()=>{
			$.ajax({
				url:'/msg/restore',
				type:'get',
				data:{
					msgNo:`${msg.msgNo}`
				},
				headers: {
		            'Content-Type': 'application/x-www-form-urlencoded',
		            'X-CSRF-TOKEN': csrfToken
		        },
				success:(res)=>{
					location.href="/msg/inbox";
				},
			});
		});
	});
	
	
</script>