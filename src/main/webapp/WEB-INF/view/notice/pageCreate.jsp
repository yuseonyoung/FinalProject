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
		let ntcNm = $("#ntcNm").val();
		let ntcTitle = $("#ntcTitle").val();
		let ntcCont = CKEDITOR.instances.ntcCont.getData();
		
		//가상의 form 태그 생성 <form></form>
		let formData = new FormData();
		//<input class="form-control" id="uploadFile" name="uploadFile" type="file" multiple />
		let inputFile = $("input[name='uploadFile']");
		//파일 object 안에 이미지를 가져와보자
		//inputFile[0] : input type="file"
		//.files : 그 안에 들어있는 이미지 
		let files = inputFile[0].files;
		//files : [object FileList]
		console.log("files : ", files);
		
		//가상의 form인 formData Object에 filedata를 추가해보자
		for(let i=0;i<files.length;i++){
			//<form><input type='file' name='uploadFile' /></form>
			formData.append("uploadFile",files[i]);
		}
		
		/*
		<form>
			<input type="file" name="uploadFile" />
			<input type="file" name="uploadFile" />
			<input type="file" name="uploadFile" />
			<input type="text" name="ntcNm" value="a001" />
			<input type="text" name="ntcTitle" value="글제목" />
			<input type="text" name="ntcCont" value="글내용" />
		</form>
	*/
		formData.append("ntcNm",ntcNm);
		formData.append("ntcTitle",ntcTitle);
		formData.append("ntcCont",ntcCont);
		
		//아작났어유..피씨다타써
		//contentType : 보내는타입
		//dataType : 응답타입
		/*요청URI : /notice/pageCreatePost
		  요청파라미터 : {"ntcNm": "E201802180101","ntcTitle": "adf", "ntcCont": "<p>ss</p>\n","uploadFile":"파일객체들"}
		  요청방식 : post
		*/
		$.ajax({
			url:"/notice/pageCreatePost",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				
				console.log("result : ",result);

				location.href="/notice/pageDetail?ntcNo="+result;
			}
		});
	});
});
</script>

<!-- 로그인은 했니? -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.realUser" var="realUser" /><!-- 로그인 정보를 변수에 담음 -->
</sec:authorize>

<%-- <p>${realUser}</p> --%>

<input type="hidden" id="ntcNm" name="ntcNm" value="${realUser.empCd}" />
<div class="mb-3">
	<label class="form-label" for="exampleFormControlInput1">제목</label>
	<input class="form-control" name="ntcTitle" id="ntcTitle" type="text" placeholder="제목을 입력해주세요" required />
</div>
<div class="mb-3">
	<label class="form-label" for="exampleFormControlTextarea1">내용</label>
	<textarea class="form-control" id="ntcCont" name="ntcCont" rows="3"></textarea>
</div>
<div class="card-footer clearfix">
     	<div class="d-flex justify-content-center mt-3">
       </div>
        <div style="float:right;">
        	<button class="btn btn-sm btn-primary px-4 ms-2" type="button" id="inputDataOpen" data-list-pagination="next"><span>일괄입력</span></button>
        </div>
        <div style="float:right;">
        	<button class="btn btn-sm btn-primary px-4 ms-2" type="button" id="btnRegister" data-list-pagination="next"><span>등록</span></button>
        	<a href="/notice/list" class="btn btn-sm btn-primary px-4 ms-2" type="button" id="btnRegister" data-list-pagination="next"><span>취소</span></a>
        </div>
        <div style="float:left;">
	         	<input class="form-control" id="uploadFile" name="uploadFile" type="file" multiple />
		</div>
     </div>
<script>
$("#inputDataOpen").on("click", function() {
   $("#ntcTitle").val("AIM 창립 기념 행사 안내");
 	//내용 미리 넣기
 	let str = "<p style='text-align:center'>직원 여러분 안녕하십니까 ?</p>";
 		str += "<p style='text-align:center'>AIM 창립 5주년을 맞이하여 창립 기념 행사를 하려고 합니다.&nbsp;</p>";
 		str += "<p style='text-align:center'>5년전 오늘이 있기 위해 사람들이 있었습니다.</p>";
 		str += "<p style='text-align:center'>오직 신념하나로 판매한 영업사원이 있었습니다.</p>";
 		str += "<p style='text-align:center'>그로부터 5년이 지난 2011년 오늘, 바로 오늘이 있기 위해 또 많은 사람돠 가슴 찡한 사연들이 있었습니다.</p>";
 		str += "<p style='text-align:center'>&nbsp;</p>";
 		str += "<p style='text-align:center'>그들이 오늘의 AIM입니다.&nbsp;</p>";
 		str += "<p style='text-align:center'>가족 여러분 ! 오늘은 창립 기념일. 생일 입니다.</p>";
 		str += "<p style='text-align:center'>5년 전 오늘 태어난 꿈과 소망과 사명과 희망은 바로 여기 있는&nbsp;</p>";
 		str += "<p style='text-align:center'>우리 가족 여러분 입니다.&nbsp;</p>";
 		str += "<p style='text-align:center'>&nbsp;</p>";
 		str += "<p style='text-align:center'>탄생을 축하합니다. 감사합니다.&nbsp;</p>";
 		str += "<p style='text-align:center'>&nbsp;</p>";
 		str += "<p style='text-align:center'>2023년 12월 06일&nbsp;</p>";
 		str += "<p style='text-align:center'>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 대표 유선영</p>";
 		str += "<p>&nbsp;</p>";
	CKEDITOR.instances.ntcCont.setData(str); 
 });
</script>
<script>
	// CKEditor를 적용할 textarea의 ID로 CKEditor를 생성
	CKEDITOR.replace('ntcCont');
</script>
