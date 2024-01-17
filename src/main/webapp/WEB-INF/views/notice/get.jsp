<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menu.jsp"%>
	<h4 class="fw-bold py-3 mb-4">
		<span class="text-muted fw-light">고객지원/</span> 공지사항
	</h4>
		<form id="operForm" action="/board/modify" method="get">
			<input type="hidden" id="brd_id"  name="brd_id"  value='<c:out value="${notice.brd_id }"/>'>
			<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
			<input type="hidden" name="amount"  value='<c:out value="${cri.amount }"/>'>
			<input type="hidden" name='type' 	value='<c:out value="${cri.type }"></c:out>'>
			<input type="hidden" name='keyword' value='<c:out value="${cri.keyword }"></c:out>'>
		</form>
		<div class="d-flex flex-wrap justify-content-between align-items-center mb-3">

			<div class="d-flex flex-column justify-content-center">
				<h4 class="mb-1 mt-3 mb-3">공지사항 </h4>
				
			</div>
			
			<div class="d-flex align-content-center flex-wrap gap-3 mb-3">
				<c:if test="${sessionScope.mem_id eq notice.mem_id || sessionScope.mem_dept_md == 999}">
					<button data-oper='modify' class="btn btn-primary">수정하기</button>
				</c:if>
					<button data-oper='list' class="btn btn-secondary">목록</button>
			</div>
						

			<div class="col-12">
				<div class="card mb-4">
					<div class="card-body">
						<div class="mb-3">
							<label class="form-label" for="ecommerce-product-name">게시글 번호</label>
							<input type="number" name="brd_id" value='<c:out value="${notice.brd_id }"/>' readonly class="form-control" id="ecommerce-product-name"  aria-label="Product title">
						</div>
						<div class="mb-3">
							<label class="form-label" for="ecommerce-product-name">제목</label>
							<input type="text" name="title" value='<c:out value="${notice.title }"/>' readonly class="form-control" id="ecommerce-product-title" placeholder="제목을 입력해주세요" aria-label="Product title">
						</div>
						<div class="row mb-3">
							<div class="col-6">
								<label class="form-label" for="ecommerce-product-sku">작성자</label>
								<input type="text" name="mem_name" readonly value='<c:out value="${notice.mem_name }"/>'  class="form-control" id="ecommerce-product-sku" aria-label="Product SKU" >
							</div>
							<div class="col-6">
								<label class="form-label" for="ecommerce-product-sku">작성일</label>
								<input type="text" name="reg_date" readonly value='<c:out value="${notice.reg_date }"/>'  class="form-control" id="ecommerce-product-reg_date" aria-label="Product SKU" >
							</div>
						</div>

						<!-- Description -->
						<div class="mb-3">
							<label class="form-label">내용 </label>
							<textarea class="form-control" name="brd_cn" readonly id="exampleFormControlTextarea1" rows="15"><c:out value="${notice.brd_cn }"/></textarea>
						</div>

						<!-- 첨부파일, 추후에 꼭 하기 -->
