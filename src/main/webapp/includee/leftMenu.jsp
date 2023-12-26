<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="security"%>
   <style>
      .leftMenuBg{
         background-color: white;
      }
      #navbarVerticalCollapse{
         background-color: white;
      }
      
      #gugu{
         color: black;
      }
   </style>
<nav class="navbar navbar-light navbar-vertical navbar-expand-xl" id="leftMenuBg">

   <script>
            var navbarStyle = localStorage.getItem("navbarStyle");
            if (navbarStyle && navbarStyle !== 'transparent') {
              document.querySelector('.navbar-vertical').classList.add(`navbar-${navbarStyle}`);
            }
    </script>
    
    
    
   <div class="d-flex align-items-center">
      <div class="toggle-icon-wrapper">

         <button
            class="btn navbar-toggler-humburger-icon navbar-vertical-toggle"
            data-bs-toggle="tooltip" data-bs-placement="left"
            title="Toggle Navigation">
            <span class="navbar-toggle-icon"><span class="toggle-line"></span></span>
         </button>

      </div>
      <a class="navbar-brand" href="/index.do">
         <div class="d-flex align-items-center py-3">
            <img class="me-2" src="/resources/images/logo/logo.png" alt=""
               width="40" /> <span class="font-sans-serif">AIM</span>
            <!-- <span class="font-sans-serif">AIM</span> -->
         </div>
      </a>
   </div>
   
   
   <div class="collapse navbar-collapse" id="navbarVerticalCollapse">
      <div class="navbar-vertical-content scrollbar">
         <ul class="navbar-nav flex-column mb-3" id="navbarVerticalNav">
            <li class="nav-item">
   
               <!-- label-->
               <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                  <div class="col-auto navbar-vertical-label" id="gugu">영업관리</div>
                  <div class="col ps-0">
                     <hr class="mb-0 navbar-vertical-divider" />
                  </div>
               </div> <!-- parent pages--> 
               <a class="nav-link dropdown-indicator" id="gugu"
                  href="#quote" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="support-desk">
                     <div class="d-flex align-items-center">
                        <span class="fas fa-paste"  style="margin-right: 15px;"></span><span
                           class="nav-link-text ps-1" id="gugu">견적서</span>
                     </div>
               </a>
               <ul class="nav collapse" id="quote">
                  <li class="nav-item"><a class="nav-link" href="/quote/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">견적서 조회</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','OFFICE')">
                     <li class="nav-item"><a class="nav-link" href="/quote/form">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">견적서 입력</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                     <li class="nav-item"><a class="nav-link"
                        href="/quote/status">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">견적서 현황</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </security:authorize>

               </ul> <!-- parent pages--> 
               <a class="nav-link dropdown-indicator"  id="gugu"
                  href="#sale" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="support-desk">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-coins"  style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1" id="gugu">판매</span>
                  </div>
               </a>
               <ul class="nav collapse" id="sale">
                  <li class="nav-item"><a class="nav-link" href="/sale/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">판매 조회</span>
                        </div>
                  </a> <security:authorize access="hasAnyRole('ADMIN','OFFICE')">
                        <!-- more inner pages--></li>
                  <li class="nav-item"><a class="nav-link" href="/sale/form">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">판매 입력</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <li class="nav-item"><a class="nav-link" href="/sale/status">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">판매 현황</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  </security:authorize>
               </ul> <!-- parent pages--> 
               <a class="nav-link dropdown-indicator" id="gugu"
                  href="#rels" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="support-desk">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-clipboard-list"  style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1" id="gugu">출하지시서</span>
                  </div>
               </a>
               <ul class="nav collapse" id="rels">
                  <li class="nav-item"><a class="nav-link" href="/rels/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">출하지시서 조회</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','OFFICE')">
                     <li class="nav-item"><a class="nav-link" href="/rels/form">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">출하지시서 입력</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                     <li class="nav-item"><a class="nav-link" href="/rels/status">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">출하지시서 현황</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </security:authorize>
               </ul>
            </li>
            <li class="nav-item">
               <!-- label-->
               <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                  <div class="col-auto navbar-vertical-label" id="gugu">구매관리</div>
                  <div class="col ps-0">
                     <hr class="mb-0 navbar-vertical-divider" />
                  </div>
               </div> <!-- parent pages--> 
               <a class="nav-link dropdown-indicator" id="gugu"
               href="#orderPlan" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="email">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-dolly-flatbed"  style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1" id="gugu">발주계획</span>
                  </div>
               </a>
               <ul class="nav collapse" id="orderPlan">
                  <li class="nav-item">
                  <a class="nav-link"
                     href="/orderPlan/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">발주계획 조회</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','OFFICE')">
                     <li class="nav-item"><a class="nav-link"
                        href="/orderPlan/enroll">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">발주계획 등록</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </security:authorize>
               </ul> <!-- parent pages--> 
               <a class="nav-link dropdown-indicator" id="gugu"
               href="#unitPrice" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="support-desk">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-file-invoice-dollar" style="margin-right: 20px;"></span><span
                        class="nav-link-text ps-1" id="gugu">단가요청</span>
                  </div>
               </a>
               <ul class="nav collapse" id="unitPrice">
                  <li class="nav-item"><a class="nav-link"
                     href="/orderUnitPrice/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">단가요청 조회</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','OFFICE')">
                     <li class="nav-item"><a class="nav-link"
                        href="/orderUnitPrice/enroll">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">확정단가 등록</span>
                           </div>
                     </a> <!-- more inner pages--></li>

                  </security:authorize>
               </ul> <!-- parent pages--> 
               <a class="nav-link dropdown-indicator" id="gugu"
               href="#orderPlay" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="support-desk">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-file-export" style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1" id="gugu">발주서</span>
                  </div>
               </a>
               <ul class="nav collapse" id="orderPlay">
                  <li class="nav-item"><a class="nav-link"
                     href="/orderPlay/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">발주서 조회</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','OFFICE')">
                     <li class="nav-item"><a class="nav-link"
                        href="/orderPlay/enroll">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">발주서 입력</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                     <li class="nav-item"><a class="nav-link"
                        href="/orderPlay/current">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">발주서 현황</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </security:authorize>
               </ul>
            </li>
            
            <li class="nav-item">
               <!-- label-->
               <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                  <div class="col-auto navbar-vertical-label" id="gugu">자재관리</div>
                  <div class="col ps-0">
                     <hr class="mb-0 navbar-vertical-divider" />
                  </div>
               </div> <!-- parent pages--> <a class="nav-link dropdown-indicator"
               href="#actInven" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="actInven" id="gugu">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-boxes" style="margin-right: 15px;">
                     </span> <span class="nav-link-text ps-1" id="gugu">재고관리</span>
                  </div>
            </a>
               <ul class="nav collapse" id="actInven">
                  <!-- actualInventory / actInven -->
                  <li class="nav-item"><security:authorize
                        access="hasAnyRole('ADMIN','FIELD')">
                        <a class="nav-link" href="/invenAdjust/itemInvenCheck">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">재고 조회</span>
                           </div>
                        </a>
                     </security:authorize> <a class="nav-link" href="/actInven/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">실사재고 조회</span>
                        </div>
                  </a> <security:authorize access="hasAnyRole('ADMIN','FIELD')">
                        <a class="nav-link" href="/actInven/form">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">실사재고 입력</span>
                           </div>
                        </a>
                        <a class="nav-link" href="/actInven/crntSttn">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">실사재고 현황</span>
                           </div>
                        </a>
                        <a class="nav-link" href="/invenAdjust/list">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">재고 조정</span>
                           </div>
                        </a>
                     </security:authorize></li>
               </ul> <!-- parent pages--> <a class="nav-link dropdown-indicator"
               href="#defect" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="support-desk">
                  <div class="d-flex align-items-center" id="gugu">
                     <span class="far fa-file-excel" style="margin-right: 20px;">
                     </span> <span class="nav-link-text ps-1" id="gugu">불량관리</span>
                  </div>
            </a>
               <ul class="nav collapse" id="defect">
                  <!-- defect -->
                  <li class="nav-item"><a class="nav-link" href="/defect/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">불량재고 조회</span>
                        </div>
                  </a> <security:authorize access="hasAnyRole('ADMIN','FIELD')">
                        <a class="nav-link" href="/defect/form">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">불량재고 입력</span>
                           </div>
                        </a>
                        <a class="nav-link" href="/defect/crntSttn">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">불량재고 현황</span>
                           </div>
                        </a>
                     </security:authorize></li>
               </ul>
            </li>


            <li class="nav-item">
               <!-- label-->
               <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                  <div class="col-auto navbar-vertical-label" id="gugu">창고관리</div>
                  <div class="col ps-0">
                     <hr class="mb-0 navbar-vertical-divider" />
                  </div>
               </div> <!-- parent pages--> <a class="nav-link dropdown-indicator"
               href="#wareRetrieve" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="support-desk" id="gugu">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-warehouse" style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1">창고 관리</span>
                  </div>
            </a>
               <ul class="nav collapse" id="wareRetrieve">
                  <li class="nav-item"><a class="nav-link"
                     href="<c:url value="/stor/view"/>">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1" id="wareRetrieve">창고 조회</span>
                        </div>
                  </a> <!-- more inner pages-->
                  <li class="nav-item"><a class="nav-link"
                     href="<c:url value="/sector/view"/>">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">창고구역 조회</span>
                        </div> 
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','FIELD')">
                     <li class="nav-item"><a class="nav-link"
                        href="<c:url value="/sector/form"/>">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">창고구역 등록</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </security:authorize>
                  <li class="nav-item"><a class="nav-link"
                     href="<c:url value="/sector/item"/>">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">품목 이동</span>
                        </div>
                  </a> <!-- more inner pages--></li>

               </ul> <!-- parent pages--> <a class="nav-link dropdown-indicator"
               href="#orderRequest" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="support-desk" id="gugu">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-scroll" style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1" id="gugu">발주요청</span>
                  </div>
            </a>
               <ul class="nav collapse" id="orderRequest">
                  <li class="nav-item"><a class="nav-link"
                     href="<c:url value="/pur/list"/>">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">발주요청 조회</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','FIELD')">
                     <li class="nav-item"><a class="nav-link" href="/pur/form">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">발주요청 등록</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                     <li class="nav-item"><a class="nav-link" href="/pur/cond">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">발주요청 현황</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </security:authorize>
               </ul> <!-- parent pages--> <a class="nav-link dropdown-indicator"
               href="#inWare" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="support-desk" id="gugu">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-file-import" style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1" id="gugu">창고입고관리</span>
                  </div>
            </a>
               <ul class="nav collapse" id="inWare">
                  <li class="nav-item"><a class="nav-link"
                     href="<c:url value="/scheduledStock/inView"/>">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">입고예정 조회</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','FIELD')">
                     <li class="nav-item"><a class="nav-link"
                        href="<c:url value="/storInOut/inView"/>">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">입고확정</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </security:authorize>

               </ul> <!-- parent pages--> <a class="nav-link dropdown-indicator"
               href="#outWare" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="support-desk" id="gugu">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-file-export" style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1" id="gugu">창고출고관리</span>
                  </div>
            </a>
               <ul class="nav collapse" id="outWare">
                  <li class="nav-item"><a class="nav-link"
                     href="<c:url value="/scheduledStock/outView"/>">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">출고예정 조회</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <security:authorize access="hasAnyRole('ADMIN','FIELD')">
                     <li class="nav-item"><a class="nav-link"
                        href="<c:url value="/storInOut/outView"/>">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">출고 진행</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </security:authorize>
               </ul> <a class="nav-link dropdown-indicator" href="#InvenReceiptPayment"
               role="button" data-bs-toggle="collapse" aria-expanded="false"
               aria-controls="support-desk" id="gugu">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-box" style="margin-right: 15px;"></span><span
                        class="nav-link-text ps-1">재고수불부</span>
                  </div>
            </a>
               <ul class="nav collapse" id="InvenReceiptPayment">
                  <li class="nav-item"><a class="nav-link"
                     href="/invenSituation">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">재고수불부 현황</span>
                        </div>
                  </a> <!-- more inner pages--></li>
               </ul>
            </li>



            <li class="nav-item">
               <!-- label-->
               <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                  <div class="col-auto navbar-vertical-label" id="gugu">전자결재</div>
                  <div class="col ps-0">
                     <hr class="mb-0 navbar-vertical-divider" />
                  </div>
               </div> 
               <a class="nav-link dropdown-indicator" href="#edsm" role="button"
               data-bs-toggle="collapse" aria-expanded="false"
               aria-controls="edsm" id="gugu">
                  <div class="d-flex align-items-center">
                     <span class="fas fa-file-contract"  style="margin-right: 15px;"></span>
                     </span> <span class="nav-link-text ps-1">전자결재</span>
                  </div>
               </a> <!-- 전자결재 하위 메뉴 -->
               <ul class="nav collapse" id="edsm">
                  <li class="nav-item">
                  <a class="nav-link dropdown-indicator"
                     href="#drafting" role="button" data-bs-toggle="collapse"
                     aria-expanded="false" aria-controls="drafting">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1" aria-hidden="true"
                              focusable="false" data-prefix="fas">기안</span>
                        </div>
                  </a></li>
                  <!-- 기안 하위 메뉴 -->
                  <ul class="nav collapse" id="drafting">
                     <li class="nav-item"><a class="nav-link" href="/draft/form">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">문서 양식</span>
                           </div>
                     </a></li>
                     <li class="nav-item"><a class="nav-link"
                        href="/draft/doc/temp">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">임시 저장</span>
                           </div>
                     </a></li>
                  </ul>
                  <li class="nav-item"><a class="nav-link dropdown-indicator"
                     href="#docubox" role="button" data-bs-toggle="collapse"
                     aria-expanded="false" aria-controls="docubox">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">문서함</span>
                        </div>
                  </a></li>
                  <!-- 문서함 하위 메뉴 -->
                  <ul class="nav collapse" id="docubox">
                     <li class="nav-item"><a class="nav-link"
                        href="/draft/doc?category=during">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">기안 문서</span>
                           </div>
                     </a></li>
                     <li class="nav-item"><a class="nav-link"
                        href="/draft/ram">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">회람 문서</span>
                           </div>
                     </a></li>
                     <li class="nav-item"><a class="nav-link"
                        href="/draft/susin">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">수신 문서</span>
                           </div>
                     </a></li>
                  </ul>
                  <li class="nav-item"><a class="nav-link dropdown-indicator"
                     href="#signoffon" role="button" data-bs-toggle="collapse"
                     aria-expanded="false" aria-controls="signoffon">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">결재</span>
                        </div>
                  </a></li>
                  <ul class="nav collapse" id="signoffon">
                     <li class="nav-item"><a class="nav-link"
                        href="/draft/doc/atrz">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">결재 문서</span>
                           </div>
                     </a></li>
                  </ul>
               </ul>
               </li> <!-- ////////////////////////////////////// 전자결재 끝 //////////////////////////////////////-->
               <!-- ////////////////////////////인사관리 시작/////////////////////////////// -->
               <!-- label--> 
            <li class="nav-item">
                  <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                     <div class="col-auto navbar-vertical-label" id="gugu">인사관리</div>
                     <div class="col ps-0">
                        <hr class="mb-0 navbar-vertical-divider" />
                     </div>
                  </div>
                  <a class="nav-link dropdown-indicator" href="#hrm" role="button"
                     data-bs-toggle="collapse" aria-expanded="false"
                     aria-controls="hrm" id="gugu">
                     <div class="d-flex align-items-center">
                        <span class="nav-link-icon"> <span
                           class="fa-solid fa-user-tie"></span>
                        </span> <span class="nav-link-text ps-1">개인 인사관리</span>
                     </div>
                  </a>
                     <!-- 개인 인사정보 하위메뉴 -->
                     <ul class="nav collapse" id="hrm">
                        <li class="nav-item"><a class="nav-link"
                           href="/empInfo/empInfo">
                              <div class="d-flex align-items-center">
                                 <span class="nav-link-text ps-1">인사 정보</span>
                              </div>
                        </a></li>
                        <li class="nav-item"><a class="nav-link"
                           href="/empInfo/vacinfopersonal">
                              <div class="d-flex align-items-center">
                                 <span class="nav-link-text ps-1">연차 정보</span>
                              </div>
                        </a></li>
                        <li class="nav-item"><a class="nav-link"
                           href="/empInfo/payment">
                              <div class="d-flex align-items-center">
                                 <span class="nav-link-text ps-1">급여 정보</span>
                              </div>
                        </a></li>
                     </ul>
                     <!-- 개인 인사정보 하위메뉴 -->
                     
                     <security:authorize access="hasRole('ADMIN')">
                     <a class="nav-link dropdown-indicator" href="#personnel" role="button"
                     data-bs-toggle="collapse" aria-expanded="false"
                     aria-controls="hrm" id="gugu">
                     <div class="d-flex align-items-center">
                        <span class="nav-link-icon"> <span
                           class="fas fa-users"></span>
                        </span> <span class="nav-link-text ps-1">직원 인사관리</span>
                     </div>
                  </a>
                  <!-- 전직원 인사관리 하위메뉴 -->
                  <ul class="nav collapse" id="personnel">
                     <li class="nav-item"><a class="nav-link"
                        href="/empInfo/personnel/vacinfoemployee">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">직원 연차 정보</span>
                           </div>
                     </a></li>
                     <li class="nav-item"><a class="nav-link"
                        href="/empInfo/personnel/paymentemployee">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">직원 급여 정보</span>
                           </div>
                     </a></li>
                     <li class="nav-item"><a class="nav-link"
                        href="/empChart/empInfo">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">인사정보 현황</span>
                           </div>
                     </a></li>
                     
                  </ul>
                     <!-- 전직원 인사관리 하위메뉴 -->
                     </security:authorize>
               </li>
                <!-- ////////////////////////////인사관리 끝/////////////////////////////// -->

               <!--------------------------- 게시판 시작 ------------------------- -->
            <li class="nav-item">
               <!-- label-->
               <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                  <div class="col-auto navbar-vertical-label" id="gugu">게시판</div>
                  <div class="col ps-0">
                     <hr class="mb-0 navbar-vertical-divider" />
                  </div>
               </div> <!-- parent pages--> <a class="nav-link dropdown-indicator"
               href="#notice" role="button" data-bs-toggle="collapse"
               aria-expanded="false" aria-controls="support-desk" id="gugu">
                  <div class="d-flex align-items-center">
                      <span class="far fa-edit" style="margin-right: 15px;"></span>
                      게시판
                  </div>

            </a>
               <ul class="nav collapse" id="notice">
                  <li class="nav-item"><a class="nav-link" href="/notice/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">공지사항</span>
                        </div>
                  </a> <!-- more inner pages--></li>
                  <li class="nav-item"><a class="nav-link" href="/board/list">
                        <div class="d-flex align-items-center">
                           <span class="nav-link-text ps-1">사내게시판</span>
                        </div>
                  </a> <!-- more inner pages--></li>
               </ul> 
            </li>
            <!-- ------------------------- 게시판 끝 ------------------------- -->

            <security:authorize access="hasRole('ADMIN')">
               <li class="nav-item">
                  <!-- label-->
                  <div class="row navbar-vertical-label-wrapper mt-3 mb-2">
                     <div class="col-auto navbar-vertical-label" id="gugu">관리자</div>
                     <div class="col ps-0">
                        <hr class="mb-0 navbar-vertical-divider" />
                     </div>
                  </div> <!-- parent pages--> <a class="nav-link dropdown-indicator"
                  href="#email" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="email" id="gugu">
                     <div class="d-flex align-items-center">
                        <span class="fas fa-bookmark"style="margin-right: 15px;"></span><span
                           class="nav-link-text ps-1">기초등록</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="email">
                     <li class="nav-item"><a class="nav-link"
                        href="app/email/inbox.html">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">거래처등록</span>
                           </div>
                     </a> <!-- more inner pages--></li>

                     <li class="nav-item"><a class="nav-link"
                        href="app/email/email-detail.html">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">불량등록</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                     <li class="nav-item"><a class="nav-link" href="/item/view">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">품목등록</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </ul> <!-- parent pages--> <a class="nav-link dropdown-indicator"
                  href="#support-desk" role="button" data-bs-toggle="collapse"
                  aria-expanded="false" aria-controls="support-desk" id="gugu">
                     <div class="d-flex align-items-center">
                        <span class="fas fa-cog" style="margin-right: 15px;"></span><span
                           class="nav-link-text ps-1">시스템관리</span>
                     </div>
               </a>
                  <ul class="nav collapse" id="support-desk">
                     <li class="nav-item"><a class="nav-link"
                        href="/emp/logList">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">로그관리</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                     <!-- //////////////////////사원 관리///////////////////////// -->
                     <li class="nav-item"><a class="nav-link"
                        href="/emp/selectList">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">사원관리</span>
                           </div>
                     </a></li>
                     <!-- //////////////////////사원 관리 끝///////////////////////// -->
                     <li class="nav-item"><a class="nav-link"
                        href="/account/list">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">계정관리</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                     <li class="nav-item"><a class="nav-link"
                        href="/commCd/commonCodeList">
                           <div class="d-flex align-items-center">
                              <span class="nav-link-text ps-1">공통코드관리</span>
                           </div>
                     </a> <!-- more inner pages--></li>
                  </ul>
               </li>

            </security:authorize>
         </ul>

      </div>
   </div>
</nav>