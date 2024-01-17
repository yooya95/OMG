W<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 상세</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menu.jsp"%>
	<h4 class="fw-bold py-3 mb-4">
		<span class="text-muted fw-light">고객지원/</span> 문의사항
	</h4>
	<div class="d-flex justify-content-end flex-wrap gap-3 mb-2">
		<button type="button" class="btn btn-secondary" onclick="location.href='../qna?currentPage=${pageNum}'">목록</button>
	</div>

	<div class="card g-3 mt-1 mb-2">
		<div class="card-body row g-3">
			<div class="col-lg-12">
				<div class="d-flex justify-content-between align-items-center flex-wrap gap-1 border-bottom">
					<div class="me-1">
						<h5 class="mb-1">${QnA.title }</h5>
						<p class="mb-1">
							<span class="fw-medium">${QnA.mem_name }</span>
						</p>
					</div>
					<div class="me-1">
						<p></p>
						<p class="mb-1">
							<span class="fw-medium">${QnA.reg_date }</span>
						</p>
					</div>
				</div>

				<div class="card academy-content shadow-none">
					<div class="p-2">
						<div class="d-flex justify-content-end align-items-center flex-wrap mb-4 gap-1 ">
							<i class="bx bx-share-alt bx-sm mx-2"></i> <i class="bx bx-bookmarks bx-sm"></i>
						</div>
						<div class="cursor-pointer">
							<div class="plyr plyr--full-ui plyr--video plyr--html5 plyr--fullscreen-enabled plyr--paused plyr--stopped plyr--pip-supported plyr__poster-enabled" style="border-radius: 7px;">
								<div class="plyr__video-wrapper">
									<video class="w-100" poster="https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-HD.jpg" id="plyr-video-player" playsinline="" data-poster="https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-HD.jpg">
										<source src="https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-576p.mp4" type="video/mp4">
									</video>
									<div class="plyr__poster" style="display: none; background-image: url(&quot;https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-HD.jpg&quot;);"></div>
								</div>
								<div class="plyr__captions" dir="auto"></div>
							</div>
						</div>
					</div>
					<div class="card-body">
						<p>${QnA.brd_cn }</p>

					</div>
				</div>
			</div>

		</div>
	</div>


	<div class="d-flex justify-content-center flex-wrap gap-3 mb-5">
		<button type="submit" class="btn btn-primary">수정</button>

		<button type="button" class="btn btn-warning">삭제</button>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>