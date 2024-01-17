<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 작성</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/menu.jsp" %>
		<h4 class="fw-bold py-3 mb-4">
		<span class="text-muted fw-light">고객지원/</span> 문의사항
	</h4>

	<div class="d-flex flex-wrap justify-content-between align-items-center mb-3">

		<div class="d-flex flex-column justify-content-center">
			<h4 class="mb-1 mt-3">문의사항 작성</h4>
			<p class="text-muted">아래에 내용을 적어주세요</p>
		</div>
		<div class="d-flex align-content-center flex-wrap gap-3">
			<button type="submit" class="btn btn-primary">작성하기</button>

			<button type="button" class="btn btn-secondary">취소</button>

		</div>


		<div class="col-12">
			<div class="card mb-4">
				<div class="card-body">
					<div class="mb-3">
						<label class="form-label" for="ecommerce-product-name">제목</label>
						<input type="text" class="form-control" id="ecommerce-product-name" placeholder="Product title" name="productTitle" aria-label="Product title">
					</div>
					<div class="row mb-3">
						<div class="col">
							<label class="form-label" for="ecommerce-product-sku">작성자</label>
							<input type="number" class="form-control" id="ecommerce-product-sku" placeholder="SKU" name="productSku" aria-label="Product SKU">
						</div>
						<div class="col">
							<label class="form-label" for="ecommerce-product-barcode">작성일</label>
							<input type="text" class="form-control" id="ecommerce-product-barcode" placeholder="0123-4567" name="productBarcode" aria-label="Product barcode">
						</div>
					</div>

					<!-- Description -->
					<div class="mb-3">
						<label class="form-label">내용 <span class="text-muted">(Optional)</span></label>
						<textarea class="form-control" id="exampleFormControlTextarea1" rows="15"></textarea>
					</div>

					<div class="mb-3">
						<label for="formFile" class="form-label">첨부파일</label>
						<input class="form-control" type="file" id="formFile">
					</div>
				</div>
			</div>
		</div>

	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>