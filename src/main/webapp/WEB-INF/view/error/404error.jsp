<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en-US" dir="ltr">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
    <title>AIM</title>


    <!-- ===============================================-->
    <!--    Favicons-->
    <!-- ===============================================-->
<link rel="apple-touch-icon" sizes="180x180" href="/resources/falcon/public/assets/img/favicons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="/resources/falcon/public/assets/img/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/resources/falcon/public/assets/img/favicons/favicon-16x16.png">
<link rel="shortcut icon" type="image/x-icon" href="/resources/falcon/public/assets/img/favicons/favicon.ico">
<link rel="manifest" href="/resources/falcon/public/assets/img/favicons/manifest.json">
<meta name="msapplication-TileImage" content="/resources/falcon/public/assets/img/favicons/mstile-150x150.png">
<meta name="theme-color" content="#ffffff">
<script src="/resources/falcon/public/assets/js/config.js"></script>
<script src="/resources/falcon/public/vendors/simplebar/simplebar.min.js"></script>



    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
   
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
    <link href="/resources/falcon/public/vendors/simplebar/simplebar.min.css" rel="stylesheet">
    <link href="/resources/falcon/public/assets/css/theme-rtl.css" rel="stylesheet" id="style-rtl">
    <link href="/resources/falcon/public/assets/css/theme.css" rel="stylesheet" id="style-default">
    <link href="/resources/falcon/public/assets/css/user-rtl.css" rel="stylesheet" id="user-style-rtl">
    <link href="/resources/falcon/public/assets/css/user.css" rel="stylesheet" id="user-style-default">
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
        <div class="row flex-center min-vh-100 py-6 text-center">
          <div class="col-sm-10 col-md-8 col-lg-6 col-xxl-5"><a class="d-flex flex-center mb-4" href="/"><img class="me-2" src="/resources/images/aim/aimlogo-clear2.png" alt="" width="300px" /></a>
            <div class="card">
              <div class="card-body p-4 p-sm-5">
                <div class="fw-black lh-1 text-300 fs-error">404</div>
                <p class="lead mt-4 text-800 font-sans-serif fw-semi-bold w-md-75 w-xl-100 mx-auto">원하시는 페이지를 찾을 수 없습니다.</p>
                <hr />
                <p> 찾으려는 페이지의 주소가 잘못 입력되었거나,<br>주소의 변경, 혹은 삭제로 인해 사용하실 수 없습니다.<br> 찾으려는 페이지의 주소가 정확한지 다시 한번 확인해주세요.</p><a class="btn btn-primary btn-sm mt-3" href="http://localhost/"><span class="fas fa-home me-2">
                </span>메인으로 돌아가기</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
    <!-- ===============================================-->
    <!--    End of Main Content-->
    <!-- ===============================================-->




    <!-- ===============================================-->
    <!--    JavaScripts-->
    <!-- ===============================================-->
    <script src="/resources/falcon/public/vendors/popper/popper.min.js"></script>
    <script src="/resources/falcon/public/vendors/bootstrap/bootstrap.min.js"></script>
    <script src="/resources/falcon/public/vendors/anchorjs/anchor.min.js"></script>
    <script src="/resources/falcon/public/vendors/is/is.min.js"></script>
    <script src="/resources/falcon/public/vendors/fontawesome/all.min.js"></script>
    <script src="/resources/falcon/public/vendors/lodash/lodash.min.js"></script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
    <script src="/resources/falcon/public/vendors/list.js/list.min.js"></script>
    <script src="/resources/falcon/public/assets/js/theme.js"></script>

  </body>

</html>