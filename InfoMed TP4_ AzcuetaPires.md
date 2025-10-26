# TP4 Infomed

Azcueta-Pires

## Parte 1

1)
La base de datos es relacional, ya que organiza la información en tablas vinculadas mediante claves primarias y foráneas (por ejemplo, pacientes, médicos, recetas) que permiten establecer relaciones entre los datos. Según su propósito, es una base de datos transaccional (OLTP), ya que su objetivo principal es registrar y gestionar operaciones diarias del centro de salud (registro de pacientes, emisión de recetas) con integridad y rapidez, más que realizar análisis históricos o agregados propios de un data warehouse.

2)
![WhatsApp Image 2025-10-26 at 19 43 11_f3eb191b](https://github.com/user-attachments/assets/66e59b80-4ded-485a-8452-1bbd8066c6f2)

3)
![WhatsApp Image 2025-10-26 at 20 22 10_cca55f56](https://github.com/user-attachments/assets/ca005174-f6e8-4c14-ad6c-7dd0f470eda2)

4)
La base de datos se encuentra parcialmente normalizada, ya que presenta una estructura coherente y con relaciones bien definidas, pero aún podrían optimizarse algunos aspectos para cumplir plenamente con las tres primeras formas normales. Para alcanzar la Primera Forma Normal (1FN), se debe asegurar que todos los campos contengan valores atómicos, sin grupos repetidos, sin listas ni atributos multivaluados (por ejemplo, direcciones separadas correctamente en calle, número y ciudad). Para la Segunda Forma Normal (2FN), sería necesario eliminar dependencias parciales en tablas con claves compuestas, asegurando que cada atributo dependa totalmente de la clave primaria. Finalmente, para cumplir la Tercera Forma Normal (3FN), deberían eliminarse las dependencias transitivas, separando en nuevas tablas los datos que dependen de otros atributos no clave (por ejemplo, especialidades o direcciones profesionales). Estas mejoras reducirían la redundancia y aumentarían la integridad de la base de datos.

## Parte 2: *Query's*

1. Cuando se realizan consultas sobre la tabla paciente agrupando por ciudad, los tiempos de respuesta son demasiado largos. Proponer mediante una query SQL una solución a este problema.

```sql
CREATE INDEX idx_pacientes_ciudad
ON pacientes(ciudad);

SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad;
```

<img width="598" height="174" alt="Captura de pantalla 2025-10-26 a la(s) 4 44 41 p  m" src="https://github.com/user-attachments/assets/ec2af54a-2c4a-4e88-bcde-524613277f77" />



2. Se tiene la fecha de nacimiento de los pacientes. Se desea calcular la edad de los pacientes y almacenarla de forma dinámica en el sistema ya que es un valor típicamente consultado, junto con otra información relevante del paciente.
```sql
SELECT 
  id_paciente,
  P.nombre,
  EXTRACT(YEAR FROM age(current_date, P.fecha_nacimiento)) AS edad
FROM pacientes P
```
<img width="452" height="307" alt="Captura de pantalla 2025-10-26 a la(s) 4 45 40 p  m" src="https://github.com/user-attachments/assets/eac43009-8aa4-4762-bf9b-84ba8effcfc5" />

3. La paciente,“Luciana Gómez”, ha cambiado de dirección. Antes vivía en “Avenida Las Heras 121” en “Buenos Aires”, pero ahora vive en “Calle Corrientes 500” en “Buenos Aires”. Actualizar la dirección de este paciente en la base de datos.
```sql
UPDATE pacientes
set calle='Calle Corrientes', numero=500
WHERE id_paciente=1
SELECT nombre, calle, numero from pacientes where id_paciente=1
```

<img width="698" height="69" alt="Captura de pantalla 2025-10-26 a la(s) 4 52 19 p  m" src="https://github.com/user-attachments/assets/758ee3c7-0f8c-4f97-9fb5-ab307722420e" />

