<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>
<%@ include file="obtenerDatosProfesional.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Postulaciones en Solicitudes - Profesional</title>
    <link rel="stylesheet" type="text/css" href="css/postulacion_servicios.css">
    <link rel="shortcut icon" href="recursos/corazonh.png">
</head>
<body>
    <header>
        <div id="logo">
            <img src="recursos/logo.png" alt="Home Savvy Logo" class="logo_hs">
        </div>
        <nav>
            <ul>
                <li><a href="ver_solicitudes_servicio.jsp" >Ver Solicitudes de Servicio</a></li>
                <li><a href="postulaciones_servicios.jsp " class="active">Postulaciones en Solicitudes</a></li>
                <li><a href="crud_solicitudes_trabajo.jsp">Solicitudes de Trabajo Subidas</a></li>
                <li><a href="subir_solicitud_trabajo.jsp">Subir Solicitud de Trabajo</a></li>
                <li><a href="crud_perfil_profesional.jsp">Tu perfil, <%= session.getAttribute("nombre_profesional") %></a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Postulaciones en Solicitudes</h1>
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
                    // Verifica que el atributo de sesión id_experto esté establecido
                    Integer idExpertoSesion = (Integer) session.getAttribute("id_experto");
                    if (idExpertoSesion != null) {
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            conn = DBConnection.getConnection();
                            stmt = conn.createStatement();
                            String query = "SELECT * FROM Trabajo WHERE id_experto = " + idExpertoSesion;
                            rs = stmt.executeQuery(query);
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
                    } else {
                        out.println("<tr><td colspan='5'>No se ha encontrado el ID del experto en la sesión.</td></tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>

