package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StudentDetailsController {
      @RequestMapping("/admin/student-details")
      public ModelAndView getstudentdetails()
      {
    	  System.out.println("HJhjhjhnj ckjldc ucec apaonapANT");
    	  ModelAndView v=new ModelAndView();
    	  v.setViewName("student-list");
		return v;
    	  
      }
}
