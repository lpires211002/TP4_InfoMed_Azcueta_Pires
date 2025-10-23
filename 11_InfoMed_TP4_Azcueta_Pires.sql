--11 Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las consultas médicas realizadas en agosto del 2024.
SELECT p.nombre, c.fecha, c.diagnostico from consultas c 
join pacientes p on p.id_paciente=c.id_paciente
where  fecha >= '2024-08-01' AND fecha <  '2024-09-01'