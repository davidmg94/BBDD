-- EJERCICIO 6
SELECT e.codigooficina, SUM(dp.cantidad * dp.preciounidad) AS TOTAL_VENDIDO
FROM  j_empleados e 
    JOIN j_clientes c ON c.codigoempleadorepventas = e.codigoempleado
    JOIN j_pedidos p ON p.codigocliente = c.codigocliente 
    JOIN j_detallepedidos dp ON dp.codigopedido = p.codigopedido
WHERE UPPER(e.codigooficina) LIKE '%USA' OR UPPER(e.codigooficina) LIKE '%ES'
GROUP BY e.codigooficina
HAVING SUM(dp.cantidad * dp.preciounidad) > 20000
ORDER BY e.codigooficina;