package com.example.demo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AssignFacultyRepo extends JpaRepository<AssignFaculty,Long> {

    @Query("SELECT af FROM AssignFaculty af WHERE af.facultyName = :facultyName")
    List<AssignFaculty> findByFacultyName(@Param("facultyName") String facultyName);

	List<AssignFaculty> findBySubjectName(String subject);

	
}
