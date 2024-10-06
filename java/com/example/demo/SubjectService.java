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
public class SubjectService {

    @Autowired
    private SubjectRepo subjectRepository;

    @Transactional
    public String saveSubjects(MultipartFile file) {
        StringBuilder result = new StringBuilder();
        List<Subject> subjects = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(file.getInputStream()))) {
            String line;
            br.readLine(); // Skip the header row
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length < 5) continue; // Skip malformed lines
                Subject subject = new Subject();
                subject.setSubjectCode(data[0]);
                subject.setCourseName(data[1]);
                subject.setSemester(data[2]);
                subject.setName(data[3]);
                subject.setDescription(data[4]);
                subjects.add(subject);
            }
            subjectRepository.saveAll(subjects);
            result.append("Subjects uploaded successfully.");
        } catch (IOException e) {
            e.printStackTrace();
            result.append("Error uploading subjects: ").append(e.getMessage());
        }
        return result.toString();
    }
}
