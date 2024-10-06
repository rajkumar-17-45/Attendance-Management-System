package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class StudentUploadController {

    @Autowired
    private StudentService studentService;

    @PostMapping("/uploadStudent")
    public String uploadStudentCSVFile(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a CSV file to upload.");
            redirectAttributes.addFlashAttribute("isError", true);
        } else {
            studentService.saveCSV(file);
            redirectAttributes.addFlashAttribute("message", "Student file uploaded successfully!");
            redirectAttributes.addFlashAttribute("isError", false);
        }
        return "redirect:/admin/userhome.jsp";
    }
}
