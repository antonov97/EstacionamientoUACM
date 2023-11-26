<%@ page import="modelo.EspacioEstacionamiento" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ver estado de los espacios del estacionamiento</title>
    <link rel="stylesheet" href="estilo.css">
    <style>
        /* Estilos para la matriz */
        .matriz {
            display: grid;
            grid-template-columns: repeat(10, 1fr);
            grid-gap: 10px;
            margin-top: 20px;
        }

        .espacio {
            text-align: center;
            font-weight: bold;
            position: relative;
        }

        .espacio img {
            max-width: 100px;
            height: auto;
            position: relative;
        }

        .espacio::before {
            content: attr(data-numero);
            position: absolute;
            top: 5px;
            left: 5px;
            font-weight: bold;
            font-size: 16px;
            color: white;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 2px 4px;
            border-radius: 4px;
            z-index: 1;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .espacio:hover::before {
            opacity: 1;
        }

        .espacio::after {
            content: attr(data-matricula);
            position: absolute;
            bottom: 5px;
            left: 5px;
            font-weight: bold;
            font-size: 16px;
            color: white;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 2px 4px;
            border-radius: 4px;
            z-index: 1;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .espacio:hover::after {
            opacity: 1;
        }

        /* Resto de estilos igual que en el código anterior */
    </style>
    <script>
        function actualizarReloj() {
            var ahora = new Date();
            var horas = ahora.getHours();
            var minutos = ahora.getMinutes();
            var segundos = ahora.getSeconds();

            horas = horas < 10 ? '0' + horas : horas;
            minutos = minutos < 10 ? '0' + minutos : minutos;
            segundos = segundos < 10 ? '0' + segundos : segundos;

            var tiempoActual = horas + ':' + minutos + ':' + segundos;

            document.getElementById('reloj').innerHTML = tiempoActual;

            setTimeout(actualizarReloj, 1000);
        }

        window.onload = function() {
            actualizarReloj();
        };
    </script>
</head>
<body>
    <h1>Ver estado de los espacios del estacionamiento</h1>
    <div id="reloj" style="font-size: 20px; margin-bottom: 20px;"></div>
    <form action="BuscarEspaciosEstacionamiento" method="post">
        <br><br>
        <input type="submit" value="Buscar ahora">
    </form>
    <form action="menuPrincipal.jsp" method="post">
        <input type="submit" value="Menu Principal">
    </form>
    <div>
        <label for="espaciosSelector">Ver Espacios:</label>
        <select id="espaciosSelector" onchange="filtrarEspacios()">
            <option value="todos">Todos</option>
            <option value="libres">Espacios Libres</option>
            <option value="ocupados">Espacios Ocupados</option>
        </select>
    </div>
    <% boolean espaciosEncontrados = (request.getAttribute("espaciosEncontrados") != null) ? (boolean) request.getAttribute("espaciosEncontrados") : false;
        if (espaciosEncontrados) {
            List<EspacioEstacionamiento> espacios = (List<EspacioEstacionamiento>) request.getAttribute("espacios");
    %>
    <h2>Espacios Encontrados</h2>
    <div class="matriz">
        <%
        for (int i = 0; i < espacios.size(); i++) {
        %>
            <div class="espacio <%= espacios.get(i).isEstado() ? "ocupado" : "libre" %>"
                 data-numero="<%= espacios.get(i).getNumero() %>"
                 data-matricula="<%= (espacios.get(i).getMatricula() != null) ? "Matrícula: " + espacios.get(i).getMatricula() : "NO HAY VEHÍCULO" %>">
                <img src="<%= espacios.get(i).isEstado() ? "imagenes/cajones/cajon-ocupado.png" : "imagenes/cajones/cajon-disponible.png" %>" alt="<%= espacios.get(i).isEstado() ? "Ocupado" : "Libre" %>">
            </div>
        <%
        }
        %>
        <%
        int espaciosFaltantes = 10 - (espacios.size() % 10);
        for (int j = 0; j < espaciosFaltantes; j++) {
        %>
            <div class="vacio"></div>
        <%
        }
        %>
    </div>
    <script>
        function filtrarEspacios() {
            const espacios = document.querySelectorAll(".espacio");
            const espaciosSelector = document.getElementById("espaciosSelector").value;

            espacios.forEach((espacio) => {
                if (espaciosSelector === "todos" || (espaciosSelector === "libres" && !espacio.classList.contains("ocupado")) || (espaciosSelector === "ocupados" && espacio.classList.contains("ocupado"))) {
                    espacio.style.display = "block";
                } else {
                    espacio.style.display = "none";
                }
            });
        }
    </script>
    <%
    } else {
    %>
    <h2>Espacios NO Encontrados</h2>
    <div>
        <p>No se encontraron espacios de estacionamiento.</p>
    </div>
    <form action="menuPrincipal.jsp" method="post">
        <input type="submit" value="Menu Principal">
    </form>
    <%
    }
    %>
</body>
</html>
