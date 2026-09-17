# Dashboard de cumplimiento de capacitaciones e inspecciones HSE

## 1. El problema de negocio
El cumplimiento de capacitaciones y el cierre de hallazgos de inspección son indicadores líderes (predicen incidentes antes de que ocurran), pero suelen revisarse manualmente y de forma tardía. Este proyecto responde: **¿qué áreas están quedando atrás en cumplimiento, antes de que eso se traduzca en un incidente?**

## 2. Los datos
- Fuente: registro de capacitaciones programadas vs. realizadas por empleado y área, y registro de inspecciones con hallazgos abiertos y cerrados.
- Periodo: enero–febrero (datos simulados, con la misma estructura de los formatos de capacitación e inspección usados en campo).
- Limpieza: manejo de valores nulos en `fecha_realizada` (capacitaciones no ejecutadas) sin descartar esas filas, ya que son justamente las que interesa medir. Además, se corrigió el denominador del % de cierre de hallazgos: debe ser el **total de hallazgos identificados** (abiertos + cerrados), no solo los que quedaron abiertos — usar solo los abiertos como base subestimaba el indicador real.

## 3. El proceso
- Cálculo en SQL del % de cumplimiento de capacitaciones por área, usando `CASE WHEN` para convertir la condición "se realizó / no se realizó" en una métrica agregada.
- Cálculo corregido del % de cierre de hallazgos: `hallazgos_cerrados / (hallazgos_abiertos + hallazgos_cerrados) × 100` por área.
- Visualización: dashboard en Power BI con semáforo (rojo/amarillo/verde) por área y por tema de capacitación.

## 4. Insight y recomendación
- **Izajes** fue la única área con 100% de cumplimiento de capacitaciones; **Alturas, Eléctrica y Espacios Confinados** quedaron empatadas en 50% — la mitad del personal de esas tres áreas no recibió la capacitación programada en el periodo.
- Con la fórmula corregida, **Espacios Confinados** tiene el menor % de cierre de hallazgos (20%), seguida de Izajes (40%) — confirma que Espacios Confinados es el área más rezagada en ambos indicadores líderes a la vez.
- **Recomendación**: reprogramar de inmediato las capacitaciones pendientes en las tres áreas al 50%, priorizando Espacios Confinados por su bajo cierre de hallazgos, y escalar su seguimiento con el supervisor del área antes de que ambos rezagos se traduzcan en un incidente real.

## 5. Código y dashboard
- Consulta SQL completa: [`analisis.sql`](./analisis.sql)
- Dashboard interactivo: *(agregar link de Power BI publicado)*
- Dataset: [`datos.csv`](./datos.csv)

---
*Proyecto desarrollado por Nilson Fabian Ortiz Yepes como parte de su portafolio de transición hacia análisis de datos, basado en su experiencia como Director/Coordinador HSEQ.*
