/**
 * 
 */

var html = '';
$(document).on('click', '.msg-import', function() {
	html = "";
	var msgNo = $(this).data('value');
	var msgStat = $(this).data('msg-stat');
	var svg = $(this).find('svg')[0];
	var cnt = $(svg).data('cnt');
	if (msgStat == "M005") {
		html = `<svg class="svg-inline--fa fa-star fa-w-18 text-warning ms-1" data-cnt="1" data-fa-transform="down-4" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="star" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" data-fa-i2svg="" style="transform-origin: 0.5625em 0.75em;"><g transform="translate(288 256)"><g transform="translate(0, 128)  scale(1, 1)  rotate(0 0 0)"><path fill="currentColor" d="M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z" transform="translate(-288 -256)"></path></g></g></svg>`;
	} else {
		html = `<svg class="svg-inline--fa fa-star fa-w-18 text-300 ms-1" data-cnt="0" data-fa-transform="down-4" aria-hidden="true" focusable="false" data-prefix="far" data-icon="star" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" data-fa-i2svg="" style="transform-origin: 0.5625em 0.75em;"><g transform="translate(288 256)"><g transform="translate(0, 128)  scale(1, 1)  rotate(0 0 0)"><path fill="currentColor" d="M528.1 171.5L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6zM388.6 312.3l23.7 138.4L288 385.4l-124.3 65.3 23.7-138.4-100.6-98 139-20.2 62.2-126 62.2 126 139 20.2-100.6 98z" transform="translate(-288 -256)"></path></g></g></svg>`;
	}
	$(this).html(html);

	$.ajax({
		url: '/msg/importSet',
		type: 'get',
		data: {
			msgNo: msgNo,
			msgStat: msgStat
		},
		success: (res) => {
			msg('/msg/receiver', '받은 쪽지', 'detailReceiver');
		},
	});
});


$('.form-check-input.checkbox-bulk-select').on('click', function() {
	var isChecked = $(this).is(':checked');
	$('.form-check-input').prop('checked', isChecked);
});

$(() => {
	msg('/msg/receiver', '받은 쪽지', 'detailReceiver');
});

const checkInbox = $('.dropdown-item')
checkInbox.on('click', function() {
	checkInbox.find('svg').remove();
	checkInbox.attr("class", "dropdown-item d-flex justify-content-between");

	$(this).append(`<svg class="svg-inline--fa fa-check fa-w-16" data-fa-transform="down-4 shrink-4" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="" style="transform-origin: 0.5em 0.75em;">
		<g transform="translate(256 256)"><g transform="translate(0, 128)  scale(0.75, 0.75)  rotate(0 0 0)">
		<path fill="currentColor" d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z" transform="translate(-256 -256)"></path></g></g></svg>`)
})

//받은 쪽지함
$('#receive-msg').on('click', () => {
	msg('/msg/receiver', '받은 쪽지', 'detailReceiver');
});

//보낸 쪽지함
$('#send-msg').on('click', () => {
	msg('/msg/sender', '보낸 쪽지', 'detailSender');
});

//중요 쪽지함
$('#import-msg').on('click', () => {
	msg('/msg/importMsg', '중요 쪽지', 'detailReceiver');
});

//휴지통
$('#trash-msg').on('click', () => {
	msg('/msg/trash', '휴지통', 'detailReceiver');
});

//쪽지의 총 데이터 보관하는 변수
let msgData = [];

//페이징 처리 변수
let currentPage = 0;
let total = 0;
let size = 10;
let endPage = 0;
let content = [];
let pageData;

//쪽지 내용 받아옴
function msg(link, sort, path) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	$('#msg-output').html("");
	$.ajax({
		url: link,
		type: 'post',
		data:{
			empCd: empCd,
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: (res) => {
			msgData = res;

			if (res.length == 0) total = 0;
			else {
				total = res.length;
				currentPage = 1;
			}

			if (total / size % 0) endPage = total / size;
			else endPage = parseInt(total / size) + 1;
			if (total < size) {
				content = res;
			} else {
				content = [];
				for (let i = 0; i < size; i++) {
					content.push(res[i]);
				}
			}
			pageData = [{ "currentPage": currentPage }, { "total": total }, { "size": size }, { "content": content }];
			msgView(link, sort, path, content, currentPage, parseInt(total/size)+1);
			let endRow = currentPage * size;

			if (endRow < total) $('#next').attr('disabled', false);
			else $('#next').attr('disabled', true);
		},
	})
}

