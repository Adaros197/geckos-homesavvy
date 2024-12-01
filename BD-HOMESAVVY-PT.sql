DROP DATABASE IF EXISTS HOMESAVVY;
CREATE DATABASE HOMESAVVY;

USE HOMESAVVY;

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50),
    apellido_pat VARCHAR(50),
    apellido_mat VARCHAR(50),
    num_tel VARCHAR(15),
    email_client VARCHAR(50),
    direccion VARCHAR(100),
    contrasena VARCHAR(50),
    comp_domicilio BLOB,
    INE BLOB
);

CREATE TABLE Experto (
    id_experto INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50),
    apellido_pat VARCHAR(50),
    apellido_mat VARCHAR(50),
    num_tel VARCHAR(15),
    email_exp VARCHAR(50),
    contrasena VARCHAR(50),
    RFC VARCHAR(20),
    profesion VARCHAR(50),
    foto_perfil BLOB,
    INE BLOB,
    comp_domicilio BLOB,
    constancia BLOB,
    cartas_recomendacion BLOB,
    antecedentes_no_penales BLOB,
    curriculum_vitae BLOB
);

CREATE TABLE Servicio (
    id_servicio INT PRIMARY KEY auto_increment,
    id_cliente INT,
    id_experto INT,
    profesion_sol VARCHAR(50),
    precio DECIMAL(10, 2),
    descripcion TEXT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_experto) REFERENCES Experto(id_experto) ON DELETE CASCADE
);

CREATE TABLE Trabajo (
    id_trabajo INT PRIMARY KEY auto_increment,
    id_cliente INT,
    id_experto INT,
    descripcion TEXT,
    tipo_trabajo VARCHAR(15),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_experto) REFERENCES Experto(id_experto) ON DELETE CASCADE
);

INSERT INTO Cliente (nombre, apellido_pat, apellido_mat, num_tel, email_client, direccion, contrasena, comp_domicilio, INE) VALUES
('Juan', 'Perez', 'Garcia', '5512345678', 'juan.perez@example.com', 'Calle Falsa 123, Ciudad, Estado', 'password1', NULL, NULL),
('Maria', 'Lopez', 'Martinez', '5523456789', 'maria.lopez@example.com', 'Avenida Siempre Viva 456, Ciudad, Estado', 'password2', NULL, NULL),
('Carlos', 'Hernandez', 'Rodriguez', '5534567890', 'carlos.hernandez@example.com', 'Boulevard de los Sueños 789, Ciudad, Estado', 'password3', NULL, NULL),
('Ana', 'Gonzalez', 'Diaz', '5545678901', 'ana.gonzalez@example.com', 'Calle de la Esperanza 101, Ciudad, Estado', 'password4', NULL, NULL),
('Luis', 'Ramirez', 'Sanchez', '5556789012', 'luis.ramirez@example.com', 'Avenida de la Paz 202, Ciudad, Estado', 'password5', NULL, NULL);

INSERT INTO Experto (nombre, apellido_pat, apellido_mat, num_tel, email_exp, contrasena, RFC, profesion, foto_perfil, INE, comp_domicilio, constancia, cartas_recomendacion, antecedentes_no_penales, curriculum_vitae) VALUES
('Luis', 'Garcia', 'Gomez', '5512345678', 'luis.garcia@example.com', 'expertpass1', 'RFC123456789', 'Electricista', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Lucia', 'Martinez', 'Vega', '5523456789', 'lucia.martinez@example.com', 'expertpass2', 'RFC987654321', 'Plomero', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Miguel', 'Torres', 'Hernandez', '5534567890', 'miguel.torres@example.com', 'expertpass3', 'RFC567890123', 'Carpintero', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Sofia', 'Ruiz', 'Lopez', '5545678901', 'sofia.ruiz@example.com', 'expertpass4', 'RFC123098456', 'Jardinero', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Andres', 'Perez', 'Mendoza', '5556789012', 'andres.perez@example.com', 'expertpass5', 'RFC654321987', 'Pintor', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO Servicio (id_cliente, id_experto, profesion_sol, precio, descripcion) VALUES
(1, NULL, 'Electricista', 1500.00, 'Reparacion de instalacion electrica'),
(1, NULL, 'Plomero', 1200.00, 'Reparacion de fuga de agua'),
(1, 1, 'Carpintero', 2000.00, 'Construccion de mueble a medida'),
(1, 1, 'Jardinero', 800.00, 'Mantenimiento de jardin'),
(1, 1, 'Pintor', 1300.00, 'Pintura de interiores');

INSERT INTO Trabajo (id_cliente, id_experto, descripcion, tipo_trabajo) VALUES
(NULL, 1, 'Reparacion de cableado en sala', 'Electrico'),
(NULL, 1, 'Arreglo de tuberia en cocina', 'Plomeria'),
(1, 1, 'Fabricacion de estante de madera', 'Carpinteria'),
(1, 1, 'Poda y arreglo de plantas', 'Jardineria'),
(1, 1, 'Pintura de habitacion principal', 'Pintura');

CREATE TABLE Cliente_respaldo LIKE Cliente;
CREATE TABLE Experto_respaldo LIKE Experto;
CREATE TABLE Servicio_respaldo LIKE Servicio;
CREATE TABLE Trabajo_respaldo LIKE Trabajo;


DELIMITER $$

CREATE TRIGGER antes_de_actualizar_cliente
BEFORE UPDATE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Cliente_respaldo SELECT * FROM Cliente WHERE id_cliente = OLD.id_cliente;
END $$

CREATE TRIGGER antes_de_eliminar_cliente
BEFORE DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Cliente_respaldo SELECT * FROM Cliente WHERE id_cliente = OLD.id_cliente;
END $$


CREATE TRIGGER antes_de_actualizar_experto
BEFORE UPDATE ON Experto
FOR EACH ROW
BEGIN
    INSERT INTO Experto_respaldo SELECT * FROM Experto WHERE id_experto = OLD.id_experto;
END $$

CREATE TRIGGER antes_de_eliminar_experto
BEFORE DELETE ON Experto
FOR EACH ROW
BEGIN
    INSERT INTO Experto_respaldo SELECT * FROM Experto WHERE id_experto = OLD.id_experto;
END $$


CREATE TRIGGER antes_de_actualizar_servicio
BEFORE UPDATE ON Servicio
FOR EACH ROW
BEGIN
    INSERT INTO Servicio_respaldo SELECT * FROM Servicio WHERE id_servicio = OLD.id_servicio;
END $$

CREATE TRIGGER antes_de_eliminar_servicio
BEFORE DELETE ON Servicio
FOR EACH ROW
BEGIN
    INSERT INTO Servicio_respaldo SELECT * FROM Servicio WHERE id_servicio = OLD.id_servicio;
END $$


CREATE TRIGGER antes_de_actualizar_trabajo
BEFORE UPDATE ON Trabajo
FOR EACH ROW
BEGIN
    INSERT INTO Trabajo_respaldo SELECT * FROM Trabajo WHERE id_trabajo = OLD.id_trabajo;
END $$

CREATE TRIGGER antes_de_eliminar_trabajo
BEFORE DELETE ON Trabajo
FOR EACH ROW
BEGIN
    INSERT INTO Trabajo_respaldo SELECT * FROM Trabajo WHERE id_trabajo = OLD.id_trabajo;
END $$

DELIMITER ;


SELECT * FROM Cliente;
SELECT * FROM Experto;
SELECT * FROM Servicio;
SELECT * FROM Trabajo;
SELECT * FROM Cliente_respaldo;
SELECT * FROM Experto_respaldo;
SELECT * FROM Servicio_respaldo;
SELECT * FROM Trabajo_respaldo;