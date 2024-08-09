--Crear Base de datos
CREATE DATABASE DB_Fast_Food

--Crear 10 Tablas
USE DB_Fast_Food

CREATE TABLE OrigenesOrden(
	OrigenID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255));

CREATE TABLE Categorias(
	CategoriaID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255));

CREATE TABLE Productos(
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL, --Mandatorio
	CategoriaID INT,
	Precio DECIMAL (10,2) NOT NULL);

CREATE TABLE Clientes(
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255));


CREATE TABLE TiposPago(
	TipoPagoID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255) NOT NULL);


CREATE TABLE Mensajeros(
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	EsExterno BIT NOT NULL);


CREATE TABLE Empleados(
	EmpleadoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Posicion VARCHAR (255),
	Departamento VARCHAR (255),
	SucursalID INT,
	Rol VARCHAR (255));

CREATE TABLE Sucursales(
	SucursalID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255)
	);

CREATE TABLE Ordenes(
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT ,
	EmpleadoID INT,
	SucursalID INT ,
	MensajeroID INT ,
	TipoPagoID INT ,
	OrigenID INT ,
	HorarioVenta VARCHAR(50), --Jornadas: ma�ana, tarde, noche
	TotalCompra DECIMAL (10,2), 
	KilometrosRecorrer DECIMAL (10,2),
	FechaDespacho DATETIME,
	FechaEntrega DATETIME,
	FechaOrdenTomada DATETIME,
	FechaOrdenLista DATETIME);

CREATE TABLE DetalleOrdenes(
	PRIMARY KEY (OrdenID, ProductoID),
	OrdenID INT ,
	ProductoiD INT ,
	Cantidad INT,
	Precio DECIMAL (10,2) NOT NULL);
	
--Definir Relaciones entre tablas 

--FK DetalleOrdenes - Ordenes - OrdenID
ALTER TABLE DetalleOrdenes
ADD CONSTRAINT FK_Ordenes_DetalleOrdenes_OrdenID
FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID);

--FK DetalleOrdenes - Ordenes - ProductoID
ALTER TABLE DetalleOrdenes
ADD CONSTRAINT FK_Ordenes_DetalleOrdenes_ProductoID
FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID);

--FK Ordenes-Clientes
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Clientes
FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID);


--FK Ordenes-Empleados
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Empleados
FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID);

--FK Ordenes-Sucursales
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Sucursales
FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID);

--FK Ordenes-Mensajeros
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Mensajeros
FOREIGN KEY (MensajeroID) REFERENCES Mensajeros(MensajeroID);

--FK Ordenes-TipoPago
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_TipoPago
FOREIGN KEY (TipoPagoID) REFERENCES TiposPago(TipoPagoID);

--FK Ordenes-OrigenesOrden
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_OrigenesOrden
FOREIGN KEY (OrigenID) REFERENCES OrigenesOrden(OrigenID);

--FK Productos-Categorias
ALTER TABLE Productos
ADD CONSTRAINT FK_Productos_Categorias
FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID);

--FK Empleados-Sucursales
ALTER TABLE Empleados
ADD CONSTRAINT FK_Empleados_Sucursales
FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID);


/* INSERCI�N DE DATOS */

-- Insertar datos en Categorias
INSERT INTO Categorias (Nombre) VALUES
('Comida R�pida'), ('Postres'), ('Bebidas'), ('Ensaladas'), ('Desayunos'),
('Cafeter�a'), ('Helados'), ('Comida Vegana'), ('Carnes'), ('Pizzas');

Select * from Categorias

-- Insertar datos en Productos
INSERT INTO Productos (Nombre, CategoriaID, Precio) VALUES
('Hamburguesa Deluxe', 1, 9.99), ('Cheeseburger', 1, 7.99), ('Pizza Margarita', 10, 11.99), ('Pizza Pepperoni', 10, 12.99), ('Helado de Chocolate', 7, 2.99),
('Helado de Vainilla', 7, 2.99), ('Ensalada C�sar', 4, 5.99), ('Ensalada Griega', 4, 6.99), ('Pastel de Zanahoria', 2, 3.99), ('Brownie', 2, 2.99);

