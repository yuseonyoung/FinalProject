<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <!--  [[개정이력(Modification Information)]]       -->
<!--  수정일        수정자     수정내용               -->
<!--  ==========   ======    ==============        -->
<!--  2023. 11. 22.}     황수빈     최초작성               -->
<!--  Copyright (c) 2023 by DDIT All right reserved -->
 <!DOCTYPE html>
 <html>
 <head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 </head>
 <body>
 <h2>공지 사항</h2>
 <div class="card mb-3">
            <div class="card-header">
              <h5 class="mb-0" data-anchor="data-anchor" id="custom-styles">${noticeVO.ntcTitle }<a class="anchorjs-link " aria-label="Anchor" data-anchorjs-icon="#" href="#custom-styles" style="padding-left: 0.375em;"></a></h5>
            </div>
            <div class="card-body bg-body-tertiary">
              <p class="mb-0 mt-2">
              	${noticeVO.ntcCont }
              </p>
            </div>
          </div>
          
 </body>
 </html>
