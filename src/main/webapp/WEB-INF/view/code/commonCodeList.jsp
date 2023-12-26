<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>



<div class="col-lg-12 pe-lg-2">
	<div class="card mb-3">
		<div class="card-header">
		  <div class="row align-items-center">
		    <div class="col">
		      <h3 class="mb-0">공통코드</h3>
		    </div>
		    <div class="col text-end">
		      <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#cst-modal">추가</button>
		    </div>
		  </div>
		</div>
		<div class="card-body pt-1">
			<div id="tableExample2" data-list='{"valueNames":["rownum","grCd","commCd","commCdNm","empCd","commRdate","useYn"],"page":10,"pagination":true,"filter":{"key":"grCd"}}'>

			<!-- 검색 -->
			<div class="container">
			  <div class="row">
			    <div class="col">
			      <div class="row justify-content-start">
			        <div class="col-auto col-sm-10 mb-3">
			          <form>
			            <div class="input-group">
			              <input class="form-control form-control-sm shadow-none search" type="search" placeholder="Search..." aria-label="search" />
			              <div class="input-group-text bg-transparent"><span class="fa fa-search fs--1 text-600"></span></div>
			            </div>
			          </form>
			        </div>
			      </div>
			    </div>
			    <div class="col">
			      <div class="row justify-content-end">
			        <div class="col-auto px-3">
			          <select class="form-select form-select-sm mb-3" aria-label="Bulk actions" data-list-filter="data-list-filter">
			            <option selected="" value="">코드분류 선택</option>
        			    	<c:forEach var="data" items="${codeName}" varStatus="stat">
				            	<option value="${data.grCd}">${data.grNm}</option>
			            	</c:forEach>
			          </select>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>


			  <div class="table-responsive scrollbar">
			    <table class="table table-bordered table-striped fs--1 mb-0">
					<col width="10%">
					<col width="10%">
					<col width="15%">
					<col width="20%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
			      <thead class="bg-200 text-900">
			        <tr>
			          <th class="sort mb-1 text-center" data-sort="rownum">번호</th>
			          <th class="sort mb-1 text-center" data-sort="grCd">공통코드</th>
			          <th class="sort mb-1 text-center" data-sort="commCd">사용자상세코드</th>
			          <th class="sort mb-1 text-center" data-sort="commCdNm">코드명</th>
			          <th class="sort mb-1 text-center" data-sort="empCd">등록자</th>
			          <th class="sort mb-1 text-center" data-sort="commRdate">등록일</th>
			          <th class="sort mb-1 text-center white-space-nowrap text-end pe-4" data-sort="useYn">사용여부</th>
			        </tr>
			      </thead>
			      <tbody id="codeTable" class="list">
			      	<c:forEach var="data" items="${codeList}" varStatus="stat">
			        <tr>
			          <td class="mb-1 text-center rownum">${data.rownum}</td>
			          <td class="mb-1 text-center grCd" data-fa-transform="shrink-2" >${data.grCd}</td>
			          <td class="mb-1 text-center commCd">${data.commCd}</td>
			          <td class="mb-1 pm-3 commCdNm" >${data.commCdNm}</td>
			          <td class="mb-1 text-center empCd">${data.empCd}</td>
			          <td class="mb-1 text-center commRdate">${data.commRdate}</td>
			          <td class="mb-1 text-center useYn">
		          	  <c:choose>
				          <c:when test="${data.useYn == 'Y'}">
					          <button id="${data.commCd}" onclick="codeDeact('${data.commCd}')" class="btn btn-falcon-success btn-sm">활성화
					          </button>
				          </c:when>
				          <c:otherwise>
					          <button id="${data.commCd}" onclick="codeAct('${data.commCd}')" class="btn btn-falcon-default btn-sm">비활성
					          </button>
				          </c:otherwise>
			          </c:choose>
			        </tr>
			        </c:forEach>
			      </tbody>
			    </table>
			  </div>
			  <div class="d-flex justify-content-center mt-3">
			    <button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
			    <ul class="pagination mb-0"></ul>
			    <button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
			  </div>
			</div>
		</div>
	</div>
</div>






