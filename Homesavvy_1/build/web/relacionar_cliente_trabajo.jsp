<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="db.DBConnection" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = DBConnection.getConnection();
        int idTrabajo = Integer.parseInt(request.getParameter("id_trabajo"));
        int idCliente = (int) session.getAttribute("id_cliente"); // Método ficticio para obtener el ID del cliente de la sesión actual, debes implementarlo según tu lógica de autenticación
        // Actualiza el trabajo con el ID del cliente
        String sql = "UPDATE Trabajo SET id_cliente = ? WHERE id_trabajo = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idCliente);
        pstmt.setInt(2, idTrabajo);
        pstmt.executeUpdate();
        response.sendRedirect("ver_solicitudes_trabajo.jsp"); // Redirige de vuelta a la página de ver solicitudes de trabajo
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>