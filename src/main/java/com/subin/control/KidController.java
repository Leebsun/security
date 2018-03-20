package com.subin.control;

import java.io.File;
import java.io.OutputStream;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.GenericServlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kii.face.KIFACE;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
@RequestMapping(value="/kid/*")
public class KidController {

	@RequestMapping(value="form")
	public String uploadform() throws Exception{
		return "kid/01_FileUploadForm";
	}
	
	
	

	@RequestMapping(value="face")
	public String upload(HttpServletRequest request) throws Exception{
		String realFolder = "";
		String saveFolder = "resources/upload/images";
		String encType = "UTF-8";
		int maxSize = 5*1024*1024;
		int index = 0;

		int matchScore = 0;
		String[] imagesPath = new String[2];

		ServletContext context = request.getSession().getServletContext();

		realFolder = context.getRealPath(saveFolder);

		System.out.println("실제 서블릿 상 경로 : " + realFolder);
		System.out.print("실제 서블릿 상 업로드 경로 : " + realFolder);

		MultipartRequest multi = null;

		try{
			multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

			Enumeration en=multi.getParameterNames();
			while(en.hasMoreElements()){
				String name = (String)en.nextElement();
				String value = multi.getParameter(name);
				System.out.println(name + ":" + value);
			}

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

				System.out.println("파라미터 이름 : " + name);
				System.out.println("원본 이름 : " + originFile);
				System.out.println("시스템 이름 : " + systemFile);
				System.out.println("파일 타입 : " + fileType);
				System.out.println("이미지 경로 : " + realPath);

				if (file != null) {
					System.out.println("크기 : " + file.length() + "byte");
					// 이미지 파일 경로 저장하기.
					imagesPath[index] = realPath;
				}
				index++;
			}
			System.out.println("imagesPath[0] : " + imagesPath[0]);
			System.out.println("imagesPath[1] : " + imagesPath[1]);

			//KIFACE kf = new KIFACE("모델파일 경로");
			KIFACE kf = new KIFACE();
			matchScore = kf.convertImageToByteArray(imagesPath[0],
					imagesPath[1]);
			if (matchScore == 0) {
				System.out.println("변환 완료.");
				//pageContext.forward("01_FileUploadForm.jsp");	// 이동 가능 > 새로 불러옴.

				/* RequestDispatcher rd = request
					.getRequestDispatcher("01_FileUploadForm.jsp");

					rd.forward(request, response); */
			}
		} catch (Exception e) {
			System.out.println("파일 처리 간 문제 발생");
		}
		
	
		



		return "kid/01_FileUpload";
	}
}



