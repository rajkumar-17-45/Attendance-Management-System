package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Map;

@Controller
public class SaveAttendance {
    @Autowired
    private SaveAttendanceRepo saveAttendanceRepo;
    @Autowired
    private SaveAttendanceRepo saveattendancerepo;

    @Autowired
    private StudentRepo studentrepo;

    @PostMapping("/save-attendance")
    public String saveAttendance(
            @RequestParam("facultyId") int facultyId,
            @RequestParam("courseName") String courseName,
            @RequestParam("semester") String semester,
            @RequestParam("subject") String subject,
            @RequestParam("date") String date,
            @RequestParam Map<String, String> attendanceData,HttpServletRequest request) {

        attendanceData.forEach((key, value) -> {
            String[] parts = key.split("_");
            if (parts.length == 2) {
                String rollNo = parts[1];
                String status = parts[0];
                Student student = studentrepo.findById(rollNo).orElse(null);
                if (student != null) {
                 
                        String studentCourseName = student.getCoursename();
                        SaveAttendanceDTO saveAttendance = new SaveAttendanceDTO();
                        saveAttendance.setFacultyId(facultyId);
                        saveAttendance.setCourseName(studentCourseName); // Use student's course name
                        saveAttendance.setSemester(semester);
                        saveAttendance.setSubject(subject);
                        saveAttendance.setDate(date);
                        saveAttendance.setRollno(rollNo);
                        saveAttendance.setStatus(status);
                        saveAttendance.setStudentname(student.getName());
                        saveattendancerepo.save(saveAttendance);
                    }
                }
        });
        HttpSession session = request.getSession();
        List<SaveAttendanceDTO> saveAttendanceList = saveAttendanceRepo.findByFacultyId(facultyId);
        session.setAttribute("saveAttendanceList", saveAttendanceList);

        return "redirect:/admin/attendance.jsp";
    }

}
