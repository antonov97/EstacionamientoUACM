<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro Notificación</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Registro de Notificación</h1>
    <form action="RegistrarNotificacion" method="POST">
        <label for="tipo">Tipo de Notificación:</label>
        <select name="tipo">
            <option value="0">Aviso</option>
            <option value="1">Urgencia baja</option>
            <option value="2">Urgencia media</option>
            <option value="3">Urgencia alta</option>
            <option value="4">Sanción</option>
        </select><br>
        <br>
        <br>
        <label for="matricula">Ingrese la Matrícula del Vehículo:</label>
        <input minlength="5" maxlength="12" type="text" id="matricula" name="matricula"><br>
        <br>
        <label for="descripcion">Ingrese la Descripción:</label>
        <textarea id="descripcion" name="descripcion"></textarea>
        <br>
        <br>
        <input type="submit" value="Registrar Notificación">
    </form>
    
    <!-- Mensajes de éxito o error al registrar -->
    <% if (request.getAttribute("registroNotificacion") != null) {
        String registroNotificacion = (String) request.getAttribute("registroNotificacion");
        out.println("<p>" + registroNotificacion + "</p>");
    } %>

    <div>
        <form action="gestionarNotificaciones.jsp" method="post">
            <input type="submit" value="Atrás">
        </form>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" value="Menú Principal">
        </form>
    </div>
</body>
</html>
