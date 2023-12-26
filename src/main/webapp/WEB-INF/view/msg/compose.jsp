<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set value="${msg.empCd}" var="empCd"/>
<form class="card col-lg-8" action="/msg/send?${_csrf.parameterName}=${_csrf.token}" method="post">
	<div class="card-header bg-light">
		<h5 class="mb-0">새 쪽지</h5>
	</div>
	<div class="card-body p-0">
		<div class="border border-top-0 border-200 d-flex">
			<a class="col-3 btn btn btn-light title">제목</a> <input name="title"
				id="msg-title"
				class="form-control border-0 rounded-0 outline-none px-x1"
				type="text" placeholder="title">
		</div>
		<div class="border border-top-0 border-200 d-flex">
			<a class="col-3 btn btn-light to">받는 사람</a> 
			<input class="form-control border-0 rounded-0 outline-none px-x1" id="receiver" type="text" name="receiver" aria-describedby="" value="${empCd}" placeholder="To">
			<button class="btn btn-light btn-sm py-0 mt border" id="jusorok" data-toggle="modal" data-target="#exampleModal" type="button">
				<svg class="svg-inline--fa fa-user-plus fa-w-20"
					data-fa-transform="shrink-5 left-2" aria-hidden="true"
					focusable="false" data-prefix="fas" data-icon="user-plus"
					role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"
					data-fa-i2svg="" style="transform-origin: 0.5em 0.5em;">
					<g transform="translate(320 256)">
					<g transform="translate(-64, 0)  scale(0.6875, 0.6875)  rotate(0 0 0)">
					<path fill="currentColor"
						d="M624 208h-64v-64c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v64h-64c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h64v64c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16v-64h64c8.8 0 16-7.2 16-16v-32c0-8.8-7.2-16-16-16zm-400 48c70.7 0 128-57.3 128-128S294.7 0 224 0 96 57.3 96 128s57.3 128 128 128zm89.6 32h-16.7c-22.2 10.2-46.9 16-72.9 16s-50.6-5.8-72.9-16h-16.7C60.2 288 0 348.2 0 422.4V464c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48v-41.6c0-74.2-60.2-134.4-134.4-134.4z"
						transform="translate(-320 -256)"></path></g></g></svg>
			</button> 
		</div>
		<input type="hidden" name="ctxt" id="ctxt" value="">
		<div class="min-vh-50">
			<textarea class="tinymce d-none" name="brdContent" id="msg-text"
				data-tinymce="data-tinymce" name="content" placeholder="내용을 입력해주세요">
			</textarea>
		</div>
	</div>
	<div
		class="card-footer border-top border-200 d-flex flex-between-center">
		<div class="d-flex align-items-center">
			<button class="btn btn-falcon-default btn-sm" type="button" id="msg-send"> <span class="d-none d-sm-inline-block ms-1">보내기</span></button>
			<input class="d-none" id="email-image" type="file" accept="image/*">
			
		</div>
		<div class="d-flex align-items-center">
			<div class="col-auto d-flex align-items-center">
				<a class="btn btn-falcon-default btn-sm" href="javascript:history.back()"><svg class="svg-inline--fa fa-reply fa-w-16" data-fa-transform="down-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="reply" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="" style="transform-origin: 0.5em 0.625em;">
						<g transform="translate(256 256)">
						<g transform="translate(0, 64)  scale(1, 1)  rotate(0 0 0)">
						<path fill="currentColor" d="M8.309 189.836L184.313 37.851C199.719 24.546 224 35.347 224 56.015v80.053c160.629 1.839 288 34.032 288 186.258 0 61.441-39.581 122.309-83.333 154.132-13.653 9.931-33.111-2.533-28.077-18.631 45.344-145.012-21.507-183.51-176.59-185.742V360c0 20.7-24.3 31.453-39.687 18.164l-176.004-152c-11.071-9.562-11.086-26.753 0-36.328z" transform="translate(-256 -256)"></path></g></g></svg> <!-- <span class="fas fa-reply" data-fa-transform="down-2"></span> Font Awesome fontawesome.com -->
					<span class="d-none d-sm-inline-block ms-1">뒤로가기</span></a>
			</div>
		</div>
	</div>
	<sec:csrfInput/>
</form>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 600px;" role="document">
		<div class="modal-content">
			<div class="modal-body">...</div>
		</div>
	</div>
</div>

<script>
	const dispatch = `${dispatch}`;
</script>
<script src="/resources/js/msg/msg-compose.js"></script>