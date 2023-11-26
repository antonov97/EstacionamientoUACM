<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menú Principal</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <%
    HttpSession sesion = request.getSession();
    String usuario = (String) sesion.getAttribute("usuario");
    String usuario2 = (String) sesion.getAttribute("usuario2");
    Integer propietarioId = (Integer) sesion.getAttribute("propietarioId");
    String  nombrePropietario = (String) sesion.getAttribute("nombrePropietario");

    if (usuario == null && usuario2 == null) {
        // Si ninguno de los dos tipos de usuario ha iniciado sesión, redirige al inicio de sesión
        String url = "login.jsp";
        response.sendRedirect(url);
    } else {
        // Mostrar el menú correspondiente al tipo de usuario
    }
    %>
        
    <% if (usuario != null) { %>
    <form action="CerrarSesion" method="post">
        <h1>¡Bienvenido, <%= usuario %>! <button type="submit" class="btn btn-primary btn-large">Cerrar sesión</button></h1>
    </form>
    <h2>Menú Principal</h2>
    <!-- Opciones para el usuario normal -->
    <form action="gestionarPropietario.jsp" method="post">
        <input type="submit" value="Gestionar Propietario">
    </form>
    <form action="gestionarVehiculo.jsp" method="post">
        <input type="submit" value="Gestionar Vehículo">
    </form>
    <form action="gestionarNotificaciones.jsp" method="post">
        <input type="submit" value="Gestionar Notificaciones">
    </form>
    <form action="estacionamiento.jsp" method="post">
        <input type="submit" value="Entrar al estacionamiento">
    </form>
    <form action="salidaEstacionamiento.jsp" method="post">
        <input type="submit" value="Salir del estacionamiento">
    </form>
    <form action="verEspaciosEstacionamiento.jsp" method="post">
        <input type="submit" value="Ver espacios">
    </form>
    <form action="gestionarTickets.jsp" method="post">
        <input type="submit" value="Buscar Tickets">
    </form>
    <form action="estadisticasTicket.jsp" method="post">
        <input type="submit" value="Ver estadísticas">
    </form>
    
    <!-- Botón para gestionar notificaciones -->
    <form action="gestionarNotificaciones.jsp" method="post">
        <input type="submit" value="Gestionar Notificaciones">
    </form>
    
    <% } %>
    
    <% if (usuario2 != null) { %>
    <form action="CerrarSesion" method="post">
        <h1>¡Bienvenido, <%= nombrePropietario %>! <button type="submit" class="btn btn-primary btn-large">Cerrar sesión</button></h1>
    </form>
    <h2>Menú Principal</h2>
    <!-- Opciones adicionales para el usuario autenticado -->
    <form action="misCoches.jsp" method="post">
        <input type="submit" value="Ver mis autos (pendiente)">
    </form>
    <form action="verNotificaciones.jsp" method="post">
        <input type="submit" value="Ver mis notificaciones">
    </form>
    
    <!-- Botón para gestionar notificaciones -->
    <form action="gestionarNotificaciones.jsp" method="post">
        <input type="submit" value="Gestionar Notificaciones">
    </form>
    
    <% } %>
    
    <div class="image-container">
        <img src="imagenes/logo.png" alt="Logo Estacionamiento">
    </div>
</body>
</html>
