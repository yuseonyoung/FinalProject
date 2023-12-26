<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- ===============================================-->
<!--    Document Title-->
<!-- ===============================================-->
<title>Auto Inventory Management</title>


<!-- ===============================================-->
<!--    Favicons-->
<!-- ===============================================-->
<link rel="apple-touch-icon" sizes="180x180"
	href="/resources/falcon/public/assets/img/favicons/grouub.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="/resources/falcon/public/assets/img/favicons/grouub.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/falcon/public/assets/img/favicons/grouub.png">
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/falcon/public/assets/img/favicons/grouub.png">
<link rel="manifest"
	href="/resources/falcon/public/assets/img/favicons/manifest.json">
<meta name="msapplication-TileImage"
	content="/resources/falcon/public/assets/img/favicons/mstile-150x150.png">
<meta name="theme-color" content="#ffffff">
<script src="/resources/falcon/public/assets/js/config.js"></script>
<script
	src="/resources/falcon/public/vendors/simplebar/simplebar.min.js"></script>

<!-- Jquery -->
<script src="/resources/js/jquery-3.7.1.min.js"></script>
<script src="/resources/js/jquery.serializejson.js"></script>

<!-- websocket 통신관련 sockjs, stomp-->
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<!-- editor -->
<script src="/resources/falcon/public/vendors/tinymce/tinymce.min.js"></script>

<!-- chartJs -->
<script src="/resources/falcon/public/vendors/chart/chart.min.js"></script>

<!-- google font : 폰트 설정 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@500&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<!-- ===============================================-->
<!--    Stylesheets-->
<!-- ===============================================-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap"
	rel="stylesheet">
<link
	href="/resources/falcon/public/vendors/simplebar/simplebar.min.css"
	rel="stylesheet">
<link href="/resources/falcon/public/assets/css/theme-rtl.css"
	rel="stylesheet" id="style-rtl">
<link href="/resources/falcon/public/assets/css/theme.css"
	rel="stylesheet" id="style-default">
<link href="/resources/falcon/public/assets/css/user-rtl.css"
	rel="stylesheet" id="user-style-rtl">
<link href="/resources/falcon/public/assets/css/user.css"
	rel="stylesheet" id="user-style-default">
<link
	href="/resources/falcon/public/vendors/flatpickr/flatpickr.min.css"
	rel="stylesheet" />
<link href="/resources/falcon/public/vendors/fullcalendar/main.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css" />
<link href="/resources/falcon/public/vendors/dropzone/dropzone.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="/resources/falcon/public/vendors/select2/select2.min.css" />
<link rel="stylesheet"
	href="/resources/falcon/public/vendors/select2-bootstrap-5-theme/select2-bootstrap-5-theme.min.css" />
<!-- 유선영꺼 -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/custom.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
<!-- CSS 파일 -->
<!-- 유선영꺼 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.13/themes/default/style.min.css" />

<!-- JS 파일 -->
<!-- 유선영꺼 -->
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.13/jstree.min.js"></script>

<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-modal/2.2.6/css/bootstrap-modal.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-modal/2.2.6/js/bootstrap-modal.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-modal/2.2.6/js/bootstrap-modalmanager.min.js"></script> -->

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


<!-- 폰트 적용 -->
<style>
* {
	font-family: 'IBM Plex Sans KR', sans-serif;
}

.pageConversion body.modal-open {
	overflow: auto;
}

.pageConversion {
	background-color: white;
}
</style>
<security:csrfMetaTags />
</head>


<body class="pageConversion"
	data-context-path="${pageContext.request.contextPath}">

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
			<tiles:insertAttribute name="leftMenu" />
			<div class="content">
				<tiles:insertAttribute name="headerMenu" />
				<div id="listBody">
					<tiles:insertAttribute name="content" />
				</div>
				<tiles:insertAttribute name="footer" />
			</div>

			<!-- ===============================================-->
			<!--    JavaScripts-->
			<!-- ===============================================-->

			<c:if test="${not empty message }">
				<script>
            Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: '${message}'
                })
            </script>

			</c:if>

			<c:if test="${not empty xmessage }">
				<script>
            Swal.fire({
                    icon: 'error',
                    title: '실패',
                    text: '${xmessage}'
                })
            </script>
			</c:if>

			<script>
            const CSRFPARAMNAME = $("meta[name='_csrf_parameter']").attr("content");
            const CSRFHEADERNAME = $("meta[name='_csrf_header']").attr("content");
            const CSRFTOKEN = $("meta[name='_csrf']").attr("content");
            $.ajaxSetup({
               headers : {
                  [CSRFHEADERNAME] : CSRFTOKEN
               }
            });
         </script>


			<script
				src="/resources/falcon/public/vendors/bootstrap/bootstrap.min.js"></script>
			<script src="/resources/falcon/public/vendors/anchorjs/anchor.min.js"></script>
			<script src="/resources/falcon/public/vendors/is/is.min.js"></script>
			<script src="/resources/falcon/public/vendors/echarts/echarts.min.js"></script>
			<script src="/resources/falcon/public/vendors/fontawesome/all.min.js"></script>
			<script src="/resources/falcon/public/vendors/lodash/lodash.min.js"></script>
			<script
				src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
			<script src="/resources/falcon/public/vendors/list.js/list.min.js"></script>
			<script src="/resources/falcon/public/assets/js/theme.js"></script>
			<script src="/resources/falcon/public/assets/js/flatpickr.js"></script>
			<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
			<script
				src="/resources/falcon/public/vendors/fullcalendar/main.min.js"></script>
			<script
				src="/resources/falcon/public/vendors/draggable/draggable.bundle.legacy.js"></script>
			<!-- <script src="/resources/falcon/public/vendors/jquery/jquery.min.js"></script> -->
			<script src="/resources/falcon/public/vendors/select2/select2.min.js"></script>
			<script
				src="/resources/falcon/public/vendors/select2/select2.full.min.js"></script>


			<!-- 유선영꺼 -->
			<script src="/resources/js/storage/address.js"></script>
			<!-- 유선영꺼 -->
			<script
				src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


			<!-- 유선영꺼 -->
			<script
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb220a45abe792f033fbc010f5b30024&libraries=services"></script>
			<!--<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
          <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>-->

			<script
				src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
			<script
				src="https://cdn.datatables.net/v/bs5/dt-1.13.7/b-2.4.2/datatables.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
			<!-- <script src="/resources/js/storage/address.js"></script> -->
			<!-- 유선영꺼 -->
			<script
				src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script src="/resources/falcon/public/vendors/popper/popper.min.js"></script>
			<script
				src="/resources/falcon/public/vendors/dropzone/dropzone.min.js"></script>



		</div>
	</main>
</body>
</html>

<script type="text/javascript">
   Dropzone.autoDiscover = false;
    flatpickr.localize(flatpickr.l10ns.ko);
    flatpickr(".datetimepicker");
</script>