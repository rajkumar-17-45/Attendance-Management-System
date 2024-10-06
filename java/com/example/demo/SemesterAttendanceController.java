package com.example.demo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SemesterAttendanceController {

    @Autowired
    private SaveAttendanceRepo saveAttendanceRepo;

    @Autowired
    private AssignFacultyRepo assignFacultyRepo;

    @Autowired
    private SubjectRepo subjectRepo;

    @RequestMapping("/admin/semester-attendance")
    public ModelAndView putAttendance(String coursename, String semester, String subject, HttpServletRequest request) {
        ModelAndView m = new ModelAndView();
        m.setViewName("semester-attendance");

        HttpSession session = request.getSession();
        int facultyId = (int) session.getAttribute("facultyid");

        // Fetch all attendance records for the logged-in faculty
        List<SaveAttendanceDTO> saveAttendanceList = saveAttendanceRepo.findByFacultyId(facultyId);

        // Filter attendance records based on course, semester, and subject
        List<SaveAttendanceDTO> filteredList = new ArrayList<>();
        for (SaveAttendanceDTO attendance : saveAttendanceList) {
            if (attendance.getCourseName().equals(coursename) && attendance.getSemester().equals(semester) && attendance.getSubject().equals(subject)) {
                filteredList.add(attendance);
            }
        }

        // Fetch total classes for the subject
        List<AssignFaculty> assignedSubjects = (List<AssignFaculty>) session.getAttribute("facultymain");
        int totalClasses = 0;
        for (AssignFaculty assigned : assignedSubjects) {
            if (assigned.getSubjectName().equals(subject)) {
                totalClasses = assigned.getTotalClasses();
                break;
            }
        }

        // Initialize maps to store attendance details
        Map<String, Integer> presentMap = new HashMap<>();
        Map<String, Integer> absentMap = new HashMap<>();
        Map<String, String> studentNamesMap = new HashMap<>();

        // Populate attendance details
        for (SaveAttendanceDTO attendance : filteredList) {
            String rollNo = attendance.getRollno();
            if (attendance.getStatus().equals("Present")) {
                presentMap.put(rollNo, presentMap.getOrDefault(rollNo, 0) + 1);
            } else if (attendance.getStatus().equals("Absent")) {
                absentMap.put(rollNo, absentMap.getOrDefault(rollNo, 0) + 1);
            }
            studentNamesMap.put(rollNo, attendance.getStudentname());
        }

        // Add objects to ModelAndView for rendering in JSP
        m.addObject("presentlist", presentMap);
        m.addObject("absentlist", absentMap);
        m.addObject("totalhours", totalClasses);
        m.addObject("studentnames", studentNamesMap);
        m.addObject("filteredList", filteredList);

        return m;
    }
}
