<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>

<!-- jquery 낮은 버전 사용하기 -->
<script>
  var jQuery1x = jQuery.noConflict();
</script>


<style>

.image {
        display: flex;
        align-items: flex-start;
    }

.image img {
       width: 200px;
       height: 200px;
   }

.info {
    padding-left: 10px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    margin-left: 18px;
}

.btn-group {
    margin-top: 8px;
    margin-bottom: 10px;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-left: 12px;
}

.btn-group .btn {
    margin-bottom: 5px;
}

.wrapper {
	display: grid;
	grid-template-columns: 1fr;
	grid-template-rows: 100px 100px 100px;
	grid-gap: 100px;
	
}


#jstree {
	width: 20rem;
	grid-column: 2/4;
	grid-row: 1;
	overflow:overlay;
	position:relative;

}

#jstree::-webkit-scrollbar {
	width: 10px;
}

#jstree::-webkit-scrollbar-thumb {
	background-color: hsla(207.2, 63.9%, 87.1%, 0.45);
    border-radius: 100px;
}

#outBox {
	display: flex;
	height: 700px;
}


#childCard {
	width: 1000px;
	height: 690px;
}

.card .image {
	max-width : 90%; 
	height: auto; 
	text-align: left;
	padding: 10px;
	width: 130px;
	height: 130px;
}

.card .image img {
	max-width: 100%;
	max-height: 100%;
}

.card-container2 {
	display: flex;
	
}

.card .card-body {
	/* 남은 공간을 모두 차지하도록 설정 */
/* 	flex-grow: 1;  */
	padding: 10px;
}

.hidden {
	display: none;
}

.card-head-text {
	font-size: 20px;
	font-color: gray;

}

</style>



<!-- 바깥쪽 카드 -->
<div class="card" style="width:1000px; height:800px;">
		<br/>
		<h5 class="card-title"><span class="fas fa-network-wired"></span> 조직도</h5>
		<br/>
		<div class="card" id="searchBox" style=" width:300px; display: flex; margin-left: auto;">
		  <div class="input-group" style=" width:300px; display: flex; margin-left: auto;">
		    <input type="text" id="search" class="form-control" placeholder="사원 이름을 입력하세요." style="font-size: 13px;">
		    <button class="btn btn-primary" type="button">
		      <i class="fa fa-search"></i>
		    </button>
		  </div>
		</div>
			<br />
		<div class="" style="width:200px; height:800px;" >
			<div class="card treeview treeview-stripe" id="jstree" style="overflow:scroll; width:200px; height:500px; layout:fixed;" >
			</div>
		</div>
			<div id="idCard" style="position: absolute; left: 250px; top: 200px; width:700px; height: 200px; " ></div>
			
</div>			


