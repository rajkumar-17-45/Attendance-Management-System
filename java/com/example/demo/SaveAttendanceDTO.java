package com.example.demo;

import org.springframework.stereotype.Component;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Component
@Entity
public class SaveAttendanceDTO {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private Long id;

   private int facultyId;
   private String courseName;
   private String semester;
   private String subject;
   private String date;
   private String rollno;
   private String studentname;
   private String status;

   public SaveAttendanceDTO() {
       super();
   }

   public Long getId() {
       return id;
   }

   public void setId(Long id) {
       this.id = id;
   }

   public int getFacultyId() {
       return facultyId;
   }

   public void setFacultyId(int facultyId) {
       this.facultyId = facultyId;
   }

   public String getCourseName() {
       return courseName;
   }

   public void setCourseName(String courseName) {
       this.courseName = courseName;
   }

   public String getSemester() {
       return semester;
   }

   public void setSemester(String semester) {
       this.semester = semester;
   }

   public String getSubject() {
       return subject;
   }

   public void setSubject(String subject) {
       this.subject = subject;
   }

   public String getDate() {
       return date;
   }

   public void setDate(String date) {
       this.date = date;
   }

   public String getRollno() {
       return rollno;
   }

   public void setRollno(String rollno) {
       this.rollno = rollno;
   }

   public String getStudentname() {
       return studentname;
   }

   public void setStudentname(String studentname) {
       this.studentname = studentname;
   }

   public String getStatus() {
       return status;
   }

   public void setStatus(String status) {
       this.status = status;
   }

   @Override
   public String toString() {
       return "SaveAttendanceDTO [id=" + id + ", facultyId=" + facultyId + ", courseName=" + courseName + ", semester=" + semester
               + ", subject=" + subject + ", date=" + date + ", rollno=" + rollno + ", studentname=" + studentname
               + ", status=" + status + "]";
   }
}
