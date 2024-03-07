# Asignatura Bases de Datos Avanzadas - curso 2023-24
# ETS Ingeniería Sistemas Informáticos - UPM

# -----------------------------------------------------
# Practica 1 - Script de creación de la Tabla inicial
# -----------------------------------------------------

CREATE DATABASE IF NOT EXISTS practica1bda_tablaunica;

USE practica1bda_tablaunica;
SET GLOBAL sql_safe_updates=0;

--
-- Creación de tablaunica
--

DROP TABLE tablaunica;

CREATE TABLE tablaunica (
	pID varchar(11) NOT NULL,
    nompaciente varchar(40),
    genero varchar(1),
    edad varchar(3),
    telefonos varchar (50),
    localidadP varchar (50),
    provinciaP varchar (30),
    cID varchar(3),
    nomcentro varchar (100),
    localidadC varchar (50),
    provinciaC varchar (30),
    fechahora varchar(20) NOT NULL,
    motivo varchar (100),
    especialidad varchar(40),
    area varchar (30),
    mID varchar(5),
    nommedico varchar(40),
	PRIMARY KEY(fechahora, pID),
      UNIQUE (mID, fechahora)
);

DROP TABLE tablaunica;
--
-- Inserción de datos
--
INSERT INTO tablaunica 
VALUES 
(100001,'Dolores Fuertes','M',45,'967000003','Villalzarcillo','Albacete',5,'Vallesol','Metrópolis','Madrid','2024-01-02 10:00','Dolor de espalda','Traumatología','Clínica',105,'Carmelo Cotón') ,
(8980521,'Elba Calao','M',22,'600000012','Puenteviejo','Madrid',8,'Parquesol','Cantaloa','Segovia','2024-01-03 08:30','Análisis cínico','Laboratorio','Clínica',201,'Edu Cado'),
(86785,'Ernesto Rero','H',35,'921000005, 921000004,600000018','Sagrillas','Segovia',8,'Parquesol','Cantaloa','Segovia','2024-01-10 09:00','Fractura clavícula','Cirugía ósea','Quirúrgica',778,'Curro Poco'),
(100001,'Dolores Fuertes','M',null,'967000003','Villalzarcillo','Albacete',5,'Vallesol','Metrópolis','Madrid','2024-01-10 12:00','Radiografía','Pruebas imagen','Clínica',55,'Curro Mucho') ,
(50354,'Armando Casas','H',70,'975000002, 600000003','Peñafría','Soria',8,'Parquesol','Cantaloa','Segovia','2024-01-10 12:30','Radiografía','Pruebas imagen','Clínica',55,'Curro Mucho') ,
(433256,'Leandro Gao','M',30,null,'Cantaloa','Segovia',8,'Parquesol','Cantaloa','Segovia','2024-01-10 13:00','Paranoia','Psiquiatría','Clínica',565,'Encarna Vales'),
(9638211,'Soly Luna',null,18,'600000008','Metrópolis','Madrid',5,'Vallesol','Metrópolis','Madrid','2024-01-12 08:00','Análisis cínico','Laboratorio','Clínica',34,'Rosa Nitaria'),
(954216,'Aylen Tejas','M',48,null,'Sagrillas','Segovia',5,'Vallesol','Metrópolis','Madrid','2024-01-12 10:30','Dolor abdominal','Medicina general','Clínica',55,'Curro Mucho'),
(100001,'Dolores Fuertes',null,45,'967000003','Villalzarcillo','Albacete',5,'Vallesol','Metrópolis','Madrid','2024-01-12 17:00','Dolor de espalda','Traumatología','Clínica',105,'Carmelo Cotón'),
(15345678,'Elga Tito','H',5,'600000012','Puenteviejo','Madrid',5,'Vallesol','Metrópolis','Madrid','2024-01-12 18:00','Resfriado','Pediatría','Clínica',323,'Jony Mentero'),
(954216,'Aylen Tejas','M',null,'921000004, 600000014','Sagrillas','Segovia',8,'Parquesol','Cantaloa','Segovia','2024-01-15 12:30','Quiste sebáceo','Cirugía general','Quirúrgica',533,'Jony Bisturí'),
(9638211,'Soly Luna','M',18,'600000008','Metrópolis','Madrid',5,'Vallesol','Metrópolis','Madrid','2024-01-15 12:30','Vértigos','Traumatología','Clínica',105,'Carmelo Cotón'),
(37104,'Pancracia Notica','M',85,'921000005, 921000004,600000018','Sagrillas','Segovia',16,'Centro 3','Cantaloa','Segovia','2024-01-16 09:00','Análisis cínico','Laboratorio','Clínica',201,'Edu Cado'),
(50354,'Armando Casas','H',70,'975000002, 600000003','Peñafría','Soria',8,'Parquesol','Cantaloa','Segovia','2024-01-18 16:00','Vértigos','Medicina general','Clínica',55,'Curro Mucho'),
(6803298,'Armando Bronca','H',24,'975000005','Peñafría','Soria',5,'Vallesol','Metrópolis','Madrid','2024-01-18 16:00','Fractura fémur','Cirugía ósea','Quirúrgica',575,'Ana Tomía');

-- Obtener el número de pacientes que han sido atendidos en centros de salud de una provincia diferente a la suya en el área Quirúrgica. 
SELECT COUNT(*) AS numpacientes  -- , nompaciente , provinciaP , provinciaC
FROM tablaunica
WHERE area = 'Quirúrgica' AND provinciaP <> provinciaC
GROUP BY nompaciente;

-- Obtener el centro y su provincia para aquellos centros que hayan atendido tanto a pacientes de Sagrillas como de Peñafría a partir de las 12:00.
                                                
SELECT pID, nomcentro, provinciaC, fechahora AS fechaAtencion
FROM tablaunica 
WHERE localidadP = 'Sagrillas' AND SUBSTRING(fechahora, 12, 5) > '12:00'   -- 12 posicion desde donde se extrae , 5 numero de caracteres a extraer, se empieza desde el 1 a contar no el 0
AND nomcentro IN (SELECT nomcentro 
               FROM tablaunica 
               WHERE localidadP = 'Peñafría' AND SUBSTRING(fechahora, 12, 5) > '12:00');


-- Obtener para cada centro de salud, el número de asistencias atendidas en viernes a pacientes de género femenino (valor “M”). 
-- Falta determinar como definir que sea solo el viernes xd
SELECT cID, nompaciente, COUNT(*) AS asistencias2
FROM tablaunica
WHERE genero = 'M' AND DAYOFWEEK(SUBSTRING(fechahora, 1 , 10)) = 6 
GROUP BY cID , nompaciente;

SELECT cID, nompaciente , genero   -- prueba para evaluar que el dia es viernes
FROM tablaunica
WHERE DAYOFWEEK(SUBSTRING(fechahora, 1 , 10)) = 6 ;

-- Dato sucio :(dato ficticio que no tiene sentido pero estamos obligados a introducir un valor debido a que esta definido como no nulo).


-- Lista de transacciones PREGUNTA 4 A) B) C) D).

START TRANSACTION;
INSERT INTO tablaunica(cID, nomcentro, localidadC, provinciaC)
VALUES (18, 'El Pueblo', 'Peñafría', 'Soria');
ROLLBACK;

-- Anomalia: como la clave es la pID, fechahora necesitamos registrar una persona para registrar un nuevo centro

-- [X] si que va esta transacción, va bien porque hemos incluido mID como secundaria y porque no hemos puesto teléfono como clave secundaria
START TRANSACTION;
INSERT INTO tablaunica (pID, nompaciente, localidadP, provinciaP, nomcentro, cID, localidadC, provinciaC, fechahora, motivo, especialidad, area)
VALUES (99999, 'Nuevo', 'Cerrofrio', 'Burgos','El Pueblo' ,18 , 'Peñafría', 'Soria', '2024-01-20 10:00', 'Dolor pecho' , 'Medicina general' , 'Clínica');
ROLLBACK;

-- [X] si que va esta transacción,  va bien porque hemos incluido mID como secundaria y porque no hemos puesto teléfono como clave secundaria
START TRANSACTION;
INSERT INTO tablaunica (pID, nompaciente, localidadP, provinciaP, nomcentro, cID, localidadC, provinciaC, fechahora, motivo, especialidad, area, mID , nommedico)
VALUES (99999, 'Nuevo', 'Cerrofrio', 'Burgos','El Pueblo' ,18 , 'Peñafría', 'Soria', '2024-01-20 10:00','Dolor pecho' , 'Medicina general' , 'Clínica', 95, 'Tomé Dico');
ROLLBACK;

-- [X] si que va esta transacción,  va bien porque hemos incluido mID como secundaria y porque no hemos puesto teléfono como clave secundaria 
START TRANSACTION;
INSERT INTO tablaunica (nompaciente, pID, telefonos, localidadP , provinciaP , nomcentro , cID , localidadC , provinciaC , fechahora , motivo , especialidad , area , mID , nommedico)
VALUES ('Elga Tito' , 15345678, 600000012 , 'Puenteviejo' , 'Madrid' , 'Vallesol' , 5 , 'Metrópolis' , 'Madrid' , '2024-1-20 20:00' , 'Fiebre' , 'Pediatría' , 'Clínica' , 323, 'Jony Mentero' );
ROLLBACK; 


-- Pregunta 5) 

-- A) 
START TRANSACTION;
UPDATE tablaunica
SET edad = 46
WHERE nompaciente = 'Dolores Fuertes';
ROLLBACK;

-- B)
START TRANSACTION;
UPDATE tablaunica 
SET nomcentro = "Vallesol 2" ,localidadC = 'Datapolis' , cID = 19
WHERE cID = 5 AND SUBSTRING(fechahora, 1, 10) >= '2024-01-12';
ROLLBACK;

-- C) Anomalía: como solo poseemos una entrada en la base de datos de dicho paciente, al borrar su asistencia tambien estamos borrando al paciente de la base de datos.
START TRANSACTION;
DELETE FROM tablaunica 
WHERE nompaciente = 'Armando Bronca' AND fechahora = '2024-01-18 16:00';
ROLLBACK;

-- D) Anomalía: no hay debido a que al haber 2 entradas de atencion a dicho paciente no borramos la información del mismo.
START TRANSACTION;
DELETE FROM tablaunica
WHERE nompaciente = 'Soly Luna' AND fechahora = '2024-01-15 12:30';
ROLLBACK;
