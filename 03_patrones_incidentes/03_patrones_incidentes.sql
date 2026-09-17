-- #########################################################################
-- PROYECTO 3: DETECCIÓN DE PATRONES DE INCIDENTES
-- Reutiliza la tabla "incidentes" y "trabajadores_mes" del Proyecto 1
-- #########################################################################


-- =========================================================================
-- 1. FRECUENCIA Y PROMEDIO DE INCAPACIDAD POR TURNO
-- =========================================================================
SELECT
    turno,
    COUNT(*) AS num_incidentes,
    ROUND(AVG(dias_incapacidad), 1) AS promedio_dias_incapacidad,
    ROUND((COUNT(*) / (SELECT SUM(num_trabajadores) FROM trabajadores_mes)) * 100, 2) AS frecuencia_por_turno
FROM incidentes
GROUP BY turno
ORDER BY num_incidentes DESC;


-- =========================================================================
-- 2. TIPO DE INCIDENTE MÁS FRECUENTE POR ÁREA
-- =========================================================================
SELECT 
    area, 
    tipo_incidente, 
    COUNT(*) AS ocurrencias
FROM incidentes
GROUP BY area, tipo_incidente
ORDER BY area, ocurrencias DESC;


-- =========================================================================
-- 3. TENDENCIA MENSUAL DE INCIDENTES POR SEVERIDAD
-- =========================================================================
SELECT
    DATE_FORMAT(fecha, '%Y-%m-01') AS mes,
    severidad,
    COUNT(*) AS num_incidentes
FROM incidentes
GROUP BY DATE_FORMAT(fecha, '%Y-%m-01'), severidad
ORDER BY mes, severidad;
