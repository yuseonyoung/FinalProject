<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>  
<script src="/resources/js/ckeditor/ckeditor.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script> -->
<!--  [[개정이력(Modification Information)]]       -->
<!--  수정일        수정자     수정내용               -->
<!--  ==========   ======    ==============        -->
<!--  2023. 11. 21.}     황수빈     최초작성               -->
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
        let ntcNm = $("#ntcNm").val();
        let ntcTitle = $("#ntcTitle").val();
        let ntcCont = CKEDITOR.instances.ntcCont.getData();
        let ntcRdate = $("#ntcRdate").val();

        // json 오브젝트
        let data = {
            "ntcNm": ntcNm,
            "ntcTitle": ntcTitle,
            "ntcCont": ntcCont,
            "ntcRdate": ntcRdate
        };

        console.log("data : ", data);

        // Ajax 호출
        $.ajax({
            url: "/notice/pageCreatePost",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log("result : ", result);
                location.href = "/notice/pageDetail?ntcNo=" + result.ntcNo;
            }
        });
    });//end register
    
    var ntcNoToDelete = "${detail.ntcNo}";

    // 삭제 버튼 클릭 시
    $("#deleteBtn").on("click", function() {
        // 확인 대화상자를 띄우고 사용자가 확인을 누른 경우에만 Ajax로 삭제 요청 전송
        if (confirm("삭제하시겠습니까?")) {
            // 서버로 DELETE 요청을 보냄
            $.ajax({
                url: '/notice/pageDetailDelete',  // 실제 서버 엔드포인트로 변경
//                 type: 'DELETE',
                type: 'GET',
                 data: { ntcNo: ntcNoToDelete  },
                data: "ntcNo=" + ntcNoToDelete,
                success: function(data) {
                	if(data==1){
                    	alert("삭제되었습니다.");
                    	// 삭제가 성공하면 notice/list 페이지로 이동
                    	 window.location.href = '/notice/list';
                	}else{
	                    alert("삭제에 실패했습니다.");
                	}
                },
                error: function(error) {
                    console.error('삭제 중 오류 발생:', error);
                    alert("삭제에 실패했습니다.");
                }
            });
        }
    });//end delete



	var ntcNoToUpdate = "${detail.ntcNo}";
	
	// 삭제 버튼 클릭 시
	$("#updateBtn").on("click", function() {
		location.href="/notice/pageDetailUpdate?ntcNo=${param.ntcNo}";
    // 확인 대화상자를 띄우고 사용자가 확인을 누른 경우에만 Ajax로 삭제 요청 전송
 //   if (confirm("수정하시겠습니까?")) {
//         // 서버로 DELETE 요청을 보냄
//         $.ajax({
//             url: '/notice/pageDetailUpdate',  // 실제 서버 엔드포인트로 변경
// //             type: 'UPDATE',
//             type: 'GET',
// //             data: { ntcNo: ntcNoToDelete  },
//             data: "ntcNo=" + ntcNoToUpdate,
//             success: function(data) {
//             	if(data==1){
//                 	alert("수정되었습니다.");
//             	}else{
//                     alert("수정에 실패했습니다.");
//             	}
//             },
//             error: function(error) {
//                 console.error('수정 중 오류 발생:', error);
//                 alert("수정에 실패했습니다.");
//             }
//       	  });
    
// 		});
	});//end update
	
	
});
<!-- 수정 창으로 이동  -->

// $(function(){
//     $("#updateBtn").on("click", function(){
//         let ntcTitle = $("#ntcTitle").val();
//         let ntcCont = CKEDITOR.instances.ntcCont.getData();
       

//         // json 오브젝트
//         let data = {
            
//             "ntcTitle": ntcTitle,
//             "ntcCont": ntcCont,
            
//         };

//         console.log("data : ", data);

//         // Ajax 호출
//         $.ajax({
//             url: "/notice/pageCreatePost",
//             contentType: "application/json;charset=utf-8",
//             data: JSON.stringify(data),
//             type: "post",
//             beforeSend: function(xhr) {
//                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//             },
//             success: function(result) {
//                 console.log("result : ", result);
//                 location.href = "/notice/pageDetail?ntcNo=" + result.ntcNo;
//             }
//         });
//     });

