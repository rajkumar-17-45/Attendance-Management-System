<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.Subject" %>
<%@ page import="com.example.demo.Course" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>College Website</title>
    <link href="https://fonts.googleapis.com/css2?family=Martian+Mono:wght@300&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="/admin/admincss.css" >
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

        <div id="content">
            <div class="details" id="subject-section">
                <div class="options" id="subject-dis">
                    <div class="subject">
                        <i class="fas fa-book" id="subject-icon"></i>
                    </div>
                    <div class="subject-list-but">
                        <button id="display-subject-table">Subject List</button>
                    </div>
                    <div class="add-subject-but">
                        <button id="display-add-subject">
                            <i class="fas fa-plus" id="plus"></i> Add Subject
                        </button>
                    </div>
                     <div class="add-subject-but">
                   <button type="button" class="delete-btn delete-multiple">
                     <i class="fas fa-trash-alt" id="trash"></i> Delete Multiple
                   </button>
                   
                </div>
                  
                </div>
                <div id="subject-content" class="scroll-stop">
                    <h3>Subject List</h3>
                      <div class="filter-by-subject">
                        <label for="filter-course">Filter by Course Name:</label>
                        <input type="text" id="filter-course" class="filter-input" placeholder="Enter course name">
                    </div>
                    <div class="filter-by-semester">
                        <label for="filter-semester">Filter by Semester:</label>
                        <input type="text" id="filter-semester" class="filter-input" placeholder="Enter semester">
                    </div>
                    <div class="filter-by-subject-name">
                        <label for="filter-subject-name">Filter by Subject Name:</label>
                        <input type="text" id="filter-subject-name" class="filter-input" placeholder="Enter subject name">
                    </div>
                    <form id="subject-form" method="POST" data-save-url="/save-subject" data-delete-url="/delete-subject">
                        <input type="hidden" name="action" id="subject-form-action" value="">
                        <table>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="select-all-subjects" class="select-check"></th>
                                    <th>S.No</th>
                                    <th>Course Name</th>
                                    <th>Semester</th>
                                    <th>Subject</th>
                                    <th>Description</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    Iterable<Subject> subjects = (Iterable<Subject>) session.getAttribute("subjecttable");
                                    if (subjects != null) {
                                        int sno = 1;
                                        for (Subject subject : subjects) { 
                                %>
                                <tr data-subject-code="<%= subject.getSubjectCode() %>">
                                    <td><input type="checkbox" class="select-checkbox"></td>
                        <td><input type="text" name="subjectCode" class="sno-input" value="<%= subject.getSubjectCode() %>" readonly style="text-align: center;"></td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= subject.getCourseName() %></div>
                                        <input type="hidden" name="courseName" class="multiline-input" value="<%= subject.getCourseName() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= subject.getSemester() %></div>
                                        <input type="hidden" name="semester" class="multiline-input" value="<%= subject.getSemester() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= subject.getName() %></div>
                                        <input type="hidden" name="name" class="multiline-input" value="<%= subject.getName() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= subject.getDescription() %></div>
                                        <input type="hidden" name="description" class="multiline-input" value="<%= subject.getDescription() %>">
                                    </td>
                                    <td>
                                        <button type="button" class="edit-btn">Edit</button>
                                        <button type="button" class="delete-btn">Delete</button>
                                    </td>
                                </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="7">No subjects found</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </form>
                </div>

                <div class="add-subject" id="add-subject" style="display: none;">
                    <h3>Add Subject</h3>
                    <form action="addsubject" method="post">
                        <label for="subject-code">Subject Code:</label>
                        <input type="text" id="subject-code" name="subjectCode" required>
                        
                        <label for="course-name">Course Name:</label>
                        <select id="course-name" name="courseName" required>
                            <%
                                Iterable<Course> crs= (Iterable<Course>) session.getAttribute("coursetable");
                                if (crs != null) {
                                    for (Course course : crs) {
                            %>
                            <option value="<%= course.getCoursename() %>"><%= course.getCoursename() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>

                        <label for="semester">Semester:</label>
                        <select id="semester" name="semester" required>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                        </select>

                        <label for="subject-name">Name:</label>
                        <input type="text" id="name" name="name" required>

                        <label for="description">Description:</label>
                        <textarea id="description" name="description" required></textarea>
                        
                        <br><br><br>
                        <button type="submit">Save</button>
                        <button type="reset">Reset</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
    function displayDateTime() {
        const now = new Date();

        let hours = now.getHours();
        const minutes = now.getMinutes().toString().padStart(2, '0');
        const seconds = now.getSeconds().toString().padStart(2, '0');
        const ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12;
        const timeString = `${hours.toString().padStart(2, '0')}:${minutes}:${seconds} ${ampm}`;
        document.getElementById('current-time').textContent = timeString;

        const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        const dayName = days[now.getDay()];
        const day = now.getDate().toString().padStart(2, '0');
        const month = (now.getMonth() + 1).toString().padStart(2, '0');
        const year = now.getFullYear();
        const dateString = `${dayName}, ${day}-${month}-${year}`;
        document.getElementById('current-date').textContent = dateString;
    }

    document.addEventListener('DOMContentLoaded', () => {
        displayDateTime();
        setInterval(displayDateTime, 1000);

        document.getElementById('display-subject-table').addEventListener('click', () => {
            document.getElementById('subject-content').style.display = 'block';
            document.getElementById('add-subject').style.display = 'none';
        });

        document.getElementById('display-add-subject').addEventListener('click', () => {
            document.getElementById('subject-content').style.display = 'none';
            document.getElementById('add-subject').style.display = 'block';
        });

        // Filter function
        document.querySelectorAll('.filter-input').forEach(input => {
            input.addEventListener('input', () => {
                filterSubjects();
            });
        });

        function filterSubjects() {
            const filterCourse = document.getElementById('filter-course').value.toUpperCase();
            const filterSemester = document.getElementById('filter-semester').value.toUpperCase();
            const filterSubjectName = document.getElementById('filter-subject-name').value.toUpperCase();
            
            const rows = document.querySelectorAll('#subject-content table tbody tr');
            rows.forEach(row => {
                const courseName = row.querySelector('td:nth-child(3)').innerText.toUpperCase();
                const semester = row.querySelector('td:nth-child(4)').innerText.toUpperCase();
                const subjectName = row.querySelector('td:nth-child(5)').innerText.toUpperCase();

                if (courseName.includes(filterCourse) && semester.includes(filterSemester) && subjectName.includes(filterSubjectName)) {
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
                form.action = '/delete-multiple-subject'; // Endpoint for multiple delete

                selectedCheckboxes.forEach(checkbox => {
                    const row = checkbox.closest('tr');
                    const subjectcode = row.querySelector('.sno-input').value;

                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'subjectids'; // Use 'ids' as the parameter name
                    input.value =subjectcode;
                    form.appendChild(input);
                });

                document.body.appendChild(form);
                form.submit();
            } else {
                alert('Please select at least one subject  to delete.');
            }
        }
    });
    </script>
</body>
</html>