4. Seleccionar el nombre y la matrícula de cada médico cuya especialidad sea identificada por el id 4.
```sql
SELECT nombre, matricula from medicos where especialidad_id=4
```
<img width="589" height="111" alt="Captura de pantalla 2025-10-26 a la(s) 4 58 10 p  m" src="https://github.com/user-attachments/assets/77242231-7fe1-4b7c-9d1e-4043426b6a16" />


5. Puede pasar que haya inconsistencias en la forma en la que están escritos los nombres de las ciudades, ¿cómo se corrige esto? Agregar la query correspondiente.
 ```sql
UPDATE pacientes
set ciudad='Buenos Aires'
WHERE ciudad ILIKE '%s %'

UPDATE pacientes
set ciudad='Mendoza'
WHERE ciudad ILIKE '%Men%'

UPDATE pacientes
set ciudad='Córdoba'
WHERE ciudad ILIKE '%ba%'

select ciudad from pacientes GROUP by ciudad order by ciudad desc
```
<img width="595" height="215" alt="Captura de pantalla 2025-10-26 a la(s) 4 58 24 p  m" src="https://github.com/user-attachments/assets/fdcf23e0-eae4-4370-9371-79a56950639d" />


6. Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires.

```sql
Select nombre,ciudad, calle, numero from pacientes where ciudad ILIKE '%s %' -- por si no se corrigió la base de datos previamente
```
<img width="591" height="280" alt="Captura de pantalla 2025-10-26 a la(s) 4 58 42 p  m" src="https://github.com/user-attachments/assets/091d7fb2-62f0-4bef-8e50-5756cd288bf5" />


7. Cantidad de pacientes que viven en cada ciudad.
```sql   
select ciudad, count(id_paciente) as "Cantidad de pacientes" from pacientes GROUP by ciudad
```
<img width="594" height="171" alt="Captura de pantalla 2025-10-26 a la(s) 4 59 00 p  m" src="https://github.com/user-attachments/assets/5e9e4e2c-4b55-4461-b74b-1dc9f6afd419" />


8. Cantidad de pacientes por sexo que viven en cada ciudad.
```sql
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
```
<img width="597" height="279" alt="Captura de pantalla 2025-10-26 a la(s) 4 59 36 p  m" src="https://github.com/user-attachments/assets/ac15c57d-d2ec-476f-877a-f9e8a71c2ca1" />


9. Obtener la cantidad de recetas emitidas por cada médico.
```sql
select nombre as "nombre medico", count(id_receta) as "Cantidad de recetas" from recetas 
RIGHT join medicos on medicos.id_medico = recetas.id_medico
Group By medicos.nombre
```
<img width="594" height="394" alt="Captura de pantalla 2025-10-26 a la(s) 4 59 51 p  m" src="https://github.com/user-attachments/assets/78504877-b318-4c87-bfd0-8d39c76595b9" />



10. Obtener todas las consultas médicas realizadas por el médico con ID igual a 3 durante el mes de agosto de 2024.
```sql
SELECT *
FROM consultas
WHERE id_medico = 3
  AND fecha >= '2024-08-01'
  AND fecha <  '2024-09-01'
```
<img width="598" height="139" alt="Captura de pantalla 2025-10-26 a la(s) 5 00 04 p  m" src="https://github.com/user-attachments/assets/1213ab37-98c7-48bc-834e-15ed745dca4c" />

 
11. Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las consultas médicas realizadas en agosto del 2024.
```sql
SELECT p.nombre, c.fecha, c.diagnostico from consultas c 
join pacientes p on p.id_paciente=c.id_paciente
where  fecha >= '2024-08-01' AND fecha <  '2024-09-01'
```
<img width="599" height="401" alt="Captura de pantalla 2025-10-26 a la(s) 5 01 29 p  m" src="https://github.com/user-attachments/assets/2034735b-3aad-4c04-b831-bc70b8c0f273" />


12. Obtener el nombre de los medicamentos prescritos más de una vez por el médico con ID igual a 2.
```sql
SELECT 
  M.id_medicamento,
  M.nombre,
  COUNT(r.id_medicamento) AS cantidad_recetada
FROM recetas r
JOIN medicamentos M ON r.id_medicamento = M.id_medicamento
WHERE r.id_medico = 2
GROUP BY M.id_medicamento, M.nombre
HAVING COUNT(r.id_medicamento) > 1
```
<img width="600" height="63" alt="Captura de pantalla 2025-10-26 a la(s) 5 01 48 p  m" src="https://github.com/user-attachments/assets/3b88adbc-a54e-479f-87bb-9c730a7390fb" />

13.  Obtener el nombre de los pacientes junto con la cantidad total de recetas que han recibido
```sql
select p.nombre, count(id_receta) as "Cantidad de recetas" from recetas 
RIGHT join pacientes P on p.id_paciente=recetas.id_paciente
GROUP by p.nombre
Order by COUNT(id_receta) DESC,P.nombre 
```

<img width="590" height="335" alt="Captura de pantalla 2025-10-26 a la(s) 5 02 10 p  m" src="https://github.com/user-attachments/assets/210f226b-c570-42a2-a50c-b3ee8a1342a9" />

14. Obtener el nombre del medicamento más recetado junto con la cantidad de recetas emitidas para ese medicamento.
```sql
SELECT m.nombre as "Nombre medicamento", count(recetas.id_medicamento) as cantidad_emitida FROM recetas 
join medicamentos m on m.id_medicamento=recetas.id_medicamento
GROUP by m.nombre
ORDER by count(recetas.id_medicamento) desc
LIMIT 1;
```
<img width="596" height="59" alt="Captura de pantalla 2025-10-26 a la(s) 5 02 23 p  m" src="https://github.com/user-attachments/assets/9c35d4e8-1a71-4632-891e-ea9142a4b933" />


15. Obtener el nombre del paciente junto con la fecha de su última consulta y el diagnóstico asociado
```sql
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
```
<img width="595" height="345" alt="Captura de pantalla 2025-10-26 a la(s) 5 12 49 p  m" src="https://github.com/user-attachments/assets/f140fb2b-46a3-4647-924c-ff1f99579d6e" />


16. Obtener el nombre del médico junto con el nombre del paciente y el número total de consultas realizadas por cada médico para cada paciente, ordenado por médico y paciente
```sql
select m.nombre as nombre_medico, P.nombre as nombre_paciente, count(c.id_consulta) as cantidad_consultas from medicos m
Join consultas C on c.id_medico=M.id_medico
Join pacientes p on p.id_paciente=c.id_paciente
GROUP by m.nombre, p.nombre 
Order by m.nombre, count(c.id_consulta) DESC
```
<img width="597" height="339" alt="Captura de pantalla 2025-10-26 a la(s) 5 13 10 p  m" src="https://github.com/user-attachments/assets/2a4613a7-50a2-4c4a-82ef-80e27c4da451" />

17. Obtener el nombre del medicamento junto con el total de recetas prescritas para ese medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se le recetó, ordenado por total de recetas en orden descendente
```sql
SELECT medicamentos.nombre, count(id_receta) as total_recetas, medicos.nombre, pacientes.nombre from medicamentos
join recetas on recetas.id_medicamento=medicamentos.id_medicamento
join pacientes on pacientes.id_paciente=recetas.id_paciente
join medicos on recetas.id_medico=medicos.id_medico
GROUP by medicamentos.nombre,medicos.nombre, pacientes.nombre
Order by total_recetas Desc
```
<img width="595" height="342" alt="Captura de pantalla 2025-10-26 a la(s) 5 13 32 p  m" src="https://github.com/user-attachments/assets/383d6fc1-2443-4b71-87c2-91140e22797c" />

18. Obtener el nombre del médico junto con el total de pacientes a los que ha atendido, ordenado por el total de pacientes en orden descendente.
```sql
SELECT m.nombre as "Nombre del médico", count(consultas.id_paciente) as total_pacientes_atendidos from medicos m
left join consultas on consultas.id_medico=m.id_medico
group by m.nombre
Order By total_pacientes_atendidos DESC
```
<img width="592" height="334" alt="Captura de pantalla 2025-10-26 a la(s) 5 13 46 p  m" src="https://github.com/user-attachments/assets/c7512ed0-f4e4-4567-b09b-da82922988c8" />