<!-- 						<div class="mb-3"> -->
<!-- 							<label for="formFile" class="form-label">첨부파일</label> -->
<!-- 							<input class="form-control" type="file" id="formFile"> -->
<!-- 						</div> -->

					</div>
					
					
				</div>
			
			</div>
	
			<div class="col-12">
				<div class="card">
					<div class="card-header border-bottom d-flex justify-content-between">
						<i class="bi bi-chat-dots-fill"> 댓글</i> 
						<c:if test="${not empty sessionScope}">
							<button id='addReplyBtn' class="btn btn-primary btn-sm">댓글 작성</button>
						</c:if>
						
						
					</div>
					<div class="card-body">
						<ul class="list-group list-group-flush chat">
							<li class="list-group-item" data-rep_id='12'>
							<div class="d-flex justify-content-between">
								    <h5 class="card-title"></h5>
								    <h6 class="card-title text-muted"></h6>
							</div>					
								    <p class="card-text"></p>
	<!-- 							    <a href="#" class="card-link">Card link</a> -->
	<!-- 							    <a href="#" class="card-link">Another link</a> -->
							</li>
						</ul>
					</div>
					<div class="card-footer">
						
					</div>
				</div>
			</div>




	</div>
	


	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<!-- 	Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">댓글</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="form-group my-1">
						<label class="form-label">내용</label>
						<input class="form-control" id="rep_cn" name="rep_cn" value="" placeholder="댓글을 작성해 주세요">
					</div>
					<div class="form-group my-1">
						<label class="form-label">작성자</label>
						<input type="text" 	 class="form-control" name="mem_name" value='<c:out value="${sessionScope.mem_name }"/>' readonly="readonly">
						<input type="hidden" class="form-control" name="mem_id"   value='<c:out value="${sessionScope.mem_id }"/>'>
					</div>
					<div class="form-group my-1">
						<label class="form-label">작성일</label>
						<input class="form-control" name="rep_date" value=''>
					
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id='modalModBtn'      class="btn btn-outline-warning"  data-bs-dismiss="modal">수정하기</button>
					<button type="button" id='modalRemoveBtn'   class="btn btn-outline-danger"   data-bs-dismiss="modal">삭제</button>
					<button type="button" id='modalRegisterBtn' class="btn btn-outline-primary"  data-bs-dismiss="modal">등록</button>
					<button type="button" id='modalCloseBtn'    class="btn btn-outline-dark" 	 data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- JS -->
	<script type="text/javascript" src="/js/reply.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		
		console.log("============");
		console.log("JS TEST");
		
		var brd_id_value= '<c:out value="${notice.brd_id}"/>';
		var replyUL = $(".list-group.list-group-flush.chat");
		
			showList(1);
			
			function showList(page){
				
				 console.log("show list " + page);
			    
			     replyService.getList({brd_id:brd_id_value, page: page || 1 }, function(replyCnt, list) {
			    	console.log("replyCnt: " + replyCnt); 
			    	
			     	
			    	// -1이 호출되면
			    	if(page == -1){
			    		// 마지막 페이지를 pageNum 세팅
			    		pageNum = Math.ceil(replyCnt/10.0);
			    		// 마지막 페이지 호출
			    		showList(pageNum);
			    		return;
			    	}
			    	
			    	var str="";
			    
			     if(list == null || list.length == 0){
			       return;
			     }
			     
			     
			     for (var i = 0, len = list.length || 0; i < len; i++) {
			       str +="<li class='list-group-item' data-rep_id='"+list[i].rep_id+"'>";
			       str +="<div class='d-flex justify-content-between'>";
			       str +="<h5 class='card-title'>" + list[i].mem_name + "</h5>";
			       str +="<h6 class='card-title text-muted'>" + replyService.displayTime(list[i].rep_date) + "</h6>";
			       str += "</div>";
			       str += "<p class='card-text'>" + list[i].rep_cn + "</p>"
			     }
			     
			     
			     replyUL.html(str);
			     showReplyPage(replyCnt);

			 
			   });//end function
			     
			 }//end showList
		
		// 전역변수로 pageNum 선언
	    var pageNum = 1;
	    var replyPageFooter = $(".card-footer");
		    
		  	function showReplyPage(replyCnt){
		      
		      var endNum = Math.ceil(pageNum / 10.0) * 10;  
		      var startNum = endNum - 9; 
		      
		      var prev = startNum != 1;
		      var next = false;
		      
		      if(endNum * 10 >= replyCnt){
		        endNum = Math.ceil(replyCnt/10.0);
		      }
		      
		      if(endNum * 10 < replyCnt){
		        next = true;
		      }
		      
		      var str = "<ul class='pagination float-end'>";
		      
		      if(prev){
		        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>이전</a></li>";
		      }
		      
		      for(var i = startNum ; i <= endNum; i++){
		        
		        var active = pageNum == i? "active":"";
		        
		        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		      }
		      
		      if(next){
		        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>다음</a></li>";
		      }
		      
		      str += "</ul></div>";
				
		      // str문장 어떻게 구성됐는지 확인용
		      // console.log(str); 	     
		      
		      replyPageFooter.html(str);
		    }	
		  	
		    replyPageFooter.on("click","li a", function(e){
		        e.preventDefault();
		        console.log("page click");
		        
		        var targetPageNum = $(this).attr("href");
		        
		        console.log("targetPageNum: " + targetPageNum);
		        
		        pageNum = targetPageNum;
		        
		        showList(pageNum);
		      }); 
		
		    
		    
	    var modal = $(".modal");
	    var modalInputRep_cn 	= modal.find("input[name='rep_cn']");
	    var modalInputMem_id	= modal.find("input[name='mem_id']");
	    var modalInputMem_name	= modal.find("input[name='mem_name']");
	    var modalInputRep_date  = modal.find("input[name='rep_date']");

	    
	    var modalModBtn		  = $("#modalModBtn");
	    var modalRemoveBtn 	  = $("#modalRemoveBtn");
	    var modalRegisterBtn  = $("#modalRegisterBtn");
	    
	    var mem_name = null;
	    var mem_id   = null;
	    mem_name	 = '${sessionScope.mem_name}';
	    mem_id		 = '${sessionScope.mem_id}';
	    
	    
	    $("#addReplyBtn").on("click", function(e){
	      
	      modal.find("input").val("");
	      modal.find("input[name='mem_name']").val(mem_name);
	      modal.find("input[name='mem_id']").val(mem_id);
	      modalInputRep_date.closest("div").hide();
	      
	      modal.find("button[id !='modalCloseBtn']").hide();
	      modalRegisterBtn.show();
	      
	      $(".modal").modal("show");
	      
	    });
		
	    modalRegisterBtn.on("click", function(e){
	    	var reply = {
	    		rep_cn		: 	modalInputRep_cn.val(),
	    		mem_id		: 	modalInputMem_id.val(),
	    		brd_id		:	brd_id_value
	    	};
	   
			replyService.add(reply, function(result){
			
				alert("댓글이 등록 되었습니다.");
				
				// 댓글 추가 이후 다시 등록못하게 입력창 비우고 모달창 닫음
				modal.find("input").val("");
				modal.modal("hide");
				
				//댓글 작성이후 지금 추가한 댓글 / 다른사람이 추가했을 새로운댓글 가져오기
				//showList(1);
				showList(-1); // 마지막 댓글로 이동하기위한 세팅
				
				
			});
	    });
	    
	  //댓글 조회 클릭 이벤트 처리 
	    $(".list-group.list-group-flush.chat").on("click", "li", function(e){
	      
	      var rep_id = $(this).data("rep_id");
	      
	      console.log(rep_id);
	      
	      replyService.get(rep_id, function(reply){
	      
	    	modalInputRep_cn.val(reply.rep_cn);
	    	modalInputMem_id.val(reply.mem_id);
	    	modalInputMem_name.val(reply.mem_name);
	    	modalInputRep_date.val(replyService.displayTime(reply.rep_date)).attr("readonly","readonly");
	        modal.data("rep_id", reply.rep_id);
	        
	        modal.find("button[id !='modalCloseBtn']").hide();
	        modalModBtn.show();
	        modalRemoveBtn.show();
	        
	        $(".modal").modal("show");
	            
	      });
	    });
	  
	    modalModBtn.on("click", function(e){
			 
	    	 // 로그인한 유저 
	    	 console.log("mem_name: " + mem_name);
	    	 
	    	 // 원래 작성자
	    	 var originalMem_name = modalInputMem_name.val();
	    	 console.log("originalMem_name : " + originalMem_name );
	    	 
	    	 if(!mem_name){
	    		  alert("로그인후 수정 가능합니다");
	    		  modal.modal("hide");
	    		  return;
	    	 }
	    	  
	    	 if(mem_name != originalMem_name && ${sessionScope.mem_dept_md} != 999 ){
	    		  alert("자신이 작성한 댓글만 수정 가능합니다.");
	    		  modal.modal("hide");
	    		  return;
	    	 }
	    	
	      var reply = { rep_id : modal.data("rep_id"), rep_cn: modalInputRep_cn.val()};
	      
	      replyService.update(reply, function(result){
	            
	        //alert(result);
	        modal.modal("hide");
	        showList(pageNum);
	        
	      });
	      
	    });
	    
	    modalRemoveBtn.on("click", function (e){
	    	  
    	  var rep_id = modal.data("rep_id");
	      
    	  console.log("rep_id: " + rep_id);
    	  // 로그인한 유저
    	  console.log("mem_name: " + mem_name); 	
    	  
    	  if(!mem_name){
    		  alert("로그인후 삭제가 가능합니다");
    		  modal.modal("hide");
    		  return;
    	  }
    	  
    	  // 원래 작성자
    	  var originalMem_name = modalInputMem_name.val();
    	  console.log("originalMem_name : " + originalMem_name );
    	  
    	  if(mem_name != originalMem_name && ${sessionScope.mem_dept_md} != 999 ){
    		  alert("자신이 작성한 댓글만 삭제가 가능합니다.");
    		  modal.modal("hide");
    		  return;
    	  }
    	  
    	  replyService.remove(rep_id, function(result){
	    	        
    	      //alert(result);
    	      modal.modal("hide");
    	      showList(pageNum);
	    	      
	      });
	    	  
	    });
	  
		
