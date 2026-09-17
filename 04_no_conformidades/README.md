# Optimización del indicador de cierre de no conformidades (NC)

## 1. El problema de negocio
Una no conformidad detectada pero no cerrada a tiempo sigue siendo un riesgo activo. Muchas organizaciones miden solo "cuántas NC hay", sin medir qué tan rápido se cierran ni quién está acumulando backlog. Este proyecto responde: **¿qué tan eficiente es el proceso de cierre de NC, y dónde están los cuellos de botella?**

## 2. Los datos
- Fuente: registro de no conformidades con fecha de detección, fecha de cierre (o nula si sigue abierta), área y responsable.
- Periodo: enero–marzo (datos simulados).
- Limpieza: separación explícita entre NC cerradas y abiertas para no promediar tiempos de cierre incluyendo las que aún no tienen fecha de cierre.

## 3. El proceso
- Cálculo del promedio de días de cierre por área, considerando solo NC ya cerradas (`fecha_cierre - fecha_deteccion`, promediado solo donde `fecha_cierre IS NOT NULL`).
- Conteo de NC abiertas (backlog) por área y por responsable.
- Visualización: dashboard en Power BI con promedio de días de cierre por área y ranking de responsables con más NC pendientes.
- Nota de compatibilidad: la consulta está escrita en sintaxis PostgreSQL (resta directa de fechas y `FILTER`); en MySQL se reemplaza por `DATEDIFF(fecha_cierre, fecha_deteccion)` y la lógica de `FILTER` por `CASE WHEN` dentro del `AVG`.

## 4. Insight y recomendación
- El área de **Izajes** tuvo el promedio de días de cierre más alto (más de 3 semanas), y dos responsables (Supervisor B y Supervisor C) concentran la mayoría de las NC aún abiertas.
- **Recomendación**: establecer un plazo máximo de cierre (ej. 15 días) con escalamiento automático a supervisión cuando se supere, y dar seguimiento individual a los responsables con mayor backlog para identificar si el cuello de botella es de recursos, prioridad o desconocimiento del proceso.

## 5. Código y dashboard
- Consulta SQL completa: [`analisis.sql`](./analisis.sql)
- Dashboard interactivo: *(agregar link de Power BI publicado)*
- Dataset: [`datos.csv`](./datos.csv)

---
*Proyecto desarrollado por Nilson Fabian Ortiz Yepes como parte de su portafolio de transición hacia análisis de datos, basado en su experiencia como Director/Coordinador HSEQ.*
