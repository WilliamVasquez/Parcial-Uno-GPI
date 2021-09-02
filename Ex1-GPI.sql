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
		stockMinimo FLOAT,
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
		idMedida INT
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Medida')
BEGIN
    CREATE TABLE Medida (
        idMedida INT IDENTITY (1, 1),
        nombre VARCHAR(50)
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
-- LLAVES PRIMARIAS
ALTER TABLE Usuarios ADD CONSTRAINT pk_Usuarios PRIMARY KEY (idUser);
ALTER TABLE MateriaPrima ADD CONSTRAINT pk_MateriaPrima PRIMARY KEY (idMaterial);
ALTER TABLE Productos ADD CONSTRAINT pk_Productos PRIMARY KEY (idProd);
ALTER TABLE Medida ADD CONSTRAINT pk_Medida PRIMARY KEY (idMedida);
ALTER TABLE Vista ADD CONSTRAINT pk_Vistas PRIMARY KEY (idVista);
ALTER TABLE Accion ADD CONSTRAINT pk_Accion PRIMARY KEY (idAccion);
GO
-- LLAVES FORANEAS
ALTER TABLE ProductosMaterial ADD CONSTRAINT fk_Pm_Productos FOREIGN KEY (idProd) REFERENCES Productos (idProd)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ProductosMaterial ADD CONSTRAINT fk_Pm_MateriaPrima FOREIGN KEY (idMaterial) REFERENCES MateriaPrima (idMaterial)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ProductosMaterial ADD CONSTRAINT fk_Pm_Medida FOREIGN KEY (idMedida) REFERENCES Medida (idMedida)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Usuarios ADD CONSTRAINT fk_usuario_Vista FOREIGN KEY (rol) REFERENCES Vista (idVista)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE UsuarioAccion ADD CONSTRAINT fk_usuario_UsuarioAccion FOREIGN KEY (idUsuario) REFERENCES Usuarios (idUser)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE UsuarioAccion ADD CONSTRAINT fk_Accion_UsuarioAccion FOREIGN KEY (idAccion) REFERENCES Accion (idAccion)
ON UPDATE CASCADE ON DELETE CASCADE;