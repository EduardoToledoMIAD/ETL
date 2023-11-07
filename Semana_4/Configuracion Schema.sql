USE Estudiante_111_202315;

DROP TABLE Estudiante_111_202315.Hecho_Movimiento;
DROP TABLE  Estudiante_111_202315.TipoTransaccion;
DROP TABLE Estudiante_111_202315.Proveedor;
DROP TABLE Estudiante_111_202315.Producto;
DROP TABLE Estudiante_111_202315.Fecha;
DROP TABLE Estudiante_111_202315.Cliente;
DROP TABLE Estudiante_111_202315.Ciudad;


CREATE TABLE IF NOT EXISTS Fecha (
	ID_Fecha bigint NOT NULL,
	Fecha date NOT NULL,
    Dia int NOT NULL,
    Mes int NOT NULL,
    Anyo int NOT NULL,
    Numero_Semana_ISO int NOT NULL,
    PRIMARY KEY (ID_Fecha)
);

CREATE TABLE IF NOT EXISTS Producto (
  ID_Producto_DWH bigint NOT NULL auto_increment,
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
  ID_Proveedor_DWH bigint not NULL auto_increment,
  ID_Proveedor_T int not NULL,
  Nombre  varchar(100),
  Categoria varchar (50),
  Contacto_principal varchar(50),
  Dias_pago int ,
  Codigo_postal int,
  PRIMARY KEY (ID_Proveedor_DWH)
) ;
CREATE TABLE  IF NOT EXISTS Ciudad (
  ID_Ciudad_DWH bigint NOT NULL,
  ID_Ciudad_T int,
  NombreCiudad text,
  Continente text,
  Pais text,
  Poblacion bigint ,
  Region text,
  TerritorioVentas text,
  NombreEstadoProvincia  text,
  Subregion text,
PRIMARY KEY (ID_Ciudad_DWH)
);


CREATE TABLE IF NOT EXISTS Cliente (
  ID_Cliente_DWH bigint not NULL auto_increment,
  ID_Cliente_T int not NULL,
  Nombre  varchar(100) not null,
  ClienteFactura int,
  ID_CiudadEntrega_DWH bigint,
  LimiteCredito DECIMAL(10,2),
  FechaAperturaCuenta date,
  DiasPago int ,
  NombreGrupoCompra varchar(50),
  NombreCategoria varchar(50),
  PRIMARY KEY (ID_Cliente_DWH)
) ;

CREATE TABLE IF NOT EXISTS TipoTransaccion (
  ID_Tipo_transaccion_DWH bigint not NULL auto_increment,
  ID_Tipo_transaccion_T int not NULL,
  Tipo varchar(50) not NULL,
  PRIMARY KEY (ID_Tipo_transaccion_DWH)
) ;

CREATE TABLE IF NOT EXISTS Hecho_Movimiento (
  ID_Fecha bigint NOT NULL,
  ID_Producto_DWH bigint NOT NULL,
  ID_Proveedor_DWH bigint NOT NULL,
  ID_Cliente_DWH bigint NOT NULL,
  ID_Tipo_transaccion_DWH bigint NOT NULL,
  Cantidad int,
  FOREIGN KEY(ID_Fecha) REFERENCES Fecha(ID_Fecha),
  FOREIGN KEY(ID_Proveedor_DWH) REFERENCES Proveedor(ID_Proveedor_DWH),
  FOREIGN KEY(ID_Producto_DWH) REFERENCES Producto(ID_Producto_DWH),
  FOREIGN KEY(ID_Cliente_DWH) REFERENCES Cliente(ID_Cliente_DWH),
  FOREIGN KEY(ID_Tipo_transaccion_DWH) REFERENCES TipoTransaccion(ID_Tipo_transaccion_DWH)
  
);


#BORRAR REGISTROS PARA TESTEAR DE NUEVO
DELETE FROM Estudiante_111_202315.Hecho_Movimiento;
DELETE FROM  Estudiante_111_202315.TipoTransaccion;
DELETE FROM Estudiante_111_202315.Proveedor;
DELETE FROM Estudiante_111_202315.Producto;
DELETE FROM Estudiante_111_202315.Fecha;
DELETE FROM Estudiante_111_202315.Ciudad;
DELETE FROM Estudiante_111_202315.Cliente;
