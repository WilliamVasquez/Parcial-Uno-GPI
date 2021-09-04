USE master
GO
DROP DATABASE IF EXISTS Ex1GPI
BEGIN
CREATE DATABASE Ex1GPI;
END
GO
    USE Ex1GPI
GO
--You need to check if the table exists
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Usuarios')
BEGIN
    CREATE TABLE Usuarios (
        idUser INT IDENTITY (1, 1),
        nameUser VARCHAR(50),
		passUser VARCHAR(100),
		rol int,
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='MateriaPrima')
BEGIN
    CREATE TABLE MateriaPrima (
        idMaterial INT IDENTITY (1, 1),
        nombreMat VARCHAR(50),
		descripcionMat VARCHAR(50),
		stock FLOAT,
		medida VARCHAR(10),
		stockMinimo FLOAT,
		estado INT
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Productos')
BEGIN
    CREATE TABLE Productos (
        idProd INT IDENTITY (1, 1),
        nombreProd VARCHAR(50),
		descripcionProd VARCHAR(50),
		precio MONEY,
		estado INT
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ProductosMaterial')
BEGIN
    CREATE TABLE ProductosMaterial (
        idProd INT,
		idMaterial INT,
        cantidad FLOAT,
		medida VARCHAR(10)
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Vista')
BEGIN
    CREATE TABLE Vista (
        idVista INT IDENTITY (1, 1),
        vista VARCHAR(25),
		estado int
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Accion')
BEGIN
    CREATE TABLE Accion (
        idAccion INT IDENTITY (1, 1),
        accion VARCHAR(25),
		estado int
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='UsuarioAccion')
BEGIN
    CREATE TABLE UsuarioAccion (
        idUsuario INT,
        idAccion int
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Persona')
BEGIN
    CREATE TABLE Persona (
		idPersona INT IDENTITY (1, 1),
		nombre VARCHAR(50),
		apellidos VARCHAR(50),
		correo VARCHAR(50),
		puesto VARCHAR(50),
        idUsuario INT
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Pedido')
BEGIN
    CREATE TABLE Pedido (
		idPedido INT IDENTITY (1, 1),
		idPersona INT,
		fechaPedido DATE
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Venta')
BEGIN
    CREATE TABLE Venta (
		idPedido INT,
		idProd INT,
		cantidad FLOAT,
		precioF money
    )
END
GO
-- LLAVES PRIMARIAS
ALTER TABLE Usuarios ADD CONSTRAINT pk_Usuarios PRIMARY KEY (idUser);
ALTER TABLE MateriaPrima ADD CONSTRAINT pk_MateriaPrima PRIMARY KEY (idMaterial);
ALTER TABLE Productos ADD CONSTRAINT pk_Productos PRIMARY KEY (idProd);
ALTER TABLE Vista ADD CONSTRAINT pk_Vistas PRIMARY KEY (idVista);
ALTER TABLE Accion ADD CONSTRAINT pk_Accion PRIMARY KEY (idAccion);
ALTER TABLE Persona ADD CONSTRAINT pk_Persona PRIMARY KEY (idPersona);
ALTER TABLE Pedido ADD CONSTRAINT pk_Pedido PRIMARY KEY (idPedido);
GO
-- LLAVES FORANEAS
ALTER TABLE Persona ADD CONSTRAINT fk_Persona_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios (idUser)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ProductosMaterial ADD CONSTRAINT fk_Pm_Productos FOREIGN KEY (idProd) REFERENCES Productos (idProd)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ProductosMaterial ADD CONSTRAINT fk_Pm_MateriaPrima FOREIGN KEY (idMaterial) REFERENCES MateriaPrima (idMaterial)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Pedido ADD CONSTRAINT fk_Pedido_Persona FOREIGN KEY (idPersona) REFERENCES Persona (idPersona)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Venta ADD CONSTRAINT fk_Venta_Pedido FOREIGN KEY (idPedido) REFERENCES Pedido (idPedido)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Venta ADD CONSTRAINT fk_Venta_Productos FOREIGN KEY (idProd) REFERENCES Productos (idProd)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Usuarios ADD CONSTRAINT fk_usuario_Vista FOREIGN KEY (rol) REFERENCES Vista (idVista)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE UsuarioAccion ADD CONSTRAINT fk_usuario_UsuarioAccion FOREIGN KEY (idUsuario) REFERENCES Usuarios (idUser)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE UsuarioAccion ADD CONSTRAINT fk_Accion_UsuarioAccion FOREIGN KEY (idAccion) REFERENCES Accion (idAccion)
ON UPDATE CASCADE ON DELETE CASCADE;

/*create trigger dbo.something after insert as
begin
    if exists ( select * from inserted where sum(credits) > 30 )
    begin
       
    end
end*/

GO
CREATE TRIGGER TR_STATUS_STOCK ON MateriaPrima
AFTER INSERT, UPDATE as
Declare @cant FLOAT, @id int;
	SET @cant = (select stock from inserted);
	SET @id = (select idMaterial from inserted);
	IF (@cant < (select stockMinimo from inserted))
BEGIN
		UPDATE MateriaPrima SET estado = 0 where idMaterial = @id;
END
GO
CREATE TRIGGER TR_Verficar_STOCK ON Venta
FOR INSERT, UPDATE as
Declare @id INT, @status INT, @mat INT;
	SET @id = (select idProd from inserted);
	SET @mat = (select idMaterial from ProductosMaterial where idProd = @id)
	IF EXISTS(select * from MateriaPrima where estado = 0 and idMaterial=(@mat))
	BEGIN
			rollback transaction
			raiserror ('Material Insuficiente', 16, 1)
	END

INSERT INTO MateriaPrima VALUES('Maiz amarillo', 'Maiz amarillo', 10, 'quintal', 50, 1);

select * from MateriaPrima;