<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  
<script src="/resources/js/ckeditor/ckeditor.js"></script>
<style>
	.close{
		    border: solid 1px white;
	    	background-color: white;
}
.replyname{
	width: 10px;
	height: 5px;
	border:  solid 1px red;
}

</style>
<!-- <script type="text/javascript" src="/resources/js/jquery.min.js"></script> -->
<script type="text/javascript">
 <!--  [[개정이력(Modification Information)]]       -->
<!--  수정일        수정자     수정내용               -->
<!--  ==========   ======    ==============        -->
<!--  2023. 11. 21.}     황수빈     최초작성               -->
<!--  Copyright (c) 2023 by DDIT All right reserved -->
<!-- 게시판에서 사내게시판 누르면 나오는 리스트 페이지  -->


$(function(){
	dataType:"json",
	sucess:function(rsult){
		
		console.log("result8 : ",result);
		
		$.each(result,function(index,noticeVO){
			console.log(noticeVO)
		});
	}
	
});

$('#dataTable').DataTable({
    paging: true,
    searching: true,
    lengthChange: false,
    info: false,
    ordering: false,
    
});
})
		
	
	<!-- 페이징 끝 -->
	
</script>
<div id="listBody">



	<style>
input {
	border: none;
}
</style>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>
	<div class="card mb-3 px-3">
		<div class="card-header ">
			<div class="row flex-between-end">
				<div class="col-auto align-self-center">
					<br>
					<h3 class="mb-0">사내게시판</h3>
				</div>
				<div class="col-auto ms-auto">
					<div class="nav nav-pills nav-pills-falcon flex-grow-1 mt-2"
						role="tablist"></div>
				</div>
			</div>
		</div>
		<div class="card-body pt-0 ">
			<div class="tab-content">
				<div class="tab-pane preview-tab-pane active" role="tabpanel"
					aria-labelledby="tab-dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8"
					id="dom-bb1c70a1-6c4c-451a-80b8-972dfdd01aa8">
					<div>
						<div id="relsList" class="dataTables_wrapper dt-bootstrap5 no-footer">
							<div class="row">
								<div class="col-sm-12 col-md-6"></div>
								<div class="col-sm-12 col-md-6">
								<form id="frm" name="frm" action="/board/list" method="get">
									<div id="relsListDataTable_filter" class="dataTables_filter">
										<label>Search:
											<input type="hidden" id="currentPage" name="currentPage" value="1" />
											<input type="text" name="keyword" class="form-control form-control-sm" 
											value="${param.keyword}" placeholder="검색어를 입력해주세요"
											aria-controls="relsListDataTable" />
											<button type="submit" class="btn btn-info btn-flat" style="height: 30px;">검색</button>
										</label>
									</div>
								</form>
								</div>
							</div>
							<div class="row dt-row">
								<div class="col-sm-12">
									<table class="table table-bordered fs--1 mb-0 dataTable no-footer"
										id="rels">
										<thead class="bg-200 text-900">
											<tr>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 15%;text-align:center;">글번호</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 40%;text-align:center;">제목</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 10%;text-align:center;">등록일</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 15%;text-align:center;">작성자</th>
												<th class="sorting_disabled" rowspan="1" colspan="1"
													style="width: 10%;text-align:center;">조회수</th>
											</tr>
										</thead>
										<tbody class="list2" style="cursor: pointer;text-align: center;">
											<!-- data : paging -->
											<c:forEach var="boardVO" items="${data.dataList}">
											<tr class="odd" data-brd-no="${boardVO.brdNo}">
												<td class="pordCdValue">${boardVO.rnum1}</td>
												<td>${boardVO.brdTitle}</td>
												<td>${boardVO.brdRdate}</td>
												<td>
												<c:if test="${boardVO.empNm eq 'admin' }">
													관리자
												</c:if>
												<c:if test="${boardVO.empNm ne 'admin' }">
													${boardVO.empNm }
												</c:if>
												</td>
												<td>${boardVO.brdHit}</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="card-footer clearfix">
								${data.getPagingHTML()}
								<div style="float: left;justify-content;left;display:flex;">
									<a href="/board/create"
										class="btn btn-primary px-4 ms-2" type="button"
										data-list-pagination="next"><span>등록</span></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="/resources/js/scheduledStock/inScheduledStock.js"></script>
</div>
<hr />
<!-- 사내게시판 상세 확인 Modal -->
<div class="modal fade" id="testModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content" id="bigbigbox" style="width:150%;margin:auto;">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">사내게시판 상세</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close" onclick="fModalHide()">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			
			<div class="modal-body" id="testModalBody">
				<!-- /////////////////////// 상세 영역 시작 ///////////////////////////////////////// -->
				<form id="frmUpDel" name="frm" action="/board/pageDetailUpdatePost" method="post">
					<input type="hidden" name="brdNo" id="brdNo0" value="" />
					<!-- 일반모드 시작 -->
					<span id="spn1">
						<div style="float: right;">
							<button id="deleteBtn" class="btn btn-sm btn-primary px-4 ms-2"
								type="button" data-list-pagination="next"
								style="background-color: white; color: indianred;">
								<span>삭제</span>
							</button>
						</div>
						<div style="float: right;">
							<a id="updateBtn" class="btn btn-sm btn-primary px-4 ms-2"
								type="button" data-list-pagination="next"
								style="background-color: white; color: gray"><span>수정</span></a>
						</div> 
					</span>
					<!-- 일반모드 끝 --> 
					<!-- 수정모드 시작 --> 
					<span id="spn2" style="display: none;">
						<div style="float: right;">
							<button id="confirmBtn" class="btn btn-sm btn-primary px-4 ms-2"
								type="submit" data-list-pagination="next"
								style="background-color: white; color: indianred;">
								<span>확인</span>
							</button>
						</div>
						<div style="float: right;">
							<a id="cancelBtn" class="btn btn-sm btn-primary px-4 ms-2"
								type="button" data-list-pagination="next"
								style="background-color: white; color: gray"><span>취소</span></a>
						</div>
					</span>
					 <!-- 수정모드 끝 -->
					<!-- 내용 시작 -->
					<table id="boxmodal"
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
						<tr>
							<td class="text-center bg-primary-subtle">글 유형</td>
							<td class="text-center"
								style="background-color: white; color: black;">사내게시판</td>
							<td class="text-center bg-primary-subtle">제목
							<td colspan="3" style="background-color: white; color: black;"
								sbTitle></td>
						</tr>
						<tr>
							<td class="text-center bg-primary-subtle">작성자</td>
							<td class="text-center"
								style="background-color: white; color: black;" sbWriter></td>
							<td class="text-center bg-primary-subtle">등록일</td>
							<td class="text-center"
								style="background-color: white; color: black;" sbDate></td>
							<td class="text-center bg-primary-subtle">조회수</td>
							<td class="text-center"
								style="background-color: white; color: black;" sbHit></td>
						</tr>
						<tr class="empInfoPersonalDiv">
							<td class="text-center bg-primary-subtle">내용</td>
							<td class="text-center" colspan="5"
								style="background-color: white; color: black;" sbCont></td>
			
						</tr>
					</table>
					<!-- 내용 끝 -->
					<sec:csrfInput />
				</form>
				<!-- /////////////////////// 상세 영역 끝 ///////////////////////////////////////// -->
				<!-- ///////////////////////첨부파일 시작/////////////////////// -->
				<div id="button" class="box">
					<button onclick="fShowHide()" type="button"
						style="color: white; border: 1px solid #1e90ff; cursor: pointer; border-radius: 5px; background-color: #1e90ff;">첨부파일</button>
				</div>

				<div id="sbFileList">
					<table id="tblFileList"
						class="table table-bordered align-middle text-align border border-2"
						style="width: 100%; display: none">
						<thead>
							<tr>
								<th style="width: 73%;">파일명</th>
								<th style="width: 30%;">파일사이즈22</th>
								<th style="width: 30%;">파일다운</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${detail.atchFileDetailVO }"
								var="atchFileDetail">
								<tr>
									<td>${atchFileDetail.orignlFileNm }</td>
									<td>${atchFileDetail.fileSize }</td>
									<td><a
										href="/resources/upload${atchFileDetail.streFileNm }"
										download="${atchFileDetail.orignlFileNm }">DownLoad</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- ///////////////////////첨부파일 끝/////////////////////// --> 
			</div>
			
           	
           	<!-- /////////////////////// 여기에 댓글 시작/////////////////////// -->
			<!--  댓글 입력 칸 시작 -->
			<div id="replyFormDiv">
            	<form id="frmRepl" name="frmRepl" action="/repl/createPost" method="post" 
            	class="d-flex align-items-center border-top border-200 pt-3" style="text-align:center;width: 90%;margin-bottom:30px;">
            		<input type="hidden" id="replBrdNo" name="brdNo" value="" />
            		<input type="hidden" id="replEmpCd" name="empCd" value="<%=request.getUserPrincipal().getName()%>" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input class="form-control rounded-pill fs--1 clsReplCont" type="text" name="replCont" style="margin-bottom:30px;width:90%;"
                    placeholder="댓글을 입력해주세요" required/>
            	<!-- 댓글 버튼 시작 -->
					<button class="rebtn" type="submit"
					style="float:left;float:left;width: 50px;
				    float: left;
				    width: 60px;
				    border: solid 1px white;
				    border-radius: 5px;
				    background-color: dodgerblue;
				    color: white;
				" >확인</button>
				<!-- 댓글 버튼 끝 -->
					<sec:csrfInput/>
            	</form>
           	</div>
			<div id="replyDiv">
				<div id="replyname">
					
				</div>
				<div class="d-flex mt-3">
					<div class="avatar avatar-xl">
						<img class="rounded-circle"
							src="/resources/images/board/수지사원.jpeg" alt="">
					</div>
					<div class="flex-1 ms-2 fs--1">
						<p class="nene sb01" sbReplyList></p>
						<div class="px-2">
							<a href="#!">Like</a> • <a href="#!">Reply</a> • 23min
						</div>
					</div>
				</div>
			</div> 
			<!-- /////////////////////// 여기에 댓글 끝/////////////////////// -->
		</div>
	</div>
