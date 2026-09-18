-- #########################################################################
-- PROYECTO 1: ANÁLISIS DE ACCIDENTALIDAD LABORAL
-- Frecuencia y Severidad calculadas sobre la MISMA base de datos filtrada
-- #########################################################################
 
DROP TABLE IF EXISTS incidentes;
DROP TABLE IF EXISTS trabajadores_mes;
 
CREATE TABLE trabajadores_mes (
    area VARCHAR(50),
    mes DATE,
    num_trabajadores INT
);
 
CREATE TABLE incidentes (
    id INT PRIMARY KEY,
    fecha DATE,
    area VARCHAR(50),
    turno VARCHAR(20),
    tipo_incidente VARCHAR(50),
    dias_incapacidad INT,
    dias_cargados INT,
    severidad VARCHAR(20)
);
 
INSERT INTO trabajadores_mes (area, mes, num_trabajadores) VALUES
('Izajes', '2025-01-01', 22), ('Izajes', '2025-02-01', 22), ('Izajes', '2025-03-01', 24),
('Alturas', '2025-01-01', 18), ('Alturas', '2025-02-01', 19), ('Alturas', '2025-03-01', 19),
('Espacios Confinados', '2025-01-01', 10), ('Espacios Confinados', '2025-02-01', 10), ('Espacios Confinados', '2025-03-01', 9),
('Eléctrica', '2025-01-01', 15), ('Eléctrica', '2025-02-01', 15), ('Eléctrica', '2025-03-01', 16);
 
INSERT INTO incidentes (id, fecha, area, turno, tipo_incidente, dias_incapacidad, dias_cargados, severidad) VALUES
(1, '2025-01-10', 'Izajes', 'Día', 'Golpe', 2, 0, 'Leve'),
(2, '2025-01-22', 'Alturas', 'Día', 'Caída', 15, 0, 'Grave'),
(3, '2025-02-03', 'Eléctrica', 'Noche', 'Cuasi-accidente', 0, 0, 'Leve'),
(4, '2025-02-14', 'Izajes', 'Día', 'Atrapamiento', 8, 0, 'Moderado'),
(5, '2025-02-25', 'Espacios Confinados', 'Día', 'Intoxicación', 5, 0, 'Moderado'),
(6, '2025-03-05', 'Alturas', 'Noche', 'Caída', 20, 10, 'Grave'),
(7, '2025-03-12', 'Eléctrica', 'Día', 'Corte', 1, 0, 'Leve'),
(8, '2025-03-20', 'Izajes', 'Noche', 'Golpe', 3, 0, 'Leve');
 
 
-- =========================================================================
-- FRECUENCIA Y SEVERIDAD DE ACCIDENTALIDAD (una sola consulta, un solo dataset)
--
-- Ambos indicadores se calculan sobre el MISMO conjunto de datos: accidentes
-- de trabajo reales (se excluyen cuasi-accidentes, porque no son accidentes),
-- cruzados con el número de trabajadores del área en ese mes. El resultado
-- es UNA tabla con ambos indicadores como columnas — no dos consultas
-- independientes con criterios distintos.
--
-- Frecuencia = (N° de accidentes en el mes / N° de trabajadores) * 100
-- Severidad  = ((días de incapacidad + días cargados en el mes) / N° de trabajadores) * 100
-- =========================================================================
SELECT
    i.area,
    DATE_FORMAT(i.fecha, '%Y-%m-01') AS mes,
    COUNT(i.id) AS num_accidentes,
    SUM(i.dias_incapacidad + i.dias_cargados) AS dias_perdidos,
    t.num_trabajadores,
    ROUND((COUNT(i.id) / t.num_trabajadores) * 100, 2) AS frecuencia_accidentalidad,
    ROUND((SUM(i.dias_incapacidad + i.dias_cargados) / t.num_trabajadores) * 100, 2) AS severidad_accidentalidad
FROM incidentes i
JOIN trabajadores_mes t
    ON i.area = t.area
   AND DATE_FORMAT(i.fecha, '%Y-%m-01') = t.mes
WHERE i.tipo_incidente != 'Cuasi-accidente'
GROUP BY i.area, DATE_FORMAT(i.fecha, '%Y-%m-01'), t.num_trabajadores
ORDER BY severidad_accidentalidad DESC;
