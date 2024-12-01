<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>
<%@ include file="obtenerDatosCliente.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ver Solicitudes de Trabajo - Cliente</title>
    <link rel="stylesheet" type="text/css" href="css/ver_solicitudes_trabajo.css">
     <link rel="shortcut icon" href="recursos/corazonh.png">
</head>
<body>
    <header>
        <div id="logo">
            <a href="index.html"><img src="recursos/logo.png" alt="Home Savvy Logo" class="logo_hs"></a>
        </div>
        <nav>
            <ul>
                
                <li><a href="ver_solicitudes_trabajo.jsp" class="active">Ver Solicitudes de Trabajo</a></li>
                <li><a href="trabajos_pedidos.jsp">Solicitudes de Trabajo Pedidas</a></li>
                <li><a href="crud_solicitudes_servicios.jsp">Solicitudes de Servicios Subidas</a></li>
                <li><a href="subir_solicitud_servicio.jsp">Subir Solicitud</a></li>
                <li><a href="crud_perfil_cliente.jsp">Tu perfil, <%= session.getAttribute("nombre_cliente") %></a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Solicitudes de Trabajo Disponibles</h1>
        <div class="solicitudes">
            <% 
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM Trabajo WHERE id_cliente IS NULL");
                    while (rs.next()) {
                        int idTrabajo = rs.getInt("id_trabajo");
                        int idExperto = rs.getInt("id_experto");
                        String descripcion = rs.getString("descripcion");
                        String tipoTrabajo = rs.getString("tipo_trabajo");
            %>
            <div class="solicitud">
                <div class="solicitud-inner">
                    <div class="solicitud-info">
                        <div>Profesional: <%= session.getAttribute("nombre_cliente") %></div>
                        <div>Descripción: <%= descripcion %></div>
                        <div>Tipo de Trabajo: <%= tipoTrabajo %></div>
                    </div>
                    <div class="solicitud-acciones">
                        <form method="post" action="relacionar_cliente_trabajo.jsp">
                            <input type="hidden" name="id_trabajo" value="<%= idTrabajo %>">
                            <button type="submit" class="pedir">Pedir</button>
                        </form>
                    </div>
                </div>
            </div>
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
        </div>
    </main>
</body>
</html>