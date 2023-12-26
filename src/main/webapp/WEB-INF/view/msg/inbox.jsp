<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<div class="card col-lg-11">
	<div class="card-header">
	<h3 class="mb-3">쪽지함</h3>
		<div class="row align-items-center">
			<div class="col d-flex align-items-center">
				<button class="btn btn-falcon-default btn-sm ms-sm-1" type="button" onclick="location.reload()">
					<svg class="svg-inline--fa fa-redo fa-w-16" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="redo" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
						<path fill="currentColor" d="M500.33 0h-47.41a12 12 0 0 0-12 12.57l4 82.76A247.42 247.42 0 0 0 256 8C119.34 8 7.9 119.53 8 256.19 8.1 393.07 119.1 504 256 504a247.1 247.1 0 0 0 166.18-63.91 12 12 0 0 0 .48-17.43l-34-34a12 12 0 0 0-16.38-.55A176 176 0 1 1 402.1 157.8l-101.53-4.87a12 12 0 0 0-12.57 12v47.41a12 12 0 0 0 12 12h200.33a12 12 0 0 0 12-12V12a12 12 0 0 0-12-12z"></path></svg>
				</button>
				<div class="dropdown font-sans-serif">
					<button
						class="btn btn-falcon-default text-600 btn-sm dropdown-toggle dropdown-caret-none ms-2" type="button" id="email-filter" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<svg class="svg-inline--fa fa-sliders-h fa-w-16" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="sliders-h" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
							<path fill="currentColor" d="M496 384H160v-16c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v16H16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h80v16c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16v-16h336c8.8 0 16-7.2 16-16v-32c0-8.8-7.2-16-16-16zm0-160h-80v-16c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v16H16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h336v16c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16v-16h80c8.8 0 16-7.2 16-16v-32c0-8.8-7.2-16-16-16zm0-160H288V48c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v16H16C7.2 64 0 71.2 0 80v32c0 8.8 7.2 16 16 16h208v16c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16v-16h208c8.8 0 16-7.2 16-16V80c0-8.8-7.2-16-16-16z"></path></svg>
					</button>
					<div class="dropdown-menu border py-0" aria-labelledby="email-filter">
						<div class="bg-white dark__bg-dark py-2">
							<a class="dropdown-item d-flex justify-content-between" id="receive-msg" href="#!">받은 쪽지<svg class="svg-inline--fa fa-check fa-w-16" data-fa-transform="down-4 shrink-4" aria-hidden="true" 	focusable="false" data-prefix="fas" data-icon="check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="" style="transform-origin: 0.5em 0.75em;">
									<g transform="translate(256 256)">
									<g transform="translate(0, 128)  scale(0.75, 0.75)  rotate(0 0 0)">
									<path fill="currentColor" d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z" transform="translate(-256 -256)"></path></g></g></svg> 
							</a>
							<a class="dropdown-item" id="send-msg" href="#!">보낸 쪽지</a>
							<a class="dropdown-item" id="import-msg" href="#!">중요 쪽지</a>
							<a class="dropdown-item" id="trash-msg" href="#!">휴지통</a>
						</div>
					</div>
				</div>
				<div class="border-start ms-3 ps-3 d-none" id="emails-actions">
					<div class="btn-group btn-group-sm">
						<button class="btn btn-falcon-default" type="button" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Archive" data-bs-original-title="Archive">
							<svg class="svg-inline--fa fa-archive fa-w-16" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="archive" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
								<path fill="currentColor" d="M32 448c0 17.7 14.3 32 32 32h384c17.7 0 32-14.3 32-32V160H32v288zm160-212c0-6.6 5.4-12 12-12h104c6.6 0 12 5.4 12 12v8c0 6.6-5.4 12-12 12H204c-6.6 0-12-5.4-12-12v-8zM480 32H32C14.3 32 0 46.3 0 64v48c0 8.8 7.2 16 16 16h480c8.8 0 16-7.2 16-16V64c0-17.7-14.3-32-32-32z"></path>
							</svg>
						</button>
						<button class="btn btn-falcon-default" type="button" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Delete" data-bs-original-title="Delete">
							<svg class="svg-inline--fa fa-trash-alt fa-w-14" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="trash-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="">
								<path fill="currentColor" d="M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V128H32zm272-256a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zM432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16z"></path>
							</svg>
						</button>
						<button class="btn btn-falcon-default" type="button"
							data-bs-toggle="tooltip" data-bs-placement="top"
							aria-label="Mark as 읽지 않음" data-bs-original-title="Mark as 읽지 않음">
							<svg class="svg-inline--fa fa-envelope fa-w-16"
								aria-hidden="true" focusable="false" data-prefix="fas"
								data-icon="envelope" role="img"
								xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
								data-fa-i2svg="">
								<path fill="currentColor"
									d="M502.3 190.8c3.9-3.1 9.7-.2 9.7 4.7V400c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V195.6c0-5 5.7-7.8 9.7-4.7 22.4 17.4 52.1 39.5 154.1 113.6 21.1 15.4 56.7 47.8 92.2 47.6 35.7.3 72-32.8 92.3-47.6 102-74.1 131.6-96.3 154-113.7zM256 320c23.2.4 56.6-29.2 73.4-41.4 132.7-96.3 142.8-104.7 173.4-128.7 5.8-4.5 9.2-11.5 9.2-18.9v-19c0-26.5-21.5-48-48-48H48C21.5 64 0 85.5 0 112v19c0 7.4 3.4 14.3 9.2 18.9 30.6 23.9 40.7 32.4 173.4 128.7 16.8 12.2 50.2 41.8 73.4 41.4z"></path></svg>
							<!-- <span class="fas fa-envelope"></span> Font Awesome fontawesome.com -->
						</button>
						<button class="btn btn-falcon-default" type="button" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Snooze" data-bs-original-title="Snooze">
							<svg class="svg-inline--fa fa-clock fa-w-16" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="clock" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256,8C119,8,8,119,8,256S119,504,256,504,504,393,504,256,393,8,256,8Zm92.49,313h0l-20,25a16,16,0,0,1-22.49,2.5h0l-67-49.72a40,40,0,0,1-15-31.23V112a16,16,0,0,1,16-16h32a16,16,0,0,1,16,16V256l58,42.5A16,16,0,0,1,348.49,321Z"></path></svg>
						</button>
					</div>
				</div>
			</div>
			<div class="col-auto">
				<a class="btn btn-falcon-primary btn-sm" href="/msg/compose"><svg class="svg-inline--fa fa-plus fa-w-14 me-1" data-fa-transform="shrink-3" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg="" style="transform-origin: 0.4375em 0.5em;">
					<g transform="translate(224 256)"><g transform="translate(0, 0)  scale(0.8125, 0.8125)  rotate(0 0 0)"><path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z" transform="translate(-224 -256)"></path></g></g></svg>
					새 쪽지
				</a>
			</div>
		</div>
	</div>
	<div class="card-body fs--1 border-top border-200 p-0" id="msg-output"> 
	</div>
</div>

<script src="/resources/js/msg/msg-inbox.js"></script>