-- EJERCICIO 5 --
SELECT S.DESCRSEGURO, COUNT(*) AS "N� SEGUROS", SUM(S.CANTIDAD) AS "SUMA CANTIDADES" 
FROM  SV_CLIENTES C JOIN SV_VEHICULOS V ON C.DNI = V.DNI 
JOIN SV_TIPOSSEGURO S ON V.IDSEGURO = S.IDSEGURO 
WHERE UPPER(C.POBLACION) IN ('CIUDAD REAL','MIGUELTURRA','ALMAGRO','DAIMIEL')
GROUP BY S.DESCRSEGURO
HAVING AVG(S.CANTIDAD) < (SELECT AVG(SUM(S.CANTIDAD)) FROM SV_TIPOSSEGURO S GROUP BY S.CANTIDAD);

