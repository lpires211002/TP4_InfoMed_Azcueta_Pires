--12 Obtener el nombre de los medicamentos prescritos más de una vez por el médico con ID igual a 2.
SELECT 
  M.id_medicamento,
  M.nombre,
  COUNT(r.id_medicamento) AS cantidad_recetada
FROM recetas r
JOIN medicamentos M ON r.id_medicamento = M.id_medicamento
WHERE r.id_medico = 2
GROUP BY M.id_medicamento, M.nombre
HAVING COUNT(r.id_medicamento) > 1