package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class userlogin {
   
   @RequestMapping("userlog")
   public ModelAndView getuser()
   {
	   System.out.println("hello");
	   ModelAndView v=new ModelAndView();
	   
	   v.setViewName("userlogin");
	   return v;
   }
}
