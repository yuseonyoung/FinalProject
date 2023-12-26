<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<script src="/resources/js/ckeditor/ckeditor.js"></script>
<!-- <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script> -->
<!--  [[개정이력(Modification Information)]]       -->
<!--  수정일        수정자     수정내용               -->
<!--  ==========   ======    ==============        -->
<!--  2023. 11. 21.}     황수빈     최초작성               -->
<!--  Copyright (c) 2023 by DDIT All right reserved -->

<script>
$(function(){
	$("#btnRegister").on("click",function(){
		alert("눌렀닝?");
		let ntcNm = $("#ntcNm").val();
		let ntcTitle = $("#ntcTitle").val();
		let ntcCont = CKEDITOR.instances.ntcCont.getData();
		//json오브젝트
		let data = {
			"ntcNm":ntcNm,
			"ntcTitle":ntcTitle,
			"ntcCont":ntcCont
		};
		
		console.log("data : ",data);
		
		//아작났어유..피씨다타써
		//contentType : 보내는타입
		//dataType : 응답타입
		/*요청URI : /notice/pageCreatePost
		  요청파라미터 : {"ntcNm": "E201802180101","ntcTitle": "adf", "ntcCont": "<p>ss</p>\n"}
		  요청방식 : post
		*/
		$.ajax({
			type:"post",
			url:"/notice/pageCreatePost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				
				/*
				{
				    "ntcNo": "NTC0000126",
				    "ntcTitle": "개똥이공지",
				    "ntcCont": "<p>개똥이 내용</p>\n",
				    "ntcRdate": null,
				    "ntcHit": 0,
				    "ntcNm": "E201802180101"
				}
				*/
				
				console.log("result : ",result);E

				location.href="/notice/pageDetail?ntcNo="+result.ntcNo;
			}
		});
	});
});
</script>

<!-- 로그인은 했니? -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.realUser" var="realUser" /><!-- 로그인 정보를 변수에 담음 -->
</sec:authorize>

<form id="frm" name="frm" action="/notice/pageDetailUpdatePost" method="post">
<input type="hidden" id="ntcNm" name="ntcNm" value="${realUser.empCd}" />
<input type="hidden" id="ntcNo" name="ntcNo" value="${detail.ntcNo}" />
<div class="mb-3">
	<label class="form-label" for="exampleFormControlInput1">제목</label>
	<input class="form-control" name="ntcTitle" id="ntcTitle" 
	value="${detail.ntcTitle}" type="text" placeholder="제목을 입력해주세요" required />
</div>
<div class="mb-3">
	<label class="form-label" for="exampleFormControlTextarea1">내용</label>
	<textarea class="form-control" id="ntcCont" name="ntcCont" rows="3">${detail.ntcCont}</textarea>
</div>
<div class="card-footer clearfix">
     	<div class="d-flex justify-content-center mt-3">
       </div>
        <div style="float:right;">
        	<button class="btn btn-sm btn-primary px-4 ms-2" type="submit" id="btnConfirm"
        	 data-list-pagination="next"><span>확인</span></button>
        	 <a href="/notice/pageDetail?ntcNo=${detail.ntcNo}" class="btn btn-sm btn-primary px-4 ms-2" type="button" id="btnCancel"
        	 data-list-pagination="next"><span>취소</span></a>
        </div>
     </div>
     <sec:csrfInput/>
</form>
<script>
	// CKEditor를 적용할 textarea의 ID로 CKEditor를 생성
	CKEDITOR.replace('ntcCont');
</script>
