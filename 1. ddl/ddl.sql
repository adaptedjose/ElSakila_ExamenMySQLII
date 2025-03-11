-- In this folder you will find the SQL commands necessary to create the tables of the previous relational model of the database.

-- 1. Table pais - Done

create table pais(
	id_pais smallint unsigned primary key,
	nombre varchar(50),
	utlima_actualizacion timestamp
);

-- 2. Table ciudad - Done

create table ciudad(
	id_ciudad smallint unsigned primary key,
	direccion varchar(50),
	id_pais smallint unsigned,
	ultima_actualizacion timestamp,
	foreign key (id_pais) references pais(id_pais)
);

-- 3. Table direccion - Done

create table direccion(
	id_direccion smallint unsigned primary key,
	direccion varchar(50),
	direccion2 varchar(50),
	distrito varchar(20),
	id_ciudad smallint unsigned,
	codigo_postal varchar(10),
	telefono varchar(20),
	ultima_actualizacion timestamp,
	foreign key (id_ciudad) references ciudad(id_ciudad)
);

-- 4. Table almacen - Done

create table almacen(
	id_almacen tinyint unsigned primary key,
	id_empleado_jefe tinyint unsigned,
	id_direccion smallint unsigned,
	ultima_actualizacion timestamp,
	foreign key (id_direccion) references direccion(id_direccion)
);

-- 5. Table empleado - Done

create table empleado(
	id_empleado tinyint unsigned primary key,
	nombre varchar(45),
	apellidos varchar(45),
	id_direccion smallint unsigned,
	imagen blob,
	email varchar(50),
	id_almacen tinyint unsigned,
	activo tinyint(1),
	username varchar(16),
	password varchar(40),
	ultima_actualizacion timestamp,
	foreign key (id_direccion) references direccion(id_direccion),
	foreign key (id_almacen) references almacen(id_almacen)
);

-- 6. Table idioma - Done

create table idioma(
	id_idioma tinyint unsigned primary key,
	nombre char(20),
	ultima_actualizacion timestamp
);

-- 7. Table pelicula - Done

create table pelicula(
	id_pelicula smallint unsigned primary key,
	titulo varchar(255),
	descripcion text,
	anyo_lanzamiento year,
	id_idioma tinyint unsigned,
	id_idioma_original tinyint unsigned,
	duracion_alquiler tinyint unsigned,
	rental_rate decimal(4, 2),
	duracion smallint unsigned,
	replacement_cost decimal(5, 2),
	clasificacion enum('G', 'PG', 'PG-13', 'R', 'NC-17') default 'G',
	caracteristicas_especiales set('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the scenes'),
	ultima_actualizacion timestamp,
	foreign key (id_idioma) references idioma(id_idioma)
);

-- 8. Table actor - Done

create table actor(
	id_actor smallint unsigned primary key,
	nombre varchar(45),
	apellidos varchar(45),
	ultima_actualizacion timestamp
);

-- 9. Table pelicula_actor - Done

create table pelicula_actor(
	id_actor smallint unsigned,
	id_pelicula smallint unsigned,
	primary key (id_actor, id_pelicula),
	foreign key (id_actor) references actor(id_actor),
	foreign key (id_pelicula) references pelicula(id_pelicula)
);

-- 10. Table categoria - Done

create table categoria(
	id_categoria tinyint unsigned primary key,
	nombre varchar(25),
	ultima_actualizacion timestamp
);

-- 11. Table pelicula_categoria - Done

create table pelicula_categoria(
	id_pelicula smallint unsigned,
	id_categoria tinyint unsigned,
	primary key(id_pelicula, id_categoria),
	foreign key (id_pelicula) references pelicula(id_pelicula),
	foreign key (id_categoria) references categoria(id_categoria)
);

-- 12. Table film_text - Done

create table film_text(
	film_id smallint primary key,
	title varchar(255),
	description text
);

-- 13. Table inventario - Done

create table inventario(
	id_inventario mediumint unsigned primary key,
	id_pelicula smallint unsigned,
	id_almacen tinyint unsigned,
	ultima_actualizacion timestamp,
	foreign key (id_pelicula) references pelicula(id_pelicula),
	foreign key (id_almacen) references almacen(id_almacen)
);


-- 14. Table cliente - Done

create table cliente(
	id_cliente smallint unsigned primary key,
	id_almacen tinyint unsigned,
	nombre varchar(45),
	apellidos varchar(45),
	email varchar(50),
	id_direccion smallint unsigned,
	activo tinyint(1),
	fecha_creacion datetime,
	ultima_actualizacion timestamp,
	foreign key (id_almacen) references almacen(id_almacen),
	foreign key (id_direccion) references direccion(id_direccion)
); 

-- 15. Table alquiler - Done 

create table alquiler(
	id_alquiler int primary key,
	fecha_alquiler datetime,
	id_inventario mediumint unsigned,
	id_cliente smallint unsigned,
	fecha_devolucion datetime,
	id_empleado tinyint unsigned,
	ultima_actualizacion timestamp,
	foreign key (id_inventario) references inventario(id_inventario),
	foreign key (id_cliente) references cliente(id_cliente),
	foreign key (id_empleado) references empleado(id_empleado)
);

-- 16. Table pago - Done

create table pago(
	id_pago smallint unsigned primary key,
	id_cliente smallint unsigned,
	id_empleado tinyint unsigned,
	id_alquiler int,
	total decimal(5, 2),
	fecha_pago datetime,
	ultima_actualizacion timestamp,
	foreign key (id_cliente) references cliente(id_cliente),
	foreign key (id_empleado) references empleado(id_empleado),
	foreign key (id_alquiler) references alquiler(id_alquiler)
);
