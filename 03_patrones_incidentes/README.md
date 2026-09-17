# Detección de patrones de incidentes por turno, área y tipo

## 1. El problema de negocio
Los incidentes rara vez son aleatorios: suelen concentrarse en ciertos turnos, días o tipos de tarea por razones identificables (fatiga, relevos de turno, tareas críticas específicas). Sin un análisis de patrones, cada incidente se investiga de forma aislada y se pierden causas raíz recurrentes. Este proyecto responde: **¿existen patrones ocultos en cuándo y dónde ocurren los incidentes?**

## 2. Los datos
- Fuente: las tablas `incidentes` y `trabajadores_mes` del Proyecto 1 (fecha, área, turno, tipo de incidente, severidad, número de trabajadores).
- Periodo: enero–marzo (datos simulados).
- Enfoque: análisis exploratorio, no predictivo — se identifican correlaciones simples como base para un futuro modelo más avanzado.

## 3. El proceso
- Cálculo en SQL (MySQL) de la Frecuencia por turno: `(N° incidentes del turno / total de trabajadores del periodo) × 100`, además del promedio de días de incapacidad por turno — para comparar turnos por tasa relativa, no solo por conteo bruto.
- Agrupación por área y tipo de incidente (`GROUP BY area, tipo_incidente`) para identificar el tipo más recurrente en cada una.
- Tendencia mensual por severidad (`DATE_FORMAT(fecha, '%Y-%m-01')`) para ver si el problema mejora o empeora en el tiempo.
- Visualización: gráfico de barras por turno y mapa de calor área × tipo de incidente.

## 4. Insight y recomendación
- El **turno noche** tuvo menos incidentes que el turno día, pero un promedio de días de incapacidad notablemente mayor (7.7 vs. 6.2 días) — señal de que la severidad, no solo la frecuencia, cambia según el turno.
- **Recomendación**: reforzar supervisión y pausas activas en el turno noche, y evaluar si la carga de trabajo, la iluminación o el relevo de turno están afectando la toma de decisiones en tareas críticas, ya que cuando ocurre un incidente de noche, tiende a ser más grave.

## 5. Código y dashboard
- Consulta SQL completa: [`analisis.sql`](./analisis.sql)
- Dashboard interactivo: *(agregar link de Power BI publicado)*
- Dataset: [`datos.csv`](./datos.csv)

---
*Proyecto desarrollado por Nilson Fabian Ortiz Yepes como parte de su portafolio de transición hacia análisis de datos, basado en su experiencia como Director/Coordinador HSEQ.*
