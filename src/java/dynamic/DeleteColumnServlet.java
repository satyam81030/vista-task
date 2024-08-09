package dynamic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;


@WebServlet("/DeleteColumnServlet")
public class DeleteColumnServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String columnName = request.getParameter("columnName");
        
        Connection con = null;
        Statement st = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dataentry", "root", "root");
            st = con.createStatement();
            
            // Alter table to drop the selected column
            String sqlAdmin = "ALTER TABLE admin DROP COLUMN " + columnName;
            st.executeUpdate(sqlAdmin);
            
            // Alter data_entries table to drop the same column
            String sqlDataEntries = "ALTER TABLE data_entries DROP COLUMN " + columnName;
            st.executeUpdate(sqlDataEntries);
            
            response.sendRedirect("Registration.jsp?action=showData");
        } catch (IOException | ClassNotFoundException | SQLException e) {
        } finally {
            try {
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
            }
        }
    }
}
