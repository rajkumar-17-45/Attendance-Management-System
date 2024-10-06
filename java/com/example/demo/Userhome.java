package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

@Controller
public class Userhome {

    @Autowired
    private FacultyListRepo facultyListRepo;

    @Autowired
    private AssignFacultyRepo assignFacultyRepo;

    @Autowired
    private SubjectRepo subjectRepo;

    @Autowired
    private SaveAttendanceRepo saveAttendanceRepo;

    @Autowired
    private StudentRepo studentRepo;

    @RequestMapping("userhome")
    public ModelAndView getHome(String username, String password, HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();

        FacultyList objuser = facultyListRepo.findByLoginidAndPassword(username, password);

        if (objuser == null) {
            modelAndView.setViewName("userlogin");
            System.out.println("Invalid username or password");
        } else if (username.equals(objuser.getLoginid()) && password.equals(objuser.getPassword())) {
            modelAndView.setViewName("userhome");
            List<AssignFaculty> assignFacultyList = assignFacultyRepo.findByFacultyName(objuser.getName());
            System.out.println(assignFacultyList.toString());
            
            Map<String, String> subjectSemesterMap = new HashMap<>();
            
            for (AssignFaculty assignFaculty : assignFacultyList) {
                Subject subject = subjectRepo.findByName(assignFaculty.getSubjectName());
                System.out.println(subject.getName());
                
                if (subject != null && !subjectSemesterMap.containsKey(assignFaculty.getSubjectName())) {
                    subjectSemesterMap.put(assignFaculty.getSubjectName(), subject.getSemester());
                }
            }
            
            for (String j : subjectSemesterMap.keySet()) {
                System.out.println(j + subjectSemesterMap.get(j));
            }
            modelAndView.addObject("facultydetails", assignFacultyList);
            modelAndView.addObject("subjectSemesterMap", subjectSemesterMap);
            
            HttpSession session = request.getSession();
            session.setAttribute("facultymain", assignFacultyList);
            session.setAttribute("subjectSemesterMap", subjectSemesterMap);
            session.setAttribute("facultyid", objuser.getId());

            List<SaveAttendanceDTO> saveAttendanceList = saveAttendanceRepo.findByFacultyId(objuser.getId());
            session.setAttribute("saveAttendanceList", saveAttendanceList);

            // Gather student details for all subjects and semesters
            Set<Student> studentSet = new HashSet<>();
            for (Map.Entry<String, String> entry : subjectSemesterMap.entrySet()) {
                String subjectName = entry.getKey();
                String semester = entry.getValue();
                List<AssignFaculty> assignFaculties = assignFacultyRepo.findBySubjectName(subjectName);
                List<String> courseNames = new ArrayList<>();
                for (AssignFaculty assignFaculty : assignFaculties) {
                    courseNames.add(assignFaculty.getCourseName());
                }
                for (String courseName : courseNames) {
                    studentSet.addAll(studentRepo.findByCoursenameAndSemester(courseName, semester));
                }
            }
            List<Student> students = new ArrayList<>(studentSet);
            for(Student t:students)
            	System.out.println(t.toString());
            session.setAttribute("studentmanagedetails",students);

        } else {
            modelAndView.setViewName("userlogin");
        }

        return modelAndView;
    }
}
