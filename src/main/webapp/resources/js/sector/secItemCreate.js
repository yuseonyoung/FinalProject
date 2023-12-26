/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 25.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 25.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

$(function(){
	let wareWindowModal = new bootstrap.Modal($('#wareWindow')[0]);
	let itemWindowModal = new bootstrap.Modal($('#itemWindow')[0]);
	let wareSelectWindow = new bootstrap.Modal($('#wareSelectWindow')[0]);
	let cPath = $('.pageConversion').data('contextPath');
	let selectedWareCd;
	let selectedSecCd;
	//$('.modal-backdrop').remove();  
	$('#wareTable').DataTable({
	        paging: true,
	        searching: true,
	        lengthChange: false,
	        info: false,
	        ordering: false
	});
	
	//table의 body를 찍어주는부분
	let makeTrTag = function (spaceList,itemList) {
	    let trTag = `
	        	<tr>
					<td><input type="checkbox" value="${itemList.itemCd}" data-wareqty="${itemList.wareQty}" /></td>
		            <td>${itemList.itemCd}</td>
		            <td>${itemList.itemVO.itemNm}</td>
		            <td>${itemList.wareQty}</td>
		            <td>${itemList.itemVO.itemCate || ''}</td>
		            <td>${itemList.itemVO.itemSafeQty}</td>
		        </tr>
		    `;	
		return trTag;
	};
	
	//modal이 닫히는 이벤트가 발생시 body의 css를 overflow hidden을 날려주기위해 사용
	$('#wareWindow').on('hidden.bs.modal', function () {
		$('.modal-backdrop').remove();  
	    $('body').css('overflow', ''); 
	});
		
	$('#itemWindow').on('hidden.bs.modal', function () {
		$('.modal-backdrop').remove();  
	    $('body').css('overflow', ''); 
	});
	
	/*$('#itemWindow').on('shown.bs.modal', function () {
		$('.modal-backdrop').remove();  
	});*/
	//버튼 이벤트발생시 모달 show
	$('#wareBtn').on('click', function () {
	    wareWindowModal.show();
	});
	$('#inputWare').on('click', function () {
	    wareWindowModal.show();
	});
	
	let makeModalTrTag = function (item) {
	    let trTag = `
				<tr>
					<td>${item.itemCd}</td>
					<td><a href="javascript:;" class="selectItem"
						data-selected-value="${item.itemNm}" data-selected-cd="${item.itemCd}"> ${item.itemNm} </a>
					</td>
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
						trTags += makeModalTrTag(this);
					});
					$(pagingArea).html(resp.paging.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='2'>등록된 품목이 없습니다.</td>
							</tr>
						`;
					$(pagingArea).empty();
				}
				$('#dataList').html(trTags);
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
	
	/* 색깔 랜덤부여 */
	function getRandomColor(seed) {
	    const letters = '0123456789ABCDEF';
	    let color = '#';
	
	    // 시드를 이용한 의사 난수 생성
	    const random = () => {
	        let x = Math.sin(seed++) * 10000;
	        return x - Math.floor(x);
	    };
	    
	    for (let i = 0; i < 6; i++) {
	        const randomIndex = Math.floor(random() * 16);
	        color += letters[randomIndex];
	    }
	    
	    return color;
	}
		
	$('#wareTable').on('click', '.selectItem', function (e) {
	    e.preventDefault();
	    $('#itemList').html('');
	    let selectedValue = $(this).data('selected-value');
	    let selectedEmp = $(this).closest('tr').find('.hiddenEmp').data('selected-emp');
		selectedWareCd = $(this).closest('tr').find('td').eq(0).text();
	    
		$('#inputWare').val(selectedValue);
	    $('#inputEmp').val(selectedEmp);
	    wareWindowModal.hide();
	    $('.modal-backdrop').remove();
		$('#selectSector').css('display', 'none');

		writeRectItem(selectedWareCd);
	});
	
	function writeRectItem(selectedWareCd){
		let secItemList = {};
	 	$.ajax({
			url: `/sector/itemsList`,
			method: "POST",
			data:JSON.stringify({
			    wareCd: selectedWareCd,
			}),
			dataType : 'json',
			contentType: 'application/json',
			success: function (resp) {
				let secList = resp.secList;
				
				secList.forEach(sec => {
					secItemList[sec.secCd] = sec.itemWareList;
				});
				drawRectEvent(selectedWareCd, secItemList);
			},
			error: function (request, status, error) {
		        console.log("code: " + request.status)
		        console.log("message: " + request.responseText)
		        console.log("error: " + error);
		    }
		});	
	}
	
	function drawRectEvent(selectedWareCd, secItemList){
		// 도형 그림
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

	 				let tabContentContainer = document.getElementById('myTabContent');
					if (!tabContentContainer) {
					  // 컨테이너가 없으면 생성하기
					  tabContentContainer = document.createElement('div');
					  tabContentContainer.classList.add('tab-content');
					  tabContentContainer.setAttribute('id', 'myTabContent');
					  // 컨테이너를 원하는 부모 요소에 추가하기
					  document.getElementById('myTabContent').appendChild(tabContentContainer);
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

			        // 캔버스 그리는 함수호출 
			        drawReceivedRectangles(tabNames, rectanglesData, secItemList, selectedWareCd);
					addTabClickEvent();
				},
				error: function (xhr, status, error) {
					console.log(xhr);
					console.log(status);
					console.log(error);
				}
			});
	}
	
	// 캔버스 구역만들기 , 이름 부여하기
    function drawReceivedRectangles(tabNames, rectanglesData, secItemList, wareCd) {
		//몇층인지 데이터가 들어있음.
		tabNames.forEach((tx,i)=>{
			//각 섹터에 관한 정보가 들어있음.
        	rectanglesData.forEach((rect, index) => {     
				if(rect.floor==i+1){
					let canvas = $(`#canvas${i + 1}`)[0];
		        	let ctx = canvas.getContext('2d');
					
					ctx.fillStyle = getRandomColor(index+10);		
			        ctx.fillRect(rect.x, rect.y, rect.width, rect.height);												
					ctx.fillStyle = 'white';
					ctx.font = 'bold 30px Arial';
			        ctx.fillText(`sector${index + 1}`, rect.x + 10, rect.y + 30);	
					
					// 섹터 코드에 해당하는 itemNm 찾기
	                const secItemListForSector = secItemList[rect.sCode];
				
	                if (secItemListForSector) {
	                    // 섹터 코드에 해당하는 itemNm이 있는 경우 도형에 추가
						ctx.fillStyle = 'white';
	                    ctx.font = '18px Arial';
						let xOffset = 10;
	                    let yOffset = 55; // 텍스트를 표시할 세로 위치 조절
						let end = false;
						let totalSecItem = secItemListForSector.length;
						let count = 1;
						
	                    secItemListForSector.forEach((item) => {
                        // 텍스트 위치 계산
                        const textX = rect.x + xOffset;
                        const textY = rect.y + yOffset;

                        // 현재 글자와 다음 글자를 포함한 너비 계산
                        const currentTextWidth = ctx.measureText(item.itemVO.itemNm).width;
                        const nextTextWidth = ctx.measureText(item.itemVO.itemNm + '...').width;
                        const nextTextY = rect.y + yOffset + 30;
						const maxTextWidth = rect.width - xOffset;
						if (currentTextWidth >= maxTextWidth) {
							console.log("벗어남");
						}
                        // 텍스트가 사각형 경계를 벗어나는지 확인
                        if (currentTextWidth <= maxTextWidth && nextTextY >= rect.y && nextTextY <= rect.y + rect.height) {
                            // 텍스트가 경계 안에 있는 경우 그대로 그리기
                            ctx.fillText(item.itemVO.itemNm, textX, textY);
                        } else if (currentTextWidth >= maxTextWidth) {
							console.log(item.itemVO.itemNm);
                            // 텍스트가 경계를 벗어나면 일부만 그리기
					        let displayedText = item.itemVO.itemNm.substring(0, calculateMaxDisplayChars(ctx, item.itemVO.itemNm, maxTextWidth));
					        ctx.fillText(displayedText + '...', textX, textY);
                        } else if (nextTextY <= rect.y || nextTextY >= rect.y + rect.height) {
							// y가 벗어났으면 글자에 외 4건 써주기
							if(!end && totalSecItem - count != 0){
								let text = item.itemVO.itemNm + " 외 " + (totalSecItem - count).toString() + "건";
                            	ctx.fillText(text, textX, textY);
								end = true;
							}else if(!end && totalSecItem - count == 0){
								let text = item.itemVO.itemNm + " 외 " + (totalSecItem - count).toString() + "건";
                            	ctx.fillText(text, textX, textY);
								end = true;
							}
                        } else {
                            // x, y 둘 다 벗어났으면 외 3건만 써주기
                            if (!end) {
								let countText = "외 " + (totalSecItem - count).toString() + "건";
                                ctx.fillText(countText, textX, textY);
                                end = true;
                            }
                            return; // 반복문 종료
                        }

                        // 다음 아이템을 표시할 위치 조절
                        yOffset += 25;
						count ++;
                    });
                }
					canvas.addEventListener('click', function (event) {
					    addCanvasClickEvent(event, rect, wareCd);
						console.log('click');
					});
				}								
			});
	    });
    }

	// 텍스트를 생략 부호를 포함하여 지정된 최대 너비로 자르는 함수
	function calculateMaxDisplayChars(ctx, text, maxWidth) {
	    let currentWidth = 0;
	    for (let i = 0; i < text.length; i++) {
	        currentWidth += ctx.measureText(text[i]).width;
	        if (currentWidth > maxWidth) {
	            return i - 1;
	        }
	    }
	    return text.length;
	}
	
	function addCanvasClickEvent(event, rect, wareCd){
		const clickX = event.offsetX;
        const clickY = event.offsetY;

        if (
            clickX >= rect.x &&
            clickX <= rect.x + rect.width &&
            clickY >= rect.y &&
            clickY <= rect.y + rect.height
        ) {
			selectedSecCd = rect.sCode;
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
										<th></th>
										<th>품목코드</th>
										<th>품목명</th>
										<th>품목수량</th>
										<th>품목구분</th>
										<th>안전재고수량</th>
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
					<button type="button" class="btn btn-outline-primary right" id="moveSector">창고이동</button>
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
					
					clickMoveSector();
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
	
	function addTabClickEvent(){
		$('.nav-link').on('click', function(){
			$('#selectSector').css('display', 'none');
		});
	}
	
	// 품목 종류 추가 누르면 새로운 행 생김
	function addTrBtnClickEvent(){
		$('#addTr').on('click', function(){
			// 클릭 이벤트가 발생한 테이블의 tbody 선택
		    let tbody = $('#dataTable tbody');
		
		    // 테이블의 마지막 행을 복사하여 새로운 행 생성
		    let newRow = tbody.find('tr:last').clone();
		
		    // 새로운 행의 입력 필드를 초기화
		    newRow.find('input[type="text"]').val('');
		    newRow.find('input[type="number"]').val('');
		
		    // 생성된 행을 테이블의 tbody에 추가
		    tbody.append(newRow);
		});
	}
	
	// 행삭제 이벤트
	function deleteTrBtnClickEvent(){
		$('#deleteTr').on('click', function(){
			// 클릭 이벤트가 발생한 테이블의 tbody 선택
		    let tbody = $('#dataTable tbody');
		
			let rowCount = tbody.find('tr').length;
			if(rowCount >1){
			   	// 테이블의 마지막 행을 삭제
	        	tbody.find('tr:last').remove();
			}
		});
	}
	
	
	function saveBtnClickEvent(secCd, wareCd){
		$('#saveItem').on('click', function(){
			let tbody = $('#dataTable tbody');
        
	        // 모든 행에 대한 데이터 수집
	        let allRowsData = [];
			let isValid = true;
			let itemData = '';
	        tbody.find('tr').each(function () {
				let inputItemData = $(this).find('#inputItemData');
            	let inputItemQty = $(this).find('#inputItemQty');

            	// 각 입력 필드의 값을 가져옴
            	itemData = inputItemData.val();
           		let wareQty = inputItemQty.val();
				
				if(itemData == '' || !wareQty){
					isValid = false;
					
					if (itemData == '') {
	                    inputItemData.css('border', '1px solid red');
	                }
	
	                if (!wareQty) {
	                    inputItemQty.css('border', '1px solid red');
	                }
				} else {
					let rowData = {
						itemCd: $(this).find('#InputItemCd').val(),
		                wareCd: wareCd,
		                wareQty: $(this).find('#inputItemQty').val(),
						secCd2 : secCd
		            };
	                allRowsData.push(rowData);
	
	                // 비어있지 않은 경우, 이전에 강조한 스타일을 초기화
	                inputItemData.css('border', '');
	                inputItemQty.css('border', '');
				}
	        });
	        
	        // 수집된 데이터 출력 (개발자 도구 콘솔에 출력)
			if(isValid){
				$.ajax({
					url: `/sector/item`,
					method: "POST",
					data:JSON.stringify(allRowsData),
					dataType : 'json',
					contentType: 'application/json',
					success: function (resp) {
						let trTag =`
							<div id="itemTableDiv">
								<div class="d-flex justify-content-between mt-3">
									<button type="button" class="btn btn-outline-primary right" id="addTr" >품목 종류 추가</button>
									<button type="button" class="btn btn-primary right" id="saveItem">저장</button>
								</div>
								<table class="table table-bordered fs--1 mb-0" id="dataTable">
									<thead class="bg-200 text-900">
										<tr class="text-center">
											<th>품목명</th>
											<th>품목수량</th>
										</tr>
									</thead>
									<tbody class="list">
										<tr class="text-center">
											<td><div style="display: flex; align-items: center;">
													<input type="hidden" class="hiddenItemCd" id="InputItemCd"/>
													<input class="form-control" id="inputItemData" type="text"
														data-bs-target="#itemWindow" data-bs-toggle="modal"
														autocomplete="off" required/> <span id="itemCd"
														class="error"></span>
													<button id="itemBtn" type="button" class="btn searchBtn p-1"
														data-bs-target="#itemWindow" data-bs-toggle="modal">
													<i class="bi bi-search"></i>
													</button></div>
											</td>
											<td><input class="form-control" type="number" id="inputItemQty"name="wareQty" placeholder="수량을 입력하세요" min=0 required></td>
										</tr>
									</tbody>
								</table>
							</div>
						`
														
						$('#itemList').html(trTag);
						
						//버튼 이벤트발생시 모달 show
						$('#itemBtn').on('click', function () {
							$('.modal-backdrop').remove();
						    itemWindowModal.show();
						});			
						
						$('#inputItemData').on('click', function () {
							$('.modal-backdrop').remove();
						    itemWindowModal.show();
						});			
						
						itemClickItem();
						addTrBtnClickEvent();
						deleteTrBtnClickEvent();
						saveBtnClickEvent(secCd, wareCd);
						inputEvent();
						writeRectItem(wareCd);
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
	
	function itemClickItem(){
		$(document).off('click', '#dataTable #itemBtn, #dataTable #inputItemData'); // 이벤트 등록 전에 이전 이벤트를 해제
	    $(document).on('click', '#dataTable #itemBtn, #dataTable #inputItemData', function () {
	        // itemWindow 모달 열기
	        $('#itemWindow').modal('show');
	
	        // 현재 클릭된 행에 대한 데이터 가져오기
	        let currentRow = $(this).closest('tr');
			let inputItemCd = currentRow.find('.hiddenItemCd');
	        let inputItemData = currentRow.find('#inputItemData');
	
	        // itemWindow 모달에서 itemNm을 클릭할 때 실행될 이벤트 등록
	        $('#itemTableData').off('click', '.selectItem'); // 이벤트 등록 전에 이전 이벤트를 해제
	        $('#itemTableData').on('click', '.selectItem', function () {
	            // 선택한 item의 정보 가져오기
				let selectedItemCd = $(this).data('selected-cd');
	            let selectedItemNm = $(this).data('selected-value');
	
	            // 현재 클릭된 행의 input에 값을 추가
				inputItemCd.val(selectedItemCd);
	            inputItemData.val(selectedItemNm);
	
	            // itemWindow 모달 닫기
	            $('#itemWindow').modal('hide');
	            $('.modal-backdrop').remove();
				$('#inputItemData').css('border', '');
	        });
	    });
	}
	
	function inputEvent(){
		$(document).on('input', '#inputItemData', function(){
			$('#inputItemData').css('border', '');
		});
		$(document).on('input', '#inputItemQty', function(){
			$('#inputItemQty').css('border', '');
		});
	}
	
	// 탭 내용 요소 생성하는 함수
	function createTabContent(tabId,index) {
	    const tabPane = document.createElement('div');
	    tabPane.classList.add('tab-pane', 'fade');
	    if (tabId == 'floor1') {
	    	tabPane.classList.add('active', 'show');
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
	
	// 정규식으로 sectorName가져옴
	function getSectorNameFromSecCd(secCd) {
	    const match = secCd.match(/S(\d+)/);
	    if (match) {
	        const num = parseInt(match[1]);
	        return `sector${num}`;
	    }
	    return null;
	}
	
	/*
		모달이 열릴때 이벤트를 잡아와서 ajax를 돌려서 ware와 sector의 정보를 가져와서 Tree구조로 보여줌
		
	*/
	function clickMoveSector(){
		$('#moveSector').on('click', function() {
			// 선택된 체크박스의 값을 저장할 배열
	        const selectedItems = [];
	
	        // 체크된 체크박스를 찾아서 배열에 추가
	        $('#dataTable tbody input[type="checkbox"]:checked').each(function () {
	        	const itemCd = $(this).val();
            	const wareQty = $(this).data('wareqty');

				selectedItems.push({
					itemCd: itemCd,
                	rmstQty: wareQty,
					wareCd : selectedWareCd,
					secCd2 : selectedSecCd
				});
	        });

	        // 선택된 체크박스의 값들을 콘솔에 출력하거나 다른 작업을 수행할 수 있음
	        console.log('Selected items:', selectedItems);
			let baseUrl = `${cPath}/stor`;
			let arrays = [];
			$.ajax({
				url: baseUrl,
				method: "GET",
				success: function(res) {
					console.log("res는 나~",res);
					let wareList = res.wareList;
	
					let ckLength = wareList.length;
					let ckCnt = 0;
					wareList.forEach(function(item, index) {
						if (item.wareTemp === 'Y') {
							arrays.push({
								"id": item.wareCd,
								"parent": "#",
								"text": item.wareNm,
								"icon": "far fa-building"
							});
						}
						$.ajax({
							url: `${cPath}/sector/${item.wareCd}`,
							method: "GET",
		//					async:false,
							success: function(resp) {
								ckCnt++;
								let secWareList = resp.wareList;
								let sectorValue = secWareList[0]?.wareSecList;
								if (sectorValue !== null && sectorValue !== undefined) {
									sectorValue.forEach(function(i, v) {
										console.log("i",i);
										console.log("v",v);
										console.log("item",item);
										
										arrays.push({
											"id": i.secCd + i.wareCd + v,
											"parent": i.wareCd,
											"text": i.secCd,
											"icon": "fas fa-cubes"
										});
											
									});
								}
	
								if (ckCnt == ckLength) {
									$("#jstree").jstree({
										'core': {
											'data': arrays,
											"check_callback": true,  
										}
									});
									 $('#jstree').on('select_node.jstree', function (e, data) {
								        // jstree에서 노드를 클릭했을 때 발생하는 이벤트
								        let selectedNode = data.node;
							            let inputData = `
											<div class="mb-3">
							                  <label class="form-label" for="parentId">창고코드</label>
							                  <input class="form-control" id="parentId" type="text" placeholder="창고코드" value='${selectedNode.parent}'/>
							                </div>
							                <div class="mb-3">
							                  <label class="form-label" for="parentNm">창고명</label>
							                  <input class="form-control" id="parentNm" type="text" placeholder="창고명" value=''/>
							                </div>
							                <div class="mb-3">
							                  <label class="form-label" for="textId">창고구역명</label>
							                  <input class="form-control" id="textId" type="text" placeholder="구역명" value='${selectedNode.text}'/>
							                </div>
							            `;
	
								        // 선택한 노드가 자식 노드인지 확인
								        if (selectedNode.parent === '#') {
								            // 선택한 노드가 자식 노드인 경우에만 데이터 표시
								            $('#jstree').jstree(true).open_node(data.node);
								
								            $('#treeValue').html('');
								        } else {
								            // 다른 노드를 클릭했을 때는 데이터를 표시하지 않음
								            $('#treeValue').html(inputData);
											let parentNode = $('#jstree').jstree(true).get_node(selectedNode.parent);
										    let parentText = parentNode.text; // 부모 노드의 text 값
											
								            $('#parentNm').val(parentText);
										
								        }
								    });
								}
	
							},
							error: function(request, status, error) {
								console.log("code: " + request.status)
								console.log("message: " + request.responseText)
								console.log("error: " + error);
							}
						})
	
					});
				
	
				},
				error: function(request, status, error) {
					console.log("code: " + request.status)
					console.log("message: " + request.responseText)
					console.log("error: " + error);
				}
			})
			wareSelectWindow.show();
			saveSectorSelect(selectedItems);
		}); //ajax 끝
	}
	// 모달이 닫힐 때 초기화
	$('#wareSelectWindow').on('hidden.bs.modal', function () {
	    $('#treeValue').empty();
		$('#jstree').jstree('close_all');
	});
	
	function saveSectorSelect(selectedItems){
		let inOutItems = [];
		$('#savedBtn').off('click');
		$('#savedBtn').on('click', function(){
			let wareCd = $('#parentId').val();
			let sectorCd = $('#textId').val();

			for (let i = 0; i < selectedItems.length; i++) {
				let selectedItem = selectedItems[i];
				
            	// inOutItems 배열에 각 선택된 아이템을 추가
            	inOutItems.push(selectedItems[i]);

				inOutItems.push({
                	itemCd: selectedItem.itemCd,
                	rmstQty: selectedItem.rmstQty,
                	wareCd : wareCd,
					secCd2 : sectorCd
            	});
        	}
			
			console.log(inOutItems);
			$.ajax({
				url: `${cPath}/storInOut/move`,
				method: "POST",
				contentType: 'application/json',
				data: JSON.stringify(inOutItems),
				success: function(resp) {
					if(resp.totalValue.rslt == 'success'){
						$('#dataTable tbody input[type="checkbox"]:checked').each(function () {
							$(this).closest('tr').remove();
						});
						writeRectItem(selectedWareCd);
						Swal.fire({
							  title: '이동완료!',
							  text: '창고이동이 성공적으로 완료되었습니다.',
							  icon: 'success',
							  confirmButtonText: '확인'
						});
						inOutItems = [];
					} else{
						Swal.fire({
							  title: '이동실패!',
							  text: '창고이동이 실패하였습니다. 다시 시도해 주세요.',
							  icon: 'error',
							  confirmButtonText: '확인'
						});
					}
				},
				error: function(xhr, status, error) {
					console.log(xhr);
					console.log(status);
					console.log(error);
				}
			});
		});
	}
});