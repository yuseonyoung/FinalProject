<%--
* [[개정이력(Modification Information)]]
* 수정일              수정자      수정내용
* ----------     ---------  -----------------
* 2023. 11. 15.      이수정      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


<!-- ===============================================-->
<!--    Document Title-->
<!-- ===============================================-->
<title>Falcon | Dashboard &amp; Web App Template</title>


<!-- ===============================================-->
<!--    Favicons-->
<!-- ===============================================-->
<link rel="apple-touch-icon" sizes="180x180"
	href="../../assets/img/favicons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="../../assets/img/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="../../assets/img/favicons/favicon-16x16.png">
<link rel="shortcut icon" type="image/x-icon"
	href="../../assets/img/favicons/favicon.ico">
<link rel="manifest" href="../../assets/img/favicons/manifest.json">
<meta name="msapplication-TileImage"
	content="../../assets/img/favicons/mstile-150x150.png">
<meta name="theme-color" content="#ffffff">
<script src="../../assets/js/config.js"></script>
<script src="../../vendors/simplebar/simplebar.min.js"></script>


<!-- ===============================================-->
<!--    Stylesheets-->
<!-- ===============================================-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap"
	rel="stylesheet">
<link href="../../vendors/simplebar/simplebar.min.css" rel="stylesheet">
<link href="../../assets/css/theme-rtl.css" rel="stylesheet"
	id="style-rtl">
<link href="../../assets/css/theme.css" rel="stylesheet"
	id="style-default">
<link href="../../assets/css/user-rtl.css" rel="stylesheet"
	id="user-style-rtl">
<link href="../../assets/css/user.css" rel="stylesheet"
	id="user-style-default">
<script>
	var isRTL = JSON.parse(localStorage.getItem('isRTL'));
	if (isRTL) {
		var linkDefault = document.getElementById('style-default');
		var userLinkDefault = document.getElementById('user-style-default');
		linkDefault.setAttribute('disabled', true);
		userLinkDefault.setAttribute('disabled', true);
		document.querySelector('html').setAttribute('dir', 'rtl');
	} else {
		var linkRTL = document.getElementById('style-rtl');
		var userLinkRTL = document.getElementById('user-style-rtl');
		linkRTL.setAttribute('disabled', true);
		userLinkRTL.setAttribute('disabled', true);
	}
</script>
</head>


