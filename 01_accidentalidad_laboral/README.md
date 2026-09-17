# Análisis de accidentalidad laboral: frecuencia y severidad por área

## 1. El problema de negocio
En operaciones industriales (izajes, trabajo en alturas, espacios confinados, eléctrica), no todas las áreas representan el mismo nivel de riesgo. Sin un análisis cuantitativo, los esfuerzos de prevención se reparten de forma pareja en vez de dirigirse a donde más se necesitan. Este proyecto responde la pregunta: **¿qué áreas concentran el mayor riesgo real — ya sea por frecuencia o por severidad — y no solo el mayor número de eventos reportados?**

## 2. Los datos
- Fuente: registro de incidentes de campo (fecha, área, turno, tipo de incidente, días de incapacidad, días cargados, severidad) y número de trabajadores activos por área y mes.
- Periodo: enero–marzo (datos simulados, con la misma estructura de los reportes HSEQ que manejo en campo).
- Limpieza y decisión de negocio clave: los **cuasi-accidentes** (eventos sin lesión, solo "casi pasa") se excluyen del cálculo de Frecuencia, porque esta mide accidentes de trabajo reales, no todos los eventos reportados — mezclarlos infla artificialmente el indicador.

## 3. El proceso
- Extracción y cálculo en SQL (MySQL): se unieron las tablas `incidentes` y `trabajadores_mes` por área y mes (`DATE_FORMAT(fecha, '%Y-%m-01')`), y se calcularon los dos indicadores oficiales (base 100 trabajadores):
  - **Frecuencia de accidentalidad** = (N° de accidentes de trabajo en el mes, excluyendo cuasi-accidentes / N° de trabajadores en el mes) × 100 → por cada 100 trabajadores, cuántos accidentes reales se presentaron.
  - **Severidad de accidentalidad** = ((días de incapacidad + días cargados en el mes) / N° de trabajadores en el mes) × 100 → por cada 100 trabajadores, cuántos días se perdieron por accidente.
- Visualización: dashboard en Power BI con ambos indicadores por área y por mes, y desglose por tipo de incidente.

## 4. Insight y recomendación
- **Espacios Confinados** tuvo la Frecuencia más alta del periodo (10 accidentes por cada 100 trabajadores en febrero) — resultado esperado en un área con pocos trabajadores, donde un solo evento pesa mucho porcentualmente, pero igual señala un área a vigilar de cerca.
- **Alturas** concentra por lejos la mayor Severidad (superando 150 por cada 100 trabajadores en marzo), arrastrada por una caída grave y sus días cargados de un caso anterior — es decir: pocos eventos, pero de altísimo impacto.
- **Recomendación**: usar ambos indicadores juntos, no por separado. Espacios Confinados necesita revisión de causas raíz por su alta frecuencia; Alturas necesita revisión de controles críticos (PTW, anclajes, supervisión) por su severidad extrema, y seguimiento explícito de los días cargados que siguen arrastrando casos antiguos.

## 5. Código y dashboard
- Consulta SQL completa: [`analisis.sql`](./analisis.sql)
- Dashboard interactivo: *(agregar link de Power BI publicado)*
- Dataset: [`datos.csv`](./datos.csv)

---
*Proyecto desarrollado por Nilson Fabian Ortiz Yepes como parte de su portafolio de transición hacia análisis de datos, basado en su experiencia como Director/Coordinador HSEQ.*
