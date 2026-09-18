# Análisis de accidentalidad laboral: frecuencia y severidad por área

## 1. El problema de negocio
En operaciones industriales (izajes, trabajo en alturas, espacios confinados, eléctrica), no todas las áreas representan el mismo nivel de riesgo. Sin un análisis cuantitativo, los esfuerzos de prevención se reparten de forma pareja en vez de dirigirse a donde más se necesitan. Este proyecto responde la pregunta: **¿qué áreas concentran el mayor riesgo real — ya sea por frecuencia o por severidad — y no solo el mayor número de eventos reportados?**

## 2. Los datos
- Fuente: registro de incidentes de campo (fecha, área, turno, tipo de incidente, días de incapacidad, días cargados) y número de trabajadores activos por área y mes.
- Periodo: enero–marzo (datos simulados, con la misma estructura de los reportes HSEQ que manejo en campo).
- Limpieza y decisión de negocio clave: **Frecuencia y Severidad se calculan sobre el mismo conjunto de datos filtrado una sola vez** — se excluyen los cuasi-accidentes (eventos sin lesión) porque no son accidentes de trabajo reales. No se usan criterios distintos para cada indicador: ambos parten de la misma base para que sean comparables entre sí.

## 3. El proceso
- Extracción y cálculo en SQL (MySQL): una única consulta une `incidentes` (ya filtrada para excluir cuasi-accidentes) con `trabajadores_mes` por área y mes, y calcula ambos indicadores oficiales (base 100 trabajadores) **como columnas de la misma tabla de resultado**:
  - **Frecuencia de accidentalidad** = (N° de accidentes reales en el mes / N° de trabajadores en el mes) × 100
  - **Severidad de accidentalidad** = ((días de incapacidad + días cargados en el mes) / N° de trabajadores en el mes) × 100
- Visualización: dashboard en Power BI con un gráfico combinado (columnas + línea en eje secundario) que muestra ambos indicadores cruzados por área, ya que tienen escalas muy distintas y no deben forzarse al mismo eje.

## 4. Insight y recomendación
- **Espacios Confinados** tuvo la Frecuencia más alta del periodo (10 accidentes por cada 100 trabajadores en febrero) — resultado esperado en un área con pocos trabajadores, donde un solo evento pesa mucho porcentualmente, pero igual señala un área a vigilar de cerca.
- **Alturas** concentra por lejos la mayor Severidad (superando 150 por cada 100 trabajadores en marzo), arrastrada por una caída grave y sus días cargados de un caso anterior — es decir: pocos eventos, pero de altísimo impacto.
- **Recomendación**: usar ambos indicadores juntos, no por separado, y siempre calculados sobre la misma base de accidentes reales. Espacios Confinados necesita revisión de causas raíz por su alta frecuencia; Alturas necesita revisión de controles críticos (PTW, anclajes, supervisión) por su severidad extrema, y seguimiento explícito de los días cargados que siguen arrastrando casos antiguos.

## 5. Código y dashboard
- Consulta SQL completa: [`analisis.sql`](./analisis.sql)
- Dashboard interactivo: *[`01_analisis_accidentalidad`](./https://github.com/nilsonortizy85/nilsonortiz_data/blob/main/01_analisis_accidentalidad_Dashboard.jpg)*
- Dataset: [`datos.csv`](./datos.csv)

---
*Proyecto desarrollado por Nilson Fabian Ortiz Yepes como parte de su portafolio de transición hacia análisis de datos, basado en su experiencia como Director/Coordinador HSEQ.*
