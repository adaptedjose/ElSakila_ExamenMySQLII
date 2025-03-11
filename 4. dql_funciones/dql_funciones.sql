-- In this file you will find the SQL commands necessary to create the functions working in the db.

-- Funciones SQL

-- 1. TotalIngresosCliente
DELIMITER //
CREATE FUNCTION TotalIngresosCliente(id_cliente INT, año INT) 
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(costo) INTO total
    FROM alquileres
    WHERE id_cliente = id_cliente AND YEAR(fecha_alquiler) = año;
    RETURN total;
END //
DELIMITER ;

-- 2. PromedioDuracionAlquiler
DELIMITER //
CREATE FUNCTION PromedioDuracionAlquiler(id_pelicula INT) 
RETURNS INT
BEGIN
    DECLARE promedio INT;
    SELECT AVG(DATEDIFF(fecha_devolucion, fecha_alquiler)) INTO promedio
    FROM alquileres
    WHERE id_pelicula = id_pelicula;
    RETURN promedio;
END //
DELIMITER ;

-- 3. IngresosPorCategoria
DELIMITER //
CREATE FUNCTION IngresosPorCategoria(id_categoria INT) 
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(a.costo) INTO total
    FROM alquileres a
    JOIN peliculas p ON a.id_pelicula = p.id_pelicula
    WHERE p.id_categoria = id_categoria;
    RETURN total;
END //
DELIMITER ;