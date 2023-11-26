<%@ page import="modelo.Notificacion" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Notificación</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Buscar Notificación por Matrícula</h1>
    <form action="BuscarNotificaciones" method="post">
        <label>Matrícula del vehículo:</label> <input type="text" name="matricula"> <br>
        <br> <input type="submit" name="action" value="buscar">
    </form>

    <!-- Si se encontraron notificaciones, mostrar formulario de gestión -->
    <% if (request.getAttribute("notificacionesEncontradas") != null) {
        boolean notificacionesEncontradas = (boolean) request.getAttribute("notificacionesEncontradas");
        if (notificacionesEncontradas) {
            List<Notificacion> notificaciones = (List<Notificacion>) request.getAttribute("notificaciones");
    %>
    <h2>Notificaciones Encontradas</h2>
    <div>
        <table border="1">
            <tr>
                <th>ID Notificación</th>
                <th>ID Propietario</th>
                <th>Descripción</th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Tipo</th>
                <th>Matrícula</th>
            </tr>
            <% for (Notificacion notificacion : notificaciones) { %>
            <tr>
                <td><%= notificacion.getId() %></td>
                <td><%= notificacion.getIdPropietario() %></td>
                <td><%= notificacion.getDescripcion() %></td>
                <td><%= notificacion.getFecha() %></td>
                <td><%= notificacion.getHora() %></td>
                <td>
                    <% switch (notificacion.getTipo()) {
                        case 0:
                            out.println("Aviso");
                            break;
                        case 1:
                            out.println("Urgencia baja");
                            break;
                        case 2:
                            out.println("Urgencia media");
                            break;
                        case 3:
                            out.println("Urgencia alta");
                            break;
                        case 4:
                            out.println("Sanción");
                            break;
                        default:
                            out.println("Desconocido");
                    } %>
                </td>
                <td><%= notificacion.getMatriculaVehiculo() %></td>
            </tr>
            <% } %>
        </table>
    </div>
    <div>
        <form action="gestionarNotificaciones.jsp" method="post">
            <input type="submit" value="Atrás">
        </form>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" value="Menú Principal">
        </form>
    </div>
    <% } else { %>
    <h2>Notificaciones NO Encontradas</h2>
    <div>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" value="Menú Principal">
        </form>
    </div>
    <% }
       } %>
</body>
</html>
