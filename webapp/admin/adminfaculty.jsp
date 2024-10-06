<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="com.example.demo.FacultyList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>College Website</title>
    <link href="https://fonts.googleapis.com/css2?family=Martian+Mono:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
        <div class="details" id="faculty-section">
            <div class="options" id="faculty-dis">
                <div class="faculty">
                    <i class="fas fa-user-tie" id="faculty-icon"></i>
                </div>
                <div class="faculty-list-but">
                    <button id="display-faculty-table">Faculty List</button>
                </div>
                <div class="add-faculty-but">
                    <button id="display-add-faculty">
                        <i class="fas fa-plus" id="plus"></i> Add Faculty
                    </button>
                </div>
                     <div class="add-faculty-but delete-multiple">
                   <button type="button" class="delete-btn delete-multiple">
    <i class="fas fa-trash-alt" id="trash"></i> Delete Multiple
     </button>
                   
                </div>
                <div class="filter">
                    <label for="filterByName">Filter </label>
                    <input type="text" id="filterByName" placeholder="Enter faculty name">
                </div>
            </div>

            <div id="faculty-content" class="scroll-stop">
                <h3>Faculty List</h3>
                <form id="faculty-form" method="POST" data-save-url="/save-faculty" data-delete-url="/delete-faculty">
                    <input type="hidden" name="action" id="form-action" value="">
                    <table>
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="select-all" class="select-check"></th>
                                <th>S.No</th>
                                <th>Name</th>
                                <th>Login</th>
                                <th>Mobile</th>
                                <th>Date</th>
                                <th>Gender</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<FacultyList> facultyList = (List<FacultyList>) session.getAttribute("facultytable");
                                if (facultyList != null) {
                                    int count = 1;
                                    for (FacultyList faculty : facultyList) {
                            %>
                            <tr>
                                <td><input type="checkbox" class="select-checkbox"></td>
              <td><input type="text" name="id" class="sno-input" value="<%= faculty.getId() %>" readonly style="text-align: center;"></td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= faculty.getName() %></div>
                                    <input type="hidden" name="name" class="multiline-input" value="<%= faculty.getName() %>">
                                </td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= faculty.getLoginid() %></div>
                                    <input type="hidden" name="loginid" class="multiline-input" value="<%= faculty.getLoginid() %>">
                                </td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= faculty.getMobileno() %></div>
                                    <input type="hidden" name="mobileno" class="multiline-input" value="<%= faculty.getMobileno() %>">
                                </td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= faculty.getDob() %></div>
                                    <input type="hidden" name="dob" class="multiline-input" value="<%= faculty.getDob() %>">
                                </td>
                                <td>
                                    <div class="multiline-display" contenteditable="false"><%= faculty.getGender() %></div>
                                    <input type="hidden" name="gender" class="multiline-input" value="<%= faculty.getGender() %>">
                                </td>
                                <td>
                                    <button type="button" class="edit-btn">Edit</button>
                                    <button type="button" class="save-btn" style="display:none;">Save</button>
                                    <button type="button" class="delete-btn">Delete</button>
                                </td>
                            </tr>
                            <%      }
                                }
                            %>
                        </tbody>
                    </table>
                </form>
            </div>

            <div class="add-faculty" id="add-faculty" style="display: none;">
                <h3>Add Faculty</h3>
                <form action="addfaculty">
                    <label for="id">Id</label>
                    <input type="number" id="id" name="id" required>

                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>

                    <label for="login-id">Login ID:</label>
                    <input type="text" id="login-id" name="loginid" required>

                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>

                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" required>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>

                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" required>

                    <label for="mobile">Mobile No:</label>
                    <input type="text" id="mobile" name="mobileno" required>

                    <button type="submit">Save</button>
                    <button type="reset">Reset</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>


document.addEventListener('DOMContentLoaded', function() {
    const displayFacultyButton = document.getElementById('display-faculty-table');
    const displayAddFacultyButton = document.getElementById('display-add-faculty');
    const facultyContent = document.getElementById('faculty-content');
    const addFacultyForm = document.getElementById('add-faculty');

    displayFacultyButton.addEventListener('click', function() {
        facultyContent.style.display = 'block'; // Show the faculty content table
        addFacultyForm.style.display = 'none'; // Hide the add faculty form
    });

    displayAddFacultyButton.addEventListener('click', function() {
        addFacultyForm.style.display = 'block'; // Show the add faculty form
        facultyContent.style.display = 'none'; // Hide the faculty content table
    });

    // Optional: Add logic to handle hiding the form on reset or cancel
    const closeButton = addFacultyForm.querySelector('button[type="reset"]');
    closeButton.addEventListener('click', function() {
        addFacultyForm.style.display = 'none'; // Hide the add faculty form on reset
    });
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
 
document.addEventListener('DOMContentLoaded', function() {
    const filterInput = document.getElementById('filterByName');
    const facultyRows = document.querySelectorAll('#faculty-content tbody tr');

    filterInput.addEventListener('input', function() {
        const filterValue = filterInput.value.toLowerCase().trim();

        facultyRows.forEach(row => {
            const facultyName = row.querySelector('td:nth-child(3)').textContent.toLowerCase();

            if (facultyName.includes(filterValue)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
});

document.addEventListener('click', function(event) {
    if (event.target.classList.contains('delete-multiple')) {
        const selectedCheckboxes = document.querySelectorAll('.select-checkbox:checked');
        if (selectedCheckboxes.length > 0) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/delete-multiple-faculty'; 

            selectedCheckboxes.forEach(checkbox => {
                const row = checkbox.closest('tr');
                const facultyId = row.querySelector('.sno-input').value;

                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'ids'; 
                input.value = facultyId;
                form.appendChild(input);
            });

            document.body.appendChild(form);
            form.submit();
        } else {
            alert('Please select at least one faculty member to delete.');
        }
    }
});
function updateTime() {
    const now = new Date();
    const date = now.toLocaleDateString();
    const time = now.toLocaleTimeString();
    document.getElementById('current-date').innerText = date;
    document.getElementById('current-time').innerText = time;
}
setInterval(updateTime, 1000);
updateTime();
</script>
</body>
</html>
