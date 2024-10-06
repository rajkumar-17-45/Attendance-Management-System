<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@ page import="com.example.demo.FacultyList" %>
           <%@ page import="com.example.demo.Course" %>
                      <%@ page import="com.example.demo.Student" %>
                                           <%@ page import="com.example.demo.Subject" %>
                                           <%@ page import="com.example.demo.AssignFaculty" %>
                                           
        <%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>College Website</title>
    <link href="https://fonts.googleapis.com/css2?family=Martian+Mono:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="/admin/admincss.css">
    <style>
        /* Add your custom styles here */
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
    <div class="details" id="student-section">
        <div class="options" id="student-dis">
            <div class="student">
                <i class="fas fa-user-graduate" id="student-icon"></i>
            </div>
            <div class="student-list-but">
                <button id="display-student-table">Student List</button>
            </div>
            <div class="add-student-but">
                <button id="display-add-student">
                    <i class="fas fa-plus" id="plus"></i> Add Student
                </button>
            </div>
             <div class="add-faculty-but">
                   <button type="button" class="delete-btn delete-multiple">
    <i class="fas fa-trash-alt" id="trash"></i> Delete Multiple
     </button>
                   
                </div>
        </div>
        <div id="student-content" class="scroll-stop">
            <h3>Student List</h3>
            <div class="ic">
            <input type="text" id="filterByRollNo" placeholder="Filter by Roll No" class="ipt">
            <input type="text" id="filterByName" placeholder="Filter by Name" class="ipt">
            <input type="text" id="filterByCourseName" placeholder="Filter by Course Name" class="ipt">
            </div>
            <form id="student-form" method="POST" data-save-url="/save-student" data-delete-url="/delete-student">
                <input type="hidden" name="action" id="student-form-action" value="">
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="select-all-student" class="select-check"></th>
                            <th>Roll no</th>
                            <th>Course Name</th>
                            <th>Semester</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>DOB</th>
                            <th>Gender</th>
                            <th>Mobile No</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% Iterable<Student> studentList = (Iterable<Student>) session.getAttribute("studenttable");
                        if (studentList != null) {
                            for (Student student : studentList) { %>
                                <tr>
                                    <td><input type="checkbox" class="select-checkbox"></td>
                                    <td><input type="text" name="rollno" class="sno-input" value="<%= student.getRollno() %>" readonly></td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= student.getCoursename() %> </div>
                                        <input type="hidden" name="coursename" class="multiline-input" value="<%= student.getCoursename() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= student.getSemester() %> </div>
                                        <input type="hidden" name="semester" class="multiline-input" value="<%= student.getSemester() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= student.getName() %></div>
                                        <input type="hidden" name="name" class="multiline-input" value="<%= student.getName() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= student.getEmail() %></div>
                                        <input type="hidden" name="email" class="multiline-input" value="<%= student.getEmail() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= student.getDob() %> </div>
                                        <input type="hidden" name="dob" class="multiline-input" value="<%= student.getDob() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= student.getGender() %></div>
                                        <input type="hidden" name="gender" class="multiline-input" value="<%= student.getGender() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= student.getMobileno() %></div>
                                        <input type="hidden" name="mobileno" class="multiline-input" value="<%= student.getMobileno() %>">
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

        <div class="add-student" id="add-student" style="display: none;">
            <h3>Add Student</h3>
            <form action="addstudent">
                <label for="roll-no">Roll No:</label>
                <input type="text" id="rollno" name="rollno" required>

                <label for="coursename">Course Name:</label>
                <select id="coursename" name="coursename" required>
                    <% Iterable<Course> courseList = (Iterable<Course>) session.getAttribute("coursetable");
                    if (courseList != null) {
                        for (Course course : courseList) {
                    %>
                    <option value="<%= course.getCoursename() %>"><%= course.getCoursename() %></option>
                    <% }
                    } %>
                </select>

                <label for="semester">Semester:</label>
                <input type="number" id="semester" name="semester" required>

                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>

                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>

                <label for="mobileno">Mobile No:</label>
                <input type="text" id="mobileno" name="mobileno" required>

                <button type="submit">Save</button>
                <button type="reset">Reset</button>
            </form>
        </div>
    </div>
</div>

<script>

document.addEventListener('DOMContentLoaded', function() {
    const displayStudentTableButton = document.getElementById('display-student-table');
    const addStudentButton = document.getElementById('display-add-student');
    const studentListSection = document.getElementById('student-content');
    const addStudentSection = document.getElementById('add-student');

    addStudentButton.addEventListener('click', function() {
        studentListSection.style.display = 'none';
        addStudentSection.style.display = 'block';
    });

    displayStudentTableButton.addEventListener('click', function() {
        addStudentSection.style.display = 'none';
        studentListSection.style.display = 'block';
    });

    // Other existing code for filtering and editing goes here...
});
    document.addEventListener('DOMContentLoaded', function() {
        const filterByRollNo = document.getElementById('filterByRollNo');
        const filterByName = document.getElementById('filterByName');
        const filterByCourseName = document.getElementById('filterByCourseName');
        const rows = document.querySelectorAll('#student-content tbody tr');

        filterByRollNo.addEventListener('input', filterStudents);
        filterByName.addEventListener('input', filterStudents);
        filterByCourseName.addEventListener('input', filterStudents);

        function filterStudents() {
            const rollNoFilter = filterByRollNo.value.toLowerCase().trim();
            const nameFilter = filterByName.value.toLowerCase().trim();
            const courseNameFilter = filterByCourseName.value.toLowerCase().trim();

            rows.forEach(row => {
                const rollNo = row.querySelector('input[name="rollno"]').value.toLowerCase();
                const name = row.querySelector('input[name="name"]').value.toLowerCase();
                const courseName = row.querySelector('input[name="coursename"]').value.toLowerCase();

                if (rollNo.includes(rollNoFilter) && name.includes(nameFilter) && courseName.includes(courseNameFilter)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
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
                form.action = '/delete-multiple-student'; // Endpoint for multiple delete

                selectedCheckboxes.forEach(checkbox => {
                    const row = checkbox.closest('tr');
                    const rollno = row.querySelector('.sno-input').value;

                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'ids'; // Use 'ids' as the parameter name
                    input.value = rollno;
                    form.appendChild(input);
                });

                document.body.appendChild(form);
                form.submit();
            } else {
                alert('Please select at least one stduent  to delete.');
            }
        }
    });
</script>

</body>
</html>