<div class="modal fade" id="cst-modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px">
    <div class="modal-content position-relative">
      <div class="position-absolute top-0 end-0 mt-2 me-2 z-1">
        <button class="btn-close btn btn-sm btn-circle d-flex flex-center transition-base" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 py-3 ps-4 pe-6 bg-light">
          <h4 class="mb-1" id="modalExampleDemoLabel">사용자 상세코드 추가</h4>
        </div>
        <div class="p-4 pb-0">
          <form>
		  <div class="row">
		    <div class="col-lg-6">
		      <label class="form-label" for="frmGrCd">공통코드</label>
		      <select class="form-select" id="frmGrCd" name="frmGrCd" required>
		        <option selected="" value="">코드분류 선택</option>
		        <c:forEach var="data" items="${codeName}" varStatus="stat">
		          <option value="${data.grCd}">${data.grNm}(${data.grCd})</option>
		        </c:forEach>
		      </select>
		    </div>
		    <div class="col-lg-6">
		      <label class="form-label" for="frmCommCd">사용자 상세코드</label>
		      <input class="form-control" id="frmCommCd" name="frmCommCd" type="text" placeholder="자동생성" readonly>
		    </div>
		  </div>
		  <div class="mb-3">
		    <label class="form-label" for="frmCommCdNm">코드명</label>
		    <input class="form-control" id="frmCommCdNm" name="frmCommCdNm" type="text" />
		  </div>
		</form>
        </div>
      </div>
      <div class="modal-footer">
      	<input id="empCd" type="hidden" value="<sec:authentication property="principal.realUser.empCd"/>" readonly>
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
        <button class="btn btn-primary" id="createCommCd" type="button">저장</button>
      </div>
    </div>
  </div>
</div>

<script>
let dataInput = document.getElementById('frmGrCd');
dataInput.addEventListener('change', function() {
	var grCd = dataInput.value;
	var csrfToken = $("input[name='_csrf']").val();
	let searchCode = {"grCd":grCd}

	// 알림 표시
	$.ajax({
		url:"/commCd/newCommCd",
		contentType:"application/json;charset=utf-8",
		data:searchCode,
		type:"post",
		headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-CSRF-TOKEN': csrfToken
        },
		success:function(result){
			document.getElementById('frmCommCd').value = result;
		}
	});
});

const crtBtn = document.getElementById('createCommCd');

crtBtn.addEventListener('click', function() {
	var frmGrCd = document.getElementById('frmGrCd');
	var frmCommCd = document.getElementById('frmCommCd');
	var frmCommCdNm = document.getElementById('frmCommCdNm');
	var empCd = document.getElementById('empCd');
	var csrfToken = $("input[name='_csrf']").val();
	var formData = new FormData();
	formData.append('grCd', frmGrCd.value);
	formData.append('commCd', frmCommCd.value);
	formData.append('commCdNm', frmCommCdNm.value);
	formData.append('empCd', empCd.value);

	console.log(formData);

	$.ajax({
		url:"/commCd/createCommCd",
		processData: false,
		contentType: false,
		data: formData,
		type:"post",
		headers: {
            'X-CSRF-TOKEN': csrfToken
        },
        success: function(result) {
        	location.reload();
        }
	});


	var modal = document.getElementById('cst-modal');
	var bsModal = bootstrap.Modal.getInstance(modal);

	bsModal.hide();
});

function codeDeact(commCd) {
    if (!confirm(commCd + " 코드를 비활성화하시겠습니까?")) {
    } else {

	    var sendData = {"commCd":commCd}
		var csrfToken = $("input[name='_csrf']").val();

	    $.ajax({
	        url : '/commCd/codeAct',
	        data : sendData,
	        method : 'post',
			headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	            'X-CSRF-TOKEN': csrfToken
	        },
	        success: function(commCd) {
	        	  var button = document.getElementById(commCd);

	        	  if (button.classList.contains("btn-falcon-success")) {
	        	    button.classList.remove("btn-falcon-success");
	        	    button.classList.add("btn-falcon-default");
	        	    button.innerHTML = "비활성";
	        	    button.onclick = function() {
	        	      codeAct(commCd);
	        	    };
	        	  } else if (button.classList.contains("btn-falcon-default")) {
	        	    button.classList.remove("btn-falcon-default");
	        	    button.classList.add("btn-falcon-success");
	        	    button.innerHTML = "활성화";
	        	    button.onclick = function() {
	        	      codeDeact(commCd);
	        	    };
	        	  }
	        	}
	    })
        alert("비활성화 되었습니다.");
    }
}
function codeAct(commCd) {
    if (!confirm(commCd + " 코드를 활성화하시겠습니까?")) {
    } else {

	    var sendData = {"commCd":commCd}
		var csrfToken = $("input[name='_csrf']").val();

	    $.ajax({
	        url : '/commCd/codeAct',
	        data : sendData,
	        method : 'post',
			headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	            'X-CSRF-TOKEN': csrfToken
	        },
	        success: function(commCd) {
	        	  var button = document.getElementById(commCd);

	        	  if (button.classList.contains("btn-falcon-success")) {
	        	    button.classList.remove("btn-falcon-success");
	        	    button.classList.add("btn-falcon-default");
	        	    button.innerHTML = "비활성";
	        	    button.onclick = function() {
	        	      codeAct(commCd);
	        	    };
	        	  } else if (button.classList.contains("btn-falcon-default")) {
	        	    button.classList.remove("btn-falcon-default");
	        	    button.classList.add("btn-falcon-success");
	        	    button.innerHTML = "활성화";
	        	    button.onclick = function() {
	        	      codeDeact(commCd);
	        	    };
	        	  }
	        	}
	    })
        alert("활성화 되었습니다.");
    }
}





</script>