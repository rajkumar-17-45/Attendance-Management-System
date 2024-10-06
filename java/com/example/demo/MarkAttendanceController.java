package com.example.demo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MarkAttendanceController {

    @Autowired
    private AssignFacultyRepo assignFacultyRepo;

    @Autowired
    private SubjectRepo subjectRepo;
    
    @Autowired
    private StudentRepo studentRepo;

    @RequestMapping("/admin/mark-attendance")
    public ModelAndView putAttendance(String subject, String date,HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("mark-attendance");

        String arr[]=date.split("-");
        String p=new String();
        for(int i=arr.length-1;i>=0;i--)
        {
         p+=arr[i];
         if(i!=0)
         p+= "-"; 
        }
        date=p;
        List<AssignFaculty> assignFacultyList = assignFacultyRepo.findBySubjectName(subject);

        if (!assignFacultyList.isEmpty()) {
            List<String> courseNames = new ArrayList<>();
            for (AssignFaculty assignFaculty : assignFacultyList) {
                courseNames.add(assignFaculty.getCourseName());
            }

            Subject subjectEntity = subjectRepo.findByName(subject);
            if (subjectEntity != null) {
                String semester = subjectEntity.getSemester();

                modelAndView.addObject("subject", subject);
                modelAndView.addObject("date", date);
                modelAndView.addObject("semester", semester);
                modelAndView.addObject("courseNames", courseNames);

                // Flatten the list of students and remove duplicates using a Set
                Set<Student> studentSet = new HashSet<>();
                for (String courseName : courseNames) {
                    studentSet.addAll(studentRepo.findByCoursenameAndSemester(courseName, semester));
                }
                List<Student> students = new ArrayList<>(studentSet);
                modelAndView.addObject("students", students);
                HttpSession s=request.getSession();
            
            } else {
                modelAndView.addObject("error", "Subject not found");
            }
        } else {
            modelAndView.addObject("error", "AssignFaculty not found for the subject");
        }

        return modelAndView;
    }
}
