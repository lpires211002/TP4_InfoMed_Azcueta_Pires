--8 Cantidad de pacientes por sexo que viven en cada ciudad.
SELECT 
  ciudad,
  CASE 
    WHEN id_sexo = 1 THEN 'M'
    WHEN id_sexo = 2 THEN 'F'
    ELSE 'Otro'
  END AS sexo_paciente,
  COUNT(id_paciente) AS "Cantidad de pacientes"
FROM pacientes
GROUP BY ciudad, id_sexo