</div>
<!-- 폼태그 -->
<!-- 
요청URI : /notice/list
요청파라미터 : keyword=개똥이
요청방식 : get
 -->
<script type="text/javascript">
var loginUserName = '${principal.realUser.empNm }';

function fn_paging(currentPage){
	console.log("currentPage : " + currentPage);
	
	$("#currentPage").val(currentPage);
	
	$("#frm").submit();
}
</script>
<script>
	$(function(){
		<!-- 모달 창 내용 변경 스크립트 -->
	     // 수정 버튼 클릭 시 이벤트 처리
	        $("#updateBtn").on("click", function() {
	            // 내용 감추기
//	             $("#boxmodal").hide();
	            
	            // 수정 폼 보이기
//	             $("#modalfooter").show();
	            $("#spn1").css("display","none");
	            $("#replyFormDiv").css("display","none");//댓글등록영역 가림
				$("#replyDiv").css("display","none");//댓글영역 가림
				$("#spn2").css("display","block");
	            
	            $(".clsInput").removeAttr("readonly");
	            
	            let brdCont = $("#divBrdCont").html();
	            console.log("brdCont : " + brdCont);
	            
	            $("[sbCont]").html("<textarea class='form-control clsInput' name='brdCont' id='brdCont' cols='30' rows='7'>"+brdCont+"</textarea>");
	            CKEDITOR.replace('brdCont');
	            
	            $("#frmUpDel").attr("action","/board/pageDetailUpdatePost");  // -------------------------------
	            $("#button").css("display","none");
	        });

	     	//취소
	     	$("#cancelBtn").on("click",function(){
	     		$("#spn1").css("display","block");
				$("#spn2").css("display","none");
				$("#replyFormDiv").css("display","block");//댓글등록영역 보임
				$("#replyDiv").css("display","block");//댓글영역 보임
				
				$(".clsInput").attr("readonly","readonly");
				
				//sessionStorage.setItem("brdTitle",result.brdTitle);
	            //sessionStorage.setItem("brdCont",result.brdCont);
	            $("[sbTitle]").html("<input type='text' class='form-control clsInput' name='brdTitle' id='brdTitle' value='"+sessionStorage.getItem("brdTitle")+"' readonly />");
				//ckeditor 안에 있는 내용을 태그 포함해서 다 가져오기
				$("[sbCont]").html("<div id='divBrdCont'>"+sessionStorage.getItem("brdCont")+"</div>");
	            $("#button").css("display","inline-block");
	     	});
	     	
	     	//삭제
	     	$("#deleteBtn").on("click",function(){
	     		let brdNo = $("#brdNo0").val();
	     		console.log("brdNo : " + brdNo);
	     		
	     		if(confirm("삭제하시겠습니까?")){
	     			$("#frmUpDel").attr("action","/board/pageDetailDelete");
	     			$("#frmUpDel").submit();
	     		}else{
	     			alert("취소되었습니다.");
	     		}
	     	});
		
		//상세영역 하단 공백 제거
		$(".modal-body").css("flex","none");
		
		$(".clsReplCont").css("margin","0 0 0 0");
		
		$(".odd").on("click",function(){
			
			//data-brd-no="BRD0000007"
			let brdNo = $(this).data("brdNo");
			
			//목록 중 클릭한 tr 행의 조회수를 1 증가
			$(this).children("td").last().text(parseInt($(this).children("td").last().text())+1);
			
        	//BRD0000007
            console.log("brdNo : ", brdNo);
//             location.href = "/board/pageDetail?brdNo=" + params.data.brdNo;

			let data = {"brdNo":brdNo};
			console.log("data : ",data);
			
			$("#replBrdNo").val(brdNo);

			/*
			요청URI : /board/pageDetailAjax
			요청파라미터 : {"brdNo":"BRD0000007"}
			요청방식 : post
			*/
			$.ajax({
				url:"/board/pageDetailAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				success:function(result){
					console.log("result : ",result);
					
					$("#brdNo0").val(result.brdNo);
                    $("[sbTitle]").html("<input type='text' style='border:none' class='form-control clsInput' name='brdTitle' id='brdTitle' value='"+result.brdTitle+"' readonly />");
                    $("[sbWriter]").text(result.empNm);
                    $("[sbDate]").text(result.brdRdate);
                    $("[sbHit]").text(result.brdHit);
                    $("[sbCont]").html("<div id='divBrdCont'>"+result.brdCont+"</div>");
                    //"<textarea class='form-control clsInput' name='brdCont' id='brdCont' cols='30' rows='7' readonly>"+result.brdCont+"</textarea>"
					
					//$("#testModalBody").html(result.brdTitle);
                    //원본데이터를 뷰의 세션에 저장
                    sessionStorage.setItem("brdTitle",result.brdTitle);
                    sessionStorage.setItem("brdCont",result.brdCont);
                    
                    let str = "";
                    //<a href="/resources/upload/2023/11/30/99cccff3-5b5b-4a9f-9e07-1477104763fb_로고7 (1).jpg" download="로고7 (1).jpg">DownLoad</a>
                    //<a href="/resources/upload/2023/12/04/3820cd61-e63c-4a7f-aa61-dca99958710c_제목을 입력해주세요_-001 (9).png" download="제목을 입력해주세요_-001 (9).png">DownLoad</a>
                    $.each(result.atchBrdFileDetailVOList,function(idx,atchBrdFileDetailVO){
                    	if(atchBrdFileDetailVO.fileSize>0){
	                    	str += "<tr><td>"+atchBrdFileDetailVO.orignlFileNm+"</td><td>"+atchBrdFileDetailVO.fileSize+"</td>";
	                    	str += "<td><a href='/resources/upload"+atchBrdFileDetailVO.streFileNm+"' download='"+atchBrdFileDetailVO.orignlFileNm+"'>DownLoad</a></td></tr>';";
                    	}
                    });
                    
                    //첨부파일 처리
                    $("#tblFileList tbody").append(str);
                    
                    // 수정, 삭제 안보이깅, 보이깅
                    $("#spn1").css("visibility","hidden");  // 기본 안보이깅
                    // alert("체킁:" + loginUserName + ":" + result.empNm + "ppp");  // 디버깅
                    if(loginUserName == result.empNm){       // 로그인유저명과 글쓴이 이름이 같다면(정확히 하려면 코드값 비교 필요)
                    	// alert("왔엉?");  // 디버깅용
                        $("#spn1").css("visibility","visible");  // 보이겡                    	
                    }
                    
                    
                    //댓글
                    $.ajax({
						url:"/repl/replList",
						contentType:"application/json;charset=utf-8",
						data:JSON.stringify(data),
						type:"post",
						dataType:"json",
						success:function(result2){
							//List<ReplVO>
							console.log("result2 : ",result2);
							
							
							let rListHtml = "";
							var html = "";
							$.each(result2,function(idx,replVO){
								rListHtml += replVO.empCd + " : " + replVO.replCont + "<br>";
								
								console.log("replCont : " + replVO.replCont);
								console.log("empCd : " + replVO.empCd);

								// 로그인한 사용자와 댓글작성자가 같을 때망 수빈이가 수정삭제 허락
								if(replVO.empCd == '${sbPrincess.realUser.empCd}'){
									html += "<div class='d-flex p-3' id='div"+replVO.replNo+"'>";
									html += "<div style='width:50%;display:inline-block'></div>";
									html += "<div class='flex-1'>";
									html += "<div class='w-xxl-75'>";
									html += "<div class='hover-actions-trigger d-flex align-items-center'>";
									html += "<div class='chat-message bg-200 p-2 rounded-2'><span id='spnRepl"+replVO.replNo+"'>"+replVO.replCont+"</span><input type='text' id='txtRepl"+replVO.replNo+"' value='"+replVO.replCont+"' style='display:none;' /></div>";
									html += "<div class='avatar avatar-l me-2 ml-10'>";
									html += `<img style='position:relative;left:5px' class='rounded-circle' src='\${replVO.empImg}' alt='아바타'>`;
									html += "</div>";				
									html += "<ul class='hover-actions position-relative list-inline mb-0 text-400 ms-2'>";				
									html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_forward("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Forward' data-bs-original-title='Forward'><svg class='svg-inline--fa fa-share fa-w-16' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='share' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg=''><path fill='currentColor' d='M503.691 189.836L327.687 37.851C312.281 24.546 288 35.347 288 56.015v80.053C127.371 137.907 0 170.1 0 322.326c0 61.441 39.581 122.309 83.333 154.132 13.653 9.931 33.111-2.533 28.077-18.631C66.066 312.814 132.917 274.316 288 272.085V360c0 20.7 24.3 31.453 39.687 18.164l176.004-152c11.071-9.562 11.086-26.753 0-36.328z'></path></svg></a></li>";
									html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_archive("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Archive' data-bs-original-title='Archive'><svg class='svg-inline--fa fa-archive fa-w-16' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='archive' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg=''><path fill='currentColor' d='M32 448c0 17.7 14.3 32 32 32h384c17.7 0 32-14.3 32-32V160H32v288zm160-212c0-6.6 5.4-12 12-12h104c6.6 0 12 5.4 12 12v8c0 6.6-5.4 12-12 12H204c-6.6 0-12-5.4-12-12v-8zM480 32H32C14.3 32 0 46.3 0 64v48c0 8.8 7.2 16 16 16h480c8.8 0 16-7.2 16-16V64c0-17.7-14.3-32-32-32z'></path></svg></li>";
									html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_edit("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Edit' data-bs-original-title='Edit'><svg class='svg-inline--fa fa-edit fa-w-18' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='edit' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512' data-fa-i2svg=''><path fill='currentColor' d='M402.6 83.2l90.2 90.2c3.8 3.8 3.8 10 0 13.8L274.4 405.6l-92.8 10.3c-12.4 1.4-22.9-9.1-21.5-21.5l10.3-92.8L388.8 83.2c3.8-3.8 10-3.8 13.8 0zm162-22.9l-48.8-48.8c-15.2-15.2-39.9-15.2-55.2 0l-35.4 35.4c-3.8 3.8-3.8 10 0 13.8l90.2 90.2c3.8 3.8 10 3.8 13.8 0l35.4-35.4c15.2-15.3 15.2-40 0-55.2zM384 346.2V448H64V128h229.8c3.2 0 6.2-1.3 8.5-3.5l40-40c7.6-7.6 2.2-20.5-8.5-20.5H48C21.5 64 0 85.5 0 112v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V306.2c0-10.7-12.9-16-20.5-8.5l-40 40c-2.2 2.3-3.5 5.3-3.5 8.5z'></path></svg></a></li>";
									html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_remove("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Remove' data-bs-original-title='Remove'><svg class='svg-inline--fa fa-trash-alt fa-w-14' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='trash-alt' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 448 512' data-fa-i2svg=''><path fill='currentColor' d='M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V128H32zm272-256a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zM432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16z'></path></svg></a></li>";
									html += "</ul>";
									html += "</div>";
									html += "<div class='text-400 fs--2'><span>11:54 am</span></div>";
									html += "</div>";
									html += "</div>";
									html += "</div>";
								}else {
									html += "<div class='d-flex p-3' id='div"+replVO.replNo+"'>";
									html += "<div class='avatar avatar-l me-2'>";
									html += `<img class='rounded-circle' src='\${replVO.empImg}' alt='아바타'>`;
//									html += "<img class='rounded-circle' src='/resources/images/board/수지사원.jpeg' alt=''>";
									html += "</div>";
									html += "<div class='flex-1'>";
									html += "<div class='w-xxl-75'>";
									html += "<div class='hover-actions-trigger d-flex align-items-center'>";
									html += "<div class='chat-message bg-200 p-2 rounded-2'><span id='spnRepl"+replVO.replNo+"'>"+replVO.replCont+"</span><input type='text' id='txtRepl"+replVO.replNo+"' value='"+replVO.replCont+"' style='display:none;' /></div>";
									html += "<ul class='hover-actions position-relative list-inline mb-0 text-400 ms-2'>";
									html += "</ul>";
								    html += "</div>";
								    html += "<div class='text-400 fs--2'><span>"+replVO.replRdate+"</span></div>";
								    html += "</div>";
								    html += "</div>";
								    html += "</div>";
								}

							});
							
							$("#replyDiv").html(html);
							
							
						}
                    });
					
					$("#testModal").modal("show");
				}
			});

		});
	});
</script>

<script type="text/javascript">
	// 댓글 insert 
		const  frmRepl=$("#frmRepl")[0];

		console.log("동적생성",frmRepl);
		frmRepl.addEventListener("submit",()=>{
			event.preventDefault();  // submit 막기

			let ReplVO = {
				empCd:frmRepl.empCd.value, 
				replCont:frmRepl.replCont.value, 
				brdNo:frmRepl.brdNo.value,
				replNo:0, 
			}

			console.log("체킁:",ReplVO);
			frmRepl.replCont.value ="";
			//frmRepl.replCont.focus();
			$.ajax({
				type:"post",
				url:"/repl/createPost",
				contentType:"application/json",
				data: JSON.stringify(ReplVO),
				dataType:"json",
				success:(replVO)=>{
					console.log("체킁킁",replVO);
					
					let today = new Date();   

					let year = today.getFullYear(); // 년도
					let month = today.getMonth() + 1;  // 월
					let date = today.getDate();  // 날짜
					//let day = today.getDay();  // 요일

					let replRdate = year + '-' + month + '-' + date;
					
					// 답글 
					let html= "";
					html += "<div class='d-flex p-3' id='div"+replVO.replNo+"'>";
					html += "<div style='width:50%;display:inline-block'></div>";
					html += "<div class='flex-1'>";
					html += "<div class='w-xxl-75'>";
					html += "<div class='hover-actions-trigger d-flex align-items-center'>";
					html += "<div class='chat-message bg-200 p-2 rounded-2'><span id='spnRepl"+replVO.replNo+"'>"+replVO.replCont+"</span><input type='text' id='txtRepl"+replVO.replNo+"' value='"+replVO.replCont+"' style='display:none;' /></div>";
					html += "<div class='avatar avatar-l me-2 ml-10'>";
					html += `<img style='position:relative;left:5px' class='rounded-circle' src='/resources/images/cristal.png' alt='아바타'>`;
//					html += "<img style='position:relative;left:5px' class='rounded-circle' src='/resources/images/board/수지사원.jpeg' alt=''>";
					html += "</div>";				
					html += "<ul class='hover-actions position-relative list-inline mb-0 text-400 ms-2'>";				
					html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_forward("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Forward' data-bs-original-title='Forward'><svg class='svg-inline--fa fa-share fa-w-16' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='share' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg=''><path fill='currentColor' d='M503.691 189.836L327.687 37.851C312.281 24.546 288 35.347 288 56.015v80.053C127.371 137.907 0 170.1 0 322.326c0 61.441 39.581 122.309 83.333 154.132 13.653 9.931 33.111-2.533 28.077-18.631C66.066 312.814 132.917 274.316 288 272.085V360c0 20.7 24.3 31.453 39.687 18.164l176.004-152c11.071-9.562 11.086-26.753 0-36.328z'></path></svg></a></li>";
					html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_archive("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Archive' data-bs-original-title='Archive'><svg class='svg-inline--fa fa-archive fa-w-16' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='archive' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg=''><path fill='currentColor' d='M32 448c0 17.7 14.3 32 32 32h384c17.7 0 32-14.3 32-32V160H32v288zm160-212c0-6.6 5.4-12 12-12h104c6.6 0 12 5.4 12 12v8c0 6.6-5.4 12-12 12H204c-6.6 0-12-5.4-12-12v-8zM480 32H32C14.3 32 0 46.3 0 64v48c0 8.8 7.2 16 16 16h480c8.8 0 16-7.2 16-16V64c0-17.7-14.3-32-32-32z'></path></svg></li>";
					html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_edit("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Edit' data-bs-original-title='Edit'><svg class='svg-inline--fa fa-edit fa-w-18' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='edit' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512' data-fa-i2svg=''><path fill='currentColor' d='M402.6 83.2l90.2 90.2c3.8 3.8 3.8 10 0 13.8L274.4 405.6l-92.8 10.3c-12.4 1.4-22.9-9.1-21.5-21.5l10.3-92.8L388.8 83.2c3.8-3.8 10-3.8 13.8 0zm162-22.9l-48.8-48.8c-15.2-15.2-39.9-15.2-55.2 0l-35.4 35.4c-3.8 3.8-3.8 10 0 13.8l90.2 90.2c3.8 3.8 10 3.8 13.8 0l35.4-35.4c15.2-15.3 15.2-40 0-55.2zM384 346.2V448H64V128h229.8c3.2 0 6.2-1.3 8.5-3.5l40-40c7.6-7.6 2.2-20.5-8.5-20.5H48C21.5 64 0 85.5 0 112v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V306.2c0-10.7-12.9-16-20.5-8.5l-40 40c-2.2 2.3-3.5 5.3-3.5 8.5z'></path></svg></a></li>";
					html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_remove("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Remove' data-bs-original-title='Remove'><svg class='svg-inline--fa fa-trash-alt fa-w-14' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='trash-alt' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 448 512' data-fa-i2svg=''><path fill='currentColor' d='M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V128H32zm272-256a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zM432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16z'></path></svg></a></li>";
					html += "</ul>";
					html += "</div>";
					html += "<div class='text-400 fs--2'><span>"+replRdate+"</span></div>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
					
					$("#replyDiv").html($("#replyDiv").html()+html);
					//console.log("children",$("#replyDiv")[0].children.length);// 댓글 1개당 높이 92.67
					$("#replyDiv")[0].scrollTo(0, $("#replyDiv")[0].children.length*92.67 );

 
					

				},
				error:(xhr)=>{
					console.log("error",xhr.status);
				}
			})
			
		})
	

		//댓글 수정 취소
		function fn_forward(replNo){
			console.log("replNo : " + replNo);
			
			$("#txtRepl"+replNo).val($("#spnRepl"+replNo).html());
			
			$("#spnRepl"+replNo).css("display","block");//보이는글
			$("#txtRepl"+replNo).css("display","none");//입력란
		}
		
		//댓글 수정
		function fn_edit(replNo){
			console.log("replNo : " + replNo);
			
			let replCont = $("#spnRepl"+replNo).html();
			console.log("replCont : " + replCont);
			
			$("#spnRepl"+replNo).css("display","none");//보이는글
			$("#txtRepl"+replNo).css("display","block");//입력란
			
		}
		
		//댓글 수정 실행
		function fn_archive(replNo){
			console.log("replNo : " + replNo);
			let replCont = $("#txtRepl"+replNo).val();
			
			console.log("replCont : " + replCont);
			
			let data = {
				"replNo":replNo,
				"replCont":replCont
			};
			
			console.log("data : ", data);
			
			$.ajax({
				url:"/repl/updatePost",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				success:function(result){
					console.log("result : ", result);
					
					$("#spnRepl"+replNo).html(result.replCont);
					
					$("#spnRepl"+replNo).css("display","block");//보이는글
					$("#txtRepl"+replNo).css("display","none");//입력란
				}
			});
		}
		
		//댓글 삭제
		function fn_remove(replNo){
			console.log("replNo : " + replNo);
			
			let data = {
				"replNo":replNo
			};
			
			console.log("data : ", data);
			
			$.ajax({
				url:"/repl/deletePost",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"text",
				success:function(result){
					console.log("result : ", result);
					
					if(result == "OK"){
						alert("삭제되었습니다");
						//해당 댓글 영역을 제거
						console.log("체킁",$("#div"+replNo));
						$("#div"+replNo).remove();
					}else {
						alert("삭제 불가")
					}
				}
			});
			
		}

		 function fShowHide() {
		        const $tblFileList = $("#tblFileList");
		        
		        if ($tblFileList.css("display") === "none") {
		            $tblFileList.css("display", "block");
		        } else {
		            $tblFileList.css("display", "none");
		        }
		    }
		         	// CKEditor를 적용할 textarea의 ID로 CKEditor를 생성
			CKEDITOR.replace('brdCont');
		<!-- 여기까지 첨부파일 정보 모달에 뿌리기  -->
        const columnDefs = [
            { field: "rnum", headerName: "글번호" },
            { field: "brdNo", headerName: "게시글번호", hide: true },
            { field: "brdTitle", headerName: "제목" },
            { field: "brdRdate", headerName: "등록일" },
            { field: "empNm", headerName: "작성자" },
            { field: "brdHit", headerName: "조회수" }
        ];

        const gridOptions = {
            columnDefs: columnDefs,
            defaultColDef: {
                sortable: true,
                filter: true,
                resizable: true,
                minWidth: 100
            },
            pagination: true,
            paginationPageSize: 10,
            onCellClicked: function (params) {
            	//BRD0000007
                console.log("params.data.brdNo : ", params.data.brdNo);
//                 location.href = "/board/pageDetail?brdNo=" + params.data.brdNo;

				let data = {"brdNo":params.data.brdNo};
				console.log("data : ",data);
				
				$("#replBrdNo").val(params.data.brdNo);

				/*
				요청URI : /board/pageDetailAjax
				요청파라미터 : {"brdNo":"BRD0000007"}
				요청방식 : post
				*/
				$.ajax({
					url:"/board/pageDetailAjax",
					contentType:"application/json;charset=utf-8",
					data:JSON.stringify(data),
					type:"post",
					dataType:"json",
					success:function(result){
						console.log("result : ",result);
						
						$("#brdNo0").val(result.brdNo);
                        $("[sbTitle]").html("<input type='text' style='border:none' class='form-control clsInput' name='brdTitle' id='brdTitle' value='"+result.brdTitle+"' readonly />");
                        $("[sbWriter]").text(result.empNm);
                        $("[sbDate]").text(result.brdRdate);
                        $("[sbHit]").text(result.brdHit);
                        $("[sbCont]").html("<div id='divBrdCont'>"+result.brdCont+"</div>");
                        //"<textarea class='form-control clsInput' name='brdCont' id='brdCont' cols='30' rows='7' readonly>"+result.brdCont+"</textarea>"
						
						//$("#testModalBody").html(result.brdTitle);
                        //원본데이터를 뷰의 세션에 저장
                        sessionStorage.setItem("brdTitle",result.brdTitle);
                        sessionStorage.setItem("brdCont",result.brdCont);
                        
                        let str = "";
                        //<a href="/resources/upload/2023/11/30/99cccff3-5b5b-4a9f-9e07-1477104763fb_로고7 (1).jpg" download="로고7 (1).jpg">DownLoad</a>
                        //<a href="/resources/upload/2023/12/04/3820cd61-e63c-4a7f-aa61-dca99958710c_제목을 입력해주세요_-001 (9).png" download="제목을 입력해주세요_-001 (9).png">DownLoad</a>
                        $.each(result.atchBrdFileDetailVOList,function(idx,atchBrdFileDetailVO){
                        	str += "<tr><td>"+atchBrdFileDetailVO.orignlFileNm+"</td><td>fileSize</td>";
                        	str += "<td><a href='/resources/upload"+atchBrdFileDetailVO.streFileNm+"' download='"+atchBrdFileDetailVO.orignlFileNm+"'>DownLoad</a></td></tr>';";
                        });
                        
                        //첨부파일 처리
                        $("#tblFileList tbody").append(str);
                        
                        //댓글
                        $.ajax({
							url:"/repl/replList",
							contentType:"application/json;charset=utf-8",
							data:JSON.stringify(data),
							type:"post",
							dataType:"json",
							success:function(result2){
								//List<ReplVO>
								console.log("result2 : ",result2);
								
								
								let rListHtml = "";
								var html = "";
								$.each(result2,function(idx,replVO){
									rListHtml += replVO.empCd + " : " + replVO.replCont + "<br>";
									
									console.log("replCont : " + replVO.replCont);
									console.log("empCd : " + replVO.empCd);

									// 로그인한 사용자와 댓글작성자가 같을 때망 수빈이가 수정삭제 허락
									if(replVO.empCd == '${sbPrincess.realUser.empCd}'){
										html += "<div class='d-flex p-3' id='div"+replVO.replNo+"'>";
										html += "<div style='width:50%;display:inline-block'></div>";
										html += "<div class='flex-1'>";
										html += "<div class='w-xxl-75'>";
										html += "<div class='hover-actions-trigger d-flex align-items-center'>";
										html += "<div class='chat-message bg-200 p-2 rounded-2'><span id='spnRepl"+replVO.replNo+"'>"+replVO.replCont+"</span><input type='text' id='txtRepl"+replVO.replNo+"' value='"+replVO.replCont+"' style='display:none;' /></div>";
										html += "<div class='avatar avatar-l me-2 ml-10'>";
										html += `<img style='position:relative;left:5px' class='rounded-circle' src='\${replVO.empImg}' alt='아바타'>`;
										html += "</div>";				
										html += "<ul class='hover-actions position-relative list-inline mb-0 text-400 ms-2'>";				
										html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_forward("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Forward' data-bs-original-title='Forward'><svg class='svg-inline--fa fa-share fa-w-16' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='share' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg=''><path fill='currentColor' d='M503.691 189.836L327.687 37.851C312.281 24.546 288 35.347 288 56.015v80.053C127.371 137.907 0 170.1 0 322.326c0 61.441 39.581 122.309 83.333 154.132 13.653 9.931 33.111-2.533 28.077-18.631C66.066 312.814 132.917 274.316 288 272.085V360c0 20.7 24.3 31.453 39.687 18.164l176.004-152c11.071-9.562 11.086-26.753 0-36.328z'></path></svg></a></li>";
										html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_archive("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Archive' data-bs-original-title='Archive'><svg class='svg-inline--fa fa-archive fa-w-16' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='archive' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512' data-fa-i2svg=''><path fill='currentColor' d='M32 448c0 17.7 14.3 32 32 32h384c17.7 0 32-14.3 32-32V160H32v288zm160-212c0-6.6 5.4-12 12-12h104c6.6 0 12 5.4 12 12v8c0 6.6-5.4 12-12 12H204c-6.6 0-12-5.4-12-12v-8zM480 32H32C14.3 32 0 46.3 0 64v48c0 8.8 7.2 16 16 16h480c8.8 0 16-7.2 16-16V64c0-17.7-14.3-32-32-32z'></path></svg></li>";
										html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_edit("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Edit' data-bs-original-title='Edit'><svg class='svg-inline--fa fa-edit fa-w-18' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='edit' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 576 512' data-fa-i2svg=''><path fill='currentColor' d='M402.6 83.2l90.2 90.2c3.8 3.8 3.8 10 0 13.8L274.4 405.6l-92.8 10.3c-12.4 1.4-22.9-9.1-21.5-21.5l10.3-92.8L388.8 83.2c3.8-3.8 10-3.8 13.8 0zm162-22.9l-48.8-48.8c-15.2-15.2-39.9-15.2-55.2 0l-35.4 35.4c-3.8 3.8-3.8 10 0 13.8l90.2 90.2c3.8 3.8 10 3.8 13.8 0l35.4-35.4c15.2-15.3 15.2-40 0-55.2zM384 346.2V448H64V128h229.8c3.2 0 6.2-1.3 8.5-3.5l40-40c7.6-7.6 2.2-20.5-8.5-20.5H48C21.5 64 0 85.5 0 112v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V306.2c0-10.7-12.9-16-20.5-8.5l-40 40c-2.2 2.3-3.5 5.3-3.5 8.5z'></path></svg></a></li>";
										html += "<li class='list-inline-item'><a class='chat-option' href='javascript:fn_remove("+replVO.replNo+")' data-bs-toggle='tooltip' data-bs-placement='top' aria-label='Remove' data-bs-original-title='Remove'><svg class='svg-inline--fa fa-trash-alt fa-w-14' aria-hidden='true' focusable='false' data-prefix='fas' data-icon='trash-alt' role='img' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 448 512' data-fa-i2svg=''><path fill='currentColor' d='M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V128H32zm272-256a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zM432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16z'></path></svg></a></li>";
										html += "</ul>";
										html += "</div>";
										html += "<div class='text-400 fs--2'><span>11:54 am</span></div>";
										html += "</div>";
										html += "</div>";
										html += "</div>";
									}else {
										html += "<div class='d-flex p-3' id='div"+replVO.replNo+"'>";
										html += "<div class='avatar avatar-l me-2'>";
										html += `<img class='rounded-circle' src='\${replVO.empImg}' alt='아바타'>`;
//										html += "<img class='rounded-circle' src='/resources/images/board/수지사원.jpeg' alt=''>";
										html += "</div>";
										html += "<div class='flex-1'>";
										html += "<div class='w-xxl-75'>";
										html += "<div class='hover-actions-trigger d-flex align-items-center'>";
										html += "<div class='chat-message bg-200 p-2 rounded-2'><span id='spnRepl"+replVO.replNo+"'>"+replVO.replCont+"</span><input type='text' id='txtRepl"+replVO.replNo+"' value='"+replVO.replCont+"' style='display:none;' /></div>";
										html += "<ul class='hover-actions position-relative list-inline mb-0 text-400 ms-2'>";
										html += "</ul>";
									    html += "</div>";
									    html += "<div class='text-400 fs--2'><span>11:54 am</span></div>";
									    html += "</div>";
									    html += "</div>";
									    html += "</div>";
									}

								});
								
								$("#replyDiv").html(html);
								
								
							}
                        });
						
						$("#testModal").modal("show");
					}
				});

            }
        };

        function sbGetData() {
            var xhr = new XMLHttpRequest();
            xhr.open("get", "/board/listAjax", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    let rslt = JSON.parse(xhr.responseText);
                    console.log("rslt : " + JSON.stringify(rslt));
                    gridOptions.api.setRowData(rslt);
                }
            }
            xhr.send();
        }

        $('#testBtn').click(function (e) {
            e.preventDefault();
            $('#testModal').modal("show");
        });

        function fModalHide(){
            $('#testModal').modal("hide");
        }

        document.addEventListener('DOMContentLoaded', () => {
            const gridDiv = document.querySelector('#myGrid');
            new agGrid.Grid(gridDiv, gridOptions);
            sbGetData();
        });
        
            
        </script>


<!-- 이거 한번 넣어볼게 왠지 클릭하면 시케이 에디어 안에 데이터 값 주지 않을까..? -->
