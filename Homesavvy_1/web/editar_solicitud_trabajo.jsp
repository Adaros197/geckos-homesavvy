<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="db.DBConnection" %>
<%@ include file="obtenerDatosProfesional.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Solicitud de Trabajo</title>
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
                <li><a href="crud_solicitudes_trabajo.jsp" class="active">Solicitudes de Trabajo Subidas</a></li>
                <li><a href="subir_solicitud_trabajo.jsp">Subir Solicitud de Trabajo</a></li>
                <li><a href="crud_perfil_profesional.jsp">Tu perfil, <%= session.getAttribute("nombre_profesional") %></a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Editar Solicitud de Trabajo</h1>
        <div class="form-container">
            <% 
                // Obtener el ID de la solicitud de trabajo
                String idTrabajoStr = request.getParameter("id");
                int idTrabajo = Integer.parseInt(idTrabajoStr);

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    String sql = "SELECT descripcion, tipo_trabajo FROM Trabajo WHERE id_trabajo = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, idTrabajo);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String descripcion = rs.getString("descripcion");
                        String tipoTrabajo = rs.getString("tipo_trabajo");
            %>
                <form action="ActualizarSolicitudTrabajoServlet" method="post">
                    <input type="hidden" name="id_trabajo" value="<%= idTrabajo %>">
                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" required><%= descripcion %></textarea><br>
                    <label for="tipo_trabajo">Tipo de Trabajo:</label>
                    <select id="tipo_trabajo" name="tipo_trabajo" required>
                        <option value="Electricidad" <%= tipoTrabajo.equals("Electricidad") ? "selected" : "" %>>Electricidad</option>
                        <option value="Plomería" <%= tipoTrabajo.equals("Plomería") ? "selected" : "" %>>Plomería</option>
                        <option value="Carpintería" <%= tipoTrabajo.equals("Carpintería") ? "selected" : "" %>>Carpintería</option>
                        <option value="Pintura" <%= tipoTrabajo.equals("Pintura") ? "selected" : "" %>>Pintura</option>
                        <option value="Albañilería" <%= tipoTrabajo.equals("Albañilería") ? "selected" : "" %>>Albañilería</option>
                        <option value="Jardinería" <%= tipoTrabajo.equals("Jardinería") ? "selected" : "" %>>Jardinería</option>
                        <option value="Cerrajería" <%= tipoTrabajo.equals("Cerrajería") ? "selected" : "" %>>Cerrajería</option>
                        <option value="Aire Acondicionado" <%= tipoTrabajo.equals("Aire Acondicionado") ? "selected" : "" %>>Aire Acondicionado</option>
                        <option value="Electrodomésticos" <%= tipoTrabajo.equals("Electrodomésticos") ? "selected" : "" %>>Electrodomésticos</option>
                        <option value="Sistemas de Seguridad" <%= tipoTrabajo.equals("Sistemas de Seguridad") ? "selected" : "" %>>Sistemas de Seguridad</option>
                        <option value="Fontanería" <%= tipoTrabajo.equals("Fontanería") ? "selected" : "" %>>Fontanería</option>
                        <option value="Cristalería" <%= tipoTrabajo.equals("Cristalería") ? "selected" : "" %>>Cristalería</option>
                        <option value="Techado" <%= tipoTrabajo.equals("Techado") ? "selected" : "" %>>Techado</option>
                        <option value="Instalación de Pisos" <%= tipoTrabajo.equals("Instalación de Pisos") ? "selected" : "" %>>Instalación de Pisos</option>
                        <option value="Decoración de Interiores" <%= tipoTrabajo.equals("Decoración de Interiores") ? "selected" : "" %>>Decoración de Interiores</option>
                    </select><br>
                    <input type="submit" value="Actualizar Solicitud">
                </form>
            <% 
                    } else {
                        // Manejar el caso en que no se encuentre la solicitud de trabajo
                        out.println("Solicitud de trabajo no encontrada.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    // Manejar el error apropiadamente
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                }
            %>
        </div>
    </main>
</body>
</html>
