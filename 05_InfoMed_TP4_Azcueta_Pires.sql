--5  Puede pasar que haya inconsistencias en la forma en la que están escritos los nombres de las ciudades, ¿cómo se corrige esto? Agregar la query correspondiente.
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