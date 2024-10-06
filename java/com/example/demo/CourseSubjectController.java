package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class CourseSubjectController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private SubjectService subjectService;

    @PostMapping("/uploadCourse")
    public String uploadCourse(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
        String message = courseService.saveCourses(file);
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/userhome.jsp";
    }

    @PostMapping("/uploadSubject")
    public String uploadSubject(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
        String message = subjectService.saveSubjects(file);
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/userhome.jsp";
    }
}
