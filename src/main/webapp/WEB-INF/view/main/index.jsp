<%--
* [[개정이력(Modification Information)]]
* 수정일              수정자      수정내용
* ----------     ---------  -----------------
* 2023. 11. 13.      이수정      최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.card {
	height: 100%;
}
#flowChart{
	background-color: #4690f4;
	color: white;
}
#calender{
	background-color: #4690f4;
}
#mail1{
	background-color: #4690f4;
}
#flowChart{
	background-color: #4690f4;
}
#whiteC{
	color: white;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>

<input type="hidden" id="empCd"
	value="<sec:authentication property="principal.realUser.empCd"/>" />
<input type="hidden" id="deptNo"
	value="<sec:authentication property="principal.realUser.deptNo"/>" />
<div class="row g-0">
	<div class="col-lg-7 col-xl-8 pe-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center py-2" id="flowChart">
				<h6 class="mb-0" id="whiteC">Flow Chart</h6>
			</div>
			<div class="card-body pb-0 text-center" >
				<img src="/resources/images/index/flowchart.png"
					style="width: 600px;" />
			</div>
		</div>
	</div>



	<div class="col-lg-5 col-xl-4 ps-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center py-2" id="mail1">
				<h6 class="mb-0" id="whiteC">Mail</h6>
			</div>
			<div class="card-body pb-0" style="margin-bottom: 20px;">


				<div class="sendMailDiv" style="font-size: small;"></div>


			</div>
		</div>
	</div>
</div>

<div class="row g-0">
	<div class="col-lg-6 pe-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center py-2" id="calender">
				<h6 class="mb-0" id="whiteC">일정</h6>
			</div>
			<div class="card-body pb-0" style="height: 650px">
				<span class="badge badge-subtle-danger">회사일정</span>
				<span class="badge badge-subtle-primary">부서일정</span> 
				<span class="badge badge-subtle-success">개인일정</span>
				<div class="card shadow-none" style="height: auto;">
					<div class="tab-pane preview-tab-pane active" role="tabpanel"
						aria-labelledby="tab-dom-d119274c-28f2-4f9b-a522-5ff7a03cee30"
						id="dom-d119274c-28f2-4f9b-a522-5ff7a03cee30">
						<div id="calendar"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<sec:authorize access="hasRole('ADMIN')">
	<div class="col-lg-6 pe-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center py-2" id="flowChart">
				<h6 class="mb-0" id="whiteC">매출 현황</h6>
			</div>
			<div class="card-body pb-0" style="height: 650px">
				<div id="main" style="width: 600px;height:500px;padding-top: 50px;"></div>
			</div>
		</div>

	</div>
	</sec:authorize>
	
	<sec:authorize access="hasRole('OFFICE')">
	<div class="col-lg-6 pe-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center py-2" style="background-color: #4690f4;">
				<h6 class="mb-0" id="whiteC">발주서 진행상황</h6>
			</div>
			<div class="card-body pb-0" style="height: 650px">
				<div id="officeChart" style="width: 500px;height:400px; padding-top: 100px; padding-left: 80px;" ></div>
			</div>
		</div>

	</div>
	</sec:authorize>
	
	<sec:authorize access="hasRole('FIELD')">
	<div class="col-lg-6 pe-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center py-2" style="background-color: #4690f4;">
				<h6 class="mb-0" id="whiteC">불량재고 현황</h6>
			</div>
			<div class="card-body pb-0" style="height: 650px">
				<div id="fieldChart" style="width: 500px;height:400px; padding-top: 50px;"></div>
			</div>
		</div>

	</div>
	</sec:authorize>
</div>






<script type="text/javascript">



let cPath = $('.pageConversion').data('contextPath');

let makePaging = function(rslt) {
	let paging =
		`
			<nav>
			  <ul class="pagination justify-content-center">
				   		\${rslt.pagingHTML}
			  </ul>
			</nav>
		`
	return paging;
}



