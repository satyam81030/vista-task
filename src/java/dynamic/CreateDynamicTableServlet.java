package dynamic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/createDynamicTable")
public class CreateDynamicTableServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dataentry", "root", "root");
            st = con.createStatement();

            // Fetch column names from the admin table
            String query = "SELECT name FROM admin ORDER BY id ASC";
            rs = st.executeQuery(query);

            // Alter the dynamic_userdata table to add columns
            StringBuilder alterTableQuery = new StringBuilder("ALTER TABLE dynamic_userdata ");
            boolean first = true;

            while (rs.next()) {
                if (!first) {
                    alterTableQuery.append(", ");
                }
                first = false;

                String columnName = rs.getString("name");
                alterTableQuery.append("ADD COLUMN ").append(columnName).append(" VARCHAR(255)");
            }

            st.executeUpdate(alterTableQuery.toString());
            response.getWriter().println("Dynamic table altered successfully!");

        } catch (IOException | ClassNotFoundException | SQLException e) {
            response.getWriter().println("Error creating dynamic table: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                // Handle closing exceptions

            }
        }
    }
}
