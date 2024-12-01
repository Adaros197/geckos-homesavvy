package servlet;

import db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EliminarSolicitudTrabajoServlet")
public class EliminarSolicitudTrabajoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID de la solicitud de trabajo a eliminar desde la solicitud GET
        int idTrabajo = Integer.parseInt(request.getParameter("id"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM Trabajo WHERE id_trabajo = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idTrabajo);
            pstmt.executeUpdate();
            
            // Redirigir a la página de CRUD de solicitudes de trabajo
            response.sendRedirect("crud_solicitudes_trabajo.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar el error apropiadamente
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}