$(document).on('click', '#prev, #next', function() {
	//두 버튼을 눌렀을 때 발생되는 currentPage 설정
	if ($(this).attr('id') === 'prev') {
		currentPage -= 1;
	} else {
		currentPage += 1;
	}

	//content 배열 초기화
	content = [];

	//시작행
	let startRow = (currentPage - 1) * size;
	//끝행
	let endRow = currentPage * size;
	if (endRow > msgData.length) endRow = msgData.length;

	for (let i = startRow; i < endRow; i++) {
		content.push(msgData[i]);
	}

	const cls = $(this).data('cls');
	if (cls == '받은 쪽지') msgView('/msg/receiver', '받은 쪽지', 'detailReceiver', content, currentPage, parseInt(total/size)+1);
	else if (cls == '보낸 쪽지') msgView('/msg/sender', '보낸 쪽지', 'detailSender', content, currentPage, parseInt(total/size)+1);
	else if (cls == '중요 쪽지') msgView('/msg/importMsg', '중요 쪽지', 'detailReceiver', content, currentPage, parseInt(total/size)+1);
	else if (cls == '휴지통') msgView('/msg/trash', '휴지통', 'detailReceiver', content, currentPage, parseInt(total/size)+1);

	//cls 값에 따라 호출하는 부분

	//버튼에 대한 disabled 설정
	startRow = (currentPage - 1) * size;
	endRow = currentPage * size;

	if (endRow >= total) $('#next').attr('disabled', true);
	else $('#next').attr('disabled', false);
	if (startRow > 0) $('#prev').attr('disabled', false);
	else $('#prev').attr('disabled', true);
});

