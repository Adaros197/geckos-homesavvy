<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Subir Solicitud - Cliente</title>
    <link rel="stylesheet" type="text/css" href="css/subir_solicitud_servicio.css">
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
                <li><a href="subir_solicitud_servicio.jsp" class="active">Subir Solicitud</a></li>
                <li><a href="crud_perfil_cliente.jsp">Perfil</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h1>Subir Nueva Solicitud</h1>
        <div class="form-container">
            <form action="SubirSolicitudServicioServlet" method="post">
                <label for="profesion">Profesión:</label>
                <input type="text" id="profesion" name="profesion" required><br>
                <label for="precio">Precio:</label>
                <input type="number" id="precio" name="precio" required><br>
                <label for="descripcion">Descripción:</label>
                <textarea id="descripcion" name="descripcion" required></textarea><br>
                <input type="submit" value="Subir Solicitud">
            </form>
        </div>
    </main>
</body>
</html>

