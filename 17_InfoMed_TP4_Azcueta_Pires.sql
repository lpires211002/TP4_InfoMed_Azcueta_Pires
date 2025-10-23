--17 Obtener el nombre del medicamento junto con el total de recetas prescritas para ese medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se le recetó, ordenado por total de recetas en orden descendente
SELECT medicamentos.nombre, count(id_receta) as total_recetas, medicos.nombre, pacientes.nombre from medicamentos
join recetas on recetas.id_medicamento=medicamentos.id_medicamento
join pacientes on pacientes.id_paciente=recetas.id_paciente
join medicos on recetas.id_medico=medicos.id_medico
GROUP by medicamentos.nombre,medicos.nombre, pacientes.nombre
Order by total_recetas Desc
