package storeData;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Enumeration;

@WebServlet("/submitData")
public class SubmitDataServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jdbcUrl = "jdbc:mysql://localhost:3306/dataentry";
        String jdbcUser = "root";
        String jdbcPassword = "root";

        try (Connection con = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword)) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Enumeration<String> parameterNames = request.getParameterNames();
            StringBuilder columnNames = new StringBuilder();
            StringBuilder valuesPlaceholders = new StringBuilder();

            while (parameterNames.hasMoreElements()) {
                String paramName = parameterNames.nextElement();

                // Add column if it does not exist
                String addColumnProcedure = "CALL add_column_if_not_exist(?, ?, ?)";
                try (PreparedStatement pst = con.prepareStatement(addColumnProcedure)) {
                    pst.setString(1, "data_entries"); // Table name
                    pst.setString(2, paramName); // Column name
                    pst.setString(3, "VARCHAR(255)"); // Column type
                    pst.execute();
                }

                if (columnNames.length() > 0) {
                    columnNames.append(", ");
                    valuesPlaceholders.append(", ");
                }

                columnNames.append("`").append(paramName).append("`");
                valuesPlaceholders.append("?");
            }

            String insertQuery = "INSERT INTO data_entries (" + columnNames + ") VALUES (" + valuesPlaceholders + ")";
            try (PreparedStatement pst = con.prepareStatement(insertQuery)) {
                // Reset parameter names enumeration
                parameterNames = request.getParameterNames();
                int index = 1;
                while (parameterNames.hasMoreElements()) {
                    String paramValue = request.getParameter(parameterNames.nextElement());
                    pst.setString(index++, paramValue);
                }

                pst.executeUpdate();
                response.getWriter().println("Data submitted successfully!");
            }

        } catch (ClassNotFoundException e) {
            response.getWriter().write("Driver class not found: " + e.getMessage());
        } catch (SQLException e) {
            response.getWriter().write("Database error: " + e.getMessage());
        }
    }
}
