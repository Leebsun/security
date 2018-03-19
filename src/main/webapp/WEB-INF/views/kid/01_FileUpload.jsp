<%@page import="com.kii.face.KIFACE"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%-- <%@page import="com.kii.face.KIFACE"%>
<jsp:useBean id="face" class="com.kii.face.KIFACE" scope="page" /> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String realFolder = "";
	//업로드용 폴더 이름
	String saveFolder = "resources/upload/images";
	String encType = "utf-8";
	int maxSize = 5 * 1024 * 1024; // 5M Byte
	int index = 0;

	//매칭 스코어 변수 초기화.
	int matchScore = 0;
	String[] imagesPath = new String[2];

	//jspMain2-context라고 한다. 서버에서(서블릿) 어디에 어느 폴더에서 서블릿으로 변환되는지에 대한 정의.
	ServletContext context = this.getServletContext();

	//서블릿 상의 upload폴더 경로를 알아온다.
	realFolder = context.getRealPath(saveFolder);

	//콘솔  브라우저에 실제 경로를 출력
	System.out.println("실제 서블릿 상 경로 : " + realFolder);
	out.print("실제 서블릿 상 업로드 경로 : " + realFolder);

	//파일을 받아와서 폴더에 업로드 하면 된다.
	MultipartRequest multi = null;

	try {
		multi = new MultipartRequest(request, realFolder, maxSize,
				encType, new DefaultFileRenamePolicy());

		Enumeration en = multi.getParameterNames();
		while (en.hasMoreElements()) {
			String name = (String) en.nextElement();
			String value = multi.getParameter(name);
			out.print("<br>" + name + ":" + value);
		}
		out.print("<hr>");

		//전송된 파일이름 fileName1, fileName2를 가져온다.
		en = multi.getFileNames();
		while (en.hasMoreElements() && index < 2) {
			String name = (String) en.nextElement();
			//name파라미터에는 file의 이름이 들어있다.
			//그 이름을 주면 실제 값(업로드 "할" file)을 가져온다.
			String originFile = multi.getOriginalFileName(name);

			//만약 업로드 폴더에 똑같은 파일이 있으면, 현재 올리는 파일 이름은 바뀐다. (중복정책)
			//그래서 시스템에 있는 이름을 알려준다.
			String systemFile = multi.getFilesystemName(name);

			//전송된 파일의 타입 - MIME 타입 (기계여,image, HTML, text...)
			String fileType = multi.getContentType(name);

			String realPath = realFolder + "\\" + systemFile;
			//문자열 "파일 이름"이 name에 들어온 상태
			//문자열 파일 이름을 통해 실제 파일 객체를 가져온다.
			File file = multi.getFile(name); //java.io

			out.println("파라미터 이름 : " + name + "<br>");
			out.println("원본 이름 : " + originFile + "<br>");
			out.println("시스템 이름 : " + systemFile + "<br>");
			out.println("파일 타입 : " + fileType + "<br>");
			out.println("이미지 경로 : " + realPath + "<br>");

			if (file != null) {
				out.println("크기 : " + file.length() + "byte"
						+ "<br><br>");
				// 이미지 파일 경로 저장하기.
				imagesPath[index] = realPath;
			}
			index++;
		}
		out.println("imagesPath[0] : " + imagesPath[0] + "<br>");
		out.println("imagesPath[1] : " + imagesPath[1] + "<br>");

		//KIFACE kf = new KIFACE("모델파일 경로");
		KIFACE kf = new KIFACE();
		matchScore = kf.convertImageToByteArray(imagesPath[0],
				imagesPath[1]);
		if (matchScore == 0) {
			out.println("변환 완료.");
			//pageContext.forward("01_FileUploadForm.jsp");	// 이동 가능 > 새로 불러옴.

			/* RequestDispatcher rd = request
			.getRequestDispatcher("01_FileUploadForm.jsp");

			rd.forward(request, response); */
		}
	} catch (Exception e) {
		out.println("파일 처리 간 문제 발생");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>01_FileUpload.jsp</title>
</head>
<body>
	<br>
	<%-- <img src="<%=imagesPath[0]%>" width="50" height="50"> --%>
	<%-- <img src="<%=imagesPath[0].replace("%20", " ")%>" width="50"
		height="50"/> --%>
</body>
</html>