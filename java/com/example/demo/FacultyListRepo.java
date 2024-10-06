package com.example.demo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface FacultyListRepo extends JpaRepository<FacultyList, Integer> {

    @Query("SELECT fl FROM FacultyList fl WHERE fl.loginid = :loginid AND fl.password = :password")
    FacultyList findByLoginidAndPassword(@Param("loginid") String loginid, @Param("password") String password);
}
