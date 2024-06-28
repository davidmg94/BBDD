--EJERCICIO 1--
CREATE OR REPLACE TYPE PERSONAL AS OBJECT (
  IDCLIENTE NUMBER(5),
  DNI VARCHAR2(10),
  NOMBRE VARCHAR2(30),
  CALLE VARCHAR2(100),
  POBLACION VARCHAR2(50),
  PROVINCIA VARCHAR2(30),
  FECHA_ALTA DATE
)NOT FINAL;
--EJERCICIO 2--
CREATE OR REPLACE TYPE CLIENTE UNDER PERSONAL (
  NRO_CUENTA VARCHAR2(20),
  TIPO_CLI NUMBER(1),
  
  CONSTRUCTOR FUNCTION CLIENTE(
    idcliente NUMBER,
    dni VARCHAR2,
    nombre VARCHAR2,
    apellidos VARCHAR2,
    calle VARCHAR2,
    poblacion VARCHAR2,
    provincia VARCHAR2
  ) RETURN SELF AS RESULT,

  CONSTRUCTOR FUNCTION CLIENTE(
    idcliente NUMBER,
    dni VARCHAR2,
    nombre VARCHAR2,
    calle VARCHAR2,
    poblacion VARCHAR2,
    provincia VARCHAR2,
    nro_cuenta VARCHAR2,
    tipo_cli NUMBER,
    fecha_alta DATE
  ) RETURN SELF AS RESULT,

  MEMBER FUNCTION getDireccion RETURN VARCHAR2
);
/
CREATE OR REPLACE TYPE BODY CLIENTE AS
  
  CONSTRUCTOR FUNCTION CLIENTE(
    idcliente NUMBER,
    dni VARCHAR2,
    nombre VARCHAR2,
    apellidos VARCHAR2,
    calle VARCHAR2,
    poblacion VARCHAR2,
    provincia VARCHAR2
  ) RETURN SELF AS RESULT IS
  BEGIN
    SELF.IDCLIENTE := idcliente;
    SELF.DNI := dni;
    SELF.NOMBRE := nombre || ' ' || apellidos;
    SELF.CALLE := calle;
    SELF.POBLACION := poblacion;
    SELF.PROVINCIA := provincia;
    SELF.FECHA_ALTA := SYSDATE;
    RETURN;
  END;
  
  CONSTRUCTOR FUNCTION CLIENTE(
    idcliente NUMBER,
    dni VARCHAR2,
    nombre VARCHAR2,
    calle VARCHAR2,
    poblacion VARCHAR2,
    provincia VARCHAR2,
    nro_cuenta VARCHAR2,
    tipo_cli NUMBER,
    fecha_alta DATE
  ) RETURN SELF AS RESULT IS
  BEGIN
    SELF.IDCLIENTE := idcliente;
    SELF.DNI := dni;
    SELF.NOMBRE := nombre;
    SELF.CALLE := calle;
    SELF.POBLACION := poblacion;
    SELF.PROVINCIA := provincia;
    SELF.NRO_CUENTA := nro_cuenta;
    SELF.TIPO_CLI := tipo_cli;
    SELF.FECHA_ALTA := fecha_alta;
    RETURN;
  END;
  
  MEMBER FUNCTION getDireccion RETURN VARCHAR2 IS
  BEGIN
  RETURN SELF.CALLE || ', ' || SELF.POBLACION || ', ' || SELF.PROVINCIA;
  END;
END;
--EJERCICIO 3--
CREATE OR REPLACE TYPE SERVICIO AS OBJECT (
  IDSERVICIO NUMBER(5),
  REFCLIENTE REF CLIENTE,
  NRO_HORAS NUMBER(3),
  PRECIO_HORA NUMBER(5,2),
  FECHA_SERVICIO DATE
);
--EJERCICIO 4--
CREATE TABLE CLIENTES_OBJ OF CLIENTE (
    IDCLIENTE PRIMARY KEY);

INSERT INTO CLIENTES_OBJ 
VALUES (CLIENTE(1, '111111111A', 'MAR�A', 'LASO MAR', 'TOLEDO, 21-1� C', 'CIUDAD REAL', 'CIUDAD REAL'));

INSERT INTO CLIENTES_OBJ 
VALUES (CLIENTE(2, '2222222B', 'JUAN MIRTA GIL', 'COSO, 10', 'DAIMIEL', 'CIUDAD REAL', '', '', TO_DATE('04/02/2021', 'DD/MM/YYYY')));

INSERT INTO CLIENTES_OBJ 
VALUES (CLIENTE(3,'33333333C','PEDRO TOSAR MESA','BARRIAL,10','ARG�S','TOLEDO', NULL, NULL, TO_DATE('03/08/2020', 'DD/MM/YYYY')));





--EJERCICIO 5--
CREATE TABLE SERVICIOS_OBJ OF SERVICIO(
    IDSERVICIO PRIMARY KEY);
--EJERCICIO 6--
DECLARE
    REFCLIENTE1 REF CLIENTE;
    REFCLIENTE2 REF CLIENTE;
    REFCLIENTE3 REF CLIENTE;
    CLIENTE_2 CLIENTE;
    SERVICIO_V SERVICIO;
BEGIN
    SELECT REF(C) INTO REFCLIENTE1 FROM CLIENTES_OBJ C WHERE C.IDCLIENTE = 1;
    SELECT REF(C) INTO REFCLIENTE2 FROM CLIENTES_OBJ C WHERE C.IDCLIENTE = 2;

    INSERT INTO SERVICIOS_OBJ 
    VALUES (SERVICIO(11, REFCLIENTE1, 10, 30, TO_DATE('01/02/2022', 'DD/MM/YYYY')));
    
    INSERT INTO SERVICIOS_OBJ 
    VALUES (SERVICIO(22, REFCLIENTE2, 20, 40, TO_DATE('12/03/2022', 'DD/MM/YYYY')));

    SELECT VALUE(C) INTO CLIENTE_2 FROM CLIENTES_OBJ C WHERE C.IDCLIENTE = 2;
    CLIENTE_2.IDCLIENTE := 22;
    CLIENTE_2.DNI := '21111111B';
    INSERT INTO CLIENTES_OBJ VALUES (CLIENTE_2);

    SELECT VALUE(S) INTO SERVICIO_V FROM SERVICIOS_OBJ S WHERE S.IDSERVICIO = 11;
    SELECT REF(C) INTO REFCLIENTE3 FROM CLIENTES_OBJ C WHERE C.IDCLIENTE = 3;
    SERVICIO_V.IDSERVICIO := 12;
    SERVICIO_V.REFCLIENTE := REFCLIENTE3;
    INSERT INTO SERVICIOS_OBJ VALUES (SERVICIO_V);
END;
--EJERCICIO 7--
SELECT
    S.IDSERVICIO,
    S.REFCLIENTE.NOMBRE AS "NOMBRE CLIENTE",
    S.REFCLIENTE.DNI AS "DNI",
    S.REFCLIENTE.POBLACION AS "POBLACION",
    S.NRO_HORAS AS "NRO_HORAS",
    S.PRECIO_HORA AS "PRECIO HORA",
    (S.NRO_HORAS * S.PRECIO_HORA) AS "TOTAL"
FROM
    SERVICIOS_OBJ S
ORDER BY IDSERVICIO;

