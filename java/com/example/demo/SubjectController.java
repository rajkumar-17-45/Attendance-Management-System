package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SubjectController {

    @Autowired
    private SubjectRepo subjectRepo;

    @RequestMapping("/admin/addsubject")
    public ModelAndView addSubject(@ModelAttribute Subject subject) {
//    	System.out.println(subject.toString());
        subjectRepo.save(subject);
        return new ModelAndView("redirect:/enter");
    }

    @RequestMapping("/save-subject")
    public ModelAndView saveSubject(@ModelAttribute Subject subject) {
        Subject existingSubject = subjectRepo.findById(subject.getSubjectCode()).orElse(null);
        if (existingSubject != null) {
            // Update the existing subject record with new values
            existingSubject.setCourseName(subject.getCourseName());
            existingSubject.setSemester(subject.getSemester());
            existingSubject.setName(subject.getName());
            existingSubject.setDescription(subject.getDescription());
            subjectRepo.save(existingSubject);
        } else {
            // Save new subject record
            subjectRepo.save(subject);
        }
        return new ModelAndView("redirect:/enter");
    }

    @RequestMapping("/delete-subject")
    public ModelAndView deleteSubject(@ModelAttribute Subject subject) {
    	System.out.println(subject.toString() +" helllo ok that");
        subjectRepo.delete(subject);
        return new ModelAndView("redirect:/enter");
    }
    @PostMapping("/delete-multiple-subject")
    public String deleteMultipleSubjects(@RequestParam("subjectids") List<String> subjectIds) {
        for (String id : subjectIds) {
            subjectRepo.deleteById(id);
        }
        return "redirect:/enter";
}
}
