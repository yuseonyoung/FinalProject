<%--
* [[개정이력(Modification Information)]]
* 수정일          수정자          수정내용
* ----------  ---------  -----------------
* 2023. 12. 5.       우정범          최초작성
* Copyright (c) 2023 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<script src="/resources/falcon/public/vendors/echarts/echarts.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<!-- 1단계: ECharts 설치하기 -->
<script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>


<input type="hidden" id="empCd"
	value="<sec:authentication property="principal.realUser.empCd"/>" />
<input type="hidden" id="deptNo"
	value="<sec:authentication property="principal.realUser.deptNo"/>" />
<div class="row g-0">
	<div class="col-lg-5 col-xl-6 pe-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center bg-light py-2">
				<h6 class="mb-0">부서별 인원 현황</h6>
			</div>
			<div class="card-body pb-0 text-center" >
				<div class="echart-doughnut-chart1" style="min-height: 400px;" data-echart-responsive="true"></div>
			</div>
		</div>
	</div>



	<div class="col-lg-5 col-xl-6 ps-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center bg-light py-2">
				<h6 class="mb-0">직급별 인원 현황</h6>
			</div>
			<div class="card-body pb-0 text-center">
				<div class="echart-doughnut-chart2" style="min-height: 400px;" data-echart-responsive="true"></div>
			</div>
		</div>
	</div>
</div>

<div class="row g-0">
	<div class="col-lg-13 pe-lg-2 mb-3">
		<div class="card">
			<div class="card-header d-flex flex-between-center bg-light py-2">
				<h6 class="mb-0">분기 별 인건비 현황</h6>
			</div>
				<div class="card-body pb-0" style="height: 450px">
					<div class="echart-bar-chart3" style="min-height: 320px;" data-echart-responsive="true"></div>
				</div>
			</div>
		</div>
	</div>

</div>



<script>
   
//ECharts 사용을 위해 차트를 그릴 DOM 요소를 가져옵니다.
var echartContainer1 = document.querySelector('.echart-doughnut-chart1');

// ECharts 차트 생성
var echart1 = echarts.init(echartContainer1);

// 차트 옵션 설정
var options1 = {
    title: {
        text: '부서 별 인원 현황',
        left: 'center'
    },
    tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b}: {c} ({d}%)'
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['구매부','유통부','자재부','인사부','판매부','임원']
    },
    series: [
        {
            name: '부서',
            type: 'pie',
            radius: '50%',
            center: ['50%', '50%'],
            avoidLabelOverlap: false,
            label: {
                show: false,
                position: 'center'
            },
            emphasis: {
                label: {
                    show: true,
                    fontSize: '20',
                    fontWeight: 'bold'
                }
            },
            labelLine: {
                show: false
            },
            data: [
                { value: 7, name: '구매부' },
                { value: 7, name: '유통부' },
                { value: 6, name: '자재부' },
                { value: 6, name: '인사부' },
                { value: 6, name: '판매부' },
                { value: 1, name: '임원' }
            ]
        }
    ]
};


//차트에 옵션 적용
echart1.setOption(options1);
    
    
   

//ECharts 사용을 위해 차트를 그릴 DOM 요소를 가져옵니다.
var echartContainer2 = document.querySelector('.echart-doughnut-chart2');

// ECharts 차트 생성
var echart2 = echarts.init(echartContainer2);

// 차트 옵션 설정
var options2 = {
    title: {
        text: '직급 별 인원 현황',
        left: 'center'
    },
    tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b}: {c} ({d}%)'
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['사원','대리','과장','부장','대표이사']
    },
    series: [
        {
            name: '직급',
            type: 'pie',
            radius: '50%',
            center: ['50%', '50%'],
            avoidLabelOverlap: false,
            label: {
                show: false,
                position: 'center'
            },
            emphasis: {
                label: {
                    show: true,
                    fontSize: '20',
                    fontWeight: 'bold'
                }
            },
            labelLine: {
                show: false
            },
            data: [
                { value: 11, name: '사원' },
                { value: 11, name: '대리' },
                { value: 5, name: '과장' },
                { value: 4, name: '부장' },
                { value: 1, name: '대표이사' }
            ]
        }
    ]
};

// 차트에 옵션 적용
echart2.setOption(options2);



//ECharts 사용을 위해 차트를 그릴 DOM 요소를 가져옵니다.
var echartContainer3 = document.querySelector('.echart-bar-chart3');

// ECharts 차트 생성
var echart3 = echarts.init(echartContainer3);

// 차트 옵션 설정
var options3 = {
		title: {
	        text: '분기 별 인건비 현황',
	        left: 'left'
	    },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        legend: {
            data: ['사원', '대리', '과장', '부장', '대표이사' , '총합']
        },
        grid: {
            top: '30%',  // top 속성을 이용하여 차트의 상단 여백을 설정합니다.
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        yAxis: {
            type: 'value',
            boundaryGap: [0, 0.01],
            axisLabel: {
                formatter: '{value} 만원'
            }
        },
        xAxis: {
            type: 'category',
            data: ['2023 1분기', '2023 2분기', '2023 3분기', '2023 4분기']
        },
        series: [
            {
                name: '사원',
                type: 'bar',
                data: [10560, 10500, 10860, 12360]
            },
            {
                name: '대리',
                type: 'bar',
                data: [13550, 14350, 13250, 14950]
            },
            {
                name: '과장',
                type: 'bar',
                data: [8400, 8900, 8100, 10500]
            },
            {
                name: '부장',
                type: 'bar',
                data: [9600, 9800, 8900, 11600]
            },
            {
                name: '대표이사',
                type: 'bar',
                data: [1200, 1300, 1400, 2000]
            },
            {
                name: '총합',
                type: 'bar',
                data: [43310, 44850, 42510, 51410]
            }
        ]
    };


// 차트에 옵션 적용
echart3.setOption(options3);
</script>
