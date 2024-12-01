<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Solicitud de Servicio</title>
    <link rel="stylesheet" type="text/css" href="css/editar_solcitud_servicio.css">
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
                <li><a href="trabajos_pedidos.jsp">Solicitudes de Trabajo Pedidas</a></li>
                <li><a href="crud_solicitudes_servicios.jsp">Solicitudes de Servicios Subidas</a></li>
                <li><a href="subir_solicitud_servicio.jsp">Subir Solicitud</a></li>
                <li><a href="crud_perfil_cliente.jsp">Perfil</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Editar Solicitud de Servicio</h1>
        <div class="form-container">
            <% 
                // Obtener el ID de la solicitud de servicio
                String idServicioStr = request.getParameter("id");
                int idServicio = Integer.parseInt(idServicioStr);

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnection.getConnection();
                    String sql = "SELECT profesion_sol, precio, descripcion FROM Servicio WHERE id_servicio = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, idServicio);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String profesion = rs.getString("profesion_sol");
                        double precio = rs.getDouble("precio");
                        String descripcion = rs.getString("descripcion");
            %>
                <form action="ActualizarSolicitudServicioServlet" method="post">
                    <input type="hidden" name="id_servicio" value="<%= idServicio %>">
                    <label for="profesion">Profesión:</label>
                    <input type="text" id="profesion" name="profesion" value="<%= profesion %>" required><br>
                    <label for="precio">Precio:</label>
                    <input type="number" id="precio" name="precio" value="<%= precio %>" required><br>
                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" required><%= descripcion %></textarea><br>
                    <input type="submit" value="Actualizar Solicitud">
                </form>
            <% 
                    } else {
                        // Manejar el caso en que no se encuentre la solicitud de servicio
                        out.println("Solicitud de servicio no encontrada.");
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
