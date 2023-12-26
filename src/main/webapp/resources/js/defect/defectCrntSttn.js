/**
 * <pre>
 * 
 * </pre>
 * @author 작성자명
 * @since 2023. 12. 3.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 12. 3.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

$(document).ready(function() {
	
	let itemWindowModal = new bootstrap.Modal($('#itemWindow')[0]);
	let wareWindowModal = new bootstrap.Modal($('#wareWindow')[0]);

	//버튼 이벤트발생시 모달 show
	$('#itemSearchBtn').on('click', function () {
		itemWindowModal.show();
	});
	$('#itemSearch').on('click', function () {
		itemWindowModal.show();
		$('.modal-backdrop').remove();
	});
	//버튼 이벤트발생시 모달 show
	$('#wareSearchBtn').on('click', function () {
	    wareWindowModal.show();
	});
	$('#wareSearch').on('click', function () {
	    wareWindowModal.show();
	});
	
	
	$('#wareTable').DataTable({
	        paging: true,
	        searching: true,
	        lengthChange: false,
	        info: false,
	        ordering: false
	});
	//modal이 닫히는 이벤트가 발생시 body의 css를 overflow hidden을 날려주기위해 사용
	
	$('#wareWindow').on('hidden.bs.modal', function () {
	    $('body').css('overflow', ''); 
	});
	
	let cPath = $('.pageConversion').data('contextPath');
	let baseUrl = `${cPath}/invenSituation`;
	
	let makeTrTag = function (result) {
	    let trTag = `
				<tr>
       	  			<td><input class="form-check-input checkData" type="checkbox" /></td>
           	  		<td style="text-align: center;">${result.itemCd}</td>
           	  		<td style="text-align: left;"><a href="javascript:;" class="selectItem" data-selected-value="${result.itemNm}">
           	  			${result.itemNm}
           	  		</a></td>
       	  		</tr>
		    `;
		
		    return trTag;
		};
	
	
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let urls = this.action;
		let datas = $(this).serialize();
		$.ajax({
			url: urls,
			method: "GET",
			data : datas,
			success: function (resp) {
				console.log(resp);
				let itemList = resp.paging.dataList;
				let trTags = "";
		
				if (itemList?.length > 0) {
					$.each(itemList, function () {
						trTags += makeTrTag(this);
					});
					$(pagingArea).html(resp.paging.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='3'>등록된 품목이 없습니다.</td>
							</tr>
						`;
					$(pagingArea).empty();
				}
				$('.list').html(trTags);
				
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	}).submit();
	
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			console.log(name);
			console.log(value);
			$(searchForm).find(`:input[name=${name}]`).val(value);
		});
		$('#searchForm').submit();
	});
	
	
	
	 //품목코드 한개를 선택시 span태그에 저장
	$('.modal-body').on('click', '.selectItem', function (e) {
	  e.preventDefault();
 	  let row = $(this).closest('tr');
	  let itemCd = row.find('td:eq(1)').text();
	  let selectedValue = $(this).data('selected-value');
	  
	  appendSpanIfNotDuplicate(selectedValue,itemCd);
	  
	  $('.modal-backdrop').remove();
	  itemWindowModal.hide();
	});
	//모달에서  창고선택시 발생하는 이벤트
	$('.modal-body').on('click', '.selectWare', function (e) {
	  e.preventDefault();
	  let selectedValue = $(this).data('selected-value');
	  
	  $('#wareSearch').val(selectedValue);
	  wareWindowModal.hide();
	});
	// 품목 span 태그 생성
	function spanMaker(selectedValue,itemCd) {
	    return `
	        <span id =${itemCd} class ="customSpan" style="margin-left: 3px; margin-top: 10px; padding: 3px; background-color: #3498db; color: white; border-radius: 5px;">
	            ${selectedValue}
	            <button type="button" class="btn searchBtn p-1 border-0 removeSpan">
	                <i class="fas fa-times-circle"></i>
	            </button>
	        </span>
	    `;
	}
	
	// span 태그 삭제
	$(document).on('click', '.removeSpan', function() {
	    $(this).closest('.customSpan').remove();
	});

	//저장버튼을 클릭하면 생기는 이벤트
	$('#saveBtn').on('click',function(){
	    $('.checkData:checked').each(function() {
			let row = $(this).closest('tr');
	        let itemCd = row.find('td:eq(1)').text();
	        let itemNm = row.find('td:eq(2)').text(); 
	        let spanTag = appendSpanIfNotDuplicate(itemNm, itemCd);
			$('#spanSpace').append(spanTag);
			$(this).prop('checked', false);
	    });
	})
	
	
	//중복검사를 통해 중복된 값이 추가되려하면 막음.
	function appendSpanIfNotDuplicate(selectedValue, itemCd) {
	    let isDuplicate = false;
	
	    if (typeof selectedValue === 'string' && typeof selectedValue.trim === 'function') {
	        $('#spanSpace').find('.customSpan').each(function() {
	            if ($(this).text().trim() === selectedValue.trim()) {
	                isDuplicate = true;
	                return false;
	            }
	        });
	    }
	
	    if (!isDuplicate) {
	        let spanTag = spanMaker(selectedValue, itemCd);
	        $('#spanSpace').append(spanTag);
	    }
	}

	//폼이 submit될때의 이벤트를 잡음
 	$('#defectForm').on('submit',function(e){
		e.preventDefault();
		//span태그내에 있는 id의 값을 가져와 배열에 저장함
		let itemCd=[];
		$('.customSpan').each(function() {
           let datas = $(this).attr('id');
           itemCd.push(datas);
		});
		
		let jsonTrans = [];
        //저장된 배열을 for문돌려서 json형식으로 만들어줌
		itemCd.forEach(code => {
		     let itemCode = { 'itemCd': code };
   			 jsonTrans.push(itemCode);
		});
		
		let data = $(this).serializeJSON();
		
		let rmstSdate = data.rmstSdate;
		let rmstLdate = data.rmstLdate;
		
		
		let invenValue = 0 ; //전일재고를 계산하기 위한 전역변수 선언 
		data.itemList = jsonTrans;
		
		let jsonData = JSON.stringify(data);
		console.log(jsonData);
		let url = $(this).attr('action');
		let method = $(this).attr('method');
		$.ajax({
			url: url,
			method: method,
			data : jsonData,
			contentType: 'application/json',
			success: function (resp) {
			
				
				let invenList = resp.invenList;
				let totalValueMap = resp.totalValueMap;
				let groupedData = {};
				let groupedItems = {};
				
				if(data.graph==='Y'){
					$('#contentBody').html('');
					$('#graphBody').html('');
					let timelineData=[];
						
					let charts =`
						<div id="chart" class="echart-bar-timeline-chart-example" style="width: 1100px; height: 700px;" data-echart-responsive="true"></div>
						<ul class="nav nav-tabs" id="yearTabs"></ul>
						<div id="monthlyDataContainer"></div>
					`;
					
					$('#graphBody').html(charts);
					
					var chart = echarts.init(document.getElementById('chart'));
					invenList.forEach(item => {
						//2차원배열로 date관리
					   	const date = moment(item.rmstDate);
				        const year = date.year();
				        const month = date.month() + 1; // month는 0부터 시작하므로 1을 더함
				
			            // 그룹화된 데이터 객체에 추가
			            if (!groupedData[year]) {
			                groupedData[year] = {};
			            }
			            if (!groupedData[year][month]) {
			                groupedData[year][month] = [];
			            }
			            groupedData[year][month].push(item);

						
						
						
					}); //forEach 마지막
					
					//ECharts를 위한 timelineData 넣기 
					timelineData=Object.keys(groupedData);
					console.log("이간 날짜 데이터]",groupedData);
					console.log("이건 타임라인 ",timelineData);
					
					
					
					
					var option = {
					    baseOption: {
					        timeline: {
					            data: timelineData,
					            axisType: 'category',
					            autoPlay: false,
					        },
					        xAxis: {
					            type: 'category',
					            data: [], // 빈 배열로 초기화
					        },
					        yAxis: {
					            type: 'value',
					        },
					        series: [
					            {
					                name: 'Series 1',
					                type: 'line',
					                data: [], // 빈 배열로 초기화
					            },
					        ],
					    },
					    options: [], // 타임라인에 따른 각 날짜별 차트 옵션
					};
					var yAxisData = [];

					// 타임라인에 따른 각 날짜별 차트 옵션 설정
					timelineData.forEach(function (date) {
					    // xAxis와 series의 data에 해당하는 월별 데이터 추가
					    var xAxisData = Object.keys(groupedData[date]);
					    var seriesDataIn = []; // 입고 데이터
					    var seriesDataOut = []; // 출고 데이터
					    
					    // 월별로 입고 및 출고 수량을 분류
					    xAxisData.forEach(function (month) {
					        var totalQuantityIn = 0;
					        var totalQuantityOut = 0;
					
					        groupedData[date][month].forEach(function (item) {
					            if (item.storCate === 'B001') {
					                totalQuantityIn += item.rmstQty;
					            } else if (item.storCate === 'B002') {
					                totalQuantityOut += item.rmstQty;
					            }
					        });
					
					        seriesDataIn.push(totalQuantityIn);
					        seriesDataOut.push(totalQuantityOut);
					    });
					
					   option.options.push({
						    title: {
						        text: 'Chart on ' + date,
						    },
						    xAxis: {
						        type: 'category', // x축 타입을 category로 변경
						        data: xAxisData,
						    },
						    yAxis: {
						        type: 'value',
						        axisLabel: {
						            formatter: '{value} pcs', // 수량에 따라 수정
						        },
						    },
						    legend: {
						        data: ['입고', '출고', '입고 선형 그래프', '출고 선형 그래프'], // 범례에 표시될 항목 설정
						        textStyle: {
						            fontSize: 12, // 범례의 폰트 크기 조절
						        },
						    },
						    series: [
						        {
						            type: 'bar', // 시리즈 타입을 bar로 변경
						            data: seriesDataIn,
						            name: '풀량유형',
						            barWidth: '20%', // 바의 너비 조절
						            itemStyle: {
						                color: 'orange', // 입고 데이터의 색상 (주황색)
						            },
						            label: {
						                show: true,
						                position: 'top', // 막대 위에 표시
						                formatter: '{c} pcs', // 수량에 따라 수정
						                fontSize: 22, // 라벨의 폰트 크기 조절
						            },
						        },
						        {
						            type: 'bar', // 시리즈 타입을 bar로 변경
						            data: seriesDataOut,
						            name: '출고',
						            barWidth: '20%', // 바의 너비 조절
						            itemStyle: {
						                color: 'skyblue', // 출고 데이터의 색상 (하늘색)
						            },
						            label: {
						                show: true,
						                position: 'top', // 막대 위에 표시
						                formatter: '{c} pcs', // 수량에 따라 수정
						                fontSize: 22, // 라벨의 폰트 크기 조절
						            },
						        },
						        {
						            type: 'line', // 선형 그래프 설정
						            data: seriesDataIn,
						            name: '입고 선형 그래프',
						            itemStyle: {
						                color: 'green', // 입고 선형 그래프의 색상 (녹색)
						            }
						        },
						        {
						            type: 'line', // 선형 그래프 설정
						            data: seriesDataOut,
						            name: '출고 선형 그래프',
						            itemStyle: {
						                color: 'purple', // 출고 선형 그래프의 색상 (보라색)
						            }
						        },
						    ],
							textStyle: {
						        fontFamily: 'Roboto, sans-serif' // 여기에 사용할 폰트 지정
						    }
											
						});
					    // yAxis 데이터에 현재 날짜에 해당하는 총 수량 추가
					    yAxisData.push({
					        name: date,
					        value: seriesDataIn.reduce(function (total, quantity) {
					            return total + quantity;
					        }, 0) + seriesDataOut.reduce(function (total, quantity) {
					            return total + quantity;
					        }, 0),
					    });
					});
					
					// yAxis 설정
					option.baseOption.yAxis = {
					    type: 'value',
					    axisLabel: {
					        formatter: '{value} pcs', // 수량에 따라 수정
					    },
					    data: yAxisData,
					};
					
					// 차트에 옵션 적용
					chart.setOption(option);

					let yearTabsHTML = '<ul class="nav nav-tabs" id="yearTabs">';
					for (let year in groupedData) {
					    yearTabsHTML += `<li class="nav-item"><a class="nav-link" id="tab${year}" data-year="${year}" href="javascript:void(0);">${year}</a></li>`;
					}
					yearTabsHTML += '</ul>';
					$('#yearTabs').html(yearTabsHTML);
					
					// 탭 클릭 시 연도별 데이터를 표시하는 이벤트 핸들러
					$('#yearTabs').on('click', 'a[data-year]', function(e) {
					    e.preventDefault();
					
					    let selectedYear = $(this).data('year');
					
					    // 선택한 연도의 1월부터 12월까지의 데이터를 계산
					    let monthlyData = {};
						let totalInSum = 0; // 입고 총량 합산을 위한 변수
					    let totalOutSum = 0; // 출고 총량 합산을 위한 변수
					    for (let month = 1; month <= 12; month++) {
					        let totalIn = 0;
					        let totalOut = 0;
					
					        if (groupedData[selectedYear] && groupedData[selectedYear][month]) {
					            groupedData[selectedYear][month].forEach(item => {
					                if (item.storCate === 'B001') {
					                    totalIn += item.rmstQty;
					                } else if (item.storCate === 'B002') {
					                    totalOut += item.rmstQty;
					                }
					            });
					        }
					
					        monthlyData[month] = { totalIn, totalOut };

					        // 입고량과 출고량의 총합을 계산
					        totalInSum += totalIn;
					        totalOutSum += totalOut;
					    }
					
					    // 월별 데이터를 표시하는 부분
					  let tableHTML = `<table id="monthlyDataTable" class="table">
										    <thead>
										        <tr>
										            <th></th>
										            ${Array.from({ length: 12 }, (_, i) => `<th>${i + 1}월</th>`).join('')}
										            <th>총합</th>
										        </tr>
										    </thead>
										    <tbody>
										        <tr>
										            ${Array.from({ length: 13 }, (_, i) => `<td>${i === 0 ? '입고 합계' : (monthlyData[i] ? monthlyData[i].totalIn : '')}</td>`).join('')}
										            <td>${totalInSum}</td>
										        </tr>
										        <tr>
										            ${Array.from({ length: 13 }, (_, i) => `<td>${i === 0 ? '출고 합계' : (monthlyData[i] ? monthlyData[i].totalOut : '')}</td>`).join('')}
										            <td>${totalOutSum}</td>
										        </tr>
										    </tbody>
										</table>`;
										
					$('#monthlyDataContainer').empty().append(tableHTML);

					});

					
				}else{
					$('#contentBody').html('');
					$('#graphBody').html('');
					
					invenList.forEach(item => {
					
					if (!groupedItems[item.itemNm]) {
					    groupedItems[item.itemNm] = [];
					  }
					  groupedItems[item.itemNm].push(item);
					});
					
					
				
					let keys = Object.keys(groupedItems);
					// 반복문으로 nameValue값 변경됨
					keys.forEach(item =>{
						let nameValue=0;
						let idValue="";
						groupedItems[item].forEach(data=>{
							nameValue = totalValueMap[data.itemCd]
							idValue = data.itemCd;
						})
						let invenId = `inven0_${idValue}`;
						let trTags="";
						trTags += `
						<div id="flexDiv">
						  <div class="leftContent">
						    품목명: ${item}
						  </div>
						  <div class="rightContent">
						    검색일자: ${rmstSdate}~${rmstLdate}
						  </div>
						</div>
						<div class="card mb-3">
							<table class="table table-bordered table-striped fs--1 mb-0 itemTable">
							  <thead>
							    <tr>
							      <th scope="col">일자</th>
							      <th scope="col">거래처명</th>
							      <th scope="col">적요</th>
							      <th scope="col">입고수량</th>
							      <th scope="col">출고수량</th>
							      <th scope="col">재고수량</th>
							    </tr>
							  </thead>
							  <tbody class="irpList">
								<tr>
									<td colspan='3' style='text-align: center;'><span style='color : red'>전일재고</span></td>
									<td></td>
									<td></td>
									<td id="${invenId}">${nameValue}</td>
								</tr>
								`;
							let recTotal = 0;
							let outTotal = 0;
							invenValue = nameValue; // 전역변수에 초기값 설정(변경된 전일재고값으로 초기값 설정)
							groupedItems[item].forEach(data=>{
								trTags += makeTrTag(data, invenValue);
								
								if (data.storCate === 'B001') {
							        recTotal += data.rmstQty;
							    } else if (data.storCate === 'B002' || data.storCate === 'B003') {
							        outTotal -= data.rmstQty;
							    }
							})
							
							let totalStock = nameValue + recTotal + outTotal;
							let names = '';
							trTags += `
								<tr>
									<td>합계</td>
									<td></td>
									<td></td>
									<td id="rec_count${idValue}"></td>
									<td id="out_count${idValue}"></td>
									<td id="names">${totalStock} ${names}</td>
								</tr>
								</tbody>
								</table></div>
							`;
							$('#contentBody').append(trTags);
							let totals = setCount(idValue); 
						    recTotal = totals.recTotal; 
						    outTotal = totals.outTotal;	
					})
				}
				
				
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});	
		
		/* 아작스를 위한 데이터 설정 */
		let makeTrTag = function (rslt, nameValue) {
		    let recId = 'rec_' + rslt.itemCd;
		    let outId = 'out_' + rslt.itemCd;
			let InvenId = 'inven_' + rslt.itemCd;
			
			let invenVal = parseInt(nameValue); // 전일재고
			let recVal = rslt.storCate == 'B001' ? parseInt(rslt.rmstQty) : 0; // 입고수량
			
			// 출고수량
			let outVal = 0;
			if(rslt.storCate == 'B002' || rslt.storCate == 'B003')
				outVal = parseInt(rslt.rmstQty);
			else
				outVal = 0;
			
			// 계산
			let invenResult = invenVal + recVal - outVal;
			
			invenValue = invenResult; // 계산된 결과를 전역변수에 저장
			
		    let trTag = `<tr>
			    <td>${rslt.rmstDate}</td>
			    ${rslt.saleComNm ? `<td>[판매]-${rslt.saleComNm}</td>` : ''}
			    ${rslt.purComNm ? `<td>[구매]-${rslt.purComNm}</td>` : ''}
			    ${rslt.defectCd ? `<td>[폐기]-폐기재고</td>` : ''}
			    <td>${rslt.rmstNote  ? rslt.rmstNote  : ''}</td>
			    <td id="${recId}">${rslt.storCate == 'B001' ? rslt.rmstQty : ''}</td>
			    <td id="${outId}">
			        ${rslt.storCate == 'B002' ? rslt.rmstQty : ''}
			        ${rslt.storCate == 'B003' ? rslt.rmstQty : ''}
			    </td>
				<td id="${InvenId}">${invenResult}</td>
		    </tr>`;
			
			return trTag;
		};
		
		function setCount(idValue){
			let recTotal=0;
			let outTotal=0;
			
			$('[id^="rec_' + idValue + '"]').each(function() {
		        let value = parseFloat($(this).text()) || 0; 
		        recTotal += value; 
		    });
			    
		    $('[id^="out_' + idValue + '"]').each(function() {
		        let value = parseFloat($(this).text()) || 0; 
		        outTotal += value; 
		    });
						
			$(`#rec_count${idValue}`).text(`${recTotal}`);
			$(`#out_count${idValue}`).text(`${outTotal}`);
			
			return  { recTotal, outTotal };
		}
	})
});
