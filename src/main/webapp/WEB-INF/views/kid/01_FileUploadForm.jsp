<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" import="java.net.InetAddress"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 추가 -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<style type="text/css">
.imgs_wrap {
	width: 600px;
	margin-top: 50px;
}

.imgs_wrap img {
	max-width: 200px;
}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"
	charset="utf-8"></script>
<script type="text/javascript">
	var sel_files = [];

	$(document).ready(function() {
		$("#input_img_1").on("change", handleImgsFilesSelect);
		$("#input_img_2").on("change", handleImgsFilesSelect);
	});

	/**
		이미지 출력 함수
	 **/
	function handleImgsFilesSelect(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}

			sel_files.push(f);

			var reader = new FileReader();
			reader.onload = function(e) {
				var img_html = "<img src=\"" + e.target.result + "\" />";
				$(".imgs_wrap").append(img_html);
			}
			reader.readAsDataURL(f);
		});
	}
</script>

<!-- 추가 -->


<title>01_FileUploadForm.jsp</title>
</head>
<body>
	<h3>파일 업로드 양식</h3>
	<center>
		<!-- <div>
			<h2>
				<b>다중 이미지 미리보기</b>
			</h2>
			<p class="title">다중 이미지 업로드</p>
			<input type="file" id="input_imgs" multiple />
		</div>

		<div>
			<div class="imgs_wrap"></div>
		</div>
 -->

		<!-- <div>
			<input type="file" id="input_imgs" />
		</div> -->

		<!-- <div>
			<div class="imgs_wrap"></div>
		</div> -->


		<div>
			<form action="face" method="post"
				enctype="Multipart/form-data">
				<table border="1" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="2" align="center">
							<h3>얼굴 이미지 업로드</h3>
						</td>
					</tr>

					<tr>
						<td>이름</td>
						<td><input type="text" name="name"></td>
					</tr>

					<tr>
						<td>제목</td>
						<td><input type="text" name="subject"></td>
					</tr>

					<tr>
						<td>이미지 1</td>
						<td><input type="file" name="fileName1" id="input_img_1"></td>
					</tr>

					<tr>
						<td>이미지 2</td>
						<td><input type="file" name="fileName2" id="input_img_2"></td>
					</tr>

					<tr>
						<td colspan="2" align="center"><input type="submit"
							value="전송"></td>
					</tr>

				</table>
			</form>
		</div>
		<div>
			<div class="imgs_wrap"></div>
		</div>
	</center>


</body>
</html>