<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Data Display</title>
    <link rel="stylesheet" href="style.css"/>
    <style>
        .data-container {
            display: flex;
            flex-direction: column;
        }
        .data-row {
            display: flex;
        }
        .data-cell {
            padding: 5px;
            border: 1px solid #ddd;
            flex: 1;
        }
        .header {
            font-weight: bold;
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="containers">
        <%
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            ResultSetMetaData metaData = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dataentry", "root", "root");
                st = con.createStatement();
                response.setContentType("text/html;charset=UTF-8");

                // Call the stored procedure to drop columns with all NULL values
                st.execute("CALL drop_null_columns()");

                rs = st.executeQuery("SELECT * FROM data_entries");
                metaData = rs.getMetaData();

                // Fetch column names
                int columnCount = metaData.getColumnCount();
                List<String> columnNames = new ArrayList<>();
                for (int i = 1; i <= columnCount; i++) {
                    columnNames.add(metaData.getColumnName(i));
                }
        %>
        <div class="data-container">
            <div class="data-row header">
                <% for (String columnName : columnNames) { %>
                <div class="data-cell"><%= columnName %></div>
                <% } %>
            </div>
            <% while (rs.next()) { %>
            <div class="data-row">
                <% for (String columnName : columnNames) { %>
                <div class="data-cell"><%= rs.getObject(columnName) %></div>
                <% } %>
            </div>
            <% } %>
        </div>
        <%
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
