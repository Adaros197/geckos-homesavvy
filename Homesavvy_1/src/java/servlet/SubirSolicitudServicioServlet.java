import db.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/SubirSolicitudServicioServlet")
public class SubirSolicitudServicioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String profesion = request.getParameter("profesion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        String descripcion = request.getParameter("descripcion");
        
        // Obtener el ID del cliente de la sesión actual
        int idCliente = obtenerIdClienteDeLaSesion(request);

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO Servicio (id_cliente, profesion_sol, precio, descripcion) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idCliente);
            pstmt.setString(2, profesion);
            pstmt.setDouble(3, precio);
            pstmt.setString(4, descripcion);
            pstmt.executeUpdate();
            response.sendRedirect("crud_solicitudes_servicios.jsp"); // Redirige a la página de CRUD de solicitudes de servicio
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar el error apropiadamente
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    // Método para obtener el ID del cliente de la sesión actual
    private int obtenerIdClienteDeLaSesion(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Integer idCliente = (Integer) session.getAttribute("id_cliente");
            if (idCliente != null) {
                return idCliente.intValue();
            }
        }
        // Manejar el caso en que la sesión o el atributo "id_cliente" sean nulos
        // Puedes lanzar una excepción, devolver un valor predeterminado o manejarlo de alguna otra manera según tu lógica de aplicación
        return -1; // Valor predeterminado o código de error
    }
}