// 		replyService.getList({brd_id:brd_id_value, page:1}, function(list){
			
// 			for(var i = 0, len = list.length||0; i < len; i++){
// 				console.log(list[i]);
// 			}
			
// 		});
		
		
		 
// 		//85번 댓글 삭제 테스트 
// 		 replyService.remove(85, function(count) {

// 		   console.log(count);

// 		   if (count === "success") {
// 		     alert("REMOVED");
// 		   }
// 		 }, function(err) {
// 		   		alert('ERROR...');
// 		 });
		 
// 		//12번 댓글 수정 
// 		replyService.update({
// 		  rep_id	: 12,
// 		  brd_id	: brd_id_value,
// 		  rep_cn	: "Modified Reply...."
// 		}, function(result) {

// 		  alert("수정 완료...");

// 		});  
		
		// 조회 테스트
// 		replyService.get(10, function(data){
// 			console.log(data);
// 		});
	});
	</script>
	
	<script type="text/javascript">
	$(function(){
		
		var operForm = $("#operForm");
	
		$("button[data-oper='modify']").on("click", function(e){
			
			operForm.attr("action","/notice/modify").submit();
			
		});
		
		$("button[data-oper='list']").on("click", function(e){
				
			operForm.find("#brd_id").remove();
			operForm.attr("action","/notice/list").submit();
			operForm.submit();
			
		});
		
	});
	</script>
</body>
</html>