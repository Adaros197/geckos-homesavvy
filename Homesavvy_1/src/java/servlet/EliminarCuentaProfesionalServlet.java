package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import db.DBConnection;

@WebServlet("/EliminarCuentaProfesionalServlet")
public class EliminarCuentaProfesionalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idExpertoSesion = (int) session.getAttribute("id_experto");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM Experto WHERE id_experto = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idExpertoSesion);

            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                // Invalidate the session and redirect to index.html
                session.invalidate();
                response.sendRedirect("index.html");
            } else {
                // If no rows were deleted, do nothing
                response.getWriter().write("Error: No se pudo eliminar la cuenta.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // If there is an error, do nothing
            response.getWriter().write("Error: No se pudo eliminar la cuenta.");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}