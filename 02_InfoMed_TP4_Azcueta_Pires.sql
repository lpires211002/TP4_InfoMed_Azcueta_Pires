--2  Se tiene la fecha de nacimiento de los pacientes. Se desea calcular la edad de los pacientes y almacenarla de forma dinámica en el sistema ya que es un valor típicamente consultado, junto con otra información relevante del paciente
SELECT 
  id_paciente,
  P.nombre,
  EXTRACT(YEAR FROM age(current_date, P.fecha_nacimiento)) AS edad
FROM pacientes P