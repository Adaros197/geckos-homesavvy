<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Solicitudes de Trabajo Pedidas - Cliente</title>
    <link rel="stylesheet" type="text/css" href="css/ver_solicitudes_servicio.css">
    <link rel="shortcut icon" href="recursos/corazonh.png">
</head>
<body>
    <header>
        <div id="logo">
            <img src="recursos/logo.png" alt="Home Savvy Logo" class="logo_hs">
        </div>
        <nav>
            <ul>
                <li><a href="ver_solicitudes_trabajo.jsp">Ver Solicitudes de Trabajo</a></li>
                <li><a href="trabajos_pedidos.jsp" class="active">Solicitudes de Trabajo Pedidas</a></li>
                <li><a href="crud_solicitudes_servicios.jsp">Solicitudes de Servicios Subidas</a></li>
                <li><a href="subir_solicitud_servicio.jsp">Subir Solicitud</a></li>
                <li><a href="crud_perfil_cliente.jsp">Perfil</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Mis Solicitudes de Trabajo</h1>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID Trabajo</th>
                        <th>ID Cliente</th>
                        <th>ID Experto</th>
                        <th>Descripción</th>
                        <th>Tipo de Trabajo</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    int idClienteSesion = (int) session.getAttribute("id_cliente");
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = DBConnection.getConnection();
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM Trabajo WHERE id_cliente = " + idClienteSesion);
                        while (rs.next()) {
                            int idTrabajo = rs.getInt("id_trabajo");
                            int idCliente = rs.getInt("id_cliente");
                            int idExperto = rs.getInt("id_experto");
                            String descripcion = rs.getString("descripcion");
                            String tipoTrabajo = rs.getString("tipo_trabajo");
                    %>
                    <tr>
                        <td><%= idTrabajo %></td>
                        <td><%= idCliente %></td>
                        <td><%= idExperto %></td>
                        <td><%= descripcion %></td>
                        <td><%= tipoTrabajo %></td>
                    </tr>
                    <% 
                        } 
                    } catch (Exception e) { 
                        e.printStackTrace(); 
                    } finally { 
                        if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                    } 
                    %>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
