/**
 * <pre>
 * 
 * </pre>
 * @author 작성자명
 * @since 2023. 11. 30.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 30.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */

function fn_paging(page) {
	searchForm.page.value = page;
	searchForm.requestSubmit();
	searchForm.page.value = "";
}

$(function() {

	let cPath = $('.pageConversion').data('contextPath');
	
	const addCommas = function(num) {
       	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  	};

	//검색 및 페이징 처리
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let datas = $(this).serialize();
		console.log("data@@@@@@@@", datas);
		
		$.ajax({
			url : `${cPath}/invenAdjust/itemList`,
			method : "get",
			data : datas,
			success : function(resp){
				console.log("resp : ",resp);
				let itemInvenList = resp.paging.dataList;
				let trTags = "";
				
				if (itemInvenList.length > 0) {
					$.each(itemInvenList, function(idx, itemInven) {
						trTags += makeTrTag(itemInven);
					});
					$(pagingArea).html(resp.paging.pagingHTML);
				}else {
					trTags += `
					 <tr>
                         <td class="text-nowrap" colspan='8'>등록된 데이터가 없습니다.</td>
                    </tr>
				`;
					$(pagingArea).empty();
				}
				$(".listBody").html(trTags);
			},
			error: function(xhr, status, error){
				console.log(xhr);
					console.log(status);
					console.log(error);
			}
		});
	}).submit();

	//아이템 목록 찍기위한 tag 생성
	let makeTrTag = function(rslt) {
		let itemViewURL = `${cPath}/item/itemView?what=${rslt.itemCd}`;
		let ynState = "";
		let qtyStyle = "";
		let trStyle = "";
		
		if(rslt.itemVO.itemYn=='Y'){
			ynState += `<td class="itemYn text" style="width:8%; color:red; font-weight:bold;">${rslt.itemVO.itemYn}	</td>   `;
		}else{
			ynState += `<td class="itemYn text" style="width:8%;">${rslt.itemVO.itemYn}</td>   `;
		}
		
		if(rslt.itemVO.itemSafeQty>=rslt.itemVO.itemQty){
			qtyStyle+="color:blue; font-weight:bold;";
			trStyle=` style="background-color: rgba(255, 0, 0, 0.2) !important;"`;
		}
		
		let trTag =
			`
				<tr ${trStyle}>
					<td class="itemCd text"	style="width:10%;"		><a href="${itemViewURL}">${rslt.itemCd}</a></td>          
					<td class="itemNm text"	style="width:16%;"		>${rslt.itemNm}</td>          
					<td class="itemCate text" style="width:10%;"		>${rslt.itemVO.itemCate}</td>          
					<td class="wareNm text"	style="width:10%;"		>${rslt.wareNm}</td>          
					<td class="secCd2 text"	style="width:10%;"		>${rslt.secCd2}</td>          
					<td class="itemSafeQty number" style="width:10%;"	>${addCommas(rslt.itemVO.itemSafeQty)}</td>        
					<td class="itemQty number" style="width:8%; ${qtyStyle};">${addCommas(rslt.itemVO.itemQty)}</td>   
					${ynState}
				</tr>
			`;

		return trTag;
	}
	
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			$(searchForm).find(':input[name=' + name + ']').val(value);
		});
		$(searchForm).submit();
	});
	
	$(document).on('click', '.itemCd a', function(e){
		e.preventDefault();
		var tr = $(this).closest('tr');
		var td = tr.children();
		
		let itemWareVO = {};
		
		let itemCd = $(this).text();
		let secCd2 = tr.find(`.secCd2`).text();
		
		itemWareVO.itemCd = itemCd;
		itemWareVO.secCd2 = secCd2;
		
		let itemInvenUrl = `${cPath}/invenAdjust/itemInvenView`;
		let json = JSON.stringify(itemWareVO);
		
		
		console.log("json",json);
		console.log("ffff",itemWareVO);
		
		$.ajax({
			url : itemInvenUrl,
			method : "post",
			contentType: "application/json; charset=utf-8",
			data : json,
			dataType: "json",
			success : function(resp){
				let itemInven = resp.itemDetail;
				console.log("itemInven : ",itemInven);
				
				if (itemInven!=null) {
						$("#itemCdInput").val(itemInven.itemCd);
						$("#itemNmInput").val(itemInven.itemNm);
						$("#itemUnitInput").val(itemInven.itemVO.itemUnit);
						$("#groupInput").val(itemInven.itemVO.itemCate);
						$("#itemSafeQtyInput").val(itemInven.itemVO.itemSafeQty);
						$("#itMakerInput").val(itemInven.itemVO.itMaker);
						$("#itWghtInput").val(itemInven.itemVO.itWght);
						$("#itColorInput").val(itemInven.itemVO.itColor);
						$("#itemInprInput").val(itemInven.itemVO.itemInpr);
						$("#itemOutprInput").val(itemInven.itemVO.itemOutpr);
						$("#itemNoteInput").val(itemInven.itemVO.itemNote);
						$("#itemWareInput").val(itemInven.wareNm);
						$("#itemSectInput").val(itemInven.secCd2);
				}
				
					//모달열기
					$('#createWindow').modal('show');
			}
		})
		
		
		
	})
})