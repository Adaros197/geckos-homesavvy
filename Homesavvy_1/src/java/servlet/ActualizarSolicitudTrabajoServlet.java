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

@WebServlet("/ActualizarSolicitudTrabajoServlet")
public class ActualizarSolicitudTrabajoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idTrabajo = Integer.parseInt(request.getParameter("id_trabajo"));
        String descripcion = request.getParameter("descripcion");
        String tipoTrabajo = request.getParameter("tipo_trabajo");

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE Trabajo SET descripcion = ?, tipo_trabajo = ? WHERE id_trabajo = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, descripcion);
            pstmt.setString(2, tipoTrabajo);
            pstmt.setInt(3, idTrabajo);
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