Select * from Productos

-- Insertar datos en Sucursales
INSERT INTO Sucursales (Nombre, Direccion) VALUES
('Sucursal Central', '1234 Main St'), ('Sucursal Norte', '5678 North St'), ('Sucursal Este', '9101 East St'), ('Sucursal Oeste', '1121 West St'), ('Sucursal Sur', '3141 South St'),
('Sucursal Playa', '1516 Beach St'), ('Sucursal Monta�a', '1718 Mountain St'), ('Sucursal Valle', '1920 Valley St'), ('Sucursal Lago', '2122 Lake St'), ('Sucursal Bosque', '2324 Forest St');

Select * from Sucursales

-- Insertar datos en Empleados
INSERT INTO Empleados (Nombre, Posicion, Departamento, SucursalID, Rol) VALUES
('John Doe', 'Gerente', 'Administraci�n', 1, 'Vendedor'), ('Jane Smith', 'Subgerente', 'Ventas', 1, 'Vendedor'), ('Bill Jones', 'Cajero', 'Ventas', 1, 'Vendedor'), ('Alice Johnson', 'Cocinero', 'Cocina', 1, 'Vendedor'), ('Tom Brown', 'Barista', 'Cafeter�a', 1, 'Vendedor'),
('Emma Davis', 'Repartidor', 'Log�stica', 1, 'Mensajero'), ('Lucas Miller', 'Atenci�n al Cliente', 'Servicio', 1, 'Vendedor'), ('Olivia Garc�a', 'Encargado de Turno', 'Administraci�n', 1, 'Vendedor'), ('Ethan Martinez', 'Mesero', 'Restaurante', 1, 'Vendedor'), ('Sophia Rodriguez', 'Auxiliar de Limpieza', 'Mantenimiento', 1, 'Vendedor');

Select * from Empleados

-- Insertar datos en Clientes
INSERT INTO Clientes (Nombre, Direccion) VALUES
('Cliente Uno', '1000 A Street'), ('Cliente Dos', '1001 B Street'), ('Cliente Tres', '1002 C Street'), ('Cliente Cuatro', '1003 D Street'), ('Cliente Cinco', '1004 E Street'),
('Cliente Seis', '1005 F Street'), ('Cliente Siete', '1006 G Street'), ('Cliente Ocho', '1007 H Street'), ('Cliente Nueve', '1008 I Street'), ('Cliente Diez', '1009 J Street');

Select * from Clientes

-- Insertar datos en OrigenesOrden
INSERT INTO OrigenesOrden (Descripcion) VALUES
('En l�nea'), ('Presencial'), ('Tel�fono'), ('Drive Thru'), ('App M�vil'),
('Redes Sociales'), ('Correo Electr�nico'), ('Publicidad'), ('Recomendaci�n'), ('Evento');

Select * from OrigenesOrden

-- Insertar datos en TiposPago
INSERT INTO TiposPago (Descripcion) VALUES
('Efectivo'), ('Tarjeta de Cr�dito'), ('Tarjeta de D�bito'), ('PayPal'), ('Transferencia Bancaria'),
('Criptomonedas'), ('Cheque'), ('Vale de Comida'), ('Cup�n de Descuento'), ('Pago M�vil');

Select * from TiposPago

-- Insertar datos en Mensajeros
INSERT INTO Mensajeros (Nombre, EsExterno) VALUES
('Mensajero Uno', 0), ('Mensajero Dos', 1), ('Mensajero Tres', 0), ('Mensajero Cuatro', 1), ('Mensajero Cinco', 0),
('Mensajero Seis', 1), ('Mensajero Siete', 0), ('Mensajero Ocho', 1), ('Mensajero Nueve', 0), ('Mensajero Diez', 1);

Select * from Mensajeros

