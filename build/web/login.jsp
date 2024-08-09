<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Entry Page</title>
        <link rel="stylesheet" href="style.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div class="container">
            <div class="title-form">
                <h1>DATA ENTRY</h1>
            </div>
            <form id="dataForm" method="post" action="submitData">

                <div class="student-form" id="studentForm">

                    <%
                        Connection con = null;
                        Statement st = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dataentry", "root", "root");
                            st = con.createStatement();

                            // Fetch column names from the database
                            String query = "SELECT name FROM admin ORDER BY id ASC";
                            rs = st.executeQuery(query);

                            while (rs.next()) {
                                String name = rs.getString("name");
                    %>

                    <div class="field-form" >
                        <input style="padding: inherit;" type="text" name="<%= name %>" placeholder="<%= name %>" required>
                    </div>

                    <%
                            }
                        } catch (ClassNotFoundException | SQLException e) {
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

                <div class="field-form button">
                    <div>
                        <button type="submit" id="submitButton" class="add">Submit</button>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
