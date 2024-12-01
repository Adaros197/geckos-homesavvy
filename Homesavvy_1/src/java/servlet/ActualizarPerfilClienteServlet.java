package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.DBConnection;

@WebServlet("/ActualizarPerfilClienteServlet")
public class ActualizarPerfilClienteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        int idCliente = Integer.parseInt(request.getSession().getAttribute("id_cliente").toString());
        String nombre = request.getParameter("nombre");
        String apellidoPat = request.getParameter("apellido_pat");
        String apellidoMat = request.getParameter("apellido_mat");
        String numTel = request.getParameter("num_tel");
        String emailClient = request.getParameter("email_client");
        String direccion = request.getParameter("direccion");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE Cliente SET nombre=?, apellido_pat=?, apellido_mat=?, num_tel=?, email_client=?, direccion=? WHERE id_cliente=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setString(2, apellidoPat);
            pstmt.setString(3, apellidoMat);
            pstmt.setString(4, numTel);
            pstmt.setString(5, emailClient);
            pstmt.setString(6, direccion);
            pstmt.setInt(7, idCliente);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                request.getSession().setAttribute("perfil_actualizado", "Perfil actualizado correctamente.");
                response.sendRedirect("crud_perfil_cliente.jsp");
            } else {
                request.getSession().setAttribute("error_actualizacion", "No se pudo actualizar el perfil.");
                response.sendRedirect("crud_perfil_cliente.jsp");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            // Manejar el error apropiadamente
            request.getSession().setAttribute("error_actualizacion", "Error al procesar la actualización.");
            response.sendRedirect("error_actualizacion.jsp"); // Redirigir a una página de error
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        }
    }
}