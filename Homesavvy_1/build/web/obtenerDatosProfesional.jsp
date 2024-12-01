<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>

<%
    // Inicializar las variables para los datos del profesional
    String nombreProfesional = "";
    String apellidoPatProfesional = "";
    String apellidoMatProfesional = "";
    String numTelProfesional = "";
    String emailProfesional = "";
    String profesionProfesional = "";

    Integer idProfesional = (Integer) session.getAttribute("id_experto");
    if (idProfesional != null) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT nombre, apellido_pat, apellido_mat, num_tel, email_exp, profesion FROM Experto WHERE id_experto = " + idProfesional);
            if (rs.next()) {
                nombreProfesional = rs.getString("nombre");
                apellidoPatProfesional = rs.getString("apellido_pat");
                apellidoMatProfesional = rs.getString("apellido_mat");
                numTelProfesional = rs.getString("num_tel");
                emailProfesional = rs.getString("email_exp");
                profesionProfesional = rs.getString("profesion");
                // Almacenar los datos en la sesión
                session.setAttribute("nombre_profesional", nombreProfesional);
                session.setAttribute("apellido_pat_profesional", apellidoPatProfesional);
                session.setAttribute("apellido_mat_profesional", apellidoMatProfesional);
                session.setAttribute("num_tel_profesional", numTelProfesional);
                session.setAttribute("email_profesional", emailProfesional);
                session.setAttribute("profesion_profesional", profesionProfesional);
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