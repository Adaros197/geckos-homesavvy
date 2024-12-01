<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>

<%
    // Inicializar las variables para los datos del cliente
    String nombreCliente = "";
    String apellidoPatCliente = "";
    String apellidoMatCliente = "";
    String numTelCliente = "";
    String emailCliente = "";
    String direccionCliente = "";

    Integer idCliente = (Integer) session.getAttribute("id_cliente");
    if (idCliente != null) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT nombre, apellido_pat, apellido_mat, num_tel, email_client, direccion FROM Cliente WHERE id_cliente = " + idCliente);
            if (rs.next()) {
                nombreCliente = rs.getString("nombre");
                apellidoPatCliente = rs.getString("apellido_pat");
                apellidoMatCliente = rs.getString("apellido_mat");
                numTelCliente = rs.getString("num_tel");
                emailCliente = rs.getString("email_client");
                direccionCliente = rs.getString("direccion");
                // Almacenar los datos en la sesión
                session.setAttribute("nombre_cliente", nombreCliente);
                session.setAttribute("apellido_pat_cliente", apellidoPatCliente);
                session.setAttribute("apellido_mat_cliente", apellidoMatCliente);
                session.setAttribute("num_tel_cliente", numTelCliente);
                session.setAttribute("email_cliente", emailCliente);
                session.setAttribute("direccion_cliente", direccionCliente);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
%>