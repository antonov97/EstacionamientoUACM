<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro Notificaci�n</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <h1>Registro de Notificaci�n</h1>
    <form action="RegistrarNotificacion" method="POST">
        <label for="tipo">Tipo de Notificaci�n:</label>
        <select name="tipo">
            <option value="0">Aviso</option>
            <option value="1">Urgencia baja</option>
            <option value="2">Urgencia media</option>
            <option value="3">Urgencia alta</option>
            <option value="4">Sanci�n</option>
        </select><br>
        <br>
        <br>
        <label for="matricula">Ingrese la Matr�cula del Veh�culo:</label>
        <input minlength="5" maxlength="12" type="text" id="matricula" name="matricula"><br>
        <br>
        <label for="descripcion">Ingrese la Descripci�n:</label>
        <textarea id="descripcion" name="descripcion"></textarea>
        <br>
        <br>
        <input type="submit" value="Registrar Notificaci�n">
    </form>
    
    <!-- Mensajes de �xito o error al registrar -->
    <% if (request.getAttribute("registroNotificacion") != null) {
        String registroNotificacion = (String) request.getAttribute("registroNotificacion");
        out.println("<p>" + registroNotificacion + "</p>");
    } %>

    <div>
        <form action="gestionarNotificaciones.jsp" method="post">
            <input type="submit" value="Atr�s">
        </form>
        <form action="menuPrincipal.jsp" method="post">
            <input type="submit" value="Men� Principal">
        </form>
    </div>
</body>
</html>
