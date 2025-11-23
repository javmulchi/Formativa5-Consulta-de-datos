-- ==============================================================================

-- USER PRY2205_S5 
-- IDENTIFIED BY "PRY2205.semana_5"

-- ==============================================================================

-- FORMATIVA 5 CONSULTA DE BASE DE DATOS 
-- Caso de Estudio: Financorp

-- ==============================================================================

-- CASO 1: Listado de Trabajadores
-- Generar un listado para identificar a aquellos clientes de la compañía que son trabajadores dependientes,
-- cuya profesión (oficio) es: contador o vendedor. 
-- Considerar solo a los clientes cuyo año de inscripción es mayor al promedio redondeado de todos los años de inscripción de los clientes. 
-- El promedio redondeado de años de inscripción debe ser obtenido a través de una subconsulta.

-- ==============================================================================

SELECT 
    TO_CHAR(c.numrun, '99G999G999') || '-' || c.dvrun AS "RUT Cliente",
    INITCAP(c.pnombre || ' ' || c.appaterno) AS "Nombre Cliente",
    UPPER(po.nombre_prof_ofic) AS "Profesión Cliente",
    TO_CHAR(c.fecha_inscripcion, 'DD-MM-YYYY') AS "Fecha de Inscripción",
    c.direccion AS "Dirección Cliente"
FROM CLIENTE c
JOIN PROFESION_OFICIO po ON c.cod_prof_ofic = po.cod_prof_ofic
JOIN TIPO_CLIENTE tc ON c.cod_tipo_cliente = tc.cod_tipo_cliente
WHERE tc.nombre_tipo_cliente = 'Trabajadores dependientes'
  AND po.nombre_prof_ofic IN ('Contador', 'Vendedor')
  AND EXTRACT(YEAR FROM c.fecha_inscripcion) > (
      SELECT ROUND(AVG(EXTRACT(YEAR FROM fecha_inscripcion))) 
      FROM CLIENTE
  )
ORDER BY c.numrun ASC;

-- ==============================================================================

-- CASO 2: Aumento de crédito
-- Generar un listado desplegando los RUT’s y edades de los clientes de la empresa
-- Mostrar el cupo disponible para compras, pero cuyo monto disponible es superior o igual al máximo cupo disponible del año anterior al actual.
-- Almacenar la información resultante en la tabla CLIENTES_CUPOS_COMPRA, que tú deberás crear a partir de la consulta a la BBDD.
-- El máximo cupo disponible del año pasado debe ser obtenido a través de una subconsulta.

-- ==============================================================================


CREATE TABLE CLIENTES_CUPOS_COMPRA AS
SELECT 
    TO_CHAR(c.numrun, '99G999G999') || '-' || c.dvrun AS "RUT_CLIENTE",
    TRUNC(MONTHS_BETWEEN(SYSDATE, c.fecha_nacimiento)/12) AS "EDAD_CLIENTE",
    TO_CHAR(t.cupo_disp_compra, '$99G999G999') AS "CUPO_DISPONIBLE_COMPRA",
    UPPER(tc.nombre_tipo_cliente) AS "TIPO_CLIENTE"
FROM CLIENTE c
JOIN TARJETA_CLIENTE t ON c.numrun = t.numrun
JOIN TIPO_CLIENTE tc ON c.cod_tipo_cliente = tc.cod_tipo_cliente
WHERE t.cupo_disp_compra >= (
    SELECT MAX(cupo_disp_compra)
    FROM TARJETA_CLIENTE
    WHERE EXTRACT(YEAR FROM fecha_solic_tarjeta) = EXTRACT(YEAR FROM SYSDATE) - 1
)
ORDER BY "EDAD_CLIENTE" ASC ;

-- Verificación de los datos insertados en la tabla CLIENTES_CUPOS_COMPRA

SELECT * FROM CLIENTES_CUPOS_COMPRA 
ORDER BY "EDAD_CLIENTE" ASC;


-- Trabajo por:
-- Andrea Rosero  
--Javiera Mülchi 