/*안읽은 메일 div*/
let makeUnreadMailDiv = function(rslt) {

	let unreadMailList =
		`
			<div class="check">
			  <div class="checkRemove" value="\${rslt.mailNo}">
         	    <div style = "max-height: 100px;" class="row border-bottom border-200 hover-actions-trigger hover-shadow py-2 px-1 mx-0 bg-light" data-href="\${cPath}/mail/view/\${rslt.mailNo}">
                
                  <div class="col col-md-9 col-xxl-10" style="margin-left : 10px;">
                   <div class="row">
                    <div class="col-md-4 col-xl-3 col-xxl-2 ps-md-0 mb-1 mb-md-0" 
                    	style="padding: 0px; width:70px;">
                    <div class="d-flex position-relative">
                    <div class="avatar avatar-s">
                          <img class="rounded-soft" src="\${rslt.empImg}" alt="" />
                    </div>
                    <div class="flex-1 ms-2"><a class="stretched-link inbox-link" href="\${cPath}/mail/\${rslt.mailNo}" >\${rslt.senNm}</a>
                    </div>
                   </div>
                    </div>
                    <div class="col"><a class="d-block inbox-link" href="\${cPath}/mail/\${rslt.mailNo}"><span style="height: 40px; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">\${rslt.mailTitle}</span></a>
                    </div>
                  </div>
                </div>
                <div class="col-auto ms-auto d-flex flex-column justify-content-between"><span>\${rslt.mailDate}</span><span class="fas text-warning fa-star ms-auto mb-2 d-sm-none" data-fa-transform="down-7"></span></div>
              </div>
			</div>
			</div>
	    `;
	return unreadMailList;
};




/*안읽은 메일 조회 함수*/
function retrieveUMailList() {
	let baseUrl = `\${cPath}/mail/ulist2`;
	$.ajax({
		url: baseUrl,
		method: "GET",
		contentType: 'application/json',
		dataType: "json",
		success: function(resp) {
			var dataList = resp.paging.dataList;
			let unMailLists = "";
			let pageLists = "";
			let cnt = 0;
			var pagingList = resp.paging;
			pageLists += makePaging(pagingList);
			if (dataList?.length > 0) {
					for (let i = 0; i < dataList.length; i++) {
						if (dataList[i].mailDel == 'N'&&dataList[i].mailRead == 'N') {
								cnt++;
								unMailLists += makeUnreadMailDiv(dataList[i]);
								
								if (cnt >= 4) {
					                // dataList의 length가 4 이상이면 반복문을 종료합니다.
					                break;
								}
								if (cnt == 0) {
									unMailLists += `
										<table style="margin-left: 15px">
											<tr>
												<td style="padding: 20px" class="text-nowrap">읽지 않은 메일이 없습니다.</td>
											</tr>
										</table>
										`;
								}
						}
					
					};
					
				} else {
					unMailLists += `
						<table style="margin-left: 15px">
							<tr>
								<td style="padding: 20px" class="text-nowrap">읽지 않은 메일이 없습니다.</td>
							</tr>
						</table>
							`;
				}
			
		        $('.sendMailDiv').html(unMailLists);
		        $('.check')[3].remove();
		        
			$('#pagingPlace').html(pageLists);

		},
		error: function(xhr, status, error) {
			console.log(xhr);
			console.log(status);
			console.log(error);
		}
	});
};
retrieveUMailList();


function fn_paging(page) {
	searchMap.set("page", page);
	let baseUrl = `\${cPath}/mail/ulist2`;
	let data = {};
	for (let i of searchMap.keys()) {
		data[i] = searchMap.get(i);
	}

	$.ajax({
		url: baseUrl,
		method: "GET",
		data: data,
		dataType: "json",
		success: function(resp) {
			var dataList = resp.paging.dataList;
			let cnt = 0;
			let unMailLists = "";
			let pageLists = "";
			var pagingList = resp.paging;
			pageLists += makePaging(pagingList);

			if (dataList?.length > 0) {
				for (let i = 0; i < dataList.length; i++) {
					if (dataList[i].mailDel == 'N' && dataList[i].mailRead == 'N') {
						cnt++;
						unMailLists += makeUnreadMailDiv(dataList[i]);

						if (cnt == 0) {
							unMailLists += `
									<table>
										<tr>
											<td style="padding: 20px" class="text-nowrap">읽지 않은 메일이 없습니다.</td>
										</tr>
									</table>
									`;
						}
					}

				};

			} else {
				unMailLists += `
					<table>
						<tr>
							<td style="padding: 20px" class="text-nowrap">읽지 않은 메일이 없습니다.</td>
						</tr>
					</table>
						`;
			}

			$('.sendMailDiv').html(unMailLists);
			$('#pagingPlace').html(pageLists);
			
		},
		error: function(xhr, status, error) {
			console.log(xhr);
			console.log(status);
			console.log(error);
		}
	});

}


</script>    

<script>
	$(function() {
		// FullCalendar 캘린더 생성 함수를 정의합니다.
		function createCalendar(data) {
			var calendarEl = document.getElementById('calendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				height: 560,
				contentHeight: 350,
				slotMinTime : '08:00',
				slotMaxTime : '20:00',
				headerToolbar : {
					  start: '',
					  center: '',
					  end: ''
				},
				initialView : 'dayGridMonth',
				events : data,
				locale : 'ko'
			});
			calendar.render();
		};//createCalendar끝

		var empCd = document.getElementById('empCd');
		var deptNo = document.getElementById('deptNo');

		var checkedValues = [
			empCd.value
			, deptNo.value
			, "AIM"
		];

		fetchCalendarData();

		// FullCalendar 캘린더를 생성하기 위해 필요한 데이터를 가져오는 함수입니다.
		function fetchCalendarData() {
			var request = $.ajax({
				url : "/schedule/list2Home/",
				method : "POST",
				dataType : "JSON",
				traditional : true,
				async : false,
				data : {
					checkedValues : checkedValues
				},
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				}
			});

			request.done(function(data) {
				createCalendar(data);
			});
		}
	});
</script> 
        
<script type="text/javascript">
        var myChart = echarts.init(document.getElementById('main'));

        var option = {
            title: {
            	text: '2023년 4분기 매출현황'
            },
            tooltip: {},
            grid: {
        	    width: '70%', // 그래프의 width 조절
        	    left: '15%' // 그래프의 위치를 조절할 수도 있음
        	},
            legend: {
            	data:['Sales']
            },
            xAxis: {
            	data: ["9월","10월","11월","12월"],
            	axisLabel: {
                   
                }
            },
            yAxis: {
               
            },
            series: [{
                name: 'Sales',
                type: 'bar',
                data: [${chart09.saleSum}, ${chart10.saleSum}, ${chart11.saleSum}, ${chart12.saleSum}]
            }]
        };

        myChart.setOption(option);
</script>  
 
 
 <script type="text/javascript">
        // DOM을 준비하고 echart 객체를 만듭니다.
        var myChart = echarts.init(document.getElementById('fieldChart'));

        // 차트 속성과 데이터를 지정합니다.
       option = {
		  title: {
		    text: '2023년 불량재고 현황'
		  },
		  tooltip: {
		    trigger: 'axis',
		    axisPointer: {
		      type: 'shadow'
		    }
		  },
		  legend: {},
		  grid: {
		    left: '3%',
		    right: '4%',
		    bottom: '3%',
		    containLabel: true
		  },
		  xAxis: {
		    type: 'value',
		    boundaryGap: [0, 0.01]
		  },
		  yAxis: {
		    type: 'category',
		    data: ['4분기', '3분기', '2분기', '1분기']
		  },
		  series: [
			  {
			      name: '2022',
			      type: 'bar',
			      data: [${chart8.sumDefQty}, ${chart7.sumDefQty}, ${chart6.sumDefQty}, ${chart5.sumDefQty}]
			    },
		 
		    {
		      name: '2023',
		      type: 'bar',
		      data: [${chart4.sumDefQty}, ${chart3.sumDefQty}, ${chart2.sumDefQty}, ${chart1.sumDefQty}]
		    }
		  ]
		};
        // 위에서 설정한 속성을 차트에 반영합니다.
        myChart.setOption(option);
    </script>
    
     <script type="text/javascript">
        // DOM을 준비하고 echart 객체를 만듭니다.
        var myChart = echarts.init(document.getElementById('officeChart'));

        // 차트 속성과 데이터를 지정합니다.
      option = {
		  title: {
		    text: '발주서 진행상황',
		    left: 'center'
		  },
		  tooltip: {
		    trigger: 'item'
		  },
		  legend: {
		    orient: 'vertical',
		    left: 'left'
		  },
		  series: [
		    {
		      name: 'Access From',
		      type: 'pie',
		      radius: '50%',
		      data: [
		        { value: ${chartBefore.statCount}, name: '진행전' },
		        { value: ${chartIng.statCount}, name: '진행중' },
		        { value: ${chartBack.statCount}, name: '반려' },
		        { value: ${chartDone.statCount}, name: '완료' },
		      ],
		      emphasis: {
		        itemStyle: {
		          shadowBlur: 10,
		          shadowOffsetX: 0,
		          shadowColor: 'rgba(0, 0, 0, 0.5)'
		        }
		      }
		    }
		  ]
		};
        // 위에서 설정한 속성을 차트에 반영합니다.
        myChart.setOption(option);
 
        
    </script> 