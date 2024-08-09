<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*"%>
<%
    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String aadhar = request.getParameter("aadhar");

    // Generate a unique password
    String generatedPassword = UUID.randomUUID().toString().substring(0, 8);

    // Database connection settings
    String dbURL = "jdbc:mysql://localhost:3306/UserManagement";
    String dbUser = "root";
    String dbPass = "root"; // Replace with your database password

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Insert user data into the Users table
        String sql = "INSERT INTO users (name, email, phone_number, password, aadhar_number) VALUES (?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, phone);
        stmt.setString(4, generatedPassword);
        stmt.setString(5, aadhar);
        stmt.executeUpdate();

        // Close connection
        stmt.close();
        conn.close();
%>

<%-- Display success message and redirect --%>
<html>
<head>
    <meta http-equiv="refresh" content="3;url=index.jsp">
</head>
<body>
    <h2>Registration Successful!</h2>
    <p>You will be redirected to the login page in 3 seconds.</p>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
%>

<%-- Display error message --%>
<html>
<body>
    <h2>Registration Failed!</h2>
</body>
</html>

<%
    } finally {
        // Close resources in the finally block
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
