--13  Obtener el nombre de los pacientes junto con la cantidad total de recetas que han recibido
select p.nombre, count(id_receta) as "Cantidad de recetas" from recetas 
RIGHT join pacientes P on p.id_paciente=recetas.id_paciente
GROUP by p.nombre
Order by COUNT(id_receta) DESC,P.nombre 