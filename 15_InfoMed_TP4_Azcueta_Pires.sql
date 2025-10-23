--15 Obtener el nombre del paciente junto con la fecha de su última consulta y el diagnóstico asociado
SELECT 
  p.nombre, 
  c.fecha AS ultima_consulta, 
  c.diagnostico
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
WHERE c.fecha = (
  SELECT MAX(c2.fecha)
  FROM consultas c2
  WHERE c2.id_paciente = p.id_paciente
)
ORDER BY c.fecha ASC