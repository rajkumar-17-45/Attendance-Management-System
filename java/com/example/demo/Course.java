package com.example.demo;

import org.springframework.stereotype.Component;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Component
@Entity
public class Course {
	@Id
          private String id;
          private String coursename;
          private String coursedescription;
		public Course() {
			super();
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getCoursename() {
			return coursename;
		}
		public void setCoursename(String coursename) {
			this.coursename = coursename;
		}
		public String getCoursedescription() {
			return coursedescription;
		}
		public void setCoursedescription(String coursedescription) {
			this.coursedescription = coursedescription;
		}
		@Override
		public String toString() {
			return "Course [id=" + id + ", coursename=" + coursename + ", coursedescription=" + coursedescription + "]";
		}
          
          
}
