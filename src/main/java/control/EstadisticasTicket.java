package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;
import modelo.Ticket;

@WebServlet("/EstadisticasTicket")
public class EstadisticasTicket extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los datos del formulario
        String matricula = request.getParameter("matricula");
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");

        // Verificar si se proporcionaron filtros
        boolean filtrosActivos = !matricula.isEmpty() || !fecha.isEmpty() || !hora.isEmpty();

        // Buscar los tickets según los filtros proporcionados
        List<Ticket> tickets = buscarTicketsEnBD(matricula, fecha, hora);

        if (filtrosActivos && !tickets.isEmpty()) {
            // Obtener la cantidad de registros para los filtros especificados
            int cantidadRegistros = obtenerCantidadRegistros(matricula, fecha, hora);
            // Agregar los atributos a la request
            request.setAttribute("cantidadRegistros", cantidadRegistros);
        } else {
            // Agregar un mensaje de que no se encontraron registros
            request.setAttribute("noRegistros", "No se encontraron registros para los filtros proporcionados.");
        }

        // Tickets encontrados o no, redirigir al formulario de gestión de tickets
        request.setAttribute("ticketsEncontrados", filtrosActivos);
        request.setAttribute("tickets", tickets);
        request.getRequestDispatcher("estadisticasTicket.jsp").forward(request, response);
    }

    private int obtenerCantidadRegistros(String matricula, String fecha, String hora) {
        int cantidadRegistros = 0;

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar los tickets con filtros opcionales
            String query = "SELECT COUNT(*) AS cantidad FROM ticket WHERE 1=1";

            if (!matricula.isEmpty()) {
                query += " AND matricula_vehiculo = ?";
            }

            if (!fecha.isEmpty()) {
                query += " AND fecha_emision = TO_DATE(?, 'YYYY-MM-DD')"; // Convertir cadena a DATE
            }

            if (!hora.isEmpty()) {
                query += " AND hora = ?";
            }

            PreparedStatement statement = connection.prepareStatement(query);

            int parameterIndex = 1; // Índice de parámetros

            if (!matricula.isEmpty()) {
                statement.setString(parameterIndex++, matricula);
            }

            if (!fecha.isEmpty()) {
                // Convertir la cadena de texto a una fecha
                java.sql.Date fechaDate = java.sql.Date.valueOf(fecha);
                statement.setDate(parameterIndex++, fechaDate);
            }

            if (!hora.isEmpty()) {
                statement.setString(parameterIndex, hora);
            }

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                cantidadRegistros = resultSet.getInt("cantidad");
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cantidadRegistros;
    }

    // Modifica el método buscarTicketsEnBD de la misma manera
    private List<Ticket> buscarTicketsEnBD(String matricula, String fecha, String hora) {
        List<Ticket> tickets = new ArrayList<>();

        try {
            // Establecer la conexión con la base de datos
            Connection connection = ConexionBD.obtenerConexion();

            // Construir la consulta SQL para buscar los tickets con filtros opcionales
            String query = "SELECT * FROM ticket WHERE 1=1";

            if (!matricula.isEmpty()) {
                query += " AND matricula_vehiculo = ?";
            }

            if (!fecha.isEmpty()) {
            	query += " AND fecha_emision = TO_DATE(?, 'YYYY-MM-DD')";
            }

            if (!hora.isEmpty()) {
                query += " AND hora = ?";
            }

            query += " ORDER BY fecha_emision DESC, hora DESC";

            PreparedStatement statement = connection.prepareStatement(query);

            int parameterIndex = 1; // Índice de parámetros

            if (!matricula.isEmpty()) {
                statement.setString(parameterIndex++, matricula);
            }

            if (!fecha.isEmpty()) {
                statement.setString(parameterIndex++, fecha);
            }

            if (!hora.isEmpty()) {
                statement.setString(parameterIndex, hora);
            }

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Recorrer los resultados y construir los objetos Ticket
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int cajon = resultSet.getInt("id_espacio_estacionamiento");
                String fechaResultado = resultSet.getString("fecha_emision");
                String horaResultado = resultSet.getString("hora");

                Ticket ticket = new Ticket(id, cajon, matricula, fechaResultado, horaResultado);
                tickets.add(ticket);
            }

            // Cerrar recursos
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }
}
