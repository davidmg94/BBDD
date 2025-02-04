-- EJERCICIO 4 --
-- CON REFERENCIA EXTERNA --
SELECT C.DNI, V.MATRICULA, VA.FECHA_ACCIDENTE, T.DESCR_ACCID 
FROM  SV_CLIENTES C JOIN SV_VEHICULOS V ON C.DNI = V.DNI 
JOIN SV_VEHIC_ACCID VA ON V.MATRICULA = VA.MATRICULA JOIN SV_TIPOSACCIDENTES T ON VA.IDACCIDENTE = T.IDACCIDENTE
WHERE UPPER(C.POBLACION) = 'CIUDAD REAL' AND V.DNI IN (
                                SELECT V.DNI FROM SV_CLIENTES C JOIN SV_VEHICULOS V ON C.DNI = V.DNI  GROUP BY V.DNI HAVING COUNT(V.DNI)>1);
-- CON REFERENCIA EXTERNA --
