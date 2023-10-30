USE Estudiante_111_202315;


CREATE TABLE IF NOT EXISTS Fecha (
	ID_Fecha int NOT NULL,
	Fecha date NOT NULL,
    Dia int NOT NULL,
    Mes int NOT NULL,
    Anyo int NOT NULL,
    Numero_Semana_ISO int NOT NULL,
    PRIMARY KEY (ID_Fecha)
);

CREATE TABLE IF NOT EXISTS Producto (
  ID_Producto_DWH int NOT NULL auto_increment,
  ID_Producto_T int NOT NULL,
  Nombre varchar(100),
  Marca varchar(50),
  Color  varchar(20) ,
  Necesitarefrigeracion boolean,
  Dias_tiempo_entrega int,
  cantidad_por_salida int ,
  Precio_minorista_recomendado decimal(10,2) ,
  Impuesto decimal(10,2) ,
  Precio_unitario decimal(10,0) ,
  PRIMARY KEY (ID_Producto_DWH)
);

CREATE TABLE IF NOT EXISTS Proveedor (
  ID_Proveedor_DWH int not NULL auto_increment,
  ID_Proveedor_T int not NULL,
  Nombre  varchar(100),
  Categoria varchar (50),
  Contacto_principal varchar(50),
  Dias_pago int ,
  Codigo_postal int,
  PRIMARY KEY (ID_Proveedor_DWH)
) ;

CREATE TABLE IF NOT EXISTS Cliente (
  ID_Cliente_DWH int not NULL auto_increment,
  ID_Cliente_T int not NULL,
  Nombre  varchar(100) not null,
  ClienteFactura int,
  ID_CiudadEntrega_DWH int,
  LimiteCredito DECIMAL(10,2),
  FechaAperturaCuenta date,
  DiasPago int ,
  NombreGrupoCompra varchar(50),
  NombreCategoria varchar(50),
  PRIMARY KEY (ID_Cliente_DWH)
) ;

CREATE TABLE IF NOT EXISTS TipoTransaccion (
  ID_Tipo_transaccion_DWH int not NULL auto_increment,
  ID_Tipo_transaccion_T int not NULL,
  Tipo varchar(50) not NULL,
  PRIMARY KEY (ID_Tipo_transaccion_DWH)
) ;

CREATE TABLE IF NOT EXISTS Hecho_Movimiento (
  ID_Fecha int NOT NULL,
  ID_Producto_DWH int NOT NULL,
  ID_Proveedor_DWH int NOT NULL,
  ID_Cliente_DWH int NOT NULL,
  ID_Tipo_transaccion_DWH int NOT NULL,
  Cantidad int,
  FOREIGN KEY(ID_Fecha) REFERENCES Fecha(ID_Fecha),
  FOREIGN KEY(ID_Proveedor_DWH) REFERENCES Proveedor(ID_Proveedor_DWH),
  FOREIGN KEY(ID_Producto_DWH) REFERENCES Producto(ID_Producto_DWH),
  FOREIGN KEY(ID_Cliente_DWH) REFERENCES Cliente(ID_Cliente_DWH),
  FOREIGN KEY(ID_Tipo_transaccion_DWH) REFERENCES TipoTransaccion(ID_Tipo_transaccion_DWH)
  
);


INSERT INTO Fecha (ID_Fecha, Fecha, Dia, Mes, Anyo, Numero_Semana_ISO)
VALUES
    (20231023, '2023-10-23', 23, 10, 2023, 43),
    (20231024, '2023-10-24', 24, 10, 2023, 43),
    (20231025, '2023-10-25', 25, 10, 2023, 43),
    (20231026, '2023-10-26', 26, 10, 2023, 43),
    (20231027, '2023-10-27', 27, 10, 2023, 43);

INSERT INTO Producto (ID_Producto_T, Nombre, Marca, Color, Necesitarefrigeracion, Dias_tiempo_entrega, cantidad_por_salida, Precio_minorista_recomendado, Impuesto, Precio_unitario)
VALUES
    ( 10, 'Producto A', 'Marca A', 'rojo', true, 3, 10, 25.99, 0.19, 20),
    ( 11, 'Producto B', 'Marca B', 'naranjaCliente', false, 5, 15, 19.99, 0.19, 15),
    ( 11, 'Producto C', 'Marca C', 'rojo', true, 2, 8, 34.50, 0.19, 30),
    ( 12, 'Producto D', 'Marca D', 'amarillo', false, 4, 12, 14.75, 0.19, 12),
    ( 13, 'Producto E', 'Marca E', 'verde', true, 7, 20, 28.99, 0.19, 25);


INSERT INTO Proveedor ( ID_Proveedor_T, Nombre, Categoria, Contacto_principal, Dias_pago, Codigo_postal)
VALUES
    ( 1001, 'Proveedor A', 'servicios de mensajeria', 'Eduardo Toledo', 30, 67890),
    ( 1002, 'Proveedor B', 'embalaje', 'Mario Torres', 45, 67891),
    ( 1003, 'Proveedor C', 'servicios de seguros', 'Carlos Melo', 60, 67892),
    ( 1004, 'Proveedor D', 'ropa', 'Laura Teo', 15, 67893),
    ( 1005, 'Proveedor E', 'juguetes', 'Pedro Rojas', 90, 67894);
    
INSERT INTO Cliente ( ID_Cliente_T, Nombre, ClienteFactura, ID_CiudadEntrega_DWH, LimiteCredito, FechaAperturaCuenta, DiasPago, NombreGrupoCompra, NombreCategoria)
VALUES
    ( 1001, 'Juan Pérez', 1, 1, 1000.00, '2023-01-15', 30, 'Grupo 1', 'Categoría A'),
    ( 1002, 'María López', 401, 2, 1500.00, '2022-11-20', 45, 'Grupo 2', 'Categoría B'),
    ( 1003, 'Carlos Gómez', 806, 3, 800.00, '2023-03-05', 60, 'Grupo 3', 'Categoría C'),
    ( 1004, 'Laura Rodríguez', 904, 4, 1200.00, '2023-04-10', 15, 'Grupo 1', 'Categoría A'),
    ( 1005, 'Pedro Martínez', 905, 5, 900.00, '2022-09-30', 90, 'Grupo 2', 'Categoría B');

INSERT INTO TipoTransaccion ( ID_Tipo_transaccion_T, Tipo)
VALUES
    ( 1001,'Customer Credit Note'),
    ( 1002,'Customer Payment Received'),
    ( 1003,'Customer Refund'),
    ( 1004, 'Supplier Invoice'),
    ( 1005,'Supplier Credit Note');

INSERT INTO Hecho_Movimiento (ID_Fecha, ID_Producto_DWH, ID_Proveedor_DWH, ID_Cliente_DWH, ID_Tipo_transaccion_DWH, Cantidad)
VALUES
    (20231023, 1, 1, 1, 1, 100),
    (20231024, 2, 2, 2, 2, 75),
    (20231025, 3, 3, 3, 3, 50),
    (20231026, 4, 4, 4, 4, 25),
    (20231027, 5, 5, 5, 5, 10);

# SENTENCIAS DE VERIFICACION

SELECT * FROM
Cliente;

SELECT * FROM
Proveedor;

SELECT * FROM
Producto;

SELECT * FROM 
Fecha;

SELECT * FROM 
TipoTransaccion;

SELECT * FROM Hecho_Movimiento;
    
#QUERY ANALITICO

SELECT
    HM.ID_Cliente_DWH,
    C.Nombre as NombreCliente,
    HM.ID_Proveedor_DWH,
    P.Nombre as NombreProveedor,
    HM.ID_Tipo_transaccion_DWH,
    COUNT(*) as NumeroProductosMovidos,
    SUM(HM.cantidad) as CantidadProductosMovidos
 
FROM Hecho_Movimiento HM 
INNER JOIN Fecha F ON HM.ID_Fecha = F.ID_Fecha
INNER JOIN Cliente C ON HM.ID_Cliente_DWH = C.ID_Cliente_DWH
INNER JOIN Proveedor P ON HM.ID_Proveedor_DWH = P.ID_Proveedor_DWH
WHERE F.Fecha BETWEEN '2023-01-01' AND '2023-12-31' 
GROUP BY HM.ID_Cliente_DWH, HM.ID_Proveedor_DWH, HM.ID_Tipo_transaccion_DWH;

