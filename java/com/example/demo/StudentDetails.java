package com.example.demo;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Component
public class StudentDetails {
	@RequestMapping("student-details")
	public ModelAndView getstudentdetails()
	{
		ModelAndView v=new ModelAndView();
		v.setViewName("student-details");
		return v;
	}

}
