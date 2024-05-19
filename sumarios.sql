CREATE DATABASE IF NOT EXISTS sumarios;

USE sumarios;

CREATE TABLE PersonalPolicial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    jerarquia VARCHAR(255)
);

CREATE TABLE Sumario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero INT,
    juzgado VARCHAR(255),
    fiscalia VARCHAR(255),
    juez VARCHAR(255),
    fiscal VARCHAR(255),
    imputados TEXT,
    damnificados TEXT
);

CREATE TABLE Diligencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    texto_cuerpo TEXT,
    instructor_id INT NOT NULL,
    sumario_id INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES PersonalPolicial(id),
    FOREIGN KEY (sumario_id) REFERENCES Sumario(id) ON DELETE CASCADE
);



-- Insertar datos en la tabla PersonalPolicial
INSERT INTO PersonalPolicial (nombre, jerarquia) VALUES
('Juan Perez', 'Comisario'),
('Maria Lopez', 'Oficial'),
('Pedro Ramirez', 'Sargento');

-- Insertar datos en la tabla Sumario
INSERT INTO Sumario (numero, juzgado, fiscalia, juez, fiscal, imputados, damnificados) VALUES
(1001, 'Juzgado 1', 'Fiscalía 1', 'Juez 1', 'Fiscal 1', 'Juan Martinez, Maria Gomez', 'Carlos Sanchez'),
(1002, 'Juzgado 2', 'Fiscalía 2', 'Juez 2', 'Fiscal 2', 'Luis Ramirez', 'Ana Rodriguez, Javier Fernandez'),
(1003, 'Juzgado 3', 'Fiscalía 3', 'Juez 3', 'Fiscal 3', 'Pedro Martinez, Sofia Torres', 'Juan Gomez');

-- Insertar datos en la tabla Diligencia
INSERT INTO Diligencia (fecha, texto_cuerpo, instructor_id, sumario_id) VALUES
('2024-05-01', 'Se realizó la inspección ocular del lugar del incidente.', 1, 1),
('2024-05-05', 'Se tomaron declaraciones a testigos presenciales.', 2, 1),
('2024-05-10', 'Se solicitó análisis forense de las pruebas recogidas.', 3, 1),
('2024-05-02', 'Se recabaron pruebas documentales relevantes.', 1, 2),
('2024-05-06', 'Se interrogó a los imputados en presencia de sus abogados.', 2, 2),
('2024-05-12', 'Se realizaron pericias técnicas para esclarecer los hechos.', 3, 2),
('2024-05-03', 'Se entrevistaron a los testigos y se registraron sus testimonios.', 1, 3),
('2024-05-07', 'Se llevaron a cabo reconstrucciones de los eventos.', 2, 3),
('2024-05-15', 'Se procedió al análisis de pruebas biológicas.', 3, 3);


--Seleccionar personal policial junto con los sumarios donde agregaron diligencias:
SELECT i.id, i.nombre, i.jerarquia, d.sumario_id AS sumarios
FROM PersonalPolicial i
INNER JOIN Diligencia d ON i.id = d.instructor_id;


--Seleccionar las diligencias junto con los nombres de los instructores y la información del sumario al que pertenecen:
SELECT d.id, d.fecha, d.texto_cuerpo, pp.nombre AS nombre_instructor, s.numero AS numero_sumario, s.juzgado AS juzgado_sumario
FROM Diligencia d
INNER JOIN PersonalPolicial pp ON d.instructor_id = pp.id
INNER JOIN Sumario s ON d.sumario_id = s.id;

--Contar el número de diligencias realizadas en cada sumario:
SELECT s.numero AS numero_sumario, COUNT(d.id) AS num_diligencias
FROM Sumario s
LEFT JOIN Diligencia d ON s.id = d.sumario_id
GROUP BY s.id;


--Buscar los sumarios en los que está involucrado un determinado imputado:
SELECT id, numero, juzgado, fiscalia
FROM Sumario
WHERE imputados LIKE '%Pedro Martinez%';




DELETE FROM Diligencia;
DELETE FROM PersonalPolicial;
DELETE FROM Sumario;


SELECT * FROM PersonalPolicial;
SELECT * FROM Sumario;
SELECT * FROM Diligencia;
