# 📊 Regresión en Etapas con Datos de Panel – Análisis para Argentina

Este repositorio contiene el código en **R** desarrollado para un análisis econométrico aplicado a datos de panel correspondientes a Argentina. El objetivo fue estimar un modelo con **doble endogeneidad**, abordado mediante una **regresión en tres etapas**.

El análisis fue encargado por una **economista del CONICET**, y los resultados empíricos sirvieron de base para un artículo académico revisado por pares. Este repositorio incluye el código comentado y materiales de contexto para facilitar su interpretación y reutilización.

---

## 📄 Contenido del repositorio

- **`CodigoPulido.R`**: script de R que incluye todos los pasos del análisis, con comentarios aclaratorios. Contiene:
  - Preparación de datos
  - Estimaciones por etapas
  - Diagnósticos de endogeneidad
  - Exportación de resultados en `.txt` y `.xls`
  - Introducción de ruido en variables con poca variabilidad, para garantizar la estimabilidad

- **Artículo académico (formato Word)**: escrito por la economista contratante, basado directamente en este análisis. Incluido con su autorización.

- **Paper de Jones, Sanguinetti y Tommasi (PDF)**: referencia teórica clave sobre el problema abordado, utilizado como sustento conceptual.

---

## 📌 Aclaraciones

🔒 La base de datos original **no se incluye** debido a que su publicación requeriría autorización de otras personas involucradas en su elaboración.  
🛠️ Sin embargo, el script está **altamente comentado** y puede adaptarse fácilmente a bases de estructura similar.

---

## 🔗 Publicación

El artículo se encuentra disponible en el sitio oficial del CONICET:  
👉 [Ver publicación](https://www.conicet.gov.ar/new_scp/detalle.php?keywords=&id=64277&articulos=yes)

---

## 🎯 Finalidad

Este proyecto demuestra cómo aplicar **regresiones por etapas** para abordar la **endogeneidad** en modelos con **datos de panel**.  
Está dirigido a economistas, investigadores, estudiantes avanzados de econometría y cualquier persona interesada en modelos empíricos con estructura compleja.

---

## 🛠️ Herramientas utilizadas

- **Lenguaje:** R  
- **Paquetes:** `plm`, `stargazer`, `readxl`, `writexl`, entre otros  
- **Salida de resultados:** exportación tabular (`.txt`, `.xls`) para integración con reportes

---

## ✨ Comentario final

Este repositorio tiene valor tanto como caso aplicado como por la forma en que documenta cada paso del proceso. Puede servir como referencia metodológica para quienes estén trabajando con modelos similares.
