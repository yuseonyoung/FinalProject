<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>



<script type="text/javascript">
function reloadDivArea(){
	console.log(location.href+' #dataArea');
// 	$('#dataArea').load(location.href);
	$('#dataArea').load(location.href+' #dataArea');
	
	setTimeout(() => {
		console.log("delay100_1");
		//delay100();
	}, 100);
}

// function delay100(){
// 	console.log("delay100_2");
// 	$(".commentSaveBtn").click(function() {
// 		rereply(this);
// 	});
// }

</script>
<div class="container">
	<div class="row">
		<div class="card mb-3">
			<div class="card-header ">
				<div class="row flex-between-end">
					<div class="col-auto align-self-center">
						<h3 class="mb-0">내 연차 정보</h3>
						<p class="mb-0 pt-1 mt-2 mb-0"></p>
					</div>
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.realUser.empCd" var="loginId" />
			<sec:authentication property="principal.realUser.empNm" var="loginName" />
		</sec:authorize>
		<!-- border-primary 빼면 파란색 보더 사라짐 -->
		<table class="table table-bordered align-middle text-align">
			<colgroup>
				<col width="30%">
				<col width="30%">
				<col width="30%">
			</colgroup>
			<thead>
				<tr>
					<td rowspan="4" class="bg-primary-subtle text-center">총 연차</td>
					<td class="bg-primary-subtle text-center">사용 연자</td>
					<td class="bg-primary-subtle text-center">잔여 연차</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="4" class=" text-center">${vacMainList.totalVacGrtDays}</td>
					<td class=" text-center">${vacMainList.usedDays}</td>
					<td class=" text-center">${vacMainList.totalVacGrtDays - vacMainList.usedDays}</td>
				</tr>
			</tbody>
		</table>
		</div>
		</div>
	</div>
	</div>
</div>
<div class="card mb-3">
	<div class="card-body">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link active"
				id="vac-info-use-nav" data-bs-toggle="tab" href="#vac-info-use"
				role="tab" aria-controls="vac-info-use" aria-selected="true">사용내역</a>
			</li>

			<li class="nav-item"><a class="nav-link" id="contact-tab"
				data-bs-toggle="tab" href="#tab-contact" role="tab"
				aria-controls="tab-contact" aria-selected="false">생성내역</a></li>
		</ul>
		<div class="tab-content  border-top-0 p-3" id="myTabContent">
			<div class="tab-pane fade show active" id="vac-info-use"
				role="tabpanel" aria-labelledby="vac-info-use">
				<div class="form-group">
					<select class="form-select float-end mb-3" style="width: 150px"
						name="myVacYear">
					</select>
				</div>
				<table class="table table-bordered align-middle text-align mt-2">
					<colgroup>
						<col width="12%">
						<col width="15%">
						<col width="18%">
						<col width="18%">
						<col width="12%">
						<col width="25%">
					</colgroup>
					<tbody id="dataRows">
						<tr>
							<td class="bg-primary-subtle text-center ">번호</td>
							<td class="bg-primary-subtle text-center ">휴가종류</td>
							<td class="bg-primary-subtle text-center ">시작일자</td>
							<td class="bg-primary-subtle text-center ">종료일자</td>
							<td class="bg-primary-subtle text-center ">사용일수</td>
							<td class="bg-primary-subtle text-center ">내용</td>
						</tr>
						<c:forEach var="usedVac" items="${detailUsedVac}" varStatus="stat">
							<tr id="currentYearData">
								<td class="text-center">${stat.count}</td>
								<td class="text-center">${usedVac.vacTypeNm}</td>
								<td class="text-center"><fmt:formatDate value="${usedVac.vacSdate}" pattern="yyyy-MM-dd" /></td>
								<td class="text-center"><fmt:formatDate value="${usedVac.vacEdate}" pattern="yyyy-MM-dd" /></td>
								<td class="text-center">${usedVac.vacDays}</td>
								<td class="text-center">${usedVac.vacRsn}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="tab-pane fade" id="tab-contact" role="tabpanel" aria-labelledby="contact-tab">
				<table class="table table-bordered align-middle text-align">
					<colgroup>
						<col width="10%">
						<col width="20%">
						<col width="30%">
						<col width="15">
						<col width="25%">
					</colgroup>
					<tbody>
						<tr>
							<td class="bg-primary-subtle text-center ">번호</td>
							<td class="bg-primary-subtle text-center ">생성일</td>
							<td class="bg-primary-subtle text-center ">사용기간</td>
							<td class="bg-primary-subtle text-center ">발생일수</td>
							<td class="bg-primary-subtle text-center ">내용</td>
						</tr>
						<c:forEach var="grantList" items="${grantList}" varStatus="stat">
							<tr>
								<td class="text-center">${stat.count}</td>
								<td class="text-center"><fmt:formatDate value="${grantList.vacGrtDate }" pattern="yyyy-MM-dd" /></td>
								<td class="text-center"><fmt:formatDate value="${grantList.vacGrtDate }" pattern="yyyy-MM-dd" />
									 ~ <fmt:formatDate value="${grantList.vacGrtVal }" pattern="yyyy-MM-dd" /></td>
								<td class="text-center">${grantList.vacGrtDays }</td>
								<td class="text-center">${grantList.vacGrtRsn }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
