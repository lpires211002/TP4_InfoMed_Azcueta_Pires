--7 Cantidad de pacientes que viven en cada ciudad.
select ciudad, count(id_paciente) as "Cantidad de pacientes" from pacientes GROUP by ciudad