package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ok {
  @RequestMapping("yes")
  public ModelAndView getok()
  {
	  ModelAndView v=new ModelAndView();
	  v.setViewName("sam");
	  return v;
  }
}

