package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Component
@Entity
public class FacultyList {

    @Id
	private int id;
    private String name;
    private String loginid;
   private String password;
   private String gender;
   private String dob;
   private String mobileno;
public FacultyList() {
	super();
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getLoginid() {
	return loginid;
}
public void setLoginid(String loginid) {
	this.loginid = loginid;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getGender() {
	return gender;
}
public void setGender(String gender) {
	this.gender = gender;
}
public String getDob() {
	return dob;
}
public void setDob(String dob) {
	this.dob = dob;
}
public String getMobileno() {
	return mobileno;
}
public void setMobileno(String mobileno) {
	this.mobileno = mobileno;
}
@Override
public String toString() {
	return "FacultyList [id=" + id + ", name=" + name + ", loginid=" + loginid + ", password=" + password + ", gender="
			+ gender + ", dob=" + dob + ", mobileno=" + mobileno + "]";
}
	


}