//세션에서 받아온 아이디
var loginIdSession= '${loginId}'
console.log("세션에서 받아온 로그인아이디 : ",loginIdSession);

var loginId = '${data.empCd}'
console.log("컨트롤러에서 받아온 로그인아이디 : ", loginId);

if(loginIdSession==loginId){
	console.log("동일인 로그인")
}


var myJoinYear = '${findJoinYear.joinYear}'
	//console.log("입사년도 : ",myJoinYear)

	let today = new Date();   
	let year = today.getFullYear(); // 년도
	//console.log(year)
	var arr=[]
	for(var i=year; i>=myJoinYear;i-- ){
		
		arr.push(i)
	}
	console.log(arr)
	console.log(arr[1])



	  var myVacYear = document.querySelector('select[name="myVacYear"]');
   
        for (var i = 0; i < arr.length; i++) {
            var option = document.createElement("option");
            option.value = arr[i];
            option.text = arr[i];
            myVacYear.appendChild(option);
        }
        
        
    	//옵션 선택값 받기
        $('select[name="myVacYear"]').on('change', function() {
            var selectedValue = $(this).val();
            console.log("선택된 값:", selectedValue);
	    	var loginIdSession= '${loginId}'
			var data = {
				"selectedValue" : selectedValue,
				"empCd" : loginIdSession
			};
			//console.log(data);
	    	
		
			//연도별 사용데이터 가져오기
	    	$.ajax({
	    	    url: "/empinfo/showvacused",
	    	    contentType: "application/json;charset:utf-8",
	    	    data: JSON.stringify(data),
	    	    type: "post",
	    	    dataType: "json",
	    	    beforeSend: function(xhr) {
	    	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	    },
	    	    success: function(result) {
	    	        console.log("성공!");
	    	        console.log(result);
	    	        
	    	        var mytbody = $("#dataRows");
	    	        mytbody.empty();

	    	        
    	        	var header = $("<tr></tr>");
    	        	
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>번호</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>휴가종류</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>시작일자</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>종료일자</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>사용일수</td>");
    	        	header.append("<td class='bg-primary-subtle' style='text-align: center;'>내용</td>");
	    	        
          	mytbody.append(header);
          			
	    	        $.each(result, function(index, item) {
                   	var row = $("<tr></tr>");
           			 // 데이터 행 생성
					row.append("<td class='text-center'>" + (index + 1) + "</td>");
					row.append("<td class='text-center'>" + item.vacTypeNm + "</td>");
					row.append("<td class='text-center'>" + formatDate(item.vacSdate) + "</td>");
					row.append("<td class='text-center'>" + formatDate(item.vacEdate) + "</td>");
					row.append("<td class='text-center'>" + item.vacDays + "</td>");
					row.append("<td class='text-center'>" + item.vacRsn + "</td>");

            // tbody에 행 추가
            mytbody.append(row);
        });
	    	      reloadDivArea();
	    	    },
	    	    error: function(xhr, status, error) {
	    	        console.log("에러 발생:", error);
	    	    }
	    	});


        });
    	
        function formatDate(dateString) {
            var date = new Date(dateString);
            var year = date.getFullYear();
            var month = ("0" + (date.getMonth() + 1)).slice(-2);
            var day = ("0" + date.getDate()).slice(-2);
            return year + "-" + month + "-" + day;
        }


</script>