<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="almacen.ConexionBD" %>
<%@ page import="modelo.EspacioEstacionamiento" %>
<%@ page import="modelo.Vehiculo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mis Vehículos</title>
    <link rel="stylesheet" href="estilo-coches.css">
</head>
<body>
<%
HttpSession sesion = request.getSession();
Integer propietarioId = (Integer) sesion.getAttribute("propietarioId");

if (propietarioId == null) {
    // Si el propietarioId no está disponible, redirige al usuario al inicio de sesión
    String url = "login.jsp";
    response.sendRedirect(url);
} else {
    // Realiza la consulta SQL para obtener los vehículos del usuario
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        // Obtener una conexión a la base de datos
        connection = ConexionBD.obtenerConexion();

        // Consulta SQL para obtener los vehículos del usuario
        String query = "SELECT matricula, modelo, marca, color, estacionado FROM vehiculo WHERE id_propietario = ?";
        statement = connection.prepareStatement(query);
        statement.setInt(1, propietarioId);

        resultSet = statement.executeQuery();

        List<Vehiculo> vehiculos = new ArrayList<>();

%>
<h1>Mis Vehículos</h1>
<table>
<tr bgcolor="#F0F0F0">
    <th>Vehículos</th>
</tr>
<%
        while (resultSet.next()) {
            String matricula = resultSet.getString("matricula");
            String modelo = resultSet.getString("modelo");
            String marca = resultSet.getString("marca");
            String color = resultSet.getString("color");
            Boolean estacionado = resultSet.getBoolean("estacionado");
            List<EspacioEstacionamiento> cajones = new ArrayList<>(); // Nueva lista para cada vehículo

            // Consulta SQL para verificar si el vehículo está estacionado
            String estacionadoQuery = "SELECT numero, estado, matricula FROM espacio_estacionamiento WHERE matricula = ?";
            PreparedStatement estacionadoStatement = connection.prepareStatement(estacionadoQuery);
            estacionadoStatement.setString(1, matricula);
            ResultSet estacionadoResultSet = estacionadoStatement.executeQuery();

            // Ahora obtén el valor de "numero" del ResultSet estacionadoResultSet
            while (estacionadoResultSet.next()) {
                int cajon = estacionadoResultSet.getInt("numero");
                boolean estado = estacionadoResultSet.getBoolean("estado");
                String mat = estacionadoResultSet.getString("matricula");
                EspacioEstacionamiento espacioEstacionamiento = new EspacioEstacionamiento(cajon, estado, mat);
                cajones.add(espacioEstacionamiento);
                System.out.println("Cajón encontrado: " + cajon + " matricula: " + mat);
            }

            Vehiculo vehiculo = new Vehiculo(propietarioId, modelo, marca, color, matricula);
            vehiculos.add(vehiculo);
%>
<tr>
    <td>
        <div class="vehiculo-info">
            Matrícula:
            <strong><font size="2px"><%= vehiculo.getMatricula() %></font></strong>
        </div>
        <div class="vehiculo-info">
            Marca:
            <strong><font size="2px"><%= vehiculo.getMarca() %></font></strong>
        </div>
        <div class="vehiculo-info">
            Modelo:
            <strong><font size="2px"><%= vehiculo.getModelo() %></font></strong>
        </div>
        <div class="vehiculo-info">
            Color:
            <strong><font size="2px"><%= vehiculo.getColor() %></font></strong>
        </div>
        <div class="vehiculo-info">
            Estacionado:
<%
            boolean hayCajones = false; // Variable para verificar si hay cajones disponibles
            for (EspacioEstacionamiento espacioEstacionamiento : cajones) {
                if (espacioEstacionamiento.getNumero() > 0) {
%>
            <strong><font color="green">Sí, en el cajón <%= espacioEstacionamiento.getNumero() %></font></strong>
<%
                    hayCajones = true; // Hay al menos un cajón disponible
                }
            }
            if (!hayCajones) {
%>
            <strong><font color="red">No</font></strong>
<%
            }
%>
        </div>
    </td>
    <td>
        <div class="vehiculo-imagen">
            <img src="imagenes/autos/nissan.png" alt="NISSAN">
        </div>
    </td>
</tr>
<%
        }
        vehiculos.clear(); // Limpia la lista después de imprimir
%>
</table>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Cerrar recursos
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
</body>
</html>
