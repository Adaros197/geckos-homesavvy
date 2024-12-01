<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>
<%@ include file="obtenerDatosProfesional.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ver Solicitudes de Servicio - Profesional</title>
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
                <li><a href="ver_solicitudes_servicio.jsp" class="active">Ver Solicitudes de Servicio</a></li>
                <li><a href="postulaciones_servicios.jsp">Postulaciones en Solicitudes</a></li>
                <li><a href="crud_solicitudes_trabajo.jsp">Solicitudes de Trabajo Subidas</a></li>
                <li><a href="subir_solicitud_trabajo.jsp">Subir Solicitud de Trabajo</a></li>
                <li><a href="crud_perfil_profesional.jsp">Tu perfil, <%= session.getAttribute("nombre_profesional") %></a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Solicitudes de Servicio Disponibles</h1>
        <form method="get" action="ver_solicitudes_servicio.jsp">
            <label for="profesion">Filtrar por Profesión:</label>
            <select name="profesion" id="profesion">
                    <option value="Electricidad">Electricidad</option>
                    <option value="Plomería">Plomería</option>
                    <option value="Carpintería">Carpintería</option>
                    <option value="Pintura">Pintura</option>
                    <option value="Albañilería">Albañilería</option>
                    <option value="Jardinería">Jardinería</option>
                    <option value="Cerrajería">Cerrajería</option>
                    <option value="Aire Acondicionado">Aire Acondicionado</option>
                    <option value="Electrodomésticos">Electrodomésticos</option>
                    <option value="Sistemas de Seguridad">Sistemas de Seguridad</option>
                    <option value="Fontanería">Fontanería</option>
                    <option value="Cristalería">Cristalería</option>
                    <option value="Techado">Techado</option>
                    <option value="Instalación de Pisos">Instalación de Pisos</option>
                    <option value="Decoración de Interiores">Decoración de Interiores</option>
            </select>
            <button type="submit" class="filtrar">Filtrar</button>
        </form>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID Servicio</th>
                        <th>ID Cliente</th>
                        <th>Profesión</th>
                        <th>Precio</th>
                        <th>Descripción</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = DBConnection.getConnection();
                        stmt = conn.createStatement();
                        String profesionFilter = request.getParameter("profesion");
                        String query = "SELECT * FROM Servicio WHERE id_experto IS NULL";
                        if (profesionFilter != null && !profesionFilter.isEmpty()) {
                            query += " AND profesion_sol = '" + profesionFilter + "'";
                        }
                        rs = stmt.executeQuery(query);
                        while (rs.next()) {
                            int idServicio = rs.getInt("id_servicio");
                            int idCliente = rs.getInt("id_cliente");
                            String profesionSol = rs.getString("profesion_sol");
                            double precio = rs.getDouble("precio");
                            String descripcion = rs.getString("descripcion");
                %>
                <tr>
                    <td><%= idServicio %></td>
                    <td><%= idCliente %></td>
                    <td><%= profesionSol %></td>
                    <td><%= precio %></td>
                    <td><%= descripcion %></td>
                    <td>
                        <form method="post" action="relacionar_profesional_servicio.jsp">
                            <input type="hidden" name="id_servicio" value="<%= idServicio %>">
                            <button type="submit" class="postularse">Postularse</button>
                        </form>
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
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