<!-- 수정 창으로 이동 끝  -->

</script>

<!-- 로그인은 했니? -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.realUser" var="realUser" /><!-- 로그인 정보를 변수에 담음 -->
</sec:authorize>

	<div class="Title">
		<h2>공지 사항</h2>
	</div>

<div class="sb_wrap">	
 <table
                  class="table table-bordered align-middle text-align border border-2" style="border:1px solid black;margin-left:auto;margin-right:auto;">
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
                        <td class="text-center"  style="background-color: white;color: black;">공지</td>
                        <td class="text-center bg-primary-subtle">제목</td>
                        <td class="text-center"   style="background-color: white;color: black;" id="empGend"  colspan="4">${detail.ntcTitle }</td>
                     
                     </tr>
                     <tr>
                        <td class="text-center bg-primary-subtle">작성자</td>
                        <td class="text-center"    style="background-color: white;color: black;">
                        <c:if test="${detail.empCd=='2013020001'}">
                        	관리자
                        </c:if>
                        <c:if test="${detail.empCd!='2013020001'}">
                        	${detail.empNm}
                        </c:if>
                        </td>
                        <td class="text-center bg-primary-subtle" >등록일</td>
                        <td class="text-center"    style="background-color: white;color: black;">${detail.ntcRdate}</td>
                        <td class="text-center bg-primary-subtle" >조회수</td>
                        <td class="text-center"    style="background-color: white;color: black;">${detail.ntcHit}</td>
                     </tr>
                     <tr class="empInfoPersonalDiv">
                        <td class="text-center bg-primary-subtle" >내용</td>
                        <td class="text-center" colspan="5"   style="background-color: white;color: black;">${detail.ntcCont}</td>
                       	
                     </tr>


                     
                  </tbody>
               </table>
     <div id="bigBtnbox" >
     <security:authorize access="hasRole('ADMIN')">
	<div style="float:right;">
	         	<a id="deleteBtn" class="btn btn-sm btn-primary px-4 ms-2" type="button" data-list-pagination="next"   style="background-color: white;color:red"><span>삭제</span></a>
	</div>
	<div style="float:right;">
	         	<a id="updateBtn" class="btn btn-sm btn-primary px-4 ms-2" type="button" data-list-pagination="next"   style="background-color: white;color:green"><span>수정</span></a>
	</div>
	</security:authorize>
	<div style="float:right;">
	         	<a href="/notice/list" id="listBtn" class="btn btn-sm btn-primary px-4 ms-2" type="button" data-list-pagination="next"   style="background-color: white;color:blue"><span>목록</span></a>
	</div>
</div> 
	  <div id="button" class="box" >
       <button onclick="fShowHide()"
       style=" color:white; border:1px solid #1e90ff;cursor: pointer;border-radius: 5px;
       background-color:#1e90ff;">첨부파일</button>
</div>
<div id="sbFileList" style="display:none">
	<table class="table table-bordered align-middle text-align border border-2">
		<tr>
			<th>파일명</th>
			<th>파일사이즈</th>
			<th>파일다운</th>
		</tr>
	<c:forEach items="${detail.atchFileDetailVO }" var="atchFileDetail">
		<tr>
			<td>${atchFileDetail.orignlFileNm }</td>
			<td>${atchFileDetail.fileSize }</td>
			<td><a href="/resources/upload${atchFileDetail.streFileNm }" download="${atchFileDetail.orignlFileNm }">DownLoad</a> </td>
		</tr>
	
	</c:forEach>	
	</table>
	</div>
</div>

<div id="panel" class="box" style="height:100px; line-height: 85px;">
    
</div>
	
	
  
<script>
const $sbFileList = $("#sbFileList");
function fShowHide(){
	if($sbFileList.css("display") == "none")
		$sbFileList.css("display","block");
	else 
		$sbFileList.css("display","none");	
}


	// CKEditor를 적용할 textarea의 ID로 CKEditor를 생성
	CKEDITOR.replace('ntcCont');
</script>
