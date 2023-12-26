<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <meta charset="utf-8">
    <title>ECharts</title>
    <!-- 다운받은 echarts 파일 -->
     <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js">
    </script>
<body>
<!-- 높이와 너비가 지정된 Dom 을 생성합니다 -->
<!-- <div id="fieldChart" style="width: 600px;height:400px;"></div>
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
		      name: '2023',
		      type: 'bar',
		      data: [${chart4.sumDefQty}, ${chart3.sumDefQty}, ${chart2.sumDefQty}, ${chart1.sumDefQty}]
		    }
		  ]
		};
        // 위에서 설정한 속성을 차트에 반영합니다.
        myChart.setOption(option);
    </script> -->

    <div id="fieldChart" style="width: 600px;height:400px;"></div>
    <script type="text/javascript">
        // DOM을 준비하고 echart 객체를 만듭니다.
        var myChart = echarts.init(document.getElementById('fieldChart'));

        // 차트 속성과 데이터를 지정합니다.
      option = {
		  title: {
		    text: 'Referer of a Website',
		    subtext: 'Fake Data',
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
		        { value: 10, name: '진행전' },
		        { value: 20, name: '진행중' },
		        { value: 30, name: '완료' },
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
    
    
    </body>
