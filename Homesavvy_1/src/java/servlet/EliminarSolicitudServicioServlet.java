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

@WebServlet("/EliminarSolicitudServicioServlet")
public class EliminarSolicitudServicioServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID de la solicitud de servicio a eliminar desde la solicitud GET
        int idServicio = Integer.parseInt(request.getParameter("id"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM Servicio WHERE id_servicio = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idServicio);
            pstmt.executeUpdate();
            
            // Redirigir a la página de CRUD de solicitudes de servicio
            response.sendRedirect("crud_solicitudes_servicios.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar el error apropiadamente
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}