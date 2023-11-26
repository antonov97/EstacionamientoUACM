package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;
import modelo.Notificacion;

@WebServlet("/ActualizarNotificacion")
public class ActualizarNotificacion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros del formulario
        int idNotificacion = Integer.parseInt(request.getParameter("idNotificacion"));
        String nuevaDescripcion = request.getParameter("nuevaDescripcion");
        LocalDate nuevaFecha = LocalDate.parse(request.getParameter("nuevaFecha"));
        String nuevaHora = request.getParameter("nuevaHora");
        int nuevoTipo = Integer.parseInt(request.getParameter("nuevoTipo"));

        // Actualizar la notificación
        boolean exito = actualizarNotificacion(idNotificacion, nuevaDescripcion, nuevaFecha, nuevaHora, nuevoTipo);

        if (exito) {
            // Notificación actualizada con éxito, establecer mensaje y redirigir
            request.setAttribute("mensajeActualizar", "Notificación actualizada correctamente.");
        } else {
            // Error al actualizar, establecer mensaje y redirigir
            request.setAttribute("mensajeActualizar", "Error al actualizar la notificación.");
        }

        // Redirigir de vuelta al formulario de búsqueda
        request.getRequestDispatcher("eliminarNotificacion.jsp").forward(request, response);
    }

    private boolean actualizarNotificacion(int idNotificacion, String nuevaDescripcion, LocalDate nuevaFecha,
            String nuevaHora, int nuevoTipo) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            String query = "UPDATE notificaciones SET descripcion = ?, fecha = ?, hora = ?, tipo = ? WHERE id_notificacion = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, nuevaDescripcion);
            statement.setDate(2, java.sql.Date.valueOf(nuevaFecha));
            statement.setString(3, nuevaHora);
            statement.setInt(4, nuevoTipo);
            statement.setInt(5, idNotificacion);

            int filasActualizadas = statement.executeUpdate();

            statement.close();
            connection.close();

            return filasActualizadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