-- Insertar datos en Ordenes
INSERT INTO Ordenes (ClienteID, EmpleadoID, SucursalID, MensajeroID, TipoPagoID, OrigenID, HorarioVenta, TotalCompra, KilometrosRecorrer, FechaDespacho, FechaEntrega, FechaOrdenTomada, FechaOrdenLista) VALUES
(1, 1, 1, 1, 1, 1, 'Ma�ana', 50.00, 5.5, '2023-01-10 08:30:00', '2023-01-10 09:00:00', '2023-01-10 08:00:00', '2023-01-10 08:15:00'),
(2, 2, 2, 2, 2, 2, 'Tarde', 75.00, 10.0, '2023-02-15 14:30:00', '2023-02-15 15:00:00', '2023-02-15 13:30:00', '2023-02-15 14:00:00'),
(3, 3, 3, 3, 3, 3, 'Noche', 20.00, 2.0, '2023-03-20 19:30:00', '2023-03-20 20:00:00', '2023-03-20 19:00:00', '2023-03-20 19:15:00'),
(4, 4, 4, 4, 4, 4, 'Ma�ana', 30.00, 0.5, '2023-04-25 09:30:00', '2023-04-25 10:00:00', '2023-04-25 09:00:00', '2023-04-25 09:15:00'),
(5, 5, 5, 5, 5, 5, 'Tarde', 55.00, 8.0, '2023-05-30 15:30:00', '2023-05-30 16:00:00', '2023-05-30 15:00:00', '2023-05-30 15:15:00'),
(6, 6, 6, 6, 6, 1, 'Noche', 45.00, 12.5, '2023-06-05 20:30:00', '2023-06-05 21:00:00', '2023-06-05 20:00:00', '2023-06-05 20:15:00'),
(7, 7, 7, 7, 7, 2, 'Ma�ana', 65.00, 7.5, '2023-07-10 08:30:00', '2023-07-10 09:00:00', '2023-07-10 08:00:00', '2023-07-10 08:15:00'),
(8, 8, 8, 8, 8, 3, 'Tarde', 85.00, 9.5, '2023-08-15 14:30:00', '2023-08-15 15:00:00', '2023-08-15 14:00:00', '2023-08-15 14:15:00'),
(9, 9, 9, 9, 9, 4, 'Noche', 95.00, 3.0, '2023-09-20 19:30:00', '2023-09-20 20:00:00', '2023-09-20 19:00:00', '2023-09-20 19:15:00'),
(10, 10, 10, 10, 10, 5, 'Ma�ana', 100.00, 15.0, '2023-10-25 09:30:00', '2023-10-25 10:00:00', '2023-10-25 09:00:00', '2023-10-25 09:15:00');

Select * from Ordenes

-- Insertar datos en DetalleOrdenes
INSERT INTO DetalleOrdenes (OrdenID, ProductoID, Cantidad, Precio) VALUES
(1, 1, 3, 23.44),
(1, 2, 5, 45.14),
(1, 3, 4, 46.37),
(1, 4, 4, 42.34),
(1, 5, 1, 18.25),
(1, 6, 4, 20.08),
(1, 7, 2, 13.31),
(1, 8, 2, 20.96),
(1, 9, 4, 30.13),
(1, 10, 3, 38.34);

Select * from DetalleOrdenes



--UPDATE Y DELETE

--ACTUALIZACIONES DE EJEMPLO (UPDATE)

-- Aumentar el precio de todos los productos en la categor�a 1
UPDATE Productos SET Precio = Precio + 1 WHERE CategoriaID = 1;

-- Cambiar la posici�n de todos los empleados del departamento 'Cocina' a 'Chef'
UPDATE Empleados SET Posicion = 'Chef' WHERE Departamento = 'Cocina';

-- Actualizar la direcci�n de una sucursal espec�fica
UPDATE Sucursales SET Direccion = '1234 New Address St' WHERE SucursalID = 1;

--ELIMINACIONES DE EJEMPLO (DELETE)

/*1. Eliminar una orden espec�fica
Imaginemos que quieres eliminar una orden espec�fica, 
por ejemplo, la orden con OrdenID = 10. 
Esta operaci�n eliminar�a la orden junto con sus detalles asociados 
(deber�as asegurarte de eliminar o actualizar cualquier dato relacionado 
para mantener la integridad referencial).*/

DELETE FROM DetalleOrdenes WHERE OrdenID = 10;
DELETE FROM Ordenes WHERE OrdenID = 10;

/*2. Eliminar todos los productos de una categor�a espec�fica
Si decides dejar de ofrecer todos los "Postres" 
(supongamos que Categorias.CategoriaID = 2 para "Postres"), 
podr�as querer eliminar todos los productos asociados a esa categor�a.*/

DELETE FROM Productos WHERE CategoriaID = 2;
--Antes de ejecutar este comando, deber�as considerar si hay �rdenes que incluyen estos productos y decidir c�mo manejar esas referencias.

/*3. Eliminar empleados de una sucursal que cerr�
Si una sucursal cierra, por ejemplo, 
SucursalID = 10 (Sucursal Bosque), 
podr�as necesitar eliminar a todos los empleados asociados con esa sucursal.*/

DELETE FROM Empleados WHERE SucursalID = 10;



--�Cu�l es la cantidad total de registros �nicos en la tabla de �rdenes?

SELECT COUNT(DISTINCT OrdenID) AS CantidadTotalRegistrosUnicos
FROM Ordenes;

--�Cu�ntos empleados existen en cada departamento?

SELECT COUNT(DISTINCT EmpleadoID) AS NumeroEmpleados, Departamento
FROM Empleados
GROUP BY Departamento;

--�Cu�ntos productos hay por c�digo de categor�a?

SELECT COUNT(DISTINCT ProductoID) AS CantidadProductos, CategoriaID
FROM Productos
GROUP BY CategoriaID
ORDER BY CantidadProductos ASC;

--�Cu�ntos clientes se han importado a la tabla de clientes?

SELECT COUNT(DISTINCT ClienteID) AS CantidadClientes
FROM Clientes;

/*�Cu�les son las sucursales con un promedio de ventas por orden superior a un valor espec�fico, 
ordenadas por el promedio de kil�metros recorridos para las entregas de mayor a menor?*/

SELECT SucursalID,
       AVG(TotalCompra) AS PromedioTotalCompra,
       AVG(KilometrosRecorrer) AS PromedioKilometrosRecorrer
FROM Ordenes
GROUP BY SucursalID
ORDER BY PromedioKilometrosRecorrer DESC;

--Consultas 3er Avance

--1. �Cu�l es el total de ventas (TotalCompra) a nivel global?
SELECT SUM(TotalCompra) AS TotalVentasGlobal
FROM Ordenes

--2. �Cu�l es el precio promedio de los productos dentro de cada categor�a?

SELECT CategoriaID, AVG(Precio) AS AvgPriceCategory
FROM Productos
GROUP BY CategoriaID;

--3. �Cu�l es el valor de la orden m�nima y m�xima por cada sucursal?

SELECT SucursalID, MIN(TotalCompra) AS OrdenMinima, MAX(TotalCompra) AS OrdenMaxima
FROM Ordenes
GROUP BY  SucursalID;

--4. �Cu�l es el mayor n�mero de kil�metros recorridos para una entrega?

SELECT MAX(KilometrosRecorrer) AS EntregaMaxKilometros
FROM Ordenes

--5. �Cu�l es la cantidad promedio de productos por orden?

SELECT AVG(Cantidad) AS AvgCantidadPorOrden
FROM DetalleOrdenes

--6. �Cu�l es el total de ventas por cada tipo de pago?

SELECT SUM(TotalCompra) AS TotalVentaPorTipodePago
FROM Ordenes
GROUP BY TipoPagoID

--7. �Cu�l sucursal tiene la venta promedio m�s alta?

SELECT TOP 1
	SucursalID, 
	AVG(TotalCompra) AS AvgTotalVentasSucursal
	FROM Ordenes
	GROUP BY SucursalID
	ORDER BY AvgTotalVentasSucursal DESC;

--8. �Cu�les son las sucursales que han generado ventas por orden por encima de $100, y c�mo se comparan en t�rminos del total de ventas?

SELECT SucursalID, TotalCompra
FROM Ordenes
WHERE TotalCompra > 100;

