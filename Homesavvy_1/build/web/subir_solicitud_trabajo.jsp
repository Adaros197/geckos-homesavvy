<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>
<%@ include file="obtenerDatosProfesional.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Subir Solicitud de Trabajo - Profesional</title>
    <link rel="stylesheet" type="text/css" href="css/subir_solicitud_trabajo.css">
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
                <li><a href="postulaciones_servicios.jsp">Postulaciones en Solicitudes</a></li>
                <li><a href="crud_solicitudes_trabajo.jsp">Solicitudes de Trabajo Subidas</a></li>
                <li><a href="subir_solicitud_trabajo.jsp" class="active">Subir Solicitud de Trabajo</a></li>
                <li><a href="crud_perfil_profesional.jsp" >Tu perfil, <%= session.getAttribute("nombre_profesional") %></a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Subir Nueva Solicitud de Trabajo</h1>
        <div class="form-container">
            <form action="SubirSolicitudTrabajoServlet" method="post">
                <label for="descripcion">Descripción:</label>
                <textarea id="descripcion" name="descripcion" required></textarea><br>
                <label for="tipo_trabajo">Tipo de Trabajo:</label>
                <select id="tipo_trabajo" name="tipo_trabajo" required>
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
                </select><br>
                <input type="submit" value="Subir Solicitud">
            </form>
        </div>
    </main>
</body>
</html>
