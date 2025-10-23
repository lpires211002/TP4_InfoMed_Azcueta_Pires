--14 Obtener el nombre del medicamento más recetado junto con la cantidad de recetas emitidas para ese medicamento.
SELECT m.nombre as "Nombrense medicamento", count(recetas.id_medicamento) as cantidad_emitida FROM recetas 
join medicamentos m on m.id_medicamento=recetas.id_medicamento
GROUP by m.nombre
ORDER by count(recetas.id_medicamento) desc
LIMIT 1;