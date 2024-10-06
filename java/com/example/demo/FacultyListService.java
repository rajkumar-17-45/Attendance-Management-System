package com.example.demo;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.transaction.Transactional;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Optional;

@Service
public class FacultyListService {

    private static final Logger logger = LoggerFactory.getLogger(FacultyListService.class);

    @Autowired
    private FacultyListRepo facultyListRepository;

    @Transactional
    public void saveCSV(MultipartFile file) {
        try (CSVReader csvReader = new CSVReader(new InputStreamReader(file.getInputStream()))) {
            List<String[]> records = csvReader.readAll();
            // Skip header
            if (!records.isEmpty()) {
                records.remove(0);
            }

            for (String[] record : records) {
                if (record.length != 7) {
                    logger.warn("Skipping row due to missing fields: " + String.join(", ", record));
                    continue; // Skip rows with missing fields
                }

                try {
                    int id = record[0].isEmpty() ? 0 : Integer.parseInt(record[0]);
                    String name = record[1];
                    String loginid = record[2];
                    String password = record[3];
                    String gender = record[4];
                    String dob = record[5];
                    String mobileno = record[6];

                    if (name.isEmpty() || loginid.isEmpty() || password.isEmpty() || gender.isEmpty() || dob.isEmpty() || mobileno.isEmpty()) {
                        logger.warn("Skipping row due to empty fields: " + String.join(", ", record));
                        continue; // Skip rows with empty fields
                    }

                    FacultyList facultyList;
                    Optional<FacultyList> existingFaculty = facultyListRepository.findById(id);
                    if (existingFaculty.isPresent()) {
                        // Update existing entry
                        facultyList = existingFaculty.get();
                    } else {
                        // Create new entry
                        facultyList = new FacultyList();
                        facultyList.setId(id);
                    }

                    facultyList.setName(name);
                    facultyList.setLoginid(loginid);
                    facultyList.setPassword(password);
                    facultyList.setGender(gender);
                    facultyList.setDob(dob);
                    facultyList.setMobileno(mobileno);

                    facultyListRepository.save(facultyList);
                    logger.info("Saved faculty: " + facultyList);

                } catch (NumberFormatException e) {
                    logger.error("Skipping row due to NumberFormatException: " + String.join(", ", record), e);
                } catch (Exception e) {
                    logger.error("Skipping row due to Exception: " + String.join(", ", record), e);
                }
            }
        } catch (IOException | CsvException e) {
            logger.error("Error reading CSV file", e);
        }
    }
}
