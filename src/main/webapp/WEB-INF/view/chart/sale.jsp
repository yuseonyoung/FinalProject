<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <meta charset="utf-8">
    <title>ECharts</title>
    <!-- 다운받은 echarts 파일 -->
     <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js">
    </script>
<body>
<!-- 높이와 너비가 지정된 Dom 을 생성합니다 -->
<div id="main" style="width: 600px;height:400px;"></div>
    <script type="text/javascript">
        // DOM을 준비하고 echart 객체를 만듭니다.
        var myChart = echarts.init(document.getElementById('main'));

        // 차트 속성과 데이터를 지정합니다.
        var option = {
            title: {
            	text: '2023년 4분기 매출현황'
            },
            tooltip: {},
            legend: {
            	data:['Sales']
            },
            xAxis: {
            	data: ["9월","10월","11월","12월"],
            	axisLabel: {
                    interval: 0, // 모든 레이블을 표시
                    rotate: 45 // 각도 설정
                }
            },
            yAxis: {},
            series: [{
                name: 'Sales',
                type: 'bar',
                data: [${chart09.saleSum}, ${chart10.saleSum}, ${chart11.saleSum}, ${chart12.saleSum}]
            }]
        };

        // 위에서 설정한 속성을 차트에 반영합니다.
        myChart.setOption(option);
    </script>
    </body>
