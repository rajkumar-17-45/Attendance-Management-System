package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.reactive.result.view.RedirectView;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AddFacultyController {

	@Autowired
	private FacultyList facultylist;
	@Autowired
	private FacultyListRepo facultylistrepo;
	@Autowired
	private Course course;
	@Autowired
	private CourselistRepo courselistrepo;
   @RequestMapping("addfaculty")
   public ModelAndView addfaculty (@ModelAttribute FacultyList facultylist)
   {

	   facultylistrepo.save(facultylist);
	      return new ModelAndView("redirect:/enter");
   }
   @RequestMapping("/delete-faculty")
   public ModelAndView deletefaculty(@ModelAttribute FacultyList facultylist)
   {
	   System.out.println(facultylist);
	       facultylistrepo.delete(facultylist);
	       return new ModelAndView("redirect:/enter");
   }
   @RequestMapping("/save-faculty")
   public ModelAndView editfaculty(@ModelAttribute FacultyList facultylist)
   {
	   
       // Find the existing faculty record by ID
	   System.out.println("you can do that");
	   System.out.println(facultylist.toString());
	   System.out.println(facultylist.getLoginid());
	   System.out.println(facultylist.getDob());
       FacultyList existingFaculty = facultylistrepo.findById(facultylist.getId()).orElse(null);
       if (existingFaculty != null) {
           // Update the existing faculty record with new values
           existingFaculty.setName(facultylist.getName());
           existingFaculty.setLoginid(facultylist.getLoginid());
           existingFaculty.setMobileno(facultylist.getMobileno());
           existingFaculty.setDob(facultylist.getDob());
           existingFaculty.setGender(facultylist.getGender());
           facultylistrepo.save(existingFaculty);
       }
         
       
       return new ModelAndView("redirect:/enter");
   }
   @RequestMapping("/delete-multiple-faculty")
   public ModelAndView deleteMultipleFaculty(@RequestParam("ids") List<Integer> ids) {
       for (int id : ids) {
           // Delete each faculty record by its ID
           facultylistrepo.deleteById(id);
       }
       return new ModelAndView("redirect:/enter");
   }
   
}