<body>

	<!-- ===============================================-->
	<!--    Main Content-->
	<!-- ===============================================-->
	<main class="main" id="top">
		<div class="container" data-layout="container">
			<script>
				var isFluid = JSON.parse(localStorage.getItem('isFluid'));
				if (isFluid) {
					var container = document.querySelector('[data-layout]');
					container.classList.remove('container');
					container.classList.add('container-fluid');
				}
			</script>

			<div class="content">
				<div class="card mb-3"></div>
				<div class="card">
					<div class="card-header">
						<div class="row">
							<div class="list"></div>

						</div>

					</div>
					<div class="card-footer">
						<div class="row justify-content-between">
							<div class="col">
								<a class="btn btn-falcon-default btn-sm" href="/mail/list"><svg
										class="svg-inline--fa fa-reply fa-w-16"
										data-fa-transform="down-2" aria-hidden="true"
										focusable="false" data-prefix="fas" data-icon="reply"
										role="img" xmlns="http://www.w3.org/2000/svg"
										viewBox="0 0 512 512" data-fa-i2svg=""
										style="transform-origin: 0.5em 0.625em;">
										<g transform="translate(256 256)">
										<g transform="translate(0, 64)  scale(1, 1)  rotate(0 0 0)">
										<path fill="currentColor"
											d="M8.309 189.836L184.313 37.851C199.719 24.546 224 35.347 224 56.015v80.053c160.629 1.839 288 34.032 288 186.258 0 61.441-39.581 122.309-83.333 154.132-13.653 9.931-33.111-2.533-28.077-18.631 45.344-145.012-21.507-183.51-176.59-185.742V360c0 20.7-24.3 31.453-39.687 18.164l-176.004-152c-11.071-9.562-11.086-26.753 0-36.328z"
											transform="translate(-256 -256)"></path></g></g></svg> <!-- <span class="fas fa-reply" data-fa-transform="down-2"></span> Font Awesome fontawesome.com -->
									<span class="d-none d-sm-inline-block ms-1">받은메일</span></a> 
									<a class="btn btn-falcon-default btn-sm" href="/mail/slist"><svg
										class="svg-inline--fa fa-reply fa-w-16"
										data-fa-transform="down-2" aria-hidden="true"
										focusable="false" data-prefix="fas" data-icon="reply"
										role="img" xmlns="http://www.w3.org/2000/svg"
										viewBox="0 0 512 512" data-fa-i2svg=""
										style="transform-origin: 0.5em 0.625em;">
										<g transform="translate(256 256)">
										<g transform="translate(0, 64)  scale(1, 1)  rotate(0 0 0)">
										<path fill="currentColor"
											d="M8.309 189.836L184.313 37.851C199.719 24.546 224 35.347 224 56.015v80.053c160.629 1.839 288 34.032 288 186.258 0 61.441-39.581 122.309-83.333 154.132-13.653 9.931-33.111-2.533-28.077-18.631 45.344-145.012-21.507-183.51-176.59-185.742V360c0 20.7-24.3 31.453-39.687 18.164l-176.004-152c-11.071-9.562-11.086-26.753 0-36.328z"
											transform="translate(-256 -256)"></path></g></g></svg> <!-- <span class="fas fa-reply" data-fa-transform="down-2"></span> Font Awesome fontawesome.com -->
									<span class="d-none d-sm-inline-block ms-1">보낸메일</span></a>

							</div>

						</div>
					</div>
				</div>

				<div class="modal fade" id="authentication-modal" tabindex="-1"
					role="dialog" aria-labelledby="authentication-modal-label"
					aria-hidden="true">
					<div class="modal-dialog mt-6" role="document">
						<div class="modal-content border-0">
							<div
								class="modal-header px-5 position-relative modal-shape-header bg-shape">
								<div class="position-relative z-1" data-bs-theme="light">
									<h4 class="mb-0 text-white" id="authentication-modal-label">Register</h4>
									<p class="fs--1 mb-0 text-white">Please create your free
										Falcon account</p>
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
											id="modal-auth-register-checkbox" /> <label
											class="form-label" for="modal-auth-register-checkbox">I
											accept the <a href="#!">terms </a>and <a href="#!">privacy
												policy</a>
										</label>
									</div>
									<div class="mb-3">
										<button class="btn btn-primary d-block w-100 mt-3"
											type="submit" name="submit">Register</button>
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
										<a class="btn btn-outline-facebook btn-sm d-block w-100"
											href="#"><span class="fab fa-facebook-square me-2"
											data-fa-transform="grow-8"></span> facebook</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</main>
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
						<input class="btn-check" id="themeSwitcherLight"
							name="theme-color" type="radio" value="light"
							data-theme-control="theme" /> <label
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
					<input class="form-check-input ms-0" id="mode-fluid"
						type="checkbox" data-theme-control="isFluid" />
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
						<input class="btn-check" id="navbar-style-transparent"
							type="radio" name="navbarStyle" value="transparent"
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


	<!-- ===============================================-->
	<!--    JavaScripts-->
	<!-- ===============================================-->
	<script src="../../vendors/popper/popper.min.js"></script>
	<script src="../../vendors/bootstrap/bootstrap.min.js"></script>
	<script src="../../vendors/anchorjs/anchor.min.js"></script>
	<script src="../../vendors/is/is.min.js"></script>
	<script src="../../vendors/fontawesome/all.min.js"></script>
	<script src="../../vendors/lodash/lodash.min.js"></script>
	<script
		src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
	<script src="../../vendors/list.js/list.min.js"></script>
	<script src="../../assets/js/theme.js"></script>

</body>

<c:url value="/resources/js/mail/mailView.js" var="urls" />
<script src="${urls}"></script>
