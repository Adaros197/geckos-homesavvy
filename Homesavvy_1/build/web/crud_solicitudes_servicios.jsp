<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Solicitudes de Servicios Subidas - Cliente</title>
    <link rel="stylesheet" type="text/css" href="css/crud_solicitudes_trabajo.css">
    <link rel="shortcut icon" href="recursos/corazonh.png">
</head>
<body>
    <header>
        <div id="logo">
            <img src="recursos/logo.png" alt="Home Savvy Logo">
        </div>
        <nav>
            <ul>
                <li><a href="ver_solicitudes_trabajo.jsp">Ver Solicitudes de Trabajo</a></li>
                <li><a href="trabajos_pedidos.jsp">Solicitudes de Trabajo Pedidas</a></li>
                <li><a href="crud_solicitudes_servicios.jsp" class="active">Solicitudes de Servicios Subidas</a></li>
                <li><a href="subir_solicitud_servicio.jsp">Subir Solicitud</a></li>
                <li><a href="crud_perfil_cliente.jsp">Perfil</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Administrar Solicitudes de Servicios</h1>
        <table>
            <tr>
                <th>ID Servicio</th>
                <th>ID Cliente</th>
                <th>ID Experto</th>
                <th>Profesión</th>
                <th>Precio</th>
                <th>Descripción</th>
                <th>Acciones</th>
            </tr>
            <%
                int idClienteSesion = (int) session.getAttribute("id_cliente");

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM Servicio WHERE id_cliente = " + idClienteSesion);
                    while (rs.next()) {
                        int idServicio = rs.getInt("id_servicio");
                        int idCliente = rs.getInt("id_cliente");
                        int idExperto = rs.getInt("id_experto");
                        String profesionSol = rs.getString("profesion_sol");
                        double precio = rs.getDouble("precio");
                        String descripcion = rs.getString("descripcion");
            %>
            <tr>
                <td><%= idServicio %></td>
                <td><%= idCliente %></td>
                <td><%= idExperto %></td>
                <td><%= profesionSol %></td>
                <td><%= precio %></td>
                <td><%= descripcion %></td>
                <td>
                    <a href="editar_solicitud_servicio.jsp?id=<%= idServicio %>">Editar</a> |
                    <a href="EliminarSolicitudServicioServlet?id=<%= idServicio %>" onclick="return confirm('¿Seguro que quieres eliminar esta solicitud de servicio?')">Eliminar</a>
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
