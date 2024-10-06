package com.example.demo;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;

@Component
public class finalcheck {
    @RequestMapping("check")
    public String getdis(String name)
    {
    	System.out.println(name);
    	return "sam";
    }
}
