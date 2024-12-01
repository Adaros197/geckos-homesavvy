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

@WebServlet("/ActualizarSolicitudServicioServlet")
public class ActualizarSolicitudServicioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idServicio = Integer.parseInt(request.getParameter("id_servicio"));
        String profesion = request.getParameter("profesion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        String descripcion = request.getParameter("descripcion");

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE Servicio SET profesion_sol = ?, precio = ?, descripcion = ? WHERE id_servicio = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, profesion);
            pstmt.setDouble(2, precio);
            pstmt.setString(3, descripcion);
            pstmt.setInt(4, idServicio);
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