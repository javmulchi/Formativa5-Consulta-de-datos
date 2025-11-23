# Caso de Estudio: FinanCorp: Gestión de Clientes y Cobranzas
**Actividad formativa correspondiente a la semana 5 de la asignatura Consulta de bases de datos**
## Introducción

Este repositorio contiene los scripts SQL desarrollados para la resolución del caso de negocio "FinanCorp". El objetivo es brindar apoyo al departamento de cobranzas extrayendo información clave de la base de datos para la toma de decisiones a corto plazo.

### Contexto del Caso
FinanCorp es una compañía especializada en gestión de cobranzas. Debido al aumento de su base de clientes y transacciones, se requiere:
Identificar clientes específicos (Contadores y Vendedores) para optimizar el cobro.
Evaluar clientes para un posible aumento de cupo basado en su historial del año anterior y su edad.

## Requisitos Técnicos
- Motor de Base de Datos: Oracle Database (11g, 12c, 19c o superior).
- Cliente SQL: Oracle SQL Developer.
- Configuración Regional: El script asume formatos de fecha y moneda locales (Chile).

<img width="658" height="640" alt="Formativa5" src="https://github.com/user-attachments/assets/af3c9171-1ce1-4e94-b985-881871ae8348" />

Fig.1 

## Soluciones planteadas

### 📄 Caso 1: Listado de Clientes
Objetivo: Generar un reporte de trabajadores dependientes que sean "Contador" o "Vendedor", inscritos después del año promedio de inscripción de toda la cartera.

Características del script:

Uso de JOIN entre tablas CLIENTE, PROFESION_OFICIO y TIPO_CLIENTE.

Subconsulta para calcular el promedio redondeado (ROUND, AVG) de los años de inscripción.

Formato de salida específico (INITCAP, TO_CHAR).

<img width="815" height="628" alt="Captura de pantalla 2025-11-23 184946" src="https://github.com/user-attachments/assets/69ccf36d-4065-4fde-a4dc-83b3a2bb2b92" />





### 📄 Caso 2: Aumento de Crédito
Objetivo: Crear una tabla llamada CLIENTES_CUPOS_COMPRA con clientes cuyo cupo disponible actual sea superior o igual al máximo cupo disponible registrado el año anterior.

Características del script:

Creación de tabla a partir de consulta (CREATE TABLE AS SELECT).

Cálculo de edad precisa usando MONTHS_BETWEEN y TRUNC.

Subconsulta para obtener el máximo cupo del año SYSDATE - 1


<img width="679" height="275" alt="Captura de pantalla 2025-11-23 184955" src="https://github.com/user-attachments/assets/3a84534f-5fce-4cb3-a7f1-7e85e28d0eab" />


## Observaciones Importantes (Troubleshooting)
Al ejecutar estos scripts, se pueden observar diferencias respecto a las imágenes de referencia estáticas (Figura 2 y 3 del caso). Esto se debe a dos factores técnicos identificados en el script de poblado original:

Duplicidad en Profesiones: El script de inserción (INSERT) ingresa la profesión 'Contador' dos veces (IDs generados por secuencia). Al filtrar por el nombre 'Contador', la consulta SQL trae correctamente a los clientes asociados a ambos IDs, resultando en un número de filas mayor (ej. 10 filas) que el mostrado en el ejemplo estático (ej. 6 filas).

Fechas Dinámicas (SYSDATE): Los datos de prueba se generan calculando fechas relativas al día de hoy (EXTRACT(YEAR FROM SYSDATE) - X). Esto provoca que:

El promedio de años de inscripción cambie con el tiempo.

Los clientes que califican como "del año pasado" cambien dependiendo de cuándo se ejecute el script.

Conclusión: El código SQL es correcto lógicamente y cumple con las reglas de negocio, adaptándose dinámicamente al estado actual de la base de datos.


Fila 392 y 400 se inserta duplicado "Contador":

<img width="775" height="463" alt="Captura de pantalla 2025-11-23 182339" src="https://github.com/user-attachments/assets/860140fd-2379-4355-adfb-6c62e407c696" />



**Autores**
-Javiera Mülchi
-Andrea Rosero
