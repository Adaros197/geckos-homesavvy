<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>
<%@ include file="obtenerDatosProfesional.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CRUD de Solicitudes de Trabajo Subidas - Profesional</title>
    <link rel="stylesheet" type="text/css" href="css/crud_solicitudes_trabajo.css">
    <link rel="shortcut icon" href="recursos/corazonh.png">
</head>
<body>
    <header>
        <div id="logo">
            <img src="recursos/logo.png" alt="Home Savvy Logo" class="logo_hs">
        </div>
        <nav>
            <ul>
                <li><a href="ver_solicitudes_servicio.jsp">Ver Solicitudes de Servicio</a></li>
                <li><a href="postulaciones_servicios.jsp" >Postulaciones en Solicitudes</a></li>
                <li><a href="crud_solicitudes_trabajo.jsp"  class="active">Solicitudes de Trabajo Subidas</a></li>
                <li><a href="subir_solicitud_trabajo.jsp">Subir Solicitud de Trabajo</a></li>
                <li><a href="crud_perfil_profesional.jsp">Tu perfil, <%= session.getAttribute("nombre_profesional") %></a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Administrar Solicitudes de Trabajo</h1>
        <table border="1">
            <tr>
                <th>ID Trabajo</th>
                <th>ID Cliente</th>
                <th>ID Experto</th>
                <th>Descripción</th>
                <th>Tipo de Trabajo</th>
                <th>Acciones</th>
            </tr>
            <%
                // Suponiendo que se ha guardado el ID del experto en la sesión
                int idExpertoSesion = (int) session.getAttribute("id_experto");

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM Trabajo WHERE id_experto = " + idExpertoSesion);
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
                <td>
                    <a href="editar_solicitud_trabajo.jsp?id=<%= idTrabajo %>">Editar</a> |
                    <a href="EliminarSolicitudTrabajoServlet?id=<%= idTrabajo %>" onclick="return confirm('¿Seguro que quieres eliminar esta solicitud de trabajo?')">Eliminar</a>
                </td>
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
        </table>
    </main>
</body>
</html>