/**
 * <pre>
 * 
 * </pre>
 * @author 작성자명
 * @since 2023. 11. 27.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 27.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */

$(function() {

	$(document).ready(function() {
	})

	let cPath = $('.pageConversion').data('contextPath');

	const addCommas = function(num) {
       	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  	};

	//검색 및 페이징 처리
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let url = this.action;
		let data = $(this).serialize();
		console.log("data@@@@@@@@", data);
		$.getJSON(url + '?' + data)
			.done(function(resp) {
				console.log(resp.paging);
				let invenAdjustList = resp.paging.dataList;
				let trTags = null;
				if (invenAdjustList.length > 0) {
					$.each(invenAdjustList, function(idx, invenAdjust) {
						trTags += makeTrTag(invenAdjust);
					});
				} else {
					trTags += `
					 <tr>
                         <td class="text-nowrap" colspan='7'>등록된 데이터가 없습니다.</td>
                    </tr>
				`;
				}
				$(".listBody").html(trTags);

			});
	}).submit();

	//가져온 데이터로 tr태그 생성하는 함수
	let makeTrTag = function(rslt) {
		let trTag = null;
		let errorQtyTd = null;
		console.log("@rslt", rslt);
		console.log("@rslt.actIvenItem", rslt.actIvenItem);
		if (rslt.actIvenItem && rslt.actIvenItem.length > 0) {
			$.each(rslt.actIvenItem, function(index, item) {
				console.log("@rslt.errorQty", rslt.errorQty);

				if (rslt.errorQty < 0) {
					errorQtyTd += ` 
						<td class="number" style="background-color: lightpink !important; font-weight: bold;">${addCommas(rslt.errorQty)}
							<input type="hidden" class="iText errorQty number" value="${addCommas(rslt.errorQty)}" name="errorQty"/>
							<input type="hidden" class="itemNum" name="itemNum" value="${item.itemNum}" disabled="disabled"/>
						</td>`;
				} else if (rslt.errorQty > 0) {
					errorQtyTd += ` 
						<td class="number" style="background-color: lightskyblue !important; font-weight: bold;">${addCommas(rslt.errorQty)}
							<input type="hidden" class="iText errorQty number" value="${rslt.errorQty}" name="errorQty"/>
							<input type="hidden" class="itemNum" name="itemNum" value="${item.itemNum}" disabled="disabled"/>
						</td>`;
				} else {
					errorQtyTd += ` 
						<td class="number" style="font-weight: bold;">${addCommas(rslt.errorQty)}
							<input type="hidden" class="iText errorQty number" value="${rslt.errorQty}" name="errorQty"/>
							<input type="hidden" class="itemNum" name="itemNum" value="${item.itemNum}" disabled="disabled"/>
						</td>`;
				}

				trTag += `
			        <tr>
						<td class="text checkBox" style="width:5%;"><input type="checkbox" name="select" value="${rslt.realCd}" class="check"></td>
			            <td class="text realCd" style="width:15%;">${rslt.realCd}<input type="hidden" name="rinvDate" value="${rslt.rinvDate}"/> </td>
			            <td class="text itemCd" style="width:10%;">${rslt.item.itemCd}</td>
			            <td class="text itemNm" style="width:16%;">${rslt.item.itemNm}</td>
			            <td class="text wareNm" style="width:10%;">${rslt.storage.wareNm}<input type="hidden" name="wareCd" value="${rslt.storage.wareCd}"/> </td>
			            <td class="text secCd" style="width:10%;">${rslt.secCd}</td>
			            <td class="text empNm" style="width:10%;">${rslt.emp.empNm}</td>
						<td class="number wareQty" style="width:8%;">${addCommas(item.itemWare.wareQty)}</td>
	          			<td class="number rinvQty" style="width:8%;">${addCommas(item.rinvQty)}</td>
			           	${errorQtyTd}
						<input type="hidden" name = "rinvQty" value=${item.rinvQty}/>
			        </tr>
			    `;
			})
		}
		return trTag;
	};

	//체크박스 전체 선택
	$(".checkAll").on('click', function() {
		const checkboxes = document.querySelectorAll('input[type="checkbox"]');

		checkboxes.forEach((checkbox) => {
			checkbox.checked = this.checked;
		});
	});

	$("#updateBtn").click(function() {

		var ActInvenVO = {};
		var itemArray = [];
		var checkbox = $("input[name=select]:checked");

		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {

			// checkbox.parent() : checkbox의 부모는 <td>이다.
			// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();

			// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
			var realCd = td.eq(1).text();
			var rinvDate = td.eq(1).find(`input[name=rinvDate]`).val();
			var itemCd = td.eq(2).text();
			var itemNm = td.eq(3).text();
			var wareNm = td.eq(4).text();
			var wareCd = td.eq(4).find(`input[name=wareCd]`).val();
			var secCd = td.eq(5).text();
			var empNm = td.eq(6).text(); 
			var wareQty = td.eq(7).text();
			var rinvQty = td.eq(8).find(`input[name=rinvQty]`).val();
			var errorQty = td.eq(9).find(`input[name=errorQty]`).val();
			var itemNum = td.eq(9).find(`input[name=itemNum]`).val();
			/*				var errorQty = td.eq(9).text();*/

			//반복돌릴거 actIvenItem


			if (realCd != null && realCd != "") {
				let actInvenItem = {
					realCd: realCd,
					itemCd: itemCd,
					itemNum: itemNum,
					wareQty: wareQty,
					rinvQty: rinvQty,
				};
				itemArray.push(actInvenItem);
			}

			if (itemArray.length > 0) {
				ActInvenVO.realCd = realCd;
				ActInvenVO.itemCd = itemCd;
				ActInvenVO.itemNm = itemNm;
				ActInvenVO.wareCd = wareCd;
				ActInvenVO.wareNm = wareNm;
				ActInvenVO.secCd = secCd;
				ActInvenVO.empNm = empNm;
				ActInvenVO.errorQty = errorQty;
				ActInvenVO.rinvDate = rinvDate;
				ActInvenVO.actInvenItem = itemArray;

				$('span.error').text('');

				let url = `${cPath}/invenAdjust/insertInven`;
				let json = JSON.stringify(ActInvenVO);

				console.log("json: ", json);
				console.log("ActInvenVO: ", ActInvenVO);

				Swal.fire({
					title: "조정하시겠습니까?",
					icon: "warning",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "Yes"
				}).then((rslt) => {
					$.ajax({
						url: url,
						type: "POST",
						data: json,
						headers: {
							"Content-Type": "application/json;charset=UTF-8"
						},
						success: function(res) {
							console.log("res", res);
							let result = res.errors;
							if (result) {
								if (result.rslt == "success" && rslt.isConfirmed) {
									console.log("성공~");
									Swal.fire({
										title: '조정완료!',
										text: '조정이 성공적으로 완료되었습니다.',
										icon: 'success',
										confirmButtonText: '확인'
									});
									window.location.reload();
								} else if (result.rslt == "fail") {
									Swal.fire({
										title: "조정실패!",
										text: "조정이 실패했습니다.",
										icon: 'error',
								  		confirmButtonText: '확인'
									});
									$.each(res.errors, function(fieldName, errorMessage) {
										let errorId = fieldName;
										$('#' + errorId).text(errorMessage);
									});
								}
							}
						},
						error: function(error) {
							console.error('Ajax 요청 실패:', error);
						}
					});
				});
			}
		});
	});


	/*//체크박스 선택 된 행값 가져오기
	$('#updateBtn').on('click', function() {
		let state = 0;
		$('input:checkbox[name=select]').each(function(index) {
			if ($(this).is(":checked") == true) {
				state++;
				$('tbody tr').each(function() {
					let $row = $(this);
				})
				console.log($(this).val());
			}
		})
		if (state == 0) {
			console.log("항목없음");
		}
	})

*/

	//검색
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			$(searchForm).find(':input[name=' + name + ']').val(value);
		});
		$(searchForm).submit();
	});


})
