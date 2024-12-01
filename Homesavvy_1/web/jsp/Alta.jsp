<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Altas</title>
    <script>
        function mensaje(mensaje){
            alert(mensaje);
        }
    </script>
</head>
<body>
    <%!
        // Función para escapar caracteres especiales en consultas SQL
        public String escapeString(String value) {
            return value.replace("'", "''");
        }
    %>
    <%
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        Connection con = null;
        Statement sta = null;
        ResultSet r = null;
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost/homesavvy", "root", "n0m3l0");
            sta = con.createStatement();
            out.println("Conexión realizada...");
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException error) {
            out.print(error.toString());
        }
        try {
            // Comprobar si el usuario ya existe
            r = sta.executeQuery("SELECT * FROM cliente WHERE nombre = '" + escapeString(nombre) + "';");
            if (r.next()) {
                out.println("<script> mensaje('Este usuario ya existe, por favor ingrese otro nombre.'); </script>");
                out.println("<script>window.location='acceso.html';</script>");
            } else {
                // Insertar nuevo usuario
                String insertQuery = "INSERT INTO cliente(nombre, direccion, num_tel, email_client, contrasena) " +
                                     "VALUES('" + escapeString(nombre) + "', '" + escapeString(direccion) + "', '" +
                                     escapeString(telefono) + "', '" + escapeString(correo) + "', '" +
                                     escapeString(contrasena) + "');";
                sta.executeUpdate(insertQuery);
                out.println("<script> mensaje('Usuario registrado exitosamente.'); </script>");
                con.close();
                out.println("<script>window.location='acceso.html';</script>");
            }
        } catch (SQLException error) {
            out.print(error.toString());
        }
    %>
</body>
</html>
