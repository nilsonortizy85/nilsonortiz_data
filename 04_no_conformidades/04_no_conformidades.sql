-- #########################################################################
-- PROYECTO 4: OPTIMIZACIÓN DE INDICADOR DE NO CONFORMIDADES
-- #########################################################################
 
DROP TABLE IF EXISTS no_conformidades;
 
CREATE TABLE no_conformidades (
    id INT PRIMARY KEY,
    area VARCHAR(50),
    fecha_deteccion DATE,
    fecha_cierre DATE,   -- NULL si sigue abierta
    responsable VARCHAR(50)
);
 
INSERT INTO no_conformidades (id, area, fecha_deteccion, fecha_cierre, responsable) VALUES
(1, 'Izajes', '2025-01-05', '2025-01-15', 'Supervisor A'),
(2, 'Izajes', '2025-01-18', '2025-02-10', 'Supervisor A'),
(3, 'Alturas', '2025-01-20', '2025-01-25', 'Supervisor B'),
(4, 'Alturas', '2025-02-01', NULL, 'Supervisor B'),
(5, 'Eléctrica', '2025-02-05', '2025-02-08', 'Supervisor C'),
(6, 'Eléctrica', '2025-02-20', NULL, 'Supervisor C'),
(7, 'Espacios Confinados', '2025-02-25', '2025-03-10', 'Supervisor D'),
(8, 'Espacios Confinados', '2025-03-01', '2025-03-05', 'Supervisor D');
 
-- Explicación: calculamos días de cierre solo para las NC ya cerradas
-- (fecha_cierre IS NOT NULL) usando resta de fechas, y por separado el %
-- de NC aún abiertas — dos métricas que juntas cuentan la historia completa
-- del indicador (velocidad de cierre + backlog pendiente).
SELECT
    area,
    COUNT(*) AS total_nc,
    SUM(CASE WHEN fecha_cierre IS NULL THEN 1 ELSE 0 END) AS abiertas,
    ROUND(AVG(fecha_cierre - fecha_deteccion) FILTER (WHERE fecha_cierre IS NOT NULL), 1) AS promedio_dias_cierre
FROM no_conformidades
GROUP BY area
ORDER BY promedio_dias_cierre DESC NULLS LAST;
 
-- Responsable con más NC abiertas (para seguimiento gerencial)
SELECT responsable, COUNT(*) AS nc_abiertas
FROM no_conformidades
WHERE fecha_cierre IS NULL
GROUP BY responsable
ORDER BY nc_abiertas DESC;
 
-- =====================================================================
-- NOTAS PARA OTROS MOTORES:
-- - MySQL: reemplaza "fecha_cierre - fecha_deteccion" por
--   DATEDIFF(fecha_cierre, fecha_deteccion); reemplaza FILTER (WHERE ..)
--   por SUM(CASE WHEN .. THEN valor END)/COUNT(CASE WHEN .. THEN 1 END).
-- - SQL Server: usa DATEDIFF(day, fecha_deteccion, fecha_cierre); no existe
--   FILTER, usa la misma alternativa con CASE WHEN.
-- =====================================================================
