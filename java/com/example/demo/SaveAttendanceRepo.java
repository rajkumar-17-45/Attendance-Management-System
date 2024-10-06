package com.example.demo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface SaveAttendanceRepo extends JpaRepository<SaveAttendanceDTO,Long>{
	  List<SaveAttendanceDTO> findByFacultyId(int facultyId);
}
