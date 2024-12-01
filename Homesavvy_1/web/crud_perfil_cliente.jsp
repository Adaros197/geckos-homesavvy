<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Perfil</title>
    <link rel="stylesheet" type="text/css" href="css/cud_perfil_cliente.css">
     <link rel="shortcut icon" href="recursos/corazonh.png">
    <script type="text/javascript">
        function showAlert(message) {
            alert(message);
        }
        
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="hosa">
            <div class="text_logo">HOMESAVVY</div>
            <div class="cliente">Bienvenido, <%= session.getAttribute("nombre_cliente") %></div>
        </div>
        <div class="docs">
            <h2 class="inst">Administrar tu perfil</h2>
            <%
                // Suponiendo que se ha guardado el ID del cliente en la sesión
                int idClienteSesion = (int) session.getAttribute("id_cliente");

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM Cliente WHERE id_cliente = " + idClienteSesion);
                    if (rs.next()) {
                        String nombre = rs.getString("nombre");
                        String apellidoPat = rs.getString("apellido_pat");
                        String apellidoMat = rs.getString("apellido_mat");
                        String numTel = rs.getString("num_tel");
                        String emailClient = rs.getString("email_client");
                        String direccion = rs.getString("direccion");
            %>
            <form action="ActualizarPerfilClienteServlet" method="post">
                <div class="form-row">
                    <label for="nombre">Nombre completo:</label>
                    <input type="text" id="nombre" name="nombre" value="<%= nombre %>" required readonly>
                </div>
                <div class="form-row">
                    <label for="apellido_pat">Apellido Paterno:</label>
                    <input type="text" id="apellido_pat" name="apellido_pat" value="<%= apellidoPat %>" required readonly>
                </div>
                <div class="form-row">
                    <label for="apellido_mat">Apellido Materno:</label>
                    <input type="text" id="apellido_mat" name="apellido_mat" value="<%= apellidoMat %>" required readonly>
                </div>
                <div class="form-row">
                    <label for="num_tel">No. de Teléfono:</label>
                    <input type="text" id="num_tel" name="num_tel" value="<%= numTel %>" required>
                </div>
                <div class="form-row">
                    <label for="email_client">Correo Electrónico:</label>
                    <input type="email" id="email_client" name="email_client" value="<%= emailClient %>" required>
                </div>
                <div class="form-row">
                    <label for="direccion">Dirección:</label>
                    <input type="text" id="direccion" name="direccion" value="<%= direccion %>" required>
                </div>
                <div class="form-row">
                    <input type="submit" value="Guardar">
                </div>
            </form>
            <form action="EliminarCuentaClienteServlet" method="post" onsubmit="return confirm('¿Estás seguro que deseas borrar tu cuenta?')">
                <button type="submit" class="delete-account">Eliminar Cuenta</button>
            </form>
            <button class="back-button" onclick="goBack()">Regresar</button>
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
