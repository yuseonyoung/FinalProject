/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 24.
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
	// 캔버스와 캔버스 컨텍스트 설정
	const canvas = document.getElementById('canvas');
	const ctx = canvas.getContext('2d');
	
	let totalRect = new Map(); // 층마다 사각형 값을 저장해 그려주는 배열
	let uploadedImage = new Image(); // 업로드 된 이미지 저장하는 변수
	let isUpload = false; // 이미지 업로드 되있는지 체크
	
	let rectangles = []; // 현재 캔버스에 있는 사각형을 저장하는 배열
	
	let isDrawing = false; // 그리는지 체크
	
	let startPoint, endPoint; // 사각형을 그릴 때 필요한 시작점, 끝점
	
	let sectorCount = 1; // 초기 섹터 번호
	
	let floorValue = "1"; // 층수 (기본값 1)
	
	let selectedRectangleIndex = -1; // 선택된 사각형의 인덱스
	
	let realData = []; // 실제 등록할 데이터를 저장하는 배열
	let deleteRectNames = []; // 삭제된 도형의 이름을 저장하는 배열
	let isItem = false; // 품목이 존재하는지 체크
	
	let movingRectangle = null; // 이동 중인 도형을 나타내는 변수
	let offsetX, offsetY;
	let isCreate = true;
	
	let wareWindowModal = new bootstrap.Modal($('#wareWindow')[0]);
	
	$('#imageUpload').on('change', handleImageUpload);

	$('#wareTableData').DataTable({
	        paging: true,
	        searching: true,
	        lengthChange: false,
	        info: false,
	        ordering: false
	});
	
	$('#wareWindow').on('hidden.bs.modal', function () {
	    $('body').css('overflow', ''); 
	});

	$('#wareTableData').on('click', '.selectItem', function (e) {
		e.preventDefault();
		let selectedValue = $(this).data('selected-value'); 
	    let selectedData = $(this).closest('tr').find('.hiddenWare').data('selected-data');
		let selectedWidth= $(this).closest('tr').find('#wareWidth').data('ware-width');
		let selectedY = $(this).closest('tr').find('#wareY').data('ware-y');
		
		 
	    $('#inputWareData').val(selectedValue);
	    $('#wareCdData').val(selectedData);
		$('#wareWidthSpan').text(selectedWidth);
		$('#wareYSpan').text(selectedY);
	    
	    wareWindowModal.hide();
	    $('.modal-backdrop').remove();
	    $('#canvas').show();
	    $('#saveBtn').show();
	    $('#delBtn').show();

		$('#inputWareData').trigger('input');
	});
	
	// 엔터키로 submit 되는 거 막기
	$('#sectorCreate').on('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
        }
    });
	
	// 창고 모달 보여주기
	$('#inputWareData, #wareBtn').on('click', function(){
		wareWindowModal.show();
	});
	
	// 창고명 변할 때 이벤트
	$('#inputWareData').on('input', function (){
		clearCtx();
		canvas.style.display = "block";
		$('#sectorWidthInput').val('');
		$('#sectorYInput').val('');
		$('#inputFloor').val("1");
		$('#selectSector').css('display', 'none');
		$('#itemWareSpan').css('display', 'none');
		totalRect = new Map();
		//uploadedImage = new Image();
		rectangles = [];
		isDrawing = false;
		sectorCount = 1;
		selectedRectangleIndex = -1;
		realData = [];
		movingRectangle = null;
		floorValue = "1";
		
		let selectedWareCd = $('#wareCdData').val(); 
		$.ajax({
			url: `/sector/${selectedWareCd}`,
			method: "GET",
			contentType: 'application/json',
			success: function (resp) {
				let result = resp.wareList;

				if(result.length > 0){
					isCreate = false;
					//res에 있는 has many관계를 통해 list형식으로 담겨있는값 뽑아오기
					const wareSecList = result.map(item => item.wareSecList).flat();
					
					if(wareSecList.length===0){
						let divData = `
							<div class="text-center"><h5>창고구역이 등록되지 않은 창고입니다.</h5></div>
						`;
						$('#itemList').html(divData);
					} else {
						let maxSecNum = 0;
						//for문을 돌면서 db에 저장되어있는 데이터를 배열에 저장.
						wareSecList.forEach( rslt => {
							
							let floorKey = rslt.wsecZ.toString();
							//
							if (!totalRect.has(floorKey)) {
								// 초기화
						        totalRect.set(floorKey, []);
						    }
		
						   	totalRect.get(floorKey).push({
							    //randomColor 함수를 만들어 색깔을 랜덤으로 보여줌
						        "color": getRandomColor(),
						        "coordinates": {
						            x: rslt.wsecX1,
						            y: rslt.wsecY1,
						            width: rslt.wsecX2,
						            height: rslt.wsecY2,
						            sCode: rslt.secCd,
						            wCode: rslt.wareCd
						        },
						        "floor": rslt.wsecZ,
						        "name": getSectorNameFromSecCd(rslt.secCd)
						    });
		
							let secNum = getSecnum(rslt.secCd);
							
							if(secNum > sectorCount) {
								sectorCount = secNum + 1;
								maxSecNum = secNum;
							} else {
								sectorCount++;
							}
						});
						// 존재하는 섹터들 중 가장 큰 번호까지의 섹터 중에서 deleteRectNames에 없는 것 추가
						for (let i = 1; i <= maxSecNum; i++) {
		                    let sectorName = "sector" + i;
		                    if (!deleteRectNames.includes(sectorName) && !wareSecList.find(rect => getSecnum(rect.secCd) === i)) {
		                        deleteRectNames.push(sectorName);
		                    }
		                }

						if (totalRect.has("1")) {
					        const floorRectangles = totalRect.get("1");
					        for (const rectangle of floorRectangles) {
					            drawRect(rectangle.coordinates, rectangle.color, rectangle.name);
					        }
					    }
					}
				} else {
					isCreate = true;
				}
			}
		});
	});
	
	// 마우스 다운 이벤트(마우스 눌렀을 때)
	canvas.addEventListener('mousedown', function (event) {
    // 현재 그리기 상태인지 확인
    if (isDrawing) {
        const clickPoint = getMousePosition(event);

        for (let i = rectangles.length - 1; i >= 0; i--) {
            const rect = rectangles[i];
			// 클릭한 지점과 사각형이 겹치는지 체크
            if (
                clickPoint.x >= rect.coordinates.x &&
                clickPoint.x <= rect.coordinates.x + rect.coordinates.width &&
                clickPoint.y >= rect.coordinates.y &&
                clickPoint.y <= rect.coordinates.y + rect.coordinates.height
            ) {
                // 선택된 도형을 이동 중인 도형으로 설정
                movingRectangle = rect;

                // 클릭한 지점과 도형의 좌상단 사이의 거리를 계산하여 offset 설정
                offsetX = clickPoint.x - rect.coordinates.x;
                offsetY = clickPoint.y - rect.coordinates.y;

                // 이동 중인 도형의 원래 위치 저장
                movingRectangle.originalPosition = {
                    x: rect.coordinates.x,
                    y: rect.coordinates.y
                };

                break;
            	}
        	}
    	}

	    // 그리기 상태를 활성화하고 시작점 설정
	    isDrawing = true;
	    startPoint = getMousePosition(event);
	});
	
	canvas.addEventListener('mousemove', function (event) {
	    if (movingRectangle) {
	        const newPosition = getMousePosition(event);
	
	        // 이동 중인 도형의 위치 업데이트
	        movingRectangle.coordinates.x = newPosition.x - offsetX;
	        movingRectangle.coordinates.y = newPosition.y - offsetY;
	
	        // 캔버스를 지우고 새로운 상태의 모든 도형 다시 그리기
	        clearCtx();
	        redrawAllRectangles();
	    }else {
		    if (isDrawing) {
	        // 현재 마우스 좌표 업데이트
	        endPoint = getMousePosition(event);
	    }
	}
	});
	
	canvas.addEventListener('mouseup', function () {
	    // 그리기 상태 비활성화
	    isDrawing = false;

		// 사각형 그려질 때
	    // 시작점과 끝점이 존재하고, 시작점과 끝점이 같지 않을 때
	    if (startPoint && endPoint && (startPoint.x !== endPoint.x || startPoint.y !== endPoint.y)) {
	        const rectCoordinates = {
	            x: Math.min(startPoint.x, endPoint.x),
	            y: Math.min(startPoint.y, endPoint.y),
	            width: Math.abs(endPoint.x - startPoint.x),
	            height: Math.abs(endPoint.y - startPoint.y)
	        };
			
	        // 겹치지 않는 위치에 새로운 사각형 생성
	        if (!isOverlapping(rectCoordinates)) {
	            let sectorName = '';
				// 삭제해서 배열에 이름이 있다면
	            if (deleteRectNames.length > 0) {
	                sectorName = deleteRectNames[0];
					// 사각형이 그려졌을 때만 배열값 삭제
					if (rectCoordinates.width >= 30 && rectCoordinates.height >= 30) {
	                	deleteRectNames.shift(); // 배열의 처음 값 삭제
					}
	            } else {
	                sectorName = `sector${sectorCount}`;
					// 사각형이 그려졌을 때만 섹터 번호 증가
				    if (rectCoordinates.width >= 30 && rectCoordinates.height >= 30) {
				        sectorCount++; // 섹터 번호 증가
				    }
	            }
	            // 새로운 사각형 그리기
	            drawRect(rectCoordinates, getRandomColor(), sectorName);
	        }
	    }
	
	    // 시작점과 끝점 초기화
	    startPoint = 0;
	    endPoint = 0;
	
		// 사각형 이동할 때
	    if (movingRectangle) {
	        // 이동 중인 도형 초기화
	        const originalPosition = movingRectangle.originalPosition;
	
	        // 이동 중인 도형의 현재 위치
	        const currentPosition = movingRectangle.coordinates;
	
	        // 이동 중인 도형이 원래의 위치에서 벗어났는지 확인
	        if (
	            originalPosition.x !== currentPosition.x ||
	            originalPosition.y !== currentPosition.y
	        ) {
	            // 이동 중인 도형이 다른 도형과 겹치지 않으면 위치 업데이트
	            if (!isOverlapping(currentPosition)) {
	                // 캔버스를 지우고 새로운 상태의 모든 도형 다시 그리기
	                clearCtx();
	                redrawAllRectangles();
	            } else {
	                // 겹친 경우, 원래의 위치로 되돌아가기
	                movingRectangle.coordinates.x = originalPosition.x;
	                movingRectangle.coordinates.y = originalPosition.y;
	
	                // 캔버스를 지우고 새로운 상태의 모든 도형 다시 그리기
	                clearCtx();
	                redrawAllRectangles();
	            }
	        }
	        
	        // 이동 중인 도형 초기화
	        movingRectangle = null;
	    }
	});
	
	canvas.addEventListener('click', function (event) {
	    // 마우스 클릭한 지점 좌표
	    const clickPoint = getMousePosition(event);
	    // 사각형 배열을 뒤에서부터 순회하며 클릭한 사각형 찾기
	    for (let i = rectangles.length - 1; i >= 0; i--) {
	        const rect = rectangles[i];
	
	        // 클릭한 지점이 사각형 안에 있는지 확인
	        if (
	            clickPoint.x >= rect.coordinates.x &&
	            clickPoint.x <= rect.coordinates.x + rect.coordinates.width &&
	            clickPoint.y >= rect.coordinates.y &&
	            clickPoint.y <= rect.coordinates.y + rect.coordinates.height
	        ) {
				let wareCdData = $('#wareCdData').val();
			    // 선택된 사각형의 인덱스 저장
				selectedRectangleIndex = i;
				console.log(rectangles[selectedRectangleIndex]);
				
				$('#errorSpan').css('display', 'none');
				
	            // 선택된 사각형의 정보를 가공하여 배열에 저장
	            let totalValue = rect.coordinates;
	            totalValue.secCd = numbers(rect.name);

	            if (rect && wareCdData) {
				    selectItemWare(wareCdData, totalValue.secCd)
				        .then((result) => {
				            isItem = result;
				        })
				}

	            // 중복 체크
				let isDuplicate = realData.some(item => (
				    item.wsecX1 === totalValue.x &&
				    item.wsecY1 === totalValue.y &&
				    item.wsecX2 === totalValue.width &&
				    item.wsecY2 === totalValue.height &&
				    item.secCd === totalValue.secCd &&
				    item.wsecZ === floorValue &&
				    item.wareCd === wareCdData
				));
				
				if (isDuplicate) {
				    // 중복된 경우, 해당 데이터를 배열에서 삭제하고 마지막에 추가
				    const index = realData.findIndex(item => (
				        item.wsecX1 === totalValue.x &&
				        item.wsecY1 === totalValue.y &&
				        item.wsecX2 === totalValue.width &&
				        item.wsecY2 === totalValue.height &&
				        item.secCd === totalValue.secCd &&
				        item.wsecZ === floorValue &&
				        item.wareCd === wareCdData
				    ));
				
				    if (index > -1) {
				        const removedItem = realData.splice(index, 1)[0]; // 중복된 항목을 삭제하고 해당 아이템을 가져옴
				        realData.push(removedItem); // 삭제된 아이템을 배열의 끝에 추가
				    }
				} else {
				    // 중복되지 않은 경우에만 배열에 추가
				    let updatedTuple = {
				        wsecX1: totalValue.x,
				        wsecY1: totalValue.y,
				        wsecX2: totalValue.width,
				        wsecY2: totalValue.height,
				        secCd: totalValue.secCd,
				        wsecZ: floorValue,
				        wareCd: wareCdData
				    };
				    realData.push(updatedTuple);
				}

				$('#sectorWidthInput').removeAttr('readonly');
				$('#sectorYInput').removeAttr('readonly');
				
				updateSectorSize(rectangles[selectedRectangleIndex]);
				$('#selectSector').text("선택한 섹터 : " + rectangles[selectedRectangleIndex].name);
				$('#selectSector').css('display', 'block');
				isDrawing = true;
	            break;
	        } else { // 클릭한 지점이 사각형 안에 없을 때
	            selectedRectangleIndex = -1;
				isItem = false;
				$('#sectorWidthInput').val('');
				$('#sectorYInput').val('');
				$('#selectSector').css('display', 'none');
				$('#itemWareSpan').css('display', 'none');
	        }
	    }
	});
	
	// floor가 바뀔 때 이벤트
	inputFloor.addEventListener('input', function (event) {
		// 화면에 그려진 사각형이 하나라도 있을 경우에 totalRect에 저장해놓고 초기화 시킴
	    if (rectangles.length > 0) {
	        let existingRectangles = totalRect.get(floorValue) || [];
	        
	        if (!arraysEqual(existingRectangles, rectangles)) {
	            totalRect.set(floorValue, rectangles.slice());
	        }
	    }

	    // 배열 초기화
	    rectangles.length = 0;
	
	    // 캔버스 초기화
	    clearCtx();
	
	    // 입력된 값에 해당하는 데이터 불러오기
	    let value = event.target.value;
	    floorValue = value;

		// totalRect에 저장 되있는 사각형을 키값(floorValue)를 이용해서 가져옴
	    if (totalRect.has(floorValue)) {
	        const floorRectangles = totalRect.get(floorValue);
	        for (const rectangle of floorRectangles) {
	            drawRect(rectangle.coordinates, rectangle.color, rectangle.name);
	        }
	    }
		// readonly 속성을 추가하는 코드
		$('#sectorWidthInput').attr('readonly', true);
		$('#sectorYInput').attr('readonly', true);
		
		// 초기화
		$('#sectorWidthInput').val('');
		$('#sectorYInput').val('');
		$('#selectSector').css('display', 'none');
		$('#itemWareSpan').css('display', 'none');
	});
	
	// sectorWidthInput 값이 입력될 때 이벤트 처리
	$('#sectorWidthInput').on('input', function() {
    	// 변경된 값에 대한 처리를 여기에 추가
    	let newValue = parseInt($(this).val());

		if (selectedRectangleIndex !== -1) {
	        // 값 변경
	        rectangles[selectedRectangleIndex].coordinates.width = getCanvasWidth(newValue);
	
	        // 다시 그리기
	        clearCtx();
	        redrawAllRectangles();
	    }
	});
	
	// sectorYInput 값이 입력될 때 이벤트 처리
	$('#sectorYInput').on('input', function() {
	    // 변경된 값에 대한 처리를 여기에 추가
	    let newValue = parseInt($(this).val());

		if (selectedRectangleIndex !== -1) {
			// 값 변경
	        rectangles[selectedRectangleIndex].coordinates.height = getCanvasHeight(newValue);
	
	        // 다시 그리기
	       	clearCtx();
	        redrawAllRectangles();
		}
	});
	
	// 삭제 버튼 클릭 이벤트
	$('#delBtn').click(function () {
		deleteSelectedRectangle();
	});
	
	// 섹터 생성 폼 제출 이벤트
	$('#sectorCreate').submit(function (event) {
	    event.preventDefault();
	
	    // 배열 복사
	    let matchingSectors = [];
	    realData.forEach(sector => {
	        matchingSectors.push(sector);
	    })
		
		console.log(matchingSectors);
	    // 배열을 JSON 문자열로 변환
	    let jsonData = JSON.stringify(matchingSectors);
	    console.log("값이 이렇게 넘어가", jsonData);
	
	    // 섹터 생성 함수 호출
	    secCreate(jsonData);
	});

	// 마우스 좌표 반환 함수
	function getMousePosition(event) {
	    const rect = canvas.getBoundingClientRect();
	    return {
	        x: event.clientX - rect.left,
	        y: event.clientY - rect.top
	    };
	}
	
	// 영역 중복 체크
	function isOverlapping(newRect) {
	    for (let i = 0; i < rectangles.length; i++) {
	        // 이동 중인 도형은 겹침 여부를 체크하지 않도록 제외
	        if (rectangles[i] === movingRectangle) {
	            continue;
	        }
	
	        const existingRect = rectangles[i].coordinates;
	
	        if (
	            newRect.x < existingRect.x + existingRect.width &&
	            newRect.x + newRect.width > existingRect.x &&
	            newRect.y < existingRect.y + existingRect.height &&
	            newRect.y + newRect.height > existingRect.y
	        ) {
	            // 중복됨
	            return true;
	        }
	    }
	    // 중복되지 않음
	    return false;
	}
	
	function arraysEqual(arr1, arr2) {
	    if (arr1.length !== arr2.length) return false;
	    for (let i = 0; i < arr1.length; i++) {
	        if (arr1[i] !== arr2[i]) return false;
	    }
	    return true;
	}
	
	// 임의의 색상을 반환하는 함수
	function getRandomColor() {
	    const letters = '0123456789ABCDEF';
	    let color = '#';
	    for (let i = 0; i < 6; i++) {
	        color += letters[Math.floor(Math.random() * 16)];
	    }
	    return color;
	}
	
	// 사각형 그리기 함수 가로세로길이 30이상만 그려줄것
	function drawRect(coordinates, color, name) {
		if (coordinates.width < 30 || coordinates.height < 30) {
			$('#errorSpan').css('display', 'block');
        	return;
    	}
		let wareCdValue=$('#wareCdData').val();
		$('#errorSpan').css('display', 'none');
	    ctx.fillStyle = color;
	    ctx.fillRect(coordinates.x, coordinates.y, coordinates.width, coordinates.height);

		// 사각형 위에 이름 표시
	    ctx.fillStyle = 'white'; // 텍스트 색상
	    ctx.font = 'bold 30px Arial'; // 텍스트 폰트 및 크기
	    ctx.fillText(name, coordinates.x + 10, coordinates.y + 30); // 이름 표시 위치 조정
		
	    // 그린 사각형 정보를 rectangles 배열에 추가
	    rectangles.push({
	        name: name,
	        coordinates: {
				...coordinates,
				wCode : wareCdValue
			},
	        floor: floorValue,
	        color: color
	    });
	}


	// 정규식을 통해 영역별 secCd 생성
	function numbers(str) {
	    const match = str.match(/sector(\d+)/);
	    if (match) {
	        const num = parseInt(match[1]);
	        const formattedNum = num.toString().padStart(3, '0');
	        return `S${formattedNum}`;
	    }
	    return null;
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
	
	// 정규식으로 숫자만 가져옴
	function getSecnum(secCd){
		const match = secCd.match(/S(\d+)/);
	    if (match) {
	        const num = parseInt(match[1]);
	        return num;
	    }
	}
	
	// 사각형 삭제 함수 정의
	function deleteSelectedRectangle() {
	    if (selectedRectangleIndex !== -1 && isItem == false) {
			if (!isCreate){
				let wareCd = rectangles[selectedRectangleIndex].coordinates.wCode;
				let secCd = rectangles[selectedRectangleIndex].coordinates.secCd;
				
				$.ajax({
			        url: '/sector/remove',
			        method: 'DELETE',
			        contentType: 'application/json',
			        data: JSON.stringify({
		                'wareCd': wareCd,
		                'secCd': secCd
		            }),
			        success: function (resp) {
			            let result = resp.totalValue;
			            if (result) {
			                if (result.rslt == "success") {
						 		// 선택된 사각형의 인덱스가 유효한 경우에만 삭제
						        deleteRectInCanvas();
			                } else if (result.rslt == "fail") {
			                    $.each(resp.errors, function (fieldName, errorMessage) {
			                        let errorId = fieldName;
			                        $('#' + errorId).text(errorMessage);
			                    });
			                }else if (result.rslt == "NotExist") {
								 // DB에 없는 sector와 wareCd일때 삭제
			                     deleteRectInCanvas();
			                }
			            }
			        },
			        error: function (request, status, error) {
			            console.log("code: " + request.status)
			            console.log("message: " + request.responseText)
			            console.log("error: " + error);
			        }
			    });
	       } else {
				deleteRectInCanvas();
			}
	    } else {
			Swal.fire({
				  title: '삭제실패!',
				  text: '품목이 존재하는 섹터는 삭제할 수 없습니다.',
				  icon: 'error',
				  confirmButtonText: '확인'
			});
		}
	}
	
	// 캔버스에 있는 사각형 삭제 함수
	function deleteRectInCanvas(){
		let deleteRect = rectangles.splice(selectedRectangleIndex, 1)[0];	
		
		deleteRectNames.push(deleteRect.name);
		deleteRectNames.sort(compareSectors);
		
		if(totalRect.length >0){
			let floorRectangles = totalRect.get(floorValue);
			// totalRect에서 지워주는 코드임
			// 배열을 돌면서 name이 deleteRect.name과 같으면 제거
			floorRectangles = floorRectangles.filter(rect => rect.name !== deleteRect.name);
			// 수정된 배열을 다시 totalRect에 할당
			totalRect.set(floorValue, floorRectangles);
		}
		realData.pop(); // 마지막 값 제거
        // 캔버스를 지우고 새로운 상태의 모든 사각형 다시 그리기
        clearCtx();
        redrawAllRectangles();
		
		selectedRectangleIndex = -1;
		$('#selectSector').css('display', 'none');
		$('#itemWareSpan').css('display', 'none');
	}
	
	// 모든 사각형 다시 그리기 함수
	function redrawAllRectangles() {
		const newRectangles = [];
	    rectangles.forEach(rect => {
	        if (rect.coordinates !== undefined) {
	            drawRect(rect.coordinates, rect.color, rect.name);
	            newRectangles.push(rect);
	        }
	    });
	    rectangles = newRectangles;
	}
	
	// 정렬 함수 정의
	function compareSectors(a, b) {
	    const numA = parseInt(a.match(/\d+/)[0]);
	    const numB = parseInt(b.match(/\d+/)[0]);
	
	    return numA - numB;
	}
	
	// 섹터 생성 함수
	function secCreate(data) {
	    $.ajax({
	        url: '/sector',
	        method: 'POST',
	        contentType: 'application/json',
	        data: data,
	        success: function (resp) {
	            let result = resp.totalValue;
	            if (result) {
	                if (result.rslt == "success") {
	                    Swal.fire({
							  title: '저장완료!',
							  text: '창고구역이 성공적으로 등록되었습니다.',
							  icon: 'success',
							  confirmButtonText: '확인'
						});
						clearAllElement();
	                } else if (result.rslt == "fail") {
	                    $.each(res.errors, function (fieldName, errorMessage) {
	                        let errorId = fieldName;
	                        $('#' + errorId).text(errorMessage);
	                    });
	                }
	            }
	        },
	        error: function (request, status, error) {
	            console.log("code: " + request.status)
	            console.log("message: " + request.responseText)
	            console.log("error: " + error);
	        }
	    });
	}
	
	// 섹터크기 표시하는 함수
	function updateSectorSize(selectedRectangle) {
	    // 창고 크기 가져오기
	    let wareWidth = parseInt($('#wareWidth').data('ware-width'));
		let wareY = parseInt($('#wareY').data('ware-y'));
		
		// 캔버스의 너비와 높이
	    let canvasWidth = 1160;
    	let canvasHeight = 580;
		
		// 선택한 섹터의 너비와 높이
    	let sectorWidth = selectedRectangle.coordinates.width;
    	let sectorHeight = selectedRectangle.coordinates.height;

		// 캔버스 비율을 고려한 실제 섹터의 너비와 높이 계산
	    let actualSectorWidth = (sectorWidth / canvasWidth) * wareWidth;
	    let actualSectorHeight = (sectorHeight / canvasHeight) * wareY;
		
		// 반올림하여 섹터 크기 표시
	    $('#sectorWidthInput').val(Math.round(actualSectorWidth));
	    $('#sectorYInput').val(Math.round(actualSectorHeight));
	}
	
	// 창고크기에 비례하는 sector 너비 구하기
	function getCanvasWidth(actualSectorWidth) {
		// 창고 크기 가져오기
	    let wareWidth = parseInt($('#wareWidth').data('ware-width'));

		// 캔버스의 너비
	    let canvasWidth = 1160;
		
		let sectorWidth = (actualSectorWidth / wareWidth) * canvasWidth 

	    return Math.round(sectorWidth);
	}
	
	// 창고크기에 비례하는 sector 높이 구하기
	function getCanvasHeight(actualSectorHeight) {
		// 창고 크기 가져오기
	    let wareY = parseInt($('#wareY').data('ware-y'));

		// 캔버스 높이
		let canvasHeight = 580;
	
	    // 반올림하여 캔버스에 그려지는 섹터의 너비 계산
	    let sectorHeight = (actualSectorHeight / wareY)* canvasHeight;

	    return Math.round(sectorHeight);
	}
	
	// 모든 항목 초기화
	function clearAllElement(){
		uploadedImage = new Image();
		isUpload = false;
		clearCtx();
		canvas.style.display = "none";
		$('#sectorWidthInput').val('');
		$('#sectorYInput').val('');
		$('#inputFloor').val("1");
		totalRect = new Map();
		rectangles = [];
		isDrawing = false;
		sectorCount = 1;
		selectedRectangleIndex = -1;
		realData = [];
		deleteRectNames = [];
		movingRectangle = null;
		floorValue = "1";
		$('#selectSector').css('display', 'none');
		$('#itemWareSpan').css('display', 'none');
		
		// 모든 input 요소 초기화
		var inputElements = document.querySelectorAll('input');
    	inputElements.forEach(function (element) {
            element.value = '';
        });

		// 모든 span 요소 초기화
		
		$('#wareWidthSpan').text('');
		$('#wareYSpan').text('');
	}
	
	// 섹터에 품목이 존재하는지 확인
	function selectItemWare(wareCd, secCd) {
	    return new Promise((resolve, reject) => {
	        $.ajax({
	            url: '/sector/itemList',
	            method: 'POST',
	            contentType: 'application/json',
	            dataType: 'json',
	            data: JSON.stringify({
	                'wareCd': wareCd,
	                'secCd': secCd
	            }),
	            success: function (resp) {
	                let secList = resp.secList;
	                let isItem = secList.length > 0;
	
	                if (isItem) {
	                    $('#itemWareSpan').text("등록한 품목이 존재합니다");
	                } else {
	                    $('#itemWareSpan').text("등록한 품목이 존재하지 않습니다.");
	                }
	
	                $('#itemWareSpan').css('display', 'block');
	                resolve(isItem); // Promise를 이용해 결과 값 반환
	            },
	            error: function (request, status, error) {
	                console.log("code: " + request.status)
	                console.log("message: " + request.responseText)
	                console.log("error: " + error);
	
	                // 오류 시에도 reject를 호출하여 알림
	                reject(error);
	            }
	        });
	    });
	}
	
	// 이미지 업로드 했을 시 이벤트 함수
	function handleImageUpload(event) {
        let file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
			isUpload = true;
            reader.onload = function (e) {
                uploadedImage = new Image();
                uploadedImage.src = e.target.result;
				uploadedImage.onload = function () {
			        if ($('#inputWareData').val()) {
			            reDrawCanvasBackgroud();
			        }
			    };
            };

            reader.readAsDataURL(file);
        }else{
			isUpload = false;
			if ($('#inputWareData').val()) {
				reDrawCanvasBackgroud();
			}
		}		
    }

	// 창고를 조회해 sector를 모두 다시 그리는 함수
	function reDrawCanvasBackgroud(){
		if (rectangles.length > 0) {
	        let existingRectangles = totalRect.get(floorValue) || [];
	        
	        if (!arraysEqual(existingRectangles, rectangles)) {
	            totalRect.set(floorValue, rectangles.slice());
	        }
	    }
		// 배열 초기화
	    rectangles.length = 0;
	
	    // 캔버스 초기화
	    clearCtx();
		
		if (totalRect.has(floorValue)) {
	        const floorRectangles = totalRect.get(floorValue);
	        for (const rectangle of floorRectangles) {
	            drawRect(rectangle.coordinates, rectangle.color, rectangle.name);
	        }
	    }
	}
	
	// 캔버스 초기화 함수
	function clearCtx(){
		if(isUpload){ // 이미지 업로드 되있을 경우엔 배경에 이미지 그림
			ctx.clearRect(0, 0, canvas.width, canvas.height);
			ctx.drawImage(uploadedImage, 0, 0, canvas.width, canvas.height);
		}else{
			ctx.clearRect(0, 0, canvas.width, canvas.height);
		}
	}
});