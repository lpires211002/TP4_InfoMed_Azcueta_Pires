--16 Obtener el nombre del médico junto con el nombre del paciente y el número total de consultas realizadas por cada médico para cada paciente, ordenado por médico y paciente
select m.nombre as nombre_medico, P.nombre as nombre_paciente, count(c.id_consulta) as cantidad_consultas from medicos m
Join consultas C on c.id_medico=M.id_medico
Join pacientes p on p.id_paciente=c.id_paciente
GROUP by m.nombre, p.nombre 
Order by m.nombre, count(c.id_consulta) DESC