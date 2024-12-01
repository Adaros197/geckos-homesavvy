<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>CRUD de Perfil - Profesional</title>
    <link rel="stylesheet" type="text/css" href="css/cud_perfil_cliente.css">
    <script type="text/javascript">
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="hosa">
            <div class="text_logo">HOMESAVVY</div>
            <div class="cliente">Bienvenido</div>
        </div>
        <div class="docs">
            <h2 class="inst">Administrar tu perfil profesional</h2>
            <%
                // Suponiendo que se ha guardado el ID del profesional en la sesión
                int idExpertoSesion = (int) session.getAttribute("id_experto");

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM Experto WHERE id_experto = " + idExpertoSesion);
                    if (rs.next()) {
                        String nombre = rs.getString("nombre");
                        String apellidoPat = rs.getString("apellido_pat");
                        String apellidoMat = rs.getString("apellido_mat");
                        String numTel = rs.getString("num_tel");
                        String emailExp = rs.getString("email_exp");
                        String rfc = rs.getString("RFC");
                        String profesion = rs.getString("profesion");
            %>
            <form action="ActualizarPerfilProfesionalServlet" method="post">
                <div class="form-row">
                    <label for="nombre">Nombre completo:</label>
                    <input type="text" id="nombre" name="nombre" value="<%= nombre %>" readonly>
                </div>
                <div class="form-row">
                    <label for="apellido_pat">Apellido Paterno:</label>
                    <input type="text" id="apellido_pat" name="apellido_pat" value="<%= apellidoPat %>" readonly >
                </div>
                <div class="form-row">
                    <label for="apellido_mat">Apellido Materno:</label>
                    <input type="text" id="apellido_mat" name="apellido_mat" value="<%= apellidoMat %>" readonly>
                </div>
                <div class="form-row">
                    <label for="num_tel">No. de Teléfono:</label>
                    <input type="text" id="num_tel" name="num_tel" value="<%= numTel %>" required>
                </div>
                <div class="form-row">
                    <label for="email_exp">Correo Electrónico:</label>
                    <input type="email" id="email_exp" name="email_exp" value="<%= emailExp %>" required>
                </div>
                <div class="form-row">
                    <label for="rfc">RFC:</label>
                    <input type="text" id="rfc" name="rfc" value="<%= rfc %>" readonly>
                </div>
                <div class="form-row">
                    <label for="profesion">Profesión:</label>
                    <input type="text" id="profesion" name="profesion" value="<%= profesion %>" required>
                </div>
                <div class="form-row">
                    <input type="submit" value="Actualizar Perfil">
                </div>
            </form>
            <form action="EliminarCuentaProfesionalServlet" method="post" onsubmit="return confirm('¿Estás seguro que deseas borrar tu cuenta?')">
                <button type="submit" class="delete-account">Eliminar Cuenta</button>
            </form>
            <button class="back-button" onclick="window.location.href='ver_solicitudes_servicio.jsp'">Regresar</button>

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
            <%
                String advertenciaActualizacion = (String) session.getAttribute("perfil_actualizado");
                if (advertenciaActualizacion != null && !advertenciaActualizacion.isEmpty()) {
            %>
                <script type="text/javascript">
                    showAlert("<%= advertenciaActualizacion %>");
                </script>
            <%
                }
                session.removeAttribute("perfil_actualizado"); // Limpiar el mensaje de advertencia
            %>

            <%
                String errorActualizacion = (String) session.getAttribute("error_actualizacion");
                if (errorActualizacion != null && !errorActualizacion.isEmpty()) {
            %>
                <script type="text/javascript">
                    showAlert("<%= errorActualizacion %>");
                </script>
            <%
                }
                session.removeAttribute("error_actualizacion"); // Limpiar el mensaje de error
            %>
        </div>
    </div>
</body>
</html>
