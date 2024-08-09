<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
    <link rel="stylesheet" href="style.css"/>
</head>
<body>
    <div class="container">
        <%
            String action = request.getParameter("action");
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dataentry", "root", "root");
                st = con.createStatement();
                response.setContentType("text/html;charset=UTF-8");

                if ("showData".equals(action)) {
                    rs = st.executeQuery("SELECT * FROM admin ORDER BY id ASC");
        %>
        <form id="updateForm" action="admin.jsp" method="post">
            <div class="student-form" id="studentForm">
                <% while (rs.next()) { %>
                <div class="field-form">
                    <input type="hidden" name="id<%= rs.getInt("id") %>" value="<%= rs.getInt("id") %>">
                    <input type="text" name="Name<%= rs.getInt("id") %>" value="<%= rs.getString("name") %>" placeholder="Enter data" class="dynamic-input" required>
                    <button type="submit" name="action" value="deleteData<%= rs.getInt("id") %>" class="deleteData">Delete</button>
                </div>
                <% } %>
            </div>
            <div class="field-form button">
                <button type="submit" id="updateButton" class="add" name="action" value="updateData">Update Data</button>
                <button type="submit" name="action" value="redirectToLogin" class="add">Redirect to Login</button>
            </div>
        </form>
        <% 
                } else if ("showUserData".equals(action)) {
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/usermanagement", "root", "root");
                    st = con.createStatement();
                    rs = st.executeQuery("SELECT * FROM users ORDER BY id ASC");
        %>
        <div class="user-data" style="display: flex; justify-content: center;">
            <table border="1">
                <thead>
                    <tr>
                        <th style="padding: 5px;">Name</th>
                        <th style="padding: 5px;">Email</th>
                        <th style="padding: 5px;">Phone Number</th>
                        <th style="padding: 5px;">Password</th>
                        <th style="padding: 5px;">Aadhar Number</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                    <tr>
                       
                        <td style="padding: 5px;"><%= rs.getString("name") %></td>
                        <td style="padding: 5px;"><%= rs.getString("email") %></td>
                        <td style="padding: 5px;"><%= rs.getString("phone_number") %></td>
                        <td style="padding: 5px;"><%= rs.getString("password") %></td>
                        <td style="padding: 5px;"><%= rs.getString("aadhar_number") %></td>
                   
            </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% 
                
                } else if ("insertData".equals(action)) {
                    // Fetch column names from the database
                    rs = st.executeQuery("SHOW COLUMNS FROM admin");
                    StringBuilder query = new StringBuilder("INSERT INTO admin (");
                    StringBuilder placeholders = new StringBuilder();
                    int paramCount = 0;
                    
                    while (rs.next()) {
                        String columnName = rs.getString("Field");
                        if (!"id".equals(columnName)) {  // Assuming 'id' is auto-incremented
                            if (paramCount > 0) {
                                query.append(", ");
                                placeholders.append(", ");
                            }
                            query.append(columnName);
                            placeholders.append("?");
                            paramCount++;
                        }
                    }
                    query.append(") VALUES (").append(placeholders).append(")");
                    
                    if (paramCount > 0) {
                        pstmt = con.prepareStatement(query.toString());

                        int index = 1;
                        for (int i = 1; request.getParameter("Name" + i) != null; i++) {
                            String name = request.getParameter("Name" + i);
                            if (name != null && !name.trim().isEmpty()) {
                                pstmt.setString(index++, name);
                            }
                        }

                        pstmt.executeUpdate();
                        response.sendRedirect("Registration.jsp");
                        return;
                    }
                } else if ("updateData".equals(action)) {
                    // Fetch column names from the database
                    rs = st.executeQuery("SHOW COLUMNS FROM admin");
                    while (rs.next()) {
                        String columnName = rs.getString("Field");
                        if (!"id".equals(columnName)) {
                            String newName = request.getParameter("Name" + columnName);
                            if (newName != null && !newName.trim().isEmpty()) {
                                String updateQuery = "UPDATE admin SET " + columnName + " = ? WHERE id = ?";
                                pstmt = con.prepareStatement(updateQuery);
                                pstmt.setString(1, newName);
                                pstmt.setInt(2, Integer.parseInt(request.getParameter("id" + columnName)));
                                pstmt.executeUpdate();
                            }
                        }
                    }
                    response.sendRedirect("Registration.jsp");
                    return;
                } else if (action.startsWith("deleteData")) {
                    int id = Integer.parseInt(action.substring("deleteData".length()));
                    String deleteQuery = "DELETE FROM admin WHERE id = ?";
                    pstmt = con.prepareStatement(deleteQuery);
                    pstmt.setInt(1, id);
                    pstmt.executeUpdate();

                    // Delete the corresponding column from data_entries table
                    String columnName = request.getParameter("Name" + id);
                    String alterTableQuery = "ALTER TABLE data_entries DROP COLUMN " + columnName;
                    st.executeUpdate(alterTableQuery);

                    response.sendRedirect("Registration.jsp");
                    return;
                } else if ("redirectToLogin".equals(action)) {
                    response.sendRedirect("login.jsp?" + request.getQueryString());
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (st != null) st.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
