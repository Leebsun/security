package com.subin.control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/kid/*")
public class KidController {
	
	@RequestMapping(value="form")
	public String uploadform() throws Exception{
		return "kid/01_FileUploadForm";
	}
	
	@RequestMapping(value="face")
	public String upload() throws Exception{
		return "kid/01_FileUpload";
	}

}
