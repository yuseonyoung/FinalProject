/**
 * <pre>
 * 
 * </pre>
 * @author 이수정
 * @since 2023. 11. 19.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 19.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */


let searchMap = new Map([
	["searchType", ""],
	["searchWord", ""],
	["page", 1]
]);


let cPath = $('.pageConversion').data('contextPath');

let makePaging = function(rslt) {
	let paging =
		`
			<nav>
			  <ul class="pagination justify-content-center">
				   		${rslt.pagingHTML}
			  </ul>
			</nav>
		`
	return paging;
}


/*안읽은 메일 div*/
let makeUnreadMailDiv = function(rslt) {
	console.log("ddddddddddddddddddddd" + rslt.recNm);

	let unreadMailList =
		`
			<div class="check">
			<div class="checkRemove" value="${rslt.mailNo}">
         	<div style = "max-height: 100px;" class="row border-bottom border-200 hover-actions-trigger hover-shadow py-2 px-1 mx-0 bg-light" data-href="${cPath}/mail/view/${rslt.mailNo}">
                <div class="col-auto d-none d-sm-block">
                  <div class="d-flex bg-light">
                    <div class="form-check mb-0 fs-0" value="${rslt.mailNo}">
                      <input class="form-check-input" value="${rslt.mailNo}" type="checkbox" id="checkbox-6" data-bulk-select-row="data-bulk-select-row" />
                    </div>
                  </div>
                </div>
                <div class="col col-md-9 col-xxl-10">
                  <div class="row">
                    <div class="col-md-4 col-xl-3 col-xxl-2 ps-md-0 mb-1 mb-md-0">
                      <div class="d-flex position-relative">
                        <div class="avatar avatar-s">
                          <img class="rounded-soft" src="${rslt.empImg}" alt="" />
                        </div>
                        <div class="flex-1 ms-2"><a class="stretched-link inbox-link" href="${cPath}/mail/${rslt.mailNo}">${rslt.senNm}</a>
                        </div>
                      </div>
                    </div>
                    <div class="col"><a class="d-block inbox-link" href="${cPath}/mail/${rslt.mailNo}"><span style="height: 40px; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">${rslt.mailTitle}</span></a>
                    </div>
                  </div>
                </div>
                <div class="col-auto ms-auto d-flex flex-column justify-content-between"><span>${rslt.mailDate}</span><span class="fas text-warning fa-star ms-auto mb-2 d-sm-none" data-fa-transform="down-7"></span></div>
              </div>
			</div>
			</div>
	    `;
	return unreadMailList;
};




/*안읽은 메일 조회 함수*/
function retrieveUMailList() {
	let baseUrl = `${cPath}/mail/ulist2`;
	$.ajax({
		url: baseUrl,
		method: "GET",
		contentType: 'application/json',
		dataType: "json",
		success: function(resp) {
			var dataList = resp.paging.dataList;
			let unMailLists = 
			`
			<div class="card-header">
				<div class="col d-flex align-items-center">
					<div class="d-flex col-auto d-none d-sm-block">
                    	<div class="form-check mb-0 fs-0" value="31">
                    		 <input  onclick='selectAll(this)' class="form-check-input" type="checkbox" id="checkbox-6" />
                   			 </div>
               			 </div>
					<h5 class="fs-0 px-3 pt-3 pb-2 mb-0 border-bottom border-200">안읽은 메일</h5>
				</div>
			</div>
			`;
			let pageLists = "";
			let cnt = 0;
			var pagingList = resp.paging;
			pageLists += makePaging(pagingList);
			console.log("아래를 봐2")
			console.log(resp)
			if (dataList?.length > 0) {
					for (let i = 0; i < dataList.length; i++) {
						if (dataList[i].mailDel == 'N'&&dataList[i].mailRead == 'N') {
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
			$('.delBtn').html(
				`<button id="chkDel" class="btn btn-light hover-bg-200" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete"><svg class="svg-inline--fa fa-trash-alt fa-w-14" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="trash-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V128H32zm272-256a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zM432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16z"></path></svg><!-- <span class="fas fa-trash-alt"></span> Font Awesome fontawesome.com --></button>`
			);

		},
		error: function(xhr, status, error) {
			console.log(xhr);
			console.log(status);
			console.log(error);
		}
	});
};
retrieveUMailList();

$(document).on('click', '#chkDel', function() {

	chkDel();

});

let checkDatas = [];

function selectAll(selectAll) {
	const checkboxes
		= document.querySelectorAll('input[type="checkbox"]');

	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked
	})
}


/*안읽은 메일 삭제*/
function chkDel() {
	console.log("체크함수 됨")
	let chkList = $('.check input:checked');
	console.log(chkList);

	for (let i = 0; i < chkList.length; i++) {
		var checkData = $(chkList[i]).val();
		checkDatas.push(checkData);
	}

	console.log(checkDatas);
	var checkRemove = $(this).closest(".checkRemove");
	console.log("밑에 조상 봐")
	console.log(checkRemove);
	console.log("밑에 유알엘 봐")

	$.ajax({
		url: "/mail/udelete",
		method: "delete",
		contentType: 'application/json',
		data: JSON.stringify(checkDatas),
		dataType: "json",
		success: function(resp) {

			console.log(resp);
			let page = searchMap.get("page");
			fn_paging(page);

		},
		error: function(xhr, status, error) {
			console.log(xhr);
			console.log(status);
			console.log(error);
		}
	});
}



$(searchUI).on("click", "#searchBtn", function(event) {
	console.log("서치버튼 클릭됨");
	console.log($(this).parents("#searchUI").find(":input[name]"));
	let inputs = $(this).parents("#searchUI").find(":input[name]");

	$.each(inputs, function(idx, ipt) {
		console.log(idx);
		console.log(ipt);
		let name = ipt.name;
		let value = $(ipt).val();
		console.log(name);
		console.log(value);
		searchMap.set(name, value);
		console.log("서치맵입니다")
		console.log(searchMap);
	});
	fn_paging(1);
});



function fn_paging(page) {
	console.log("gggggiiiii");
	console.log(searchMap);
	searchMap.set("page", page);
	let baseUrl = `${cPath}/mail/ulist2`;
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
			console.log(resp);
			let cnt = 0;
			let unMailLists = 
			`
			<div class="card-header">
				<div class="col d-flex align-items-center">
					<div class="d-flex col-auto d-none d-sm-block">
                    	<div class="form-check mb-0 fs-0" value="31">
                    		 <input  onclick='selectAll(this)' class="form-check-input" type="checkbox" id="checkbox-6" />
                   			 </div>
               			 </div>
					<h5 class="fs-0 px-3 pt-3 pb-2 mb-0 border-bottom border-200">안읽은 메일</h5>
				</div>
			</div>
			`;
			let pageLists = "";
			var pagingList = resp.paging;
			pageLists += makePaging(pagingList);
			console.log("아래를 봐2")
			console.log(resp)

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
			$('.delBtn').html(
				`<button id="chkDel" class="btn btn-light hover-bg-200" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete"><svg class="svg-inline--fa fa-trash-alt fa-w-14" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="trash-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V128H32zm272-256a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zM432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16z"></path></svg><!-- <span class="fas fa-trash-alt"></span> Font Awesome fontawesome.com --></button>`
			);

		},
		error: function(xhr, status, error) {
			console.log(xhr);
			console.log(status);
			console.log(error);
		}
	});

}
