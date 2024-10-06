package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class entry {
    @Autowired
    private FacultyListRepo facultylistrepo;
    @Autowired
    private CourselistRepo courselistrepo;
    @Autowired
    private StudentRepo studentrepo;
    @Autowired
    private SubjectRepo subjectrepo;
    @Autowired
    private AssignFacultyRepo assignfacultyrepo;

    @RequestMapping("enter")
    public ModelAndView dispage(HttpServletRequest request) {
        System.out.println("hai bro how are you");
        ModelAndView v = new ModelAndView();
        
        Iterable<FacultyList> facultyobj = facultylistrepo.findAll();
        v.addObject("facultytable", facultyobj);
        
        Iterable<Course> courseobj = courselistrepo.findAll();
        v.addObject("coursetable", courseobj);
        
        Iterable<Student> studentobj = studentrepo.findAll();
        v.addObject("studenttable", studentobj);
        
        Iterable<Subject> subjectobj = subjectrepo.findAll();
        v.addObject("subjecttable", subjectobj);
        
        Iterable<AssignFaculty> assignfacultyobj = assignfacultyrepo.findAll();
        for(AssignFaculty n:assignfacultyobj)
        {
        	System.out.println(n.toString());
        }
        v.addObject("assignfacultytable", assignfacultyobj);
        HttpSession session = request.getSession();
        session.setAttribute("facultytable",facultyobj);
        session.setAttribute("coursetable",courseobj);
        session.setAttribute("subjecttable",subjectobj);
        session.setAttribute("studenttable",studentobj);
        session.setAttribute("assignfacultytable", assignfacultyobj);
        v.setViewName("adminfaculty");
        return v;
    }
}
