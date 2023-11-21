# Creacion de tabla de visualizacion de ventas
DROP TABLE InventarioDatamart7000;
DROP TABLE InventarioDatamart;


# Esquema de solamente 7000 registros para acelerar el desarrollo
CREATE TABLE InventarioDatamart7000(
	Fecha datetime,
    Dia tinyint,
    Mes varchar(20),
    Anyo smallint,
    Cliente varchar(100),
    CiudadEntrega varchar(50),
    PaisEntrega varchar(50),
    DiasPagoCliente int,
    LimiteCreditoCliente decimal(10,2),
    GrupoCompra varchar(50),
    Proveedor varchar(100),
    DiasPagoProv int,
    TipoTran varchar(100),
    Cantidad int,
    Producto varchar(100),
    Marca  varchar(100),
    PrecioUnitario decimal(10,0),
    Impuesto decimal(10,0)
);

#Esquema para todos los registros
CREATE TABLE InventarioDatamart(
	Fecha datetime,
    Dia tinyint,
    Mes varchar(20),
    Anyo smallint,
    Cliente varchar(100),
    CiudadEntrega varchar(50),
    PaisEntrega varchar(50),
    DiasPagoCliente int,
    LimiteCreditoCliente decimal(10,2),
    GrupoCompra varchar(50),
    Proveedor varchar(100),
    DiasPagoProv int,
    TipoTran varchar(100),
    Cantidad int,
    Producto varchar(100),
    Marca  varchar(100),
    PrecioUnitario decimal(10,0),
    Impuesto decimal(10,0)
);
# Copiar solamente 7000 registros desde Hecho_Movimiento para acelelar la visualizacion
INSERT INTO InventarioDatamart7000(
SELECT 
	F.Fecha as Fecha,
    F.Dia as Dia,
    F.Mes as Mes,
    F.Anyo as Anyo,
    C.Nombre as Cliente,
    CIU.NombreCiudad as CiudadEntrega,
    CIU.Pais as PaisEntrega,
    C.DiasPago as DiasPagoCliente,
    C.LimiteCredito as LimiteCreditoCliente,
    C.NombreGrupoCompra as GrupoCompra,
    P.Nombre as Proveedor,
    P.Dias_pago as DiasPagoProv,
    T.Tipo as TipoTran,
    HM.Cantidad as Cantidad,
    PROD.Nombre as Producto,
    PROD.Marca as Marca,
    PROD.Precio_unitario as PrecioUnitario,
    PROD.Impuesto as Impuesto
    
FROM Hecho_Movimiento HM 
INNER JOIN Fecha F ON HM.ID_Fecha = F.ID_Fecha
INNER JOIN Cliente C ON HM.ID_Cliente_DWH = C.ID_Cliente_DWH
LEFT JOIN Ciudad CIU ON C.ID_CiudadEntrega_DWH = CIU.ID_Ciudad_DWH
INNER JOIN Proveedor P ON HM.ID_Proveedor_DWH = P.ID_Proveedor_DWH
INNER JOIN TipoTransaccion T ON HM.ID_Tipo_transaccion_DWH = T.ID_Tipo_transaccion_DWH
INNER JOIN Producto PROD ON HM.ID_Producto_DWH = PROD.ID_Producto_DWH
LIMIT 7000
);

# Copiar toda la tabla Hecho_Movimientos
INSERT INTO InventarioDatamart(
SELECT 
	F.Fecha as Fecha,
    F.Dia as Dia,
    F.Mes as Mes,
    F.Anyo as Anyo,
    C.Nombre as Cliente,
    CIU.NombreCiudad as CiudadEntrega,
    CIU.Pais as PaisEntrega,
    C.DiasPago as DiasPagoCliente,
    C.LimiteCredito as LimiteCreditoCliente,
    C.NombreGrupoCompra as GrupoCompra,
    P.Nombre as Proveedor,
    P.Dias_pago as DiasPagoProv,
    T.Tipo as TipoTran,
    HM.Cantidad as Cantidad,
    PROD.Nombre as Producto,
    PROD.Marca as Marca,
    PROD.Precio_unitario as PrecioUnitario,
    PROD.Impuesto as Impuesto
    
FROM Hecho_Movimiento HM 
INNER JOIN Fecha F ON HM.ID_Fecha = F.ID_Fecha
INNER JOIN Cliente C ON HM.ID_Cliente_DWH = C.ID_Cliente_DWH
LEFT JOIN Ciudad CIU ON C.ID_CiudadEntrega_DWH = CIU.ID_Ciudad_DWH
INNER JOIN Proveedor P ON HM.ID_Proveedor_DWH = P.ID_Proveedor_DWH
INNER JOIN TipoTransaccion T ON HM.ID_Tipo_transaccion_DWH = T.ID_Tipo_transaccion_DWH
INNER JOIN Producto PROD ON HM.ID_Producto_DWH = PROD.ID_Producto_DWH
);

#Verificar la cantidad  copiada
SELECT count(*)
FROM InventarioDatamart DM;


# Sentencias SQL de validacion  de las visualizaciones
SELECT Count(*)
FROM InventarioDatamart
WHERE TipoTran='Stock Adjustment at Stocktake';

SELECT Count(*)
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Issue','Stock Receipt');

SELECT Count(*)
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Receipt');


SELECT Count(*)
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Issue');

SELECT SUM(Cantidad)
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Issue');

SELECT COUNT(*), Cliente, Anyo
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Receipt')
GROUP BY Cliente,Anyo;


SELECT COUNT(*), Cliente, Anyo
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Issue')
GROUP BY Cliente,Anyo;

SELECT MIN(Fecha)
FROM InventarioDatamart;
SELECT MAX(Fecha)
FROM InventarioDatamart;


SELECT SUM(Cantidad*PrecioUnitario)
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Issue');

SELECT SUM(Cantidad*PrecioUnitario)/(COUNT(*))
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Issue');


SELECT PaisEntrega, CiudadEntrega, SUM(Cantidad * PrecioUnitario)
FROM InventarioDatamart
WHERE TipoTran IN ('Stock Issue')
Group by PaisEntrega, CiudadEntrega;


select * from InventarioDatamart
WHERE Cliente like '%Olya%'