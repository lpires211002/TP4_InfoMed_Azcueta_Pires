--18 Obtener el nombre del médico junto con el total de pacientes a los que ha atendido, ordenado por el total de pacientes en orden descendente.
SELECT m.nombre as "Nombre del médico", count(consultas.id_paciente) as total_pacientes_atendidos from medicos m
left join consultas on consultas.id_medico=m.id_medico
group by m.nombre
Order By total_pacientes_atendidos DESC