SELECT SUM(TotalCompra) AS TotalVentas
FROM Ordenes

--9. �C�mo se comparan las ventas promedio antes y despu�s del 1 de julio de 2023?

SELECT 
	(SELECT AVG(TotalCompra) FROM Ordenes WHERE FechaOrdenTomada < '2023-07-01 00:00:01.000') AS AvgVentasAntes1Julio,
	(SELECT AVG(TotalCompra) FROM Ordenes WHERE FechaOrdenTomada >= '2023-07-01 00:00:01.000') AS AvgVentasDespu�s1Julio;


---10. �Durante qu� horario del d�a (ma�ana, tarde, noche) se registra la mayor cantidad de ventas, 
--cu�l es el valor promedio de estas ventas, y cu�l ha sido la venta m�xima alcanzada?

SELECT * FROM Ordenes

SELECT TOP 1
	HorarioVenta, 
	SUM(TotalCompra) AS TotalVentas,
	AVG(TotalCompra) AS AvgVentas,
	MAX(TotalCompra) AS MaxVenta
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY TotalVentas DESC;

/*
--------------------
UNI�N DE TABLAS  4 AVANCE
--------------------
*/

-- 1. �C�mo puedo obtener una lista de todos los productos junto con sus categor�as?

SELECT p.ProductoID, p.Nombre AS NombreProducto, c.Nombre AS NombreCategoria
FROM Productos p
INNER JOIN Categorias c ON p.CategoriaID = c.CategoriaID;

-- 2. �C�mo puedo saber a qu� sucursal est� asignado cada empleado?

SELECT e.EmpleadoID, e.Nombre, e.SucursalID, s.Nombre
FROM Empleados e
INNER JOIN Sucursales s ON e.SucursalID = s.SucursalID


-- 3. �Existen productos que no tienen una categor�a asignada?

SELECT * 
FROM Productos p
LEFT JOIN Categorias c ON p.CategoriaID=c.CategoriaID
WHERE p.CategoriaID is not null

-- 4. �C�mo puedo obtener un detalle completo de las �rdenes, incluyendo cliente, empleado que tom� la orden, y el mensajero que la entreg�?

SELECT 
	o.*,
	c.Nombre AS NombreCliente,
	e.Nombre AS NombreVendedor,
	m.Nombre AS NombreMensajero
from Ordenes o
INNER JOIN Clientes c ON c.ClienteID = o.ClienteID
INNER JOIN Empleados e ON e.EmpleadoID = o.EmpleadoID
INNER JOIN Mensajeros m ON m.MensajeroID = o.MensajeroID;

-- 5. �Cu�ntos productos --de cada tipo-- se han vendido en cada sucursal?

--En el code review se hizo menci�n de que se deb�a omitir la frase "de cada tipo" de la consulta.
--La siguiente consulta devuelve la cantidad de productos vendidos en cada sucursal seg�n cada producto individual.

SELECT 
	p.Nombre AS Producto,
    s.Nombre AS Sucursal,
	SUM(d.Cantidad) AS Cantidad

FROM DetalleOrdenes d
INNER JOIN Ordenes o ON d.OrdenID = o.OrdenID
INNER JOIN Productos p ON d.ProductoID = p.ProductoID
INNER JOIN Sucursales s ON s.SucursalID = o.SucursalID
GROUP BY p.Nombre, s.Nombre

/* 6. �Qu� porcentaje de clientes son recurrentes versus nuevos clientes cada mes? 
NOTA: La consulta se enfocar�a en la frecuencia de �rdenes por cliente para inferir la fidelidad.*/

SELECT T2.Nombre AS Cliente, COUNT(OrdenID) AS OrdenesRealizadas, MONTH(T1.FechaOrdenLista) AS Mes,
	CASE
	WHEN COUNT(OrdenID) = 1 THEN 'Nuevo'
	ELSE 'Recurrente'
	END AS FidelidadCliente
FROM Ordenes AS T1
INNER JOIN Clientes AS T2 ON T1.ClienteID=T2.ClienteID
GROUP BY T2.Nombre, MONTH(T1.FechaOrdenLista)


