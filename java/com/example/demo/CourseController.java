package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class CourseController {
    @Autowired
    private CourselistRepo courselistrepo;
  
    @RequestMapping("/admin/addcourse")
    public ModelAndView addcourse(@ModelAttribute Course course) {
        System.out.println(course.getId());
        courselistrepo.save(course);
        return new ModelAndView("redirect:/enter");
    }

    @RequestMapping("/save-course")
    public ModelAndView saveCourse(@ModelAttribute Course course) {
        System.out.println(course);
        Course existingCourse = courselistrepo.findById(course.getId()).orElse(null);
        if (existingCourse != null) {
            existingCourse.setCoursename(course.getCoursename());
            existingCourse.setCoursedescription(course.getCoursedescription());
            courselistrepo.save(existingCourse);
        }
        return new ModelAndView("redirect:/enter");
    }

    @RequestMapping("/delete-course")
    public ModelAndView deleteCourse(@ModelAttribute Course course) {
        System.out.println(course.toString());
        courselistrepo.delete(course);
        return new ModelAndView("redirect:/enter");
    }

    @RequestMapping("/delete-multiple-course")
    public ModelAndView deleteMultipleCourses(@RequestParam("ids") List<String> courseCodes) {
        for (String courseCode : courseCodes) {
            courselistrepo.deleteById(courseCode);
        }
        return new ModelAndView("redirect:/enter");
    }
}
