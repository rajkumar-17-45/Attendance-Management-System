package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class okcontrol {
	@RequestMapping("make")
	public ModelAndView getmap(String change,int id,String name,String login,String mobile,String date,String gender)
	{
		System.out.println(name);
		System.out.println(login);
		ModelAndView v=new ModelAndView();
		v.setViewName("sam");
		return v;
	}

}
