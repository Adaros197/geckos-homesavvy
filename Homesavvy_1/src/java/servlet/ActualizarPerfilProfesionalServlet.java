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

@WebServlet("/ActualizarPerfilProfesionalServlet")
public class ActualizarPerfilProfesionalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        int idExperto = Integer.parseInt(request.getSession().getAttribute("id_experto").toString());
        String nombre = request.getParameter("nombre");
        String apellidoPat = request.getParameter("apellido_pat");
        String apellidoMat = request.getParameter("apellido_mat");
        String numTel = request.getParameter("num_tel");
        String emailExp = request.getParameter("email_exp");
        String rfc = request.getParameter("rfc");
        String profesion = request.getParameter("profesion");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE Experto SET nombre=?, apellido_pat=?, apellido_mat=?, num_tel=?, email_exp=?, RFC=?, profesion=? WHERE id_experto=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setString(2, apellidoPat);
            pstmt.setString(3, apellidoMat);
            pstmt.setString(4, numTel);
            pstmt.setString(5, emailExp);
            pstmt.setString(6, rfc);
            pstmt.setString(7, profesion);
            pstmt.setInt(8, idExperto);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                request.getSession().setAttribute("perfil_actualizado", "Perfil actualizado correctamente.");
                response.sendRedirect("crud_perfil_profesional.jsp");
            } else {
                request.getSession().setAttribute("error_actualizacion", "No se pudo actualizar el perfil.");
                response.sendRedirect("crud_perfil_profesional.jsp");
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