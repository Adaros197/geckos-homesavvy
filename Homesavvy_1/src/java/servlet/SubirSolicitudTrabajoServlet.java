import db.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/SubirSolicitudTrabajoServlet")
public class SubirSolicitudTrabajoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String descripcion = request.getParameter("descripcion");
        String tipoTrabajo = request.getParameter("tipo_trabajo");
        
        // Obtener el ID del experto de la sesión actual
        int idExperto = obtenerIdExpertoDeLaSesion(request);

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO Trabajo (id_experto, descripcion, tipo_trabajo) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idExperto);
            pstmt.setString(2, descripcion);
            pstmt.setString(3, tipoTrabajo);
            pstmt.executeUpdate();
            response.sendRedirect("crud_solicitudes_trabajo.jsp"); // Redirige a la página de CRUD de solicitudes de trabajo
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar el error apropiadamente
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    // Método para obtener el ID del experto de la sesión actual
    private int obtenerIdExpertoDeLaSesion(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Integer idExperto = (Integer) session.getAttribute("id_experto");
            if (idExperto != null) {
                return idExperto.intValue();
            }
        }
        // Manejar el caso en que la sesión o el atributo "id_experto" sean nulos
        // Puedes lanzar una excepción, devolver un valor predeterminado o manejarlo de alguna otra manera según tu lógica de aplicación
        return -1; // Valor predeterminado o código de error
    }
}