<script type="text/javascript">
$(function(){
	console.log("온로드 실행되나?");
	// DB에서 조직 정보 가져오기
	jQuery1x.ajax({
		url:"/organization/jsonList",
		type:"post",
		dataType:"json",
		beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(result){
		 	const data = [];
		 	let nodes = result;
		 	
		 	console.log("result", result);
		 	
		 	const parents = {};
		 	nodes.forEach(node => {
		 	  if (!parents[node.parent]) {
		 	    parents[node.parent] = [];
		 	  }

		 	  parents[node.parent].push({name : node.child, id : node.id});
		 	});
			
		 	console.log("parents", parents);
		 	// jstree에서 사용할 수 있는 형태로 데이터 변환
		 	Object.keys(parents).forEach(parent => {
		 	  const children = parents[parent].map(child => {
		 	    return {text: child.name, type: "file", id : child.id};
		 	  });
		 	  data.push({
		 	    text: parent,
		 	    children: children
		 	  });
		 	});
			console.log("data", data);
		 	jQuery1x('#jstree').jstree({
		 		'core': {
		 			"check_callback" : true,
		 			'data': data
		 			},
		 		"types" :{
		 			"default" : {
		 				"icon" : "fa-solid fa-folder"
		 			},
		 			"file" : {
		 				"icon" : "fa-solid fa-address-card"
		 			}
		 		},	
		 		"plugins" : ["types", "dnd", "search"]
		 		

		 	}).on('select_node.jstree',function(event, data) {
				var selectedNodeId = data.node.id;
				console.log("selectedNodeId", selectedNodeId);
				
				//idCard 하나씩만 보이기 : 보였던걸 hidden 처리하고 새롭게 클릭한 정보를 hidden 해제
				jQuery1x("[id*=childCard]").each(function(){
					if(!jQuery1x(this).hasClass("hidden")){  
						jQuery1x(this).addClass("hidden");   //현재 있는 idCard hidden
					}
				}); //하나씩 보이기 끝
				jQuery1x("#childCard" + selectedNodeId).removeClass('hidden');
		 	});
		 	
		 	
		 	// .on("activate_node.jstree", function (node) {node, event}
		 	
		 	
		 	
		 	
		 	let str = "";
	
		 	$.each(result, function(index, obj) {
		 	    var str = "<div class='card overflow-hidden-card hidden' id='childCard" + obj.id + "'>";
		 	    
		 	    str += "<div class='info'>";
		 	    str += "<table class='table table-bordered align-middle text-align mb-3 border'>";
			 	str += "	<colgroup>           ";
				str += "		<col width='30%'>";
				str += "		<col width='30%'>";
				str += "		<col width='40%'>";
				str += "	</colgroup>          ";
		 	    str += "<tbody>";
		 		str += 	"<tr>";
		 		if (obj.img) { // 이미지가 있을 경우에만 이미지 추가
		 			str += "<td colspan='1' rowspan='4'><img class='img-fluid' src='" + obj.img + "' alt='Image'></td>";
		 	    } else {
		 			str += "<td colspan='1' rowspan='4'><img class='img-fluid' src='/resources/images/emp/empImg/noimage3.png' alt='No Image'></td>";
		 	    }
		 		str += 		"<td class='bg-primary-subtle text-center '><p class='card-text' >사번</p></td>";
		 		str += 		"<td class='text-center '><p class='card-text' >" + obj.id + "</p></td>";
		 		str += 	"</tr>";
		 		str += 	"<tr>";
		 		str += 		"<td class='bg-primary-subtle text-center '><p class='card-text'>부서</p></td>";
		 		str += 		"<td class='text-center '><p class='card-text'>" + obj.dept + "</p></td>";
		 		str += 	"</tr>";
		 		str += 	"<tr>";
		 		str += 		"<td class='bg-primary-subtle text-center '><p class='card-text'>직급</p></td>";
		 		str += 		"<td class='text-center '><p class='card-text'>" + obj.grade + "</p></td>";
		 		str += 	"</tr>";
		 		str += 	"<tr>";
		 		str += 		"<td class='bg-primary-subtle text-center '><p class='card-text'>이름</p></td>";
		 		str += 		"<td class='text-center '><p class='card-text'>" + obj.name + "</p></td>";
		 		str += 	"</tr>";
		 		str += 	"<tr>";
		 		str += 		"<td class='text-center '><a class='btn btn-outline-info me-1 mb-1 btn-sm' href='/mail/send?empCmail=" + obj.cmail + "'>메일 보내기</a></td>";
		 		str +=		"<td class='bg-primary-subtle text-center '><p class='card-text'>메일</p></td>";
		 		str += 		"<td class='text-center '><p class='card-text'>" + obj.cmail + "</p></td>";
		 		str += 	"</tr>";
		 		str += 	"<tr>";
		 		str += 		"<td class='text-center '><a class='btn btn-outline-info me-1 mb-1 btn-sm' href='/msg/compose?empCd=" + obj.id + "'>쪽지 보내기</a></td>";
		 		str +=		"<td class='bg-primary-subtle text-center '><p class='card-text'>전화번호</p></td>";
		 		str += 		"<td class='text-center '><p class='card-text'>" + obj.tel + "</p></td>";
		 		str += 	"</tr>";
		 		str += "</tbody>";
		 	    str += "</div>";
		 	    str += "</div>";
		 
		   	    str += "<button type='button' class='btn-close close-button' data-card-id='" + obj.id + "' aria-label='Close' style='position: absolute; top: 0; right: 0;'></button>";
		 	    str += "</div>";
		 	    $("#idCard").append(str);
		 		  
		 		// X 버튼 클릭 이벤트 처리
	                $("#idCard").on("click", ".close-button", function() {
				      var cardId = $(this).attr("data-card-id");
				      $("#childCard" + cardId).addClass("hidden");
	                });
		 		  
		       });
			 	
			}
		 	
		});
	
	 	// 조직도 내 검색 기능
	 	$('#search').on('keyup', function () {
	 	    var searchString = $(this).val();
	 	   jQuery1x('#jstree').jstree(true).search(searchString);
	 	    
	 	});

});



</script>



