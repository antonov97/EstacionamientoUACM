public class EspacioEstacionamiento {
    private int numero;
    private boolean estado;
    private String matricula;
    private String modelo; // Nuevo atributo para el modelo del vehículo
    private String color; // Nuevo atributo para el color del vehículo

    public EspacioEstacionamiento(int numero, boolean estado, String matricula, String modelo, String color) {
        this.numero = numero;
        this.estado = estado;
        this.matricula = matricula;
        this.modelo = modelo;
        this.color = color;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        if (numero < 1 || numero > 10) {
            throw new IllegalArgumentException("Número de espacio de estacionamiento no válido");
        }
        this.numero = numero;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    @Override
    public String toString() {
        return "EspacioEstacionamiento{" +
                "numero=" + numero +
                ", estado=" + estado +
                ", matricula='" + matricula + '\'' +
                ", modelo='" + modelo + '\'' +
                ", color='" + color + '\'' +
                '}';
    }
}
