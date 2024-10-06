<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.FacultyList" %>
<%@ page import="com.example.demo.Course" %>
<%@ page import="com.example.demo.Subject" %>
<%@ page import="com.example.demo.AssignFaculty" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>College Website</title>
    <link href="https://fonts.googleapis.com/css2?family=Martian+Mono:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/admin/admincss.css">
    <style>
        /* Additional styles */
    </style>
</head>
<body>

<div id="header">
    <div id="logo">
        <img src="https://storage.googleapis.com/ezap-prod/colleges/4549/karpagam-college-of-engineering-logo.jpg" alt="Karpagam College of Engineering Logo">
    </div>
    <div id="date-time">
        <div id="current-time"></div>
        <div id="current-date"></div>
    </div>
</div>

<div class="main">
    <div class="sidebar">
        <div class="pages">Home</div>
        <div class="pages" id="faculty-details" onclick="location.href='/admin/adminfaculty.jsp'">Faculty</div>
        <div class="pages" id="student-details" onclick="location.href='/admin/adminstudent.jsp'">Student</div>
        <div class="pages" id="course-details" onclick="location.href='/admin/admincourse.jsp'">Course</div>
        <div class="pages" id="subject-details" onclick="location.href='/admin/adminsubject.jsp'">Subject</div>
        <div class="pages" id="assign-faculty-details" onclick="location.href='/admin/adminassign.jsp'">Assign Faculty</div>
        <div class="pages" id="assign-faculty-details" onclick="location.href='/admin/upload.jsp'">Upload</div>
    </div>

    <div id="content">
        <div class="details" id="assign-faculty-section">
            <div class="options" id="assign-faculty-dis">
                <div class="assign-faculty">
                    <i class="fas fa-chalkboard-teacher" id="assign-faculty-icon"></i>
                </div>
                <div class="assign-faculty-list-but">
                    <button id="display-assign-faculty-table">Assign Faculty List</button>
                </div>
                <div class="add-assign-faculty-but">
                    <button id="display-add-assign-faculty" onclick="showAddAssignFacultyForm()">
                        <i class="fas fa-plus" id="plus"></i> Add Assign Faculty
                    </button>
                </div>
                <div class="add-subject-but">
                   <button type="button" class="delete-btn delete-multiple">
                     <i class="fas fa-trash-alt" id="trash"></i> Delete Multiple
                   </button>
                   
                </div>
            </div>
            <div id="assign-faculty-content" class="scroll-stop">
                <h3>Assign Faculty List</h3>
                <div class="filter-options">
                    <label for="filter-faculty-name">Faculty Name:</label>
                    <input type="text" id="filter-faculty-name" placeholder="Filter by Faculty Name">
                    
                    <label for="filter-course-name">Course Name:</label>
                    <input type="text" id="filter-course-name" placeholder="Filter by Course Name">
                    
                    <label for="filter-subject-name">Subject Name:</label>
                    <input type="text" id="filter-subject-name" placeholder="Filter by Subject Name">
                    
                    <label for="filter-semester">Semester:</label>
                    <input type="text" id="filter-semester" placeholder="Filter by Semester">
                </div>
                <form id="assign-faculty-form" method="POST" data-save-url="/save-assign-faculty" data-delete-url="/delete-assign-faculty">
                    <input type="hidden" name="action" id="assign-faculty-form-action" value="">
                    <table>
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="select-all-assign-faculty" class="select-check"></th>
                                <th>S.No</th>
                                <th>Faculty Name</th>
                                <th>Course Name</th>
                                <th>Subject Name</th>
                                <th>Semester</th>
                                <th>Total Classes</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="assign-faculty-table-body">
                            <% 
                            Iterable<AssignFaculty> assignFacultyList = (Iterable<AssignFaculty>) session.getAttribute("assignfacultytable");
                            Iterable<Subject> subject = (Iterable<Subject>) session.getAttribute("subjecttable");
                            if (assignFacultyList != null) {
                                int sno = 1;
                                for (AssignFaculty assignFaculty : assignFacultyList) { 
                  
                                    String semester = "";
                                    for (Subject subject1 : subject) {
                                        if (subject1.getName().equals(assignFaculty.getSubjectName())) {
                                            semester = subject1.getSemester();
                                            break;
                                        }
                                    }
                            %>
                            <tr data-faculty-name="<%= assignFaculty.getFacultyName() %>" data-course-name="<%= assignFaculty.getCourseName() %>" data-subject-name="<%= assignFaculty.getSubjectName() %>" data-semester="<%= semester %>">
                                <td><input type="checkbox" class="select-checkbox"></td>
                                <td><input type="text" name="id"  class="sno-input" value="<%= assignFaculty.getId() %>" readonly style="text-align: center;"></td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= assignFaculty.getFacultyName() %></div>
                                    <input type="hidden" name="facultyName" class="multiline-input" value="<%= assignFaculty.getFacultyName() %>">
                                </td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= assignFaculty.getCourseName() %></div>
                                    <input type="hidden" name="courseName" class="multiline-input" value="<%= assignFaculty.getCourseName() %>">
                                </td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= assignFaculty.getSubjectName() %></div>
                                    <input type="hidden" name="subjectName" class="multiline-input" value="<%= assignFaculty.getSubjectName() %>">
                                </td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= semester %></div>
                                    <input type="hidden" name="semester" class="multiline-input" value="<%= semester %>">
                                </td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= assignFaculty.getTotalClasses() %></div>
                                    <input type="hidden" name="totalClasses" class="multiline-input" value="<%= assignFaculty.getTotalClasses() %>">
                                </td>
                                <td>
                                    <button type="button" class="edit-btn">Edit</button>
                                    <button type="button" class="delete-btn">Delete</button>
                                </td>
                            </tr>
                            <% }} %>
                        </tbody>
                    </table>
                </form>
            </div>

            <div class="add-assign-faculty" id="add-assign-faculty" style="display: none;">
                <h3>Add Assign Faculty</h3>
                <form action="add-assignfaculty" method="POST"> <!-- Ensure correct action and method -->

                    <!-- Faculty Name dropdown -->
                    <label for="faculty-name">Faculty Name:</label>
                    <select id="faculty-name" name="facultyName" required>
                        <% 
                        Iterable<FacultyList> fac = (Iterable<FacultyList>) session.getAttribute("facultytable");
                        if (fac != null) {
                            for (FacultyList faculty : fac) { %>
                                <option value="<%= faculty.getName() %>"><%= faculty.getName() %></option>
                            <% }
                        } %>
                    </select>

                    <!-- Course Name dropdown -->
                    <label for="course-name">Course Name:</label>
                    <select id="course-name" name="courseName" required>
                        <% 
                        Iterable<Course> course2 = (Iterable<Course>) session.getAttribute("coursetable");
                        if (course2 != null) {
                            for (Course course : course2) { %>
                                <option value="<%= course.getCoursename() %>"><%= course.getCoursename() %></option>
                            <% }
                        } %>
                    </select>

                    <!-- Subject Name dropdown -->
                    <label for="subject-name">Subject Name:</label>
                    <select id="subject-name" name="subjectName" required>
                        <% 
                        Iterable<Subject> subject2 = (Iterable<Subject>) session.getAttribute("subjecttable");
                        if (subject2 != null) {
                            for (Subject subject1 : subject2) { %>
                                <option value="<%= subject1.getName() %>"><%= subject1.getName() %></option>
                            <% }
                        } %>
                    </select>

                    <!-- Total Classes input -->
                    <label for="total-classes">Total Classes:</label>
                    <input type="number" id="total-classes" name="totalClasses" required>

                    <button type="submit" class="submit">Submit</button>
                </form>
            </div>

        </div>
    </div>
</div>

<footer id="footer">
    <div class="contact-info">
        <p><i class="fas fa-envelope"></i> info@karpagam.edu.in</p>
        <p><i class="fas fa-phone"></i> +91 422 647 1113</p>
    </div>
    <div class="social-media">
        <a href="#"><i class="fab fa-facebook-f"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
        <a href="#"><i class="fab fa-instagram"></i></a>
        <a href="#"><i class="fab fa-linkedin-in"></i></a>
    </div>
</footer>

<script>
    function showAddAssignFacultyForm() {
        document.getElementById("add-assign-faculty").style.display = "block";
        document.getElementById("assign-faculty-content").style.display = "none";
    }

    function showAssignFacultyList() {
        document.getElementById("add-assign-faculty").style.display = "none";
        document.getElementById("assign-faculty-content").style.display = "block";
    }

    document.getElementById("display-assign-faculty-table").addEventListener("click", showAssignFacultyList);
</script>

<script>
    // Function to update the current date and time
    function updateDateTime() {
        const now = new Date();
        const time = now.toLocaleTimeString();
        const date = now.toLocaleDateString();

        document.getElementById("current-time").textContent = time;
        document.getElementById("current-date").textContent = date;
    }

    // Update the date and time every second
    setInterval(updateDateTime, 1000);

    // Initialize the date and time on page load
    updateDateTime();
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const filterFacultyNameInput = document.getElementById("filter-faculty-name");
        const filterCourseNameInput = document.getElementById("filter-course-name");
        const filterSubjectNameInput = document.getElementById("filter-subject-name");
        const filterSemesterInput = document.getElementById("filter-semester");

        filterFacultyNameInput.addEventListener("input", filterTable);
        filterCourseNameInput.addEventListener("input", filterTable);
        filterSubjectNameInput.addEventListener("input", filterTable);
        filterSemesterInput.addEventListener("input", filterTable);

        function filterTable() {
            const facultyNameFilter = filterFacultyNameInput.value.toLowerCase();
            const courseNameFilter = filterCourseNameInput.value.toLowerCase();
            const subjectNameFilter = filterSubjectNameInput.value.toLowerCase();
            const semesterFilter = filterSemesterInput.value.toLowerCase();

            const rows = document.querySelectorAll("#assign-faculty-table-body tr");

            rows.forEach(row => {
                const facultyName = row.getAttribute("data-faculty-name").toLowerCase();
                const courseName = row.getAttribute("data-course-name").toLowerCase();
                const subjectName = row.getAttribute("data-subject-name").toLowerCase();
                const semester = row.getAttribute("data-semester").toLowerCase();

                const matchesFacultyName = facultyName.includes(facultyNameFilter);
                const matchesCourseName = courseName.includes(courseNameFilter);
                const matchesSubjectName = subjectName.includes(subjectNameFilter);
                const matchesSemester = semester.includes(semesterFilter);

                if (matchesFacultyName && matchesCourseName && matchesSubjectName && matchesSemester) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    });

    document.addEventListener('click', function(event) {
        if (event.target.classList.contains('edit-btn')) {
            const row = event.target.closest('tr');
            const form = row.closest('form');
            const formAction = form.getAttribute('data-save-url');
            const divs = row.querySelectorAll('.multiline-display');
            const checkbox = row.querySelector('.select-checkbox');

            divs.forEach(div => {
                div.contentEditable = true;
                div.style.border = '1px solid black';
                div.style.borderRadius = '10px';
            });

            checkbox.checked = true;

            event.target.textContent = 'Save';
            event.target.classList.remove('edit-btn');
            event.target.classList.add('save-btn');
            event.target.dataset.originalText = 'Edit';
            event.target.type = 'button';  // Change button type to prevent form submission on click
        } else if (event.target.classList.contains('save-btn')) {
            const row = event.target.closest('tr');
            const form = row.closest('form');
            const formAction = form.getAttribute('data-save-url');
            const divs = row.querySelectorAll('.multiline-display');
            const inputs = row.querySelectorAll('.multiline-input');

            divs.forEach((div, index) => {
                div.contentEditable = false;
                div.style.border = '1px solid #ccc';
                inputs[index].value = div.textContent.trim();
            });

            const clonedRow = row.cloneNode(true);
            clonedRow.querySelectorAll('.edit-btn').forEach(btn => {
                btn.textContent = 'Edit';
                btn.classList.remove('save-btn');
                btn.classList.add('edit-btn');
                btn.type = 'button';  // Change button type to prevent form submission on click
            });

            const formClone = document.createElement('form');
            formClone.method = 'POST';
            formClone.action = formAction;

            clonedRow.querySelectorAll('.multiline-input, .sno-input').forEach(input => {
                const clonedInput = input.cloneNode(true);
                formClone.appendChild(clonedInput);
            });

            document.body.appendChild(formClone);
            formClone.submit();
        } else if (event.target.classList.contains('delete-btn')) {
            const row = event.target.closest('tr');
            const form = row.closest('form');
            const formAction = form.getAttribute('data-delete-url');

            const formDelete = document.createElement('form');
            formDelete.method = 'POST';
            formDelete.action = formAction;

            row.querySelectorAll('.multiline-input, .sno-input').forEach(input => {
                const clonedInput = input.cloneNode(true);
                formDelete.appendChild(clonedInput);
            });

            document.body.appendChild(formDelete);
            formDelete.submit();
        }
    });

    document.addEventListener('keydown', function(event) {
        if (event.target.classList.contains('multiline-display') && event.key === 'Enter') {
            event.preventDefault();
            event.target.blur();
        }
    });
    
    
    document.addEventListener('click', function(event) {
        if (event.target.classList.contains('delete-multiple')) {
            const selectedCheckboxes = document.querySelectorAll('.select-checkbox:checked');
            if (selectedCheckboxes.length > 0) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/delete-multiple-afaculty'; // Endpoint for multiple delete

                selectedCheckboxes.forEach(checkbox => {
                    const row = checkbox.closest('tr');
                    const aids = row.querySelector('.sno-input').value;

                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'ids'; // Use 'ids' as the parameter name
                    input.value = aids;
                    form.appendChild(input);
                });

                document.body.appendChild(form);
                form.submit();
            } else {
                alert('Please select at least one row  to delete.');
            }
        }
    });
</script>
</body>
</html>
