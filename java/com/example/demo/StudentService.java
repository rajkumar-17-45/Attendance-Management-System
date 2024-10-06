package com.example.demo;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.transaction.Transactional;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Optional;

@Service
public class StudentService {

    @Autowired
    private StudentRepo studentRepository;

    @Transactional
    public void saveCSV(MultipartFile file) {
        try (CSVReader csvReader = new CSVReader(new InputStreamReader(file.getInputStream()))) {
            List<String[]> records = csvReader.readAll();
            // Skip header
            if (!records.isEmpty()) {
                records.remove(0);
            }

            for (String[] record : records) {
                if (record.length != 8) {
                    continue; // Skip rows with missing fields
                }

                try {
                    String rollno = record[0];
                    String coursename = record[1];
                    String semester = record[2];
                    String name = record[3];
                    String email = record[4];
                    String dob = record[5];
                    String gender = record[6];
                    String mobileno = record[7];

                    if (rollno.isEmpty() || coursename.isEmpty() || semester.isEmpty() || name.isEmpty() || email.isEmpty() || dob.isEmpty() || gender.isEmpty() || mobileno.isEmpty()) {
                        continue; // Skip rows with empty fields
                    }

                    Student student;
                    Optional<Student> existingStudent = studentRepository.findById(rollno);
                    if (existingStudent.isPresent()) {
                        // Update existing entry
                        student = existingStudent.get();
                    } else {
                        // Create new entry
                        student = new Student();
                        student.setRollno(rollno);
                    }

                    student.setCoursename(coursename);
                    student.setSemester(semester);
                    student.setName(name);
                    student.setEmail(email);
                    student.setDob(dob);
                    student.setGender(gender);
                    student.setMobileno(mobileno);

                    studentRepository.save(student);
                } catch (Exception e) {
                    e.printStackTrace();
                    // Log error and continue processing the next record
                }
            }
        } catch (IOException | CsvException e) {
            e.printStackTrace();
        }
    }
}
