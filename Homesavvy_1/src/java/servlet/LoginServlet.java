package servlet;

import db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String contrasena = request.getParameter("contrasena");

        System.out.println("Email: " + email); // Debugging
        System.out.println("Contraseña: " + contrasena); // Debugging

        Connection conn = null;
        PreparedStatement stmtCliente = null;
        PreparedStatement stmtExperto = null;
        ResultSet rsCliente = null;
        ResultSet rsExperto = null;

        try {
            conn = DBConnection.getConnection();
            System.out.println("Conexión a la base de datos establecida."); // Debugging
            
            // Consultar en la tabla Cliente
            String sqlCliente = "SELECT id_cliente FROM Cliente WHERE email_client = ? AND contrasena = ?";
            stmtCliente = conn.prepareStatement(sqlCliente);
            stmtCliente.setString(1, email);
            stmtCliente.setString(2, contrasena);
            rsCliente = stmtCliente.executeQuery();

            if (rsCliente.next()) {
                int idCliente = rsCliente.getInt("id_cliente");
                System.out.println("Cliente encontrado: " + idCliente); // Debugging
                HttpSession session = request.getSession();
                session.setAttribute("id_cliente", idCliente); // Guarda el ID del cliente en la sesión
                session.setAttribute("tipo_usuario", "cliente");
                response.sendRedirect("ver_solicitudes_trabajo.jsp");
                return; // Importante: Salir del método después de redireccionar
            } else {
                System.out.println("Cliente no encontrado."); // Debugging
            }
            
            // Consultar en la tabla Experto
            String sqlExperto = "SELECT id_experto FROM Experto WHERE email_exp = ? AND contrasena = ?";
            stmtExperto = conn.prepareStatement(sqlExperto);
            stmtExperto.setString(1, email);
            stmtExperto.setString(2, contrasena);
            rsExperto = stmtExperto.executeQuery();

            if (rsExperto.next()) {
                int idExperto = rsExperto.getInt("id_experto");
                System.out.println("Experto encontrado: " + idExperto); // Debugging
                HttpSession session = request.getSession();
                session.setAttribute("id_experto", idExperto); // Guarda el ID del experto en la sesión
                session.setAttribute("tipo_usuario", "experto");
                session.setAttribute("id_usuario", idExperto);
                response.sendRedirect("ver_solicitudes_servicio.jsp");
                return;
            } else {
                System.out.println("Experto no encontrado."); // Debugging
            }
            
            // Si el usuario no es ni cliente ni experto, redireccionar a la página de inicio de sesión con error
            System.out.println("Usuario no encontrado en ninguna tabla."); // Debugging
            response.sendRedirect("index.html?error=1");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("index.html?error=2&msg=" + e.getMessage());
        } finally {
            try {
                if (rsCliente != null) rsCliente.close();
                if (rsExperto != null) rsExperto.close();
                if (stmtCliente != null) stmtCliente.close();
                if (stmtExperto != null) stmtExperto.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
