/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 14.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 14.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

$(function(){
	
	$('#wareTable').DataTable({
	        paging: true,
	        searching: true,
	        lengthChange: false,
	        info: false,
	        ordering: false
	});

	let wareWindowModal = new bootstrap.Modal($('#wareWindow')[0]);
	
	$('#wareTableData').DataTable({
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
	
	//버튼 이벤트발생시 모달 show
	$('#wareBtn').on('click', function () {
	    wareWindowModal.show();
	});
	//input 클릭하면 모달 show
	$('#inputWare').on('click', function () {
	    wareWindowModal.show();
	});
	
	/* 색깔 랜덤부여 */
	function getRandomColor() {
	    const letters = '0123456789ABCDEF';
	    let color = '#';
	    for (let i = 0; i < 6; i++) {
	        color += letters[Math.floor(Math.random() * 16)];
	    }
	    return color;
	}
	
	//table의 body를 찍어주는부분
	let makeTrTag = function (spaceList,itemList) {
	    let trTag = `
	        	<tr>
		            <td><a href="javascript:;">${itemList.itemCd}</a></td>
		            <td>${itemList.itemVO.itemNm}</td>
		            <td>${itemList.wareQty}</td>
		            <td>${itemList.itemVO.itemCate}</td>
		            <td>${itemList.itemVO.itemSafeQty}</td>
		        </tr>
		    `;	
		return trTag;
	};
	
	$('#wareTable').on('click', '.selectItem', function (e) {
	    e.preventDefault();
	    $('#itemList').html('');
	    let selectedValue = $(this).data('selected-value');
	    let selectedEmp = $(this).closest('tr').find('.hiddenEmp').data('selected-emp');
		let selectedWareCd = $(this).closest('tr').find('td').eq(0).text();
	    
		$('#inputWare').val(selectedValue);
	    $('#inputEmp').val(selectedEmp);
	    wareWindowModal.hide();
	    $('.modal-backdrop').remove();
        $('#selectSector').css('display', 'none');
        
		$.ajax({
			url: `/sector/${selectedWareCd}`,
			method: "GET",
			contentType: 'application/json',
			success: function (resp) {
			
					const rectanglesData = [];
					let container ="";				
					let result = resp.wareList;

					//res에 있는 has many관계를 통해 list형식으로 담겨있는값 뽑아오기
					const wareSecList = result.map(item => item.wareSecList).flat();
					if(wareSecList.length===0){
						let divData = `
							<div class="text-center"><h5>창고구역이 등록되지 않은 창고입니다.</h5></div>
						`;
						$('#itemList').html(divData);
					}
					console.log(wareSecList);
					//탭을 위한 ul태그 만들기
					let tabMenu = document.createElement('ul');
					tabMenu.classList.add('nav', 'nav-tabs');
					tabMenu.setAttribute('id', 'myTab');
					tabMenu.setAttribute('role', 'tablist');
					//창고의 층을 담을 공간
					let tabNames = []; 
					//tab의 내용이 있으면 초기화
					$('#tabInput').html('');
					$('#myTabContent').html('');
					
					
					//for문을 돌면서 db에 저장되어있는 데이터를 배열에 저장.
					wareSecList.forEach( rslt => {
						
					   let idMaker = 'floor'+rslt.wsecZ;
					   tabNames.push(idMaker);
					   rectanglesData.push({ x: rslt.wsecX1, y: rslt.wsecY1, width: rslt.wsecX2, 
		                                     height: rslt.wsecY2, floor : rslt.wsecZ, sCode : rslt.secCd ,wCode : rslt.wareCd})
					});
					
					//중복제거하기위헤 set을사용
					let uniqueTabNames = new Set(tabNames);
					tabNames = Array.from(uniqueTabNames);
				
					//창고의 층을 담고 층마다 탭을위한 li생성
					tabNames.forEach((name, index) => {
					  let li = document.createElement('li');
					  li.classList.add('nav-item');
					
					  let button = document.createElement('button');
					  
			  		  button.classList.add('nav-link');
					  button.textContent = name;
					  button.setAttribute('type', 'button');
					  button.setAttribute('data-bs-toggle', 'tab');
					  button.setAttribute('role', 'tab');
					  button.setAttribute('aria-controls', String(name).toLowerCase().replace(/\s/g, ''));
					  button.setAttribute('aria-selected', index === 0 ? 'true' : 'false');
					  button.setAttribute('data-bs-target', `${String(name).toLowerCase().replace(/\s/g, '')}`);
			   	  	  container = document.getElementById('tabInput'); 
					  container.prepend(tabMenu);
					  if (index === 0) {
					    button.classList.add('active');
					  }
					
					  li.appendChild(button);
					  tabMenu.appendChild(li);
					});
					
			        // 캔버스 구역만들기 , 이름 부여하기
			        function drawReceivedRectangles() {
						//몇층인지 데이터가 들어있음.
						tabNames.forEach((tx,i)=>{
							//각 섹터에 관한 정보가 들어있음.
			            	rectanglesData.forEach((rect, index) => {     
								if(rect.floor==i+1){
									let canvas = $(`#canvas${i + 1}`)[0];
						        	let ctx = canvas.getContext('2d');
	
									ctx.fillStyle = getRandomColor();							
							        ctx.fillRect(rect.x, rect.y, rect.width, rect.height);												
							        ctx.fillStyle = 'white';
			 						ctx.font = 'bold 30px Arial';
							        ctx.fillText(`sector${index + 1}`, rect.x + 10, rect.y + 30);
									
									//캔버스에 영역으로 등록된 범위내의 있는곳을 클릭했을때 발생하는 이벤트
									canvas.addEventListener('click', function (event) {
					                    const clickX = event.offsetX;
					                    const clickY = event.offsetY;
					
					                    if (
					                        clickX >= rect.x &&
					                        clickX <= rect.x + rect.width &&
					                        clickY >= rect.y &&
					                        clickY <= rect.y + rect.height
					                    ) {
					                        $.ajax({
												url: `/sector/itemList`,
												method: "POST",
												data:JSON.stringify({
												    wareCd: rect.wCode,
												    secCd: rect.sCode
												}),
												dataType : 'json',
												contentType: 'application/json',
												success: function (resp) {
													let trTags ="";
													//각 sector의 정보
													let secList = resp.secList;
													//각 space에 있는 item의 정보
													let itemList = secList.map(item => item.itemWareList).flat();
													//각 item의 상세정보
													let itemData = itemList.map(item => item.itemVO).flat();
													
													// 테이블을 동적으로 생성
													trTags =`
														<table class="table table-bordered fs--1 mb-0" id="dataTable">
															<thead class="bg-200 text-900">
																	<tr class="text-center">
																		<th >품목코드</th>
																		<th >품목명</th>
																		<th >품목수량</th>
																		<th >품목 구분</th>
																		<th >안전재고 수량</th>
																	</tr>
															</thead>
															<tbody class="list">
								                      `
														
													
													//sector 안의 space안의 item의 상세정보 출력
													secList.forEach(a => {
														a.itemWareList.forEach(b =>{
																if(b.itemVO?.itemCd){
																	 trTags += makeTrTag(a,b);
																}
														})
																
													});
													
													//forEach 종료
													trTags +=`
														</tbody>
													</table>
													`;
													//데이터 찍어주기
													$('#itemList').html(trTags);
													
													$('#dataTable').DataTable({
												        paging: true,
												        searching: true,
												        lengthChange: false,
												        info: false,
												        ordering: false
												    });		

													$('#selectSector').text("선택한 섹터 : " + getSectorNameFromSecCd(rect.sCode));
													$('#selectSector').css('display', 'block');
												},
												error: function (request, status, error) {
											        console.log("code: " + request.status)
											        console.log("message: " + request.responseText)
											        console.log("error: " + error);
											    }
											});
					                    }
					                });				
								}								
							});
					    });
			        }
	 				let tabContentContainer = document.getElementById('myTabContent');
					if (!tabContentContainer) {
					  // 컨테이너가 없으면 생성하기
					  tabContentContainer = document.createElement('div');
					  tabContentContainer.classList.add('tab-content');
					  tabContentContainer.setAttribute('id', 'myTabContent');
					  // 컨테이너를 원하는 부모 요소에 추가하기
					  document.getElementById('myTabContent').appendChild(tabContentContainer);
					}
					
					// 정규식으로 sectorName 가져옴
					function getSectorNameFromSecCd(secCd) {
					    const match = secCd.match(/S(\d+)/);
					    if (match) {
					        const num = parseInt(match[1]);
					        return `sector${num}`;
					    }
					    return null;
					}
					
					// 탭 내용(층) 요소 생성하는 함수
					function createTabContent(tabId,index) {
					  const tabPane = document.createElement('div');
					  tabPane.classList.add('tab-pane', 'fade');
					  if (tabId == 'floor1') {
					    tabPane.classList.add('show', 'active');
					  }
					  tabPane.setAttribute('id', tabId);
					  tabPane.setAttribute('role', 'tabpanel');
					  tabPane.setAttribute('aria-labelledby', `${tabId}-tab`);
					
					  const canvas = document.createElement('canvas');
					  canvas.setAttribute('id', `canvas${index}`); 
					  canvas.width = 1160;
					  canvas.height = 580;
					  canvas.style.border = '1px solid black';
					
					  // 캔버스를 탭 내용에 추가하기
					  tabPane.appendChild(canvas);
					
					  return tabPane;
					}
					// 각 탭의 내용을id를 만들려고 만든 for
					tabNames.forEach((name, index) => {
					  const tabId = name; // 탭 id 만들기
					  
					  const tabContent = createTabContent(tabId,index+1);
					  // 탭 내용을 탭 컨텐츠 컨테이너에 추가하기
					  tabContentContainer.appendChild(tabContent);
					});
					
					let tabButtons = document.querySelectorAll('.nav-link');
					tabButtons.forEach((button) => {
					  button.addEventListener('click', function() {
					    let tabId = this.getAttribute('aria-controls');
					    let tabs = document.querySelectorAll('.tab-pane');
					    
					    tabs.forEach((tab) => {
					      tab.classList.remove('active', 'show');
					    });
					
					    let selectedTab = document.getElementById(tabId);
					    if (selectedTab) {
					      selectedTab.classList.add('active', 'show');
					    }
					  });
					});
					$('.nav-link').on('click', function(){
						$('#selectSector').css('display', 'none');
					});
			        // 캔버스 그리는 함수호출 
			        drawReceivedRectangles();
					},
					
					error: function (xhr, status, error) {
						console.log(xhr);
						console.log(status);
						console.log(error);
					}
			});	
	});
});