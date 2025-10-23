
--1 Cuando se realizan consultas sobre la tabla paciente agrupando por ciudad, los tiempos de respuesta son demasiado largos. Proponer mediante una query SQL una solución a este problema.
CREATE INDEX idx_pacientes_ciudad
ON pacientes(ciudad);

SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad;
