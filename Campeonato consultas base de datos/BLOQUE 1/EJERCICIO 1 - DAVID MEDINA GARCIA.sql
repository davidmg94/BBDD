-- DAVID MEDINA GARCIA
-- EJERCICIO 1
SELECT e.apellido1, e.apellido2, e.nombre, c.nombrecliente, o.ciudad, p.fechapago
FROM j_empleados e JOIN  j_clientes c ON e.codigoempleado = c.codigoempleadorepventas 
JOIN j_pagos p ON c.codigocliente = p.codigocliente JOIN j_oficinas o ON e.codigooficina = o.codigooficina
ORDER BY e.apellido1, e.apellido2, e.nombre, c.nombrecliente;
