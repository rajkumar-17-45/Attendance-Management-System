package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StudentController {

    @Autowired
    private StudentRepo studentrepo;

    @RequestMapping("/admin/addstudent")
    public ModelAndView addstudent(@ModelAttribute Student student) {
        System.out.println(student.toString());
        studentrepo.save(student);
        return new ModelAndView("redirect:/enter");
    }

    @RequestMapping("/save-student")
    public ModelAndView saveStudent(@ModelAttribute Student student) {
        // Assuming you have a form where student details are updated, and course name
        // is selected by the user and set in the form

        // Retrieve the existing student if it exists
        Student existingStudent = studentrepo.findById(student.getRollno()).orElse(null);
        if (existingStudent != null) {
            // Update the existing student record with new values
            existingStudent.setCoursename(student.getCoursename());
            existingStudent.setSemester(student.getSemester());
            existingStudent.setName(student.getName());
            existingStudent.setEmail(student.getEmail());
            existingStudent.setDob(student.getDob());
            existingStudent.setGender(student.getGender());
            existingStudent.setMobileno(student.getMobileno());
            studentrepo.save(existingStudent);
        } else {
            // Save new student record
            studentrepo.save(student);
        }
        return new ModelAndView("redirect:/enter");
    }

    @RequestMapping("/delete-student")
    public ModelAndView deleteStudent(@ModelAttribute Student student) {
        studentrepo.delete(student);
        return new ModelAndView("redirect:/enter");
    }
    @RequestMapping("/delete-multiple-student")
    public ModelAndView deleteMultipleStudents(@RequestParam("ids") List<String> rollnos) {
        for (String rollno : rollnos) {
            studentrepo.deleteById(rollno);
        }
        return new ModelAndView("redirect:/enter");
    }
    
}
