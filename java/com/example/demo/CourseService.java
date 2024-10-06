package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.transaction.Transactional;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

@Service
public class CourseService {

    @Autowired
    private CourselistRepo courseRepository;

    @Transactional
    public String saveCourses(MultipartFile file) {
        StringBuilder result = new StringBuilder();
        List<Course> courses = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(file.getInputStream()))) {
            String line;
            br.readLine(); // Skip the header row
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length < 3) continue; // Skip malformed lines
                Course course = new Course();
                course.setId(data[0]);
                course.setCoursename(data[1]);
                course.setCoursedescription(data[2]);
                courses.add(course);
            }
            courseRepository.saveAll(courses);
            result.append("Courses uploaded successfully.");
        } catch (IOException e) {
            e.printStackTrace();
            result.append("Error uploading courses: ").append(e.getMessage());
        }
        return result.toString();
    }
}
