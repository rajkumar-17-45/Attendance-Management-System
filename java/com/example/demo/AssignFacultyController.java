package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class AssignFacultyController {

    @Autowired
    private AssignFacultyRepo assignFacultyRepository;

    @RequestMapping("/admin/add-assignfaculty")
    public ModelAndView addAssignFaculty(@ModelAttribute AssignFaculty assignFaculty) {
        System.out.println(assignFaculty.toString());
        assignFacultyRepository.save(assignFaculty);
        return new ModelAndView("redirect:/enter");
    }

    @PostMapping("/save-assign-faculty")
    public ModelAndView saveAssignFaculty(@ModelAttribute AssignFaculty assignFaculty) {
        System.out.println(assignFaculty);
        AssignFaculty existingAssignFaculty = assignFacultyRepository.findById(assignFaculty.getId()).orElse(null);
        if (existingAssignFaculty != null) {
            // Update the existing assign faculty record with new values
            existingAssignFaculty.setFacultyName(assignFaculty.getFacultyName());
            existingAssignFaculty.setCourseName(assignFaculty.getCourseName());
            existingAssignFaculty.setSubjectName(assignFaculty.getSubjectName());
            existingAssignFaculty.setTotalClasses(assignFaculty.getTotalClasses());
            assignFacultyRepository.save(existingAssignFaculty);
        }
        return new ModelAndView("redirect:/enter");
    }

    @PostMapping("/delete-multiple-afaculty")
    public ModelAndView deleteMultipleAssignFaculty(@RequestParam("ids") List<Long> ids) {
        assignFacultyRepository.deleteAllById(ids);
        return new ModelAndView("redirect:/enter");
    }

    @PostMapping("/delete-assign-faculty")
    public ModelAndView deleteAssignFaculty(@ModelAttribute AssignFaculty assignFaculty) {
        System.out.println(assignFaculty.toString());
        assignFacultyRepository.delete(assignFaculty);
        return new ModelAndView("redirect:/enter");
    }
}
