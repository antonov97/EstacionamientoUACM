package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import almacen.ConexionBD;

@WebServlet("/BuscarNotificacion")
public class BuscarNotificacion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el ID de notificación del formulario
        int idNotificacion = Integer.parseInt(request.getParameter("id_notificacion"));

        // Buscar la notificación en la base de datos
        String descripcion = buscarNotificacionEnBD(idNotificacion);

        if (descripcion != null) {
            // La búsqueda fue exitosa, puedes redirigir a una página de éxito
            request.setAttribute("descripcion", descripcion);
            request.getRequestDispatcher("exito.jsp").forward(request, response);
        } else {
            // La búsqueda falló, puedes redirigir a una página de error
            response.sendRedirect("error.jsp");
        }
    }

    private String buscarNotificacionEnBD(int idNotificacion) {
        try {
            Connection connection = ConexionBD.obtenerConexion();

            String query = "SELECT descripcion FROM notificaciones WHERE id_notificacion = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, idNotificacion);

            String descripcion = null;

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    descripcion = resultSet.getString("descripcion");
                }
            }

            statement.close();
            connection.close();

            return descripcion;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
