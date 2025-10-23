--9 Obtener la cantidad de recetas emitidas por cada médico.
select nombre as "nombre medico", count(id_receta) as "Cantidad de recetas" from recetas 
RIGHT join medicos on medicos.id_medico = recetas.id_medico
Group By medicos.nombre