<%--
* [[개정이력(Modification Information)]]
* 수정일              수정자      수정내용
* ----------     ---------  -----------------
* 2023. 11. 15.      이수정      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<form:form id="mailSend" modelAttribute="sendMail"
	enctype="multipart/form-data">
	<div class="content">
		<div class="card">
			<div class="card-header bg-light">
				<h5 class="mb-0">메일 작성</h5>
			</div>
			<div class="card-body p-0">
				<div class="border border-top-0 border-200" onclick="mailAddr()">
					<input type="hidden" name="mailSen" id="mailSenInput"
						value="${sendMail.empCd}" /> <input type="hidden" id="senNmInput" />
					<input type="hidden" id="recNmInput" /> <input
						class="form-control border-0 rounded-0 outline-none px-x1"
						id="email-to" value="" type="text" aria-describedby="email-to"
						placeholder="받으실 분" required />
					<form:hidden path="mailRec" />
				</div>
				<div class="border border-y-0 border-200">
					<form:input
						class="form-control border-0 rounded-0 outline-none px-x1"
						path="mailTitle" type="text" aria-describedby="email-subject"
						placeholder="제목" required="required" />
				</div>
				<div class="min-vh-50">
					<form:textarea class="tinymce d-none" data-tinymce="data-tinymce"
						path="mailCont" name="mailCont" required="required" />
				</div>
				<div class="bg-light px-x1 py-3">
					<div class="fileview">
						<div class="d-inline-flex flex-column">
							<!--                   <div class="border px-2 rounded-3 d-flex flex-between-center bg-white dark__bg-1000 my-1 fs--1"><span class="fs-1 far fa-image"></span><span class="ms-2"></span><a class="text-300 p-1 ms-6" href="#!" data-bs-toggle="tooltip" data-bs-placement="right" title="Detach"><span class="fas fa-times"></span></a></div> -->
							<!--                   <div class="border px-2 rounded-3 d-flex flex-between-center bg-white dark__bg-1000 my-1 fs--1"><span class="fs-1 far fa-file-archive"></span><span class="ms-2">coffee.zip (342kb)</span><a class="text-300 p-1 ms-6" href="#!" data-bs-toggle="tooltip" data-bs-placement="right" title="Detach"><span class="fas fa-times"></span></a></div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<div
			class="card-footer border-top border-200 d-flex flex-between-center">
			<div class="d-flex align-items-center">
				<input class="btn btn-primary btn-sm px-5 me-2" type="button"
					value="발송" id="mailSendBtn" /> <input
					class="btn btn-primary btn-sm px-5 me-2" type="button" value="자동완성"
					id="autoBtn" />
					
			</div>
			<input class="d-none" id="email-attachment" type="file"
				name="mailFile" multiple onchange="sjFile(this)" /> <label
				class="me-2 btn btn-light btn-sm mb-0 cursor-pointer"
				for="email-attachment" data-bs-toggle="tooltip"
				data-bs-placement="top" title="Attach files"><span
				class="fas fa-paperclip fs-1" data-fa-transform="down-2"></span></label>
		</div>
	</div>
</form:form>

<div class="modal fade" id="authentication-modal" tabindex="-1"
	role="dialog" aria-labelledby="authentication-modal-label"
	aria-hidden="true">
	<div class="modal-dialog mt-6" role="document">
		<div class="modal-content border-0">
			<div
				class="modal-header px-5 position-relative modal-shape-header bg-shape">
				<div class="position-relative z-1" data-bs-theme="light">
					<h4 class="mb-0 text-white" id="authentication-modal-label">Register</h4>
					<p class="fs--1 mb-0 text-white">Please create your free Falcon
						account</p>
				</div>
				<button
					class="btn-close btn-close-white position-absolute top-0 end-0 mt-2 me-2"
					data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body py-4 px-5">
				<form>
					<div class="mb-3">
						<label class="form-label" for="modal-auth-name">Name</label> <input
							class="form-control" type="text" autocomplete="on"
							id="modal-auth-name" />
					</div>
					<div class="mb-3">
						<label class="form-label" for="modal-auth-email">Email
							address</label> <input class="form-control" type="email"
							autocomplete="on" id="modal-auth-email" />
					</div>
					<div class="row gx-2">
						<div class="mb-3 col-sm-6">
							<label class="form-label" for="modal-auth-password">Password</label>
							<input class="form-control" type="password" autocomplete="on"
								id="modal-auth-password" />
						</div>
						<div class="mb-3 col-sm-6">
							<label class="form-label" for="modal-auth-confirm-password">Confirm
								Password</label> <input class="form-control" type="password"
								autocomplete="on" id="modal-auth-confirm-password" />
						</div>
					</div>
					<div class="form-check">
						<input class="form-check-input" type="checkbox"
							id="modal-auth-register-checkbox" /> <label class="form-label"
							for="modal-auth-register-checkbox">I accept the <a
							href="#!">terms </a>and <a href="#!">privacy policy</a></label>
					</div>
					<div class="mb-3">
						<button class="btn btn-primary d-block w-100 mt-3" type="submit"
							name="submit">Register</button>
					</div>
				</form>
				<div class="position-relative mt-5">
					<hr />
					<div class="divider-content-center">or register with</div>
				</div>
				<div class="row g-2 mt-2">
					<div class="col-sm-6">
						<a class="btn btn-outline-google-plus btn-sm d-block w-100"
							href="#"><span class="fab fa-google-plus-g me-2"
							data-fa-transform="grow-8"></span> google</a>
					</div>
					<div class="col-sm-6">
						<a class="btn btn-outline-facebook btn-sm d-block w-100" href="#"><span
							class="fab fa-facebook-square me-2" data-fa-transform="grow-8"></span>
							facebook</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ===============================================-->
<!--    End of Main Content-->
<!-- ===============================================-->


<div class="offcanvas offcanvas-end settings-panel border-0"
	id="settings-offcanvas" tabindex="-1"
	aria-labelledby="settings-offcanvas">
	<div class="offcanvas-header settings-panel-header bg-shape">
		<div class="z-1 py-1" data-bs-theme="light">
			<div class="d-flex justify-content-between align-items-center mb-1">
				<h5 class="text-white mb-0 me-2">
					<span class="fas fa-palette me-2 fs-0"></span>Settings
				</h5>
				<button class="btn btn-primary btn-sm rounded-pill mt-0 mb-0"
					data-theme-control="reset" style="font-size: 12px">
					<span class="fas fa-redo-alt me-1" data-fa-transform="shrink-3"></span>Reset
				</button>
			</div>
			<p class="mb-0 fs--1 text-white opacity-75">Set your own
				customized style</p>
		</div>
		<button class="btn-close btn-close-white z-1 mt-0" type="button"
			data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body scrollbar-overlay px-x1 h-100"
		id="themeController">
		<h5 class="fs-0">Color Scheme</h5>
		<p class="fs--1">Choose the perfect color mode for your app.</p>
		<div class="btn-group d-block w-100 btn-group-navbar-style">
			<div class="row gx-2">
				<div class="col-6">
					<input class="btn-check" id="themeSwitcherLight" name="theme-color"
						type="radio" value="light" data-theme-control="theme" /> <label
						class="btn d-inline-block btn-navbar-style fs--1"
						for="themeSwitcherLight"> <span
						class="hover-overlay mb-2 rounded d-block"><img
							class="img-fluid img-prototype mb-0"
							src="../../assets/img/generic/falcon-mode-default.jpg" alt="" /></span><span
						class="label-text">Light</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="themeSwitcherDark" name="theme-color"
						type="radio" value="dark" data-theme-control="theme" /> <label
						class="btn d-inline-block btn-navbar-style fs--1"
						for="themeSwitcherDark"> <span
						class="hover-overlay mb-2 rounded d-block"><img
							class="img-fluid img-prototype mb-0"
							src="../../assets/img/generic/falcon-mode-dark.jpg" alt="" /></span><span
						class="label-text"> Dark</span></label>
				</div>
			</div>
		</div>
		<hr />
		<div class="d-flex justify-content-between">
			<div class="d-flex align-items-start">
				<img class="me-2"
					src="../../assets/img/icons/left-arrow-from-left.svg" width="20"
					alt="" />
				<div class="flex-1">
					<h5 class="fs-0">RTL Mode</h5>
					<p class="fs--1 mb-0">Switch your language direction</p>
					<a class="fs--1"
						href="../../documentation/customization/configuration.html">RTL
						Documentation</a>
				</div>
			</div>
			<div class="form-check form-switch">
				<input class="form-check-input ms-0" id="mode-rtl" type="checkbox"
					data-theme-control="isRTL" />
			</div>
		</div>
		<hr />
		<div class="d-flex justify-content-between">
			<div class="d-flex align-items-start">
				<img class="me-2" src="../../assets/img/icons/arrows-h.svg"
					width="20" alt="" />
				<div class="flex-1">
					<h5 class="fs-0">Fluid Layout</h5>
					<p class="fs--1 mb-0">Toggle container layout system</p>
					<a class="fs--1"
						href="../../documentation/customization/configuration.html">Fluid
						Documentation</a>
				</div>
			</div>
			<div class="form-check form-switch">
				<input class="form-check-input ms-0" id="mode-fluid" type="checkbox"
					data-theme-control="isFluid" />
			</div>
		</div>
		<hr />
		<div class="d-flex align-items-start">
			<img class="me-2" src="../../assets/img/icons/paragraph.svg"
				width="20" alt="" />
			<div class="flex-1">
				<h5 class="fs-0 d-flex align-items-center">Navigation Position</h5>
				<p class="fs--1 mb-2">Select a suitable navigation system for
					your web application</p>
				<div>
					<select class="form-select form-select-sm"
						aria-label="Navbar position" data-theme-control="navbarPosition">
						<option value="vertical"
							data-page-url="../../modules/components/navs-and-tabs/vertical-navbar.html">Vertical</option>
						<option value="top"
							data-page-url="../../modules/components/navs-and-tabs/top-navbar.html">Top</option>
						<option value="combo"
							data-page-url="../../modules/components/navs-and-tabs/combo-navbar.html">Combo</option>
						<option value="double-top"
							data-page-url="../../modules/components/navs-and-tabs/double-top-navbar.html">Double
							Top</option>
					</select>
				</div>
			</div>
		</div>
		<hr />
		<h5 class="fs-0 d-flex align-items-center">Vertical Navbar Style</h5>
		<p class="fs--1 mb-0">Switch between styles for your vertical
			navbar</p>
		<p>
			<a class="fs--1"
				href="../../modules/components/navs-and-tabs/vertical-navbar.html#navbar-styles">See
				Documentation</a>
		</p>
		<div class="btn-group d-block w-100 btn-group-navbar-style">
			<div class="row gx-2">
				<div class="col-6">
					<input class="btn-check" id="navbar-style-transparent" type="radio"
						name="navbarStyle" value="transparent"
						data-theme-control="navbarStyle" /> <label
						class="btn d-block w-100 btn-navbar-style fs--1"
						for="navbar-style-transparent"> <img
						class="img-fluid img-prototype"
						src="../../assets/img/generic/default.png" alt="" /><span
						class="label-text"> Transparent</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-inverted" type="radio"
						name="navbarStyle" value="inverted"
						data-theme-control="navbarStyle" /> <label
						class="btn d-block w-100 btn-navbar-style fs--1"
						for="navbar-style-inverted"> <img
						class="img-fluid img-prototype"
						src="../../assets/img/generic/inverted.png" alt="" /><span
						class="label-text"> Inverted</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-card" type="radio"
						name="navbarStyle" value="card" data-theme-control="navbarStyle" />
					<label class="btn d-block w-100 btn-navbar-style fs--1"
						for="navbar-style-card"> <img
						class="img-fluid img-prototype"
						src="../../assets/img/generic/card.png" alt="" /><span
						class="label-text"> Card</span></label>
				</div>
				<div class="col-6">
					<input class="btn-check" id="navbar-style-vibrant" type="radio"
						name="navbarStyle" value="vibrant"
						data-theme-control="navbarStyle" /> <label
						class="btn d-block w-100 btn-navbar-style fs--1"
						for="navbar-style-vibrant"> <img
						class="img-fluid img-prototype"
						src="../../assets/img/generic/vibrant.png" alt="" /><span
						class="label-text"> Vibrant</span></label>
				</div>
			</div>
		</div>
		<div class="text-center mt-5">
			<img class="mb-4"
				src="../../assets/img/icons/spot-illustrations/47.png" alt=""
				width="120" />
			<h5>Like What You See?</h5>
			<p class="fs--1">Get Falcon now and create beautiful dashboards
				with hundreds of widgets.</p>
			<a class="mb-3 btn btn-primary"
				href="https://themes.getbootstrap.com/product/falcon-admin-dashboard-webapp-template/"
				target="_blank">Purchase</a>
		</div>
	</div>
</div>

<!-- 여기는 신규등록 모달  -->

<div class="modal fade" id="mailAddr" data-bs-keyboard="false"
	data-bs-backdrop="static" tabindex="-1" aria-labelledby="mailAddrLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg mt-6" role="document">
		<div class="modal-content border-0">
			<div class="position-absolute top-0 end-0 mt-3 me-3 z-1">
				<button
					class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base"
					data-bs-dismiss="modal" aria-label="Close" id="createClose"></button>
			</div>

			<div class="modal-body p-0">
				<div class="bg-light rounded-top-3 py-3 ps-4 pe-6">
					<h4 class="mb-1" id="createWindowLabel">주소록</h4>
				</div>
				<div class="p-4">
					<div class="row">
						<div id="selMail">
							<div class="mb-3 w-75">
								<label for="deptNmInput">부서</label> <select class="form-control"
									name="recDept" id="deptNmInput" onchange="selMailRec(this)">
									<option>-부서 선택-</option>
									<option value="1">구매부</option>
									<option value="2">유통부</option>
									<option value="3">자재부</option>
									<option value="4">인사부</option>
									<option value="5">판매부</option>
									<option value="6">임원</option>
								</select>
							</div>
							<span id="recDept" class="error"></span>

							<div class="mb-3 w-75" id="mailRec">
								<label for="mailRecInput">수신자</label>

								<div class="contact_user_area">
									<div class="contact_user_header">
										<div class="button_checkbox_wrap">
											<input type="checkbox" id="selection_all"
												class="button_checkbox blind" onclick="selectAll(this)">
											<label for="selection_all"> <strong class="text">전체</strong></label>
										</div>
									</div>
									<div id="mailRecInput"
										style="height: 300px; overflow: auto; text-overflow: ellipsis; display: -webkit-box; -webkit-box-orient: vertical;">

									</div>
								</div>
								<span id="mailRec" class="error"></span>



								<div class="mb-3 w-75" id="buttonSpace" style="padding: 30px 0;">
									<button
										class="ml-1 btn btn-outline-primary rounded-capsule mr-1 mb-1"
										id="resultBtn">확인</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ===============================================-->
<!--    JavaScripts-->
<!-- ===============================================-->
<script>
	
</script>
<script src="../../vendors/popper/popper.min.js"></script>
<script src="../../vendors/bootstrap/bootstrap.min.js"></script>
<script src="../../vendors/anchorjs/anchor.min.js"></script>
<script src="../../vendors/is/is.min.js"></script>
<script src="../../vendors/tinymce/tinymce.min.js"></script>
<script src="../../vendors/fontawesome/all.min.js"></script>
<script src="../../vendors/lodash/lodash.min.js"></script>
<script
	src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="../../vendors/list.js/list.min.js"></script>
<script src="../../assets/js/theme.js"></script>

<c:url value="/resources/js/mail/mailSend.js" var="urls" />
<script src="${urls}"></script>
