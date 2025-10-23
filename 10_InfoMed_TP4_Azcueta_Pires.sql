--10 Obtener todas las consultas médicas realizadas por el médico con ID igual a 3 durante el mes de agosto de 2024.
SELECT *
FROM consultas
WHERE id_medico = 3
  AND fecha >= '2024-08-01'
  AND fecha <  '2024-09-01'
 