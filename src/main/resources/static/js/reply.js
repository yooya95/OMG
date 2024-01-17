console.log("Reply Module...");

var replyService = (function(){
	
	function add(reply, callback){
		console.log("reply...");
		
		$.ajax({
			type		:	'post',
			url			:	'/replies/new',
			data		:	JSON.stringify(reply),
			contentType	:	"application/json; charset=utf-8",
			success		:	function(result, status, xhr) {
								if(callback) {
									callback(result);
									}
								},
			error		:	function(xhr, status, er) {
								if(error) {
									error(er);
								}
							}
		});
	}
	
	function getList(param, callback, error) {

		var brd_id 	= param.brd_id;
		var page 	= param.page || 1;

		$.getJSON("/replies/pages/" + brd_id + "/" + page,
				function(data) {
					if (callback) {
						// callback(data);  					//댓글 목록만 가져오는경우
						callback(data.replyCnt, data.list); 	//댓글 숫자와 목록 가져오는경우
					}
				}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
	
	function remove(rep_id, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rep_id,
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function update(reply, callback, error) {

		console.log("rep_id: " + reply.rep_id);

		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rep_id,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function get(rep_id, callback, error) {
		
		$.get("/replies/" + rep_id, function(result) {

			if (callback) {
				callback(result);
			}

		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
	
	function displayTime(timeValue) {
		
		
		var today 	  = new Date();
		var timeValue = new Date(timeValue).getTime();
		var gap		  = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	};
	
	return {
		add			:	add,
		getList		:	getList,
		remove		:	remove,
		update		:	update,
		get			:	get,
		displayTime	: 	displayTime
	};
	
	
})();
