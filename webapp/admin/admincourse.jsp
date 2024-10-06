<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.example.demo.Course" %>
<%@ page import="java.io.*" %>

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
            <div href="#" class="pages" id="faculty-details" onclick="location.href='/admin/adminfaculty.jsp'">Faculty</div>
            <div href="#" class="pages" id="student-details" onclick="location.href='/admin/adminstudent.jsp'">Student</div>
            <div href="#" class="pages" id="course-details" onclick="location.href='/admin/admincourse.jsp'">Course</div>
            <div href="#" class="pages" id="subject-details" onclick="location.href='/admin/adminsubject.jsp'">Subject</div>
            <div href="#" class="pages" id="assign-faculty-details" onclick="location.href='/admin/adminassign.jsp'">Assign Faculty</div>
            <div class="pages" id="assign-faculty-details" onclick="location.href='/admin/upload.jsp'">Upload</div>
        </div>

        <div id="content">
            <div class="details" id="course-section">
                <div class="options" id="course-dis">
                    <div class="course">
                        <i class="fas fa-graduation-cap" id="course-icon"></i>
                    </div>
                    <div class="course-list-but">
                        <button id="display-course-table">Course List</button>
                    </div>
                    <div class="add-course-but">
                        <button id="display-add-course">
                            <i class="fas fa-plus" id="plus"></i>
                        </button>
                    </div>
                 <div class="add-faculty-but">
                   <button type="button" class="delete-btn delete-multiple">
                     <i class="fas fa-trash-alt" id="trash"></i> Delete Multiple
                   </button>
                   
                </div>
                </div>
                <div id="course-content" class="scroll-stop">
                    <h3>Course List</h3>
                       <div class="filter-by-course">
                        <label for="filter-course">Filter by Course Name:</label>
                        <input type="text" id="filter-course" class="filter-input" placeholder="Enter course name" class="ipt">
                    </div>
                    <div class="filter-by-course-id">
                        <label for="filter-course-id">Filter by Course ID:</label>
                        <input type="text" id="filter-course-id" class="filter-input" placeholder="Enter course ID" class="ipt">
                    </div>
                    <form id="course-form" method="POST" data-save-url="/save-course" data-delete-url="/delete-course">
                        <input type="hidden" name="action" id="course-form-action" value="">
                        <table>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="select-all-course" class="select-check"></th>
                                    <th>S.No</th>
                                    <th>Course Name</th>
                                    <th>Description</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% Iterable<Course> courses = (Iterable<Course>) session.getAttribute("coursetable");
                                if (courses != null) {
                                    int count = 1;
                                    for (Course course : courses) { %>
                                <tr>
                                    <td><input type="checkbox" class="select-checkbox"></td>
                                    <td><input type="text" name="id" class="sno-input" value="<%= course.getId() %>" readonly style="text-align: center;"></td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= course.getCoursename() %></div>
                                        <input type="hidden" name="coursename" class="multiline-input" value="<%= course.getCoursename() %>">
                                    </td>
                                    <td>
                                        <div class="multiline-display" contenteditable="false"><%= course.getCoursedescription() %></div>
                                        <input type="hidden" name="coursedescription" class="multiline-input" value="<%= course.getCoursedescription() %>">
                                    </td>
                                    <td>
                                        <button type="button" class="edit-btn">Edit</button>
                                        <button type="button" class="delete-btn">Delete</button>
                                    </td>
                                </tr>
                                <% count++;
                                    }
                                } %>
                            </tbody>
                        </table>
                    </form>
                </div>

                <div class="add-course" id="add-course" style="display: none;">
                    <h3>Add Course</h3>
                    <form action="addcourse">
                        <label for="id">Course Id</label>
                        <input type="text" id="id" name="id" required>
                        <label for="course-name">Course Name:</label>
                        <input type="text" id="course-name" name="coursename" required>
                        <label for="description">Description:</label>
                        <textarea id="description" name="coursedescription" rows="4" required></textarea>
                        <br><br>
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
            const dateString = `${dayName}, ${day}/${month}/${year}`;
            document.getElementById('current-date').textContent = dateString;
        }

        setInterval(displayDateTime, 1000);
        displayDateTime();

        document.getElementById('display-add-course').addEventListener('click', function() {
            document.getElementById('course-content').style.display = 'none';
            document.getElementById('add-course').style.display = 'block';
        });

        document.getElementById('display-course-table').addEventListener('click', function() {
            document.getElementById('course-content').style.display = 'block';
            document.getElementById('add-course').style.display = 'none';
        });

        document.addEventListener('input', function(event) {
            if (event.target.classList.contains('filter-input')) {
                filterCourses();
            }
        });

        function filterCourses() {
            const filterCourse = document.getElementById('filter-course').value.toUpperCase();
            const filterCourseId = document.getElementById('filter-course-id').value.toUpperCase();
            const rows = document.querySelectorAll('#course-content tbody tr');

            rows.forEach(row => {
                const courseName = row.cells[2].querySelector('.multiline-display').textContent.toUpperCase();
                const courseId = row.cells[1].querySelector('.sno-input').value.toUpperCase();
                
                if ((courseName.includes(filterCourse) || filterCourse === '') && (courseId.includes(filterCourseId) || filterCourseId === '')) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Initial call to filterCourses to ensure initial state matches filter input
        filterCourses();
        

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
                    form.action = '/delete-multiple-course'; // Endpoint for multiple delete

                    selectedCheckboxes.forEach(checkbox => {
                        const row = checkbox.closest('tr');
                        const coursecode = row.querySelector('.sno-input').value;

                        const input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'ids'; // Use 'ids' as the parameter name
                        input.value =coursecode;
                        form.appendChild(input);
                    });

                    document.body.appendChild(form);
                    form.submit();
                } else {
                    alert('Please select at least one course  to delete.');
                }
            }
        });
    </script>
</body>
</html>