//페이징 처리된 쪽지 보관함
function msgView(link, sort, path, content, currentPage, totalPage) {
	html = "";
	html = `<h5 class="fs-0 px-3 pt-3 pb-2 mb-0 border-bottom border-200">` + sort + `</h5>`;

	if (content.length == 0) {
		$('#msg-output').html("");
		html += `<div class='text-center'>쪽지가 없습니다.</div>`
	}
	//inbox에서 쪽지가 있으면 쪽지를 누를 수 있도록 뿌려줌
	content.forEach((value, index, array) => {
		html += `
			<div class="border-bottom border-200 hover-actions-trigger hover-shadow py-2 px-1 mx-0 bg-light d-flex justify-content-between align-items-center">
			`
		if (path != 'detailSender') {
			html += `
					<div class="d-flex bg-light">
						<div class="msg-import" data-value=`+ value.msgNo + ` data-msg-stat=` + value.msgStat + `>`
			//중요 쪽지인 경우와 아닌 경우		
			if (value.msgStat == "V005") {
				html += `<svg class="svg-inline--fa fa-star fa-w-18 text-warning ms-1" data-fa-transform="down-4" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="star" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" data-fa-i2svg="" style="transform-origin: 0.5625em 0.75em;"><g transform="translate(288 256)"><g transform="translate(0, 128)  scale(1, 1)  rotate(0 0 0)"><path fill="currentColor" d="M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z" transform="translate(-288 -256)"></path></g></g></svg></div></div>`
			}
			//휴지통인 경우
			else if (value.msgStat == "V003") {
				html += `</div></div>`
			}
			//열람한 경우 msg_no asc
			else {
				html += `<svg class="svg-inline--fa fa-star fa-w-18 text-300 ms-1" data-cnt="0" data-fa-transform="down-4" aria-hidden="true" focusable="false" data-prefix="far" data-icon="star" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" data-fa-i2svg="" style="transform-origin: 0.5625em 0.75em;"><g transform="translate(288 256)"><g transform="translate(0, 128)  scale(1, 1)  rotate(0 0 0)"><path fill="currentColor" d="M528.1 171.5L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6zM388.6 312.3l23.7 138.4L288 385.4l-124.3 65.3 23.7-138.4-100.6-98 139-20.2 62.2-126 62.2 126 139 20.2-100.6 98z" transform="translate(-288 -256)"></path></g></g></svg></div></div>`
			}
		}

		html += `
				<div class="w-25 col-4 d-flex position-relative">
					<a class="stretched-link inbox-link" href="/msg/`+ path + `?msgNo=` + value.msgNo + `&msgStat=` + value.msgStat + `">` + value.deptNm + ` ` + value.hrGradeNm + ` ` + value.empNm + `</a>
				</div>
				<div class="col-8 bg-light d-flex">
					<div class="col-8">
						<a class="d-block inbox-link" href="/msg/`+ path + `?msgNo=` + value.msgNo + `&msgStat=` + value.msgStat + `">`
		if(value.msgStatNm=='열람'){
				html += `<span>`+value.msgTitle+`</span>`;
			}else if(value.msgStatNm=='미열람'){
				html += `<span style="color: black;">`+value.msgTitle+`</span>`;
			}else if(value.msgStatNm=='중요'){
				html += `<span style="color: blue;">`+value.msgTitle+`</span>`;
			}else{
				html += `<span>`+value.msgTitle+`</span>`;
			}		
		html += `
					</a>
					</div>
					<div class="col-auto d-flex flex-column justify-content-between">
						<span>`+ value.msgStatDt + `  ` + value.msgStatNm + `</span>
					<svg class="svg-inline--fa fa-star fa-w-18 text-300 ms-auto mb-2 d-sm-none" data-fa-transform="down-7" aria-hidden="true" focusable="false" data-prefix="far" data-icon="star" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" data-fa-i2svg="" style="transform-origin: 0.5625em 0.9375em;">
						<g transform="translate(288 256)">
						<g transform="translate(0, 224)  scale(1, 1)  rotate(0 0 0)">
						<path fill="currentColor" d="M528.1 171.5L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6zM388.6 312.3l23.7 138.4L288 385.4l-124.3 65.3 23.7-138.4-100.6-98 139-20.2 62.2-126 62.2 126 139 20.2-100.6 98z" transform="translate(-288 -256)"></path></g></g></svg>
					</div>
				</div>
			</div>
			`
	});
	html += `
				<div class="card-footer d-flex justify-content-end align-items-center">
					<div>
						<small>`+((currentPage-1)*size+1)+` of `
						
	if(currentPage*size>total) html+= total
	else html += currentPage*size
					
	html +=	
					` 전체 페이지 `+totalPage+`</small>
				<button class="btn btn-falcon-default btn-sm ms-1 ms-sm-2" id="prev" type="button" data-cls="`+ sort + `" disabled>
					<svg class="svg-inline--fa fa-chevron-left fa-w-10" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-left" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M34.52 239.03L228.87 44.69c9.37-9.37 24.57-9.37 33.94 0l22.67 22.67c9.36 9.36 9.37 24.52.04 33.9L131.49 256l154.02 154.75c9.34 9.38 9.32 24.54-.04 33.9l-22.67 22.67c-9.37 9.37-24.57 9.37-33.94 0L34.52 272.97c-9.37-9.37-9.37-24.57 0-33.94z"></path></svg>
				</button>
				<button class="btn btn-falcon-default btn-sm ms-1 ms-sm-2" id="next" type="button" data-cls="`+ sort + `">
					<svg class="svg-inline--fa fa-chevron-right fa-w-10" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M285.476 272.971L91.132 467.314c-9.373 9.373-24.569 9.373-33.941 0l-22.667-22.667c-9.357-9.357-9.375-24.522-.04-33.901L188.505 256 34.484 101.255c-9.335-9.379-9.317-24.544.04-33.901l22.667-22.667c9.373-9.373 24.569-9.373 33.941 0L285.475 239.03c9.373 9.372 9.373 24.568.001 33.941z"></path></svg>
				</button>
			</div>
		</div>
	`
	$('#msg-output').html(html);
}