-- In this file you will find the SQL commands necessary to select and extract data from the db.

-- 1. Cliente con más alquileres en los últimos 6 meses
SELECT c.id_cliente, c.nombre, COUNT(a.id_alquiler) AS total_alquileres
FROM clientes c
JOIN alquileres a ON c.id_cliente = a.id_cliente
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.id_cliente
ORDER BY total_alquileres DESC
LIMIT 1;

-- 2. Cinco películas más alquiladas en el último año
SELECT p.id_pelicula, p.titulo, COUNT(a.id_alquiler) AS total_alquileres
FROM peliculas p
JOIN alquileres a ON p.id_pelicula = a.id_pelicula
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.id_pelicula
ORDER BY total_alquileres DESC
LIMIT 5;

-- 3. Total de ingresos y cantidad de alquileres por categoría
SELECT cat.id_categoria, cat.nombre, 
       SUM(a.costo) AS total_ingresos, 
       COUNT(a.id_alquiler) AS total_alquileres
FROM categorias cat
JOIN peliculas p ON cat.id_categoria = p.id_categoria
JOIN alquileres a ON p.id_pelicula = a.id_pelicula
GROUP BY cat.id_categoria;

-- 4. Clientes que han alquilado todas las películas de una misma categoría
SELECT c.id_cliente, c.nombre, cat.id_ca-- Funciones SQL

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
DELIMITER ;tegoria, cat.nombre
FROM clientes c
JOIN alquileres a ON c.id_cliente = a.id_cliente
JOIN peliculas p ON a.id_pelicula = p.id_pelicula
JOIN categorias cat ON p.id_categoria = cat.id_categoria
GROUP BY c.id_cliente, cat.id_categoria
HAVING COUNT(DISTINCT p.id_pelicula) = (
    SELECT COUNT(*) 
    FROM peliculas 
    WHERE id_categoria = cat.id_categoria
);

-- 5. Tres ciudades con más clientes activos en el último trimestre
SELECT ci.id_ciudad, ci.nombre, COUNT(DISTINCT c.id_cliente) AS total_clientes
FROM ciudades ci
JOIN clientes c ON ci.id_ciudad = c.id_ciudad
JOIN alquileres a ON c.id_cliente = a.id_cliente
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY ci.id_ciudad
ORDER BY total_clientes DESC
LIMIT 3;

-- 6. Cinco categorías con menos alquileres en el último año
SELECT cat.id_categoria, cat.nombre, COUNT(a.id_alquiler) AS total_alquileres
FROM categorias cat
JOIN peliculas p ON cat.id_categoria = p.id_categoria
JOIN alquileres a ON p.id_pelicula = a.id_pelicula
WHERE a.fecha_alquiler >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY cat.id_categoria
ORDER BY total_alquileres ASC
LIMIT 5;

-- 7. Promedio de días que un cliente tarda en devolver películas
SELECT id_cliente, AVG(DATEDIFF(fecha_devolucion, fecha_alquiler)) AS promedio_dias
FROM alquileres
GROUP BY id_cliente;

-- 8. Cinco empleados que gestionaron más alquileres en la categoría de Acción
SELECT e.id_empleado, e.nombre, COUNT(a.id_alquiler) AS total_alquileres
FROM empleados e
JOIN alquileres a ON e.id_empleado = a.id_empleado
JOIN peliculas p ON a.id_pelicula = p.id_pelicula
JOIN categorias cat ON p.id_categoria = cat.id_categoria
WHERE cat.nombre = 'Acción'
GROUP BY e.id_empleado
ORDER BY total_alquileres DESC
LIMIT 5;

-- 9. Clientes con alquileres más recurrentes
SELECT c.id_cliente, c.nombre, COUNT(a.id_alquiler) AS total_alquileres
FROM clientes c
JOIN alquileres a ON c.id_cliente = a.id_cliente
GROUP BY c.id_cliente
ORDER BY total_alquileres DESC;

-- 10. Costo promedio de alquiler por idioma
SELECT i.id_idioma, i.nombre, AVG(a.costo) AS costo_promedio
FROM idiomas i
JOIN peliculas p ON i.id_idioma = p.id_idioma
JOIN alquileres a ON p.id_pelicula = a.id_pelicula
GROUP BY i.id_idioma;