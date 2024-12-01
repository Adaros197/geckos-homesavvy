<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="db.DBConnection" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = DBConnection.getConnection();
        int idServicio = Integer.parseInt(request.getParameter("id_servicio"));
        int idProfesional = (int) session.getAttribute("id_experto"); // Método ficticio para obtener el ID del profesional de la sesión actual, debes implementarlo según tu lógica de autenticación
        // Actualiza el servicio con el ID del profesional
        String sql = "UPDATE Servicio SET id_experto = ? WHERE id_servicio = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idProfesional);
        pstmt.setInt(2, idServicio);
        pstmt.executeUpdate();
        response.sendRedirect("ver_solicitudes_servicio.jsp"); // Redirige de vuelta a la página de ver solicitudes de servicio
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>