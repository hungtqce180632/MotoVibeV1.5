<%-- 
    Document   : profile
    Created on : Feb 27, 2025, 1:28:21 AM
    Author     : truon
--%>

<%@page import="models.Customer"%>
<%@page import="models.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Profile</title>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <style>
            body {
                background: var(--rich-black);
                color: var(--text-gold);
            }

            .profile-container {
                background: var(--dark-black);
                border: 1px solid var(--secondary-gold);
                border-radius: 10px;
                padding: 2rem;
                margin: 2rem auto;
                max-width: 800px;
                box-shadow: 0 0 20px rgba(218, 165, 32, 0.2);
            }

            input[type="text"] {
                background: var(--rich-black);
                border: 1px solid var(--secondary-gold);
                color: var(--text-gold);
                padding: 8px;
                border-radius: 4px;
                margin: 5px 0;
            }

            .profile-heading {
                color: var(--primary-gold);
                border-bottom: 2px solid var(--secondary-gold);
                padding-bottom: 10px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <%
            Boolean isCustomer = (Boolean) request.getAttribute("isCustomer");
            Boolean isEmployee = (Boolean) request.getAttribute("isEmployee");
            Boolean isAdmin = (Boolean) request.getAttribute("isAdmin");
            Boolean customerNotFound = (Boolean) request.getAttribute("customerNotFound");
            Boolean employeeNotFound = (Boolean) request.getAttribute("employeeNotFound");

            if (isCustomer == null) isCustomer = false;
            if (isEmployee == null) isEmployee = false;
            if (isAdmin == null) isAdmin = false;
            if (customerNotFound == null) customerNotFound = false;
            if (employeeNotFound == null) employeeNotFound = false;
        %>

        <h1>User Profile</h1>

        <% if (customerNotFound) { %>
        <p style="color:red;">Customer profile not found in database.</p>
        <% } else if (employeeNotFound) { %>
        <p style="color:red;">Employee profile not found in database.</p>
        <% } %>

        <% if (isCustomer) {
            Customer customer = (Customer) request.getAttribute("customerProfile");
            if (customer != null) {
        %>
        <h3>Customer Profile</h3>
        <p><strong>Email:</strong> <%= customer.getEmail() %></p>
        <p><strong>Role:</strong> <%= customer.getRole() %></p>
        <p><strong>Status:</strong> <%= customer.isStatus() ? "Active" : "Inactive" %></p>

        <form action="profile" method="POST">
            <label>Name:</label>
            <input type="text" name="name" value="<%= customer.getName() %>"><br/>

            <label>Phone:</label>
            <input type="text" name="phone" value="<%= customer.getPhoneNumber() %>"><br/>

            <label>Address:</label>
            <input type="text" name="address" value="<%= customer.getAddress() %>"><br/>

            <input type="submit" value="Update Profile">
        </form>
        <%
            } else {
        %>
        <p>No customer profile data to display.</p>
        <%
            }
        } else if (isEmployee) {
            Employee emp = (Employee) request.getAttribute("employeeProfile");
            if (emp != null) {
        %>
        <h3>Employee Profile</h3>
        <p><strong>Email:</strong> <%= emp.getEmail() %></p>
        <p><strong>Role:</strong> <%= emp.getRole() %></p>
        <p><strong>Status:</strong> <%= emp.isStatus() ? "Active" : "Inactive" %></p>
        <p><strong>Name:</strong> <%= emp.getName() %></p>
        <p><strong>Phone:</strong> <%= emp.getPhoneNumber() %></p>
        <p><em>Employees cannot edit their own profile here.</em></p>
        <%
            } else {
        %>
        <p>No employee profile data found.</p>
        <%
            }
        } else if (isAdmin) {
        %>
        <h3>Admin Profile</h3>
        <p>Admins may not have a row in customers/employees. Customize as needed.</p>
        <%
        } else {
        %>
        <p>Unknown role or not logged in.</p>
        <%
} %>

    </body>
</html>