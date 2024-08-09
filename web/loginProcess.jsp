<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password"); // Ensure you handle this securely

    String url = "jdbc:mysql://localhost:3306/UserManagement";
    String dbUser = "root"; // Replace with your DB username
    String dbPass = "root"; // Replace with your DB password

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPass);

        // Check admin credentials
        String adminQuery = "SELECT * FROM admin WHERE username = ? AND password = ?";
        ps = conn.prepareStatement(adminQuery);
        ps.setString(1, username);
        ps.setString(2, password);
        rs = ps.executeQuery();

        if (rs.next()) {
            // Admin credentials match
            response.sendRedirect("Registration.jsp");
        } else {
            // Check user credentials using username as email
            String userQuery = "SELECT * FROM users WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(userQuery);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                // User credentials match
                response.sendRedirect("login.jsp");
            } else {
                // No matching credentials
                response.sendRedirect("index.jsp");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
