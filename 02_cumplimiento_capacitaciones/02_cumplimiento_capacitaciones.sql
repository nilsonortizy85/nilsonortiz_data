-- #########################################################################
-- PROYECTO 2: CUMPLIMIENTO DE CAPACITACIONES E INSPECCIONES HSE
-- #########################################################################

DROP TABLE IF EXISTS capacitaciones;
DROP TABLE IF EXISTS inspecciones;

CREATE TABLE capacitaciones (
    id INT PRIMARY KEY,
    empleado VARCHAR(50),
    area VARCHAR(50),
    tema VARCHAR(50),
    fecha_programada DATE,
    fecha_realizada DATE  -- NULL si no se realizó
);

CREATE TABLE inspecciones (
    id INT PRIMARY KEY,
    area VARCHAR(50),
    fecha DATE,
    tipo VARCHAR(50),      -- Alturas, Izajes, Espacios Confinados, Eléctrica
    hallazgos_abiertos INT,
    hallazgos_cerrados INT
);

INSERT INTO capacitaciones (id, empleado, area, tema, fecha_programada, fecha_realizada) VALUES
(1, 'Empleado 1', 'Izajes', 'Trabajo en alturas', '2025-01-05', '2025-01-05'),
(2, 'Empleado 2', 'Izajes', 'Trabajo en alturas', '2025-01-05', '2025-01-07'),
(3, 'Empleado 3', 'Alturas', 'Espacios confinados', '2025-01-10', NULL),
(4, 'Empleado 4', 'Alturas', 'Espacios confinados', '2025-01-10', '2025-01-10'),
(5, 'Empleado 5', 'Eléctrica', 'LOTO', '2025-02-01', '2025-02-01'),
(6, 'Empleado 6', 'Eléctrica', 'LOTO', '2025-02-01', NULL),
(7, 'Empleado 7', 'Espacios Confinados', 'Rescate en espacios confinados', '2025-02-15', '2025-02-16'),
(8, 'Empleado 8', 'Espacios Confinados', 'Rescate en espacios confinados', '2025-02-15', NULL);

INSERT INTO inspecciones (id, area, fecha, tipo, hallazgos_abiertos, hallazgos_cerrados) VALUES
(1, 'Izajes', '2025-01-15', 'Izajes', 3, 2),
(2, 'Alturas', '2025-01-20', 'Alturas', 5, 4),
(3, 'Eléctrica', '2025-02-05', 'Eléctrica', 2, 2),
(4, 'Espacios Confinados', '2025-02-20', 'Espacios Confinados', 4, 1);


-- =========================================================================
-- 1. CUMPLIMIENTO DE CAPACITACIONES POR ÁREA
-- =========================================================================
SELECT
    area,
    COUNT(*) AS total_programadas,
    SUM(CASE WHEN fecha_realizada IS NOT NULL THEN 1 ELSE 0 END) AS realizadas,
    ROUND(100.0 * SUM(CASE WHEN fecha_realizada IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_cumplimiento
FROM capacitaciones
GROUP BY area
ORDER BY pct_cumplimiento ASC;


-- =========================================================================
-- 2. PORCENTAJE DE CIERRE DE HALLAZGOS POR ÁREA (CORREGIDO)
-- Fórmula: (Hallazgos Cerrados / Total de Hallazgos Identificados) * 100
-- =========================================================================
SELECT
    area,
    SUM(hallazgos_abiertos) AS hallazgos_pendientes,
    SUM(hallazgos_cerrados) AS hallazgos_cerrados,
    SUM(hallazgos_abiertos + hallazgos_cerrados) AS total_hallazgos,
    ROUND(
        100.0 * SUM(hallazgos_cerrados) / NULLIF(SUM(hallazgos_abiertos + hallazgos_cerrados), 0), 
        1
    ) AS pct_cierre
FROM inspecciones
GROUP BY area
ORDER BY pct_cierre ASC;
