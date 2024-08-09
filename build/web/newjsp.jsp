<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String dbURL = "jdbc:mysql://localhost:3306/registration"; // Correct database URL
    String dbUser = "root";
    String dbPass = "root";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String role = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Validate user credentials
        String query = "SELECT password, role FROM users WHERE uniqueID = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, username);
        rs = ps.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("password");
            role = rs.getString("role");

            // Check if the provided password matches the stored hashed password
            if (BCrypt.checkpw(password, storedPassword)) {
                if (role.equals("admin")) {
                    response.sendRedirect("Registration.jsp");
                } else if (role.equals("user")) {
                    response.sendRedirect(".jsp");
                }
            } else {
                response.sendRedirect("index.jsp?error=invalid"); // Invalid credentials
            }
        } else {
            response.sendRedirect("index.jsp?error=notfound"); // User not found
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
