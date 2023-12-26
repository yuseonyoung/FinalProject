<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<script src="/resources/js/ckeditor/ckeditor.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script> -->
<!--  [[개정이력(Modification Information)]]       -->
<!--  수정일        수정자     수정내용               -->
<!--  ==========   ======    ==============        -->
<!--  2023. 12. 02.}     황수빈     최초작성               -->
<!--  Copyright (c) 2023 by DDIT All right reserved -->
<style>
	.bg-body-tertiary{
	height: 900px;
	}
	
	hr{
	border:  1px solid lightgray;
	}
	#Nm{
		display: block;
		text-align: right;
		margin-right: 200px;
	}
	#mm{
		text-align: right;
		display: inline;
	}

	.card-header pwidth:50%; float: left;padding-top: 10px;width:50%;
	/* line-height: 7px; */
	float: left;padding-top: 10p;width:50%;
	/* line-height: 7px; */
	float: left;padding-top: 10;width:50%;
	/* line-height: 7px; */
	float: left;padding-top: 1;width:50%;
	/* line-height: 7px; */
	
	
	/* 초기에 숨겨진 상태로 설정 */
        #dataContainer {
            display: none;
            overflow: hidden;
            transition: height 0.5s ease; /* 슬라이드 다운 효과를 위한 트랜지션 설정 */
        }
        #listBtn{
        	border: 1px solid blue;
        	border-radius: 5px;
        	background-color: white;
        	
        }
        #button{
        	margin-bottom: 50px;
        }
        
        .sb_wrap{width:80%; margin:0 auto;}
</style>
<script type="text/javascript">

$(function(){
    $("#btnRegister").on("click", function(){
        let brdNm = $("#brdNm").val();
        let brdTitle = $("#brdTitle").val();
        let brdCont = CKEDITOR.instances.brdCont.getData();
        let brdRdate = $("#brdRdate").val();

        // json 오브젝트
        let data = {
            "brdNm": brdNm,
            "brdTitle": brdTitle,
            "brdCont": brdCont,
            "brdRdate": brdRdate
        };

        console.log("data : ", data);

        // Ajax 호출
        $.ajax({
            url: "/board/pageCreatePost",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log("result : ", result);
                location.href = "/board/pageDetail?brdNo=" + result.brdNo;
            }
        });
    });//end register
</script>

<!-- 로그인은 했니? -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.realUser" var="realUser" /><!-- 로그인 정보를 변수에 담음 -->
</sec:authorize>

	<div class="Title">
		<h2>사내 게시판</h2>
	</div>

<div class="sb_wrap">
<!-- 
요청URI : /board/createPost
요청파라미터 : {brdTitle=제목,brdCont=내용}
요청방식 : post
 -->
	<form id="frm" name="frm"
		action="/board/createPost?${_csrf.parameterName}=${_csrf.token}"
		method="post" enctype="multipart/form-data">
		<table
			class="table table-bordered align-middle text-align border border-2"
			style="border: 1px solid black; margin-left: auto; margin-right: auto;">
			<colgroup>
				<col width="15%">
				<col width="18%">
				<col width="15%">
				<col width="18%">
				<col width="15%">
				<col width="18%">
			</colgroup>
			<tbody>
				<tr>
					<td class="text-center bg-primary-subtle">글 유형</td>
					<td class="text-center"
						style="background-color: white; color: black;">게시판</td>
					<td class="text-center bg-primary-subtle">작성자</td>
					<td class="text-center"
						style="background-color: white; color: black;" id="empGend"
						colspan="4">${realUser.empNm}</td>
				</tr>
				<tr>
					<td class="text-center bg-primary-subtle">제목</td>
					<td class="text-center" colspan="5"
						style="background-color: white; color: black;"><input
						class="form-control" name="brdTitle" id="brdTitle" type="text"
						placeholder="제목을 입력해주세요" required /></td>
				</tr>
				<tr class="empInfoPersonalDiv">
					<td class="text-center bg-primary-subtle">내용</td>
					<td class="text-center" colspan="5"
						style="background-color: white; color: black;"><textarea
							rows="3" cols="5" id="brdCont" name="brdCont"></textarea></td>
				</tr>
			</tbody>
		</table>
		<div id="bigBtnbox">
			<div id="button" class="box" style="float: left;">
				<input class="form-control" id="uploadFile" name="uploadFile"
					type="file" multiple="" />
			</div>
			<div style="float: right;">
				<a href="/board/list" class="btn btn-sm btn-primary px-4 ms-2"
					data-list-pagination="next"
					style="background-color: white; color: red"><span>취소</span></a>
			</div>
			<div style="float: right;">
				<button type="submit" class="btn btn-sm btn-primary px-4 ms-2"
					data-list-pagination="next"
					style="background-color: white; color: blue">
					<span>등록</span>
				</button>
			</div>
		</div>
		<sec:csrfInput />
	</form>
	<br />




	<script type="text/javascript">
//CKEDITOR사용
CKEDITOR.replace("brdCont");

const $sbFileList = $("#sbFileList");
function fShowHide(){
	if($sbFileList.css("display") == "none")
		$sbFileList.css("display","block");
	else 
		$sbFileList.css("display","none");	
}


	// CKEditor를 적용할 textarea의 ID로 CKEditor를 생성
	CKEDITOR.replace('brdCont');
</script>
