# Requerimientos Funcionales y Pruebas del Sistema

## Sistema de Consulta del Metro de Lima y Callao

## 1. Descripción del proyecto

ProyectoMetro es una aplicación de consola desarrollada en Swift que permite realizar consultas relacionadas con las líneas y estaciones del Metro de Lima y Callao.

El sistema fue desarrollado con la finalidad de organizar la información de las líneas registradas y permitir que el usuario pueda consultar estaciones, buscar una línea o estación específica, visualizar puntos de referencia cercanos, consultar conexiones entre líneas y calcular rutas entre una estación de origen y una estación de destino.

Para el cálculo de rutas, el sistema considera las estaciones consecutivas registradas en cada línea. Cuando el recorrido necesita utilizar más de una línea, también considera los puntos de conexión registrados y determina si es necesario realizar un transbordo.

Además, se implementaron validaciones para controlar búsquedas incorrectas, estaciones inexistentes, líneas no registradas y opciones inválidas del menú.

Actualmente el sistema trabaja con las líneas L1, L2, L3, L4, L5 y L6. Algunas líneas no poseen estaciones registradas debido a que se encuentran proyectadas o todavía no forman parte del conjunto de estaciones utilizado en esta versión del proyecto.

---

# 2. Requerimientos Funcionales

| Código | Requerimiento | Descripción detallada | Criterio de aceptación |
|---|---|---|---|
| RF-01 | Mostrar menú principal | El sistema debe presentar un menú principal que permita acceder a las diferentes funcionalidades mediante opciones numéricas. El menú debe permanecer activo mientras el usuario no seleccione la opción de salida. | Al iniciar el programa deben mostrarse las opciones del 1 al 7 y, después de realizar una consulta, el menú debe aparecer nuevamente. |
| RF-02 | Consultar líneas registradas | El sistema debe permitir visualizar las líneas del Metro de Lima y Callao que se encuentran almacenadas en la aplicación. En esta versión se consideran L1, L2, L3, L4, L5 y L6. | Al seleccionar la opción 1 deben mostrarse las seis líneas registradas junto con su información disponible. |
| RF-03 | Consultar estaciones de una línea | El usuario debe poder ingresar una línea válida para visualizar todas las estaciones que se encuentran registradas en ella. Las estaciones deben mostrarse respetando el orden almacenado del recorrido. | Al seleccionar la opción 2 e ingresar L1 deben mostrarse las 26 estaciones registradas de la Línea 1. |
| RF-04 | Consultar líneas sin estaciones registradas | El sistema debe reconocer las líneas existentes que todavía no poseen estaciones almacenadas y debe informar esta situación sin generar datos que no estén registrados. | Al consultar L3, L5 o L6 debe indicarse que la línea no tiene estaciones registradas en esta versión. |
| RF-05 | Buscar una línea | El sistema debe permitir buscar directamente una línea mediante su código o una entrada equivalente reconocida por el sistema. Al encontrarla debe mostrar su estado y sus estaciones registradas. | Al seleccionar la opción 3 e ingresar L1 debe mostrarse la información correspondiente a la Línea 1. |
| RF-06 | Buscar una estación | El usuario debe poder ingresar el nombre de una estación para localizarla dentro de las líneas registradas. El sistema debe identificar el nombre real de la estación y la línea a la cual pertenece. | Al ingresar Gamarra en la opción 3 debe mostrarse la estación Gamarra y debe indicarse que pertenece a L1. |
| RF-07 | Mostrar lugares cercanos | Cuando una estación tenga referencias almacenadas, el sistema debe mostrar lugares, avenidas, zonas comerciales, hospitales u otros puntos de referencia asociados a dicha estación. | Al consultar Gamarra deben mostrarse las referencias registradas para esa estación. |
| RF-08 | Consultar referencias de diferentes estaciones | La consulta de lugares cercanos debe funcionar para las diferentes estaciones que tengan referencias almacenadas y no únicamente para una estación específica. | Al consultar Aeropuerto deben mostrarse las referencias registradas relacionadas con la zona aeroportuaria del Callao. |
| RF-09 | Consultar conexiones entre líneas | El sistema debe mostrar las conexiones registradas que permiten relacionar dos líneas diferentes dentro de la información almacenada. | Al seleccionar la opción 4 debe mostrarse Carmen de la Legua como conexión entre L2 y L4. |
| RF-10 | Identificar estaciones de intercambio | Cuando una estación forme parte de dos líneas registradas, el sistema debe reconocerla como un punto que permite realizar el cambio entre ambas líneas. | Carmen de la Legua debe ser reconocida como estación perteneciente tanto a L2 como a L4. |
| RF-11 | Ingresar origen y destino | Para calcular una ruta, el sistema debe solicitar una estación de origen y posteriormente una estación de destino. Ambas estaciones deben ser validadas antes de realizar el cálculo. | Si las dos estaciones existen, el sistema debe continuar con el cálculo. Si alguna no existe, debe mostrar un mensaje y detener esa operación. |
| RF-12 | Calcular ruta en una misma línea | El sistema debe encontrar un recorrido entre dos estaciones pertenecientes a una misma línea utilizando las relaciones existentes entre estaciones consecutivas. | Al ingresar Gamarra como origen y Bayóvar como destino debe generarse correctamente el recorrido por L1. |
| RF-13 | Calcular ruta entre líneas diferentes | Cuando exista una conexión registrada, el sistema debe ser capaz de encontrar un recorrido que utilice estaciones pertenecientes a líneas diferentes. | Al calcular Gambetta → Puerto del Callao, el recorrido debe utilizar L4 y posteriormente L2. |
| RF-14 | Mostrar recorrido completo | Después de calcular una ruta, el sistema debe mostrar todas las estaciones que forman parte del recorrido y mantener el orden desde la estación de origen hasta la estación de destino. | La primera estación mostrada debe coincidir con el origen ingresado y la última con el destino. |
| RF-15 | Mostrar total de estaciones y tramos | El sistema debe informar la cantidad total de estaciones incluidas en el recorrido y la cantidad de tramos realizados entre estaciones consecutivas. | En la ruta Gamarra → Bayóvar deben mostrarse 12 estaciones y 11 tramos. |
| RF-16 | Detectar transbordos | El sistema debe analizar el recorrido calculado para determinar si existe un cambio de línea y debe indicar la estación donde se realiza. | En Gambetta → Puerto del Callao debe detectarse el cambio de L4 a L2 en Carmen de la Legua. |
| RF-17 | Informar rutas sin transbordo | Cuando todas las estaciones del recorrido correspondan a una misma línea, el sistema debe informar que no es necesario realizar un transbordo. | En Gamarra → Bayóvar debe mostrarse que no se requieren transbordos. |
| RF-18 | Consultar estado de las líneas | El usuario debe poder visualizar el estado registrado de cada línea para diferenciar las líneas operativas, parciales, en construcción y proyectadas. | Al seleccionar la opción 6 deben mostrarse los estados registrados para L1, L2, L3, L4, L5 y L6. |
| RF-19 | Normalizar búsquedas | La búsqueda debe permitir reconocer estaciones aunque el usuario escriba el nombre utilizando una combinación diferente de mayúsculas, minúsculas o tildes. | Al ingresar "gamarra" en minúsculas debe encontrarse correctamente la estación Gamarra. |
| RF-20 | Validar consultas inexistentes | El sistema debe controlar las líneas o estaciones que no se encuentren registradas y mostrar un mensaje informativo en lugar de producir un resultado incorrecto. | Al buscar L8 debe mostrarse que no se encontró la línea o estación ingresada. |
| RF-21 | Validar opciones del menú | El sistema debe aceptar únicamente las opciones definidas dentro del menú principal y rechazar cualquier otra entrada numérica. | Al ingresar la opción 9 debe mostrarse "Opción no válida. Intente nuevamente." |
| RF-22 | Validar origen y destino iguales | Antes de calcular una ruta, el sistema debe verificar que el origen y el destino no correspondan a la misma estación. | Si ambas estaciones son iguales, debe informarse al usuario y no debe realizarse el cálculo. |
| RF-23 | Informar ruta no disponible | Cuando las estaciones existan pero no exista una conexión posible utilizando la información registrada, el sistema debe comunicar que no se encontró una ruta disponible. | El sistema no debe generar recorridos utilizando conexiones o estaciones que no estén registradas. |
| RF-24 | Finalizar el sistema | El usuario debe poder finalizar voluntariamente la ejecución utilizando la opción 7 del menú principal. | Al seleccionar la opción 7 debe mostrarse el mensaje de despedida y finalizar la ejecución. |

---

# 3. Pruebas Funcionales Realizadas

Las siguientes pruebas fueron realizadas durante el desarrollo de ProyectoMetro para verificar que las principales funcionalidades implementadas respondieran correctamente ante diferentes entradas.

Cada prueba incluye la función evaluada, los datos ingresados, el resultado esperado y el resultado obtenido durante la ejecución.

---

## PF-01 - Visualización de líneas

**Requerimiento relacionado:** RF-02

**Objetivo:**  
Comprobar que el sistema muestre todas las líneas registradas.

**Pasos realizados:**
1. Ejecutar ProyectoMetro.
2. Esperar la aparición del menú principal.
3. Ingresar la opción `1`.

**Resultado esperado:**  
El sistema debe mostrar las líneas L1, L2, L3, L4, L5 y L6.

**Resultado obtenido:**  
Las seis líneas fueron mostradas correctamente.

**Estado:** APROBADO

---

## PF-02 - Consulta de estaciones de L1

**Requerimientos relacionados:** RF-03

**Objetivo:**  
Comprobar que el usuario pueda consultar las estaciones correspondientes a una línea registrada.

**Datos ingresados:**

- Opción: `2`
- Línea: `L1`

**Resultado esperado:**  
El sistema debe mostrar las estaciones de L1 respetando el orden registrado.

**Resultado obtenido:**  
Se mostraron correctamente las 26 estaciones registradas de L1, desde Villa El Salvador hasta Bayóvar.

**Estado:** APROBADO

---

## PF-03 - Búsqueda directa de una línea

**Requerimiento relacionado:** RF-05

**Objetivo:**  
Comprobar que una línea pueda consultarse directamente desde la opción de búsqueda.

**Datos ingresados:**

- Opción: `3`
- Búsqueda: `L1`

**Resultado esperado:**  
El sistema debe reconocer L1 y mostrar su estado junto con sus estaciones.

**Resultado obtenido:**  
L1 fue encontrada correctamente y se mostró como operativa junto con sus estaciones registradas.

**Estado:** APROBADO

---

## PF-04 - Búsqueda de la estación Gamarra

**Requerimientos relacionados:** RF-06, RF-07

**Objetivo:**  
Comprobar la búsqueda de una estación y la visualización de sus referencias cercanas.

**Datos ingresados:**

- Opción: `3`
- Búsqueda: `Gamarra`

**Resultado esperado:**  
El sistema debe reconocer Gamarra como estación de L1 y mostrar las referencias registradas.

**Resultado obtenido:**

- Estación: Gamarra
- Línea: L1
- Emporio Comercial de Gamarra
- Parque Cánepa
- Zona comercial de Gamarra

**Conclusión:**  
La búsqueda identificó correctamente la estación y mostró la información complementaria registrada.

**Estado:** APROBADO

---

## PF-05 - Consulta de referencias en Grau

**Requerimiento relacionado:** RF-07

**Objetivo:**  
Verificar que la información de lugares cercanos pueda mostrarse en otra estación registrada.

**Datos ingresados:**

- Opción: `3`
- Búsqueda: `Grau`

**Resultado esperado:**  
El sistema debe encontrar la estación Grau y mostrar sus referencias registradas.

**Resultado obtenido:**  
La estación fue localizada correctamente y se mostraron sus referencias, incluyendo el Hospital Nacional Dos de Mayo.

**Estado:** APROBADO

---

## PF-06 - Consulta de la estación Aeropuerto

**Requerimientos relacionados:** RF-06, RF-08

**Objetivo:**  
Comprobar que la búsqueda y los lugares cercanos funcionen también con una estación registrada en L4.

**Datos ingresados:**

- Opción: `3`
- Búsqueda: `Aeropuerto`

**Resultado esperado:**  
El sistema debe reconocer la estación como perteneciente a L4 y mostrar las referencias registradas.

**Resultado obtenido:**

- Estación: Aeropuerto
- Línea: L4
- Aeropuerto Internacional Jorge Chávez
- Avenida Elmer Faucett
- Zona aeroportuaria del Callao

**Estado:** APROBADO

---

## PF-07 - Búsqueda utilizando minúsculas

**Requerimiento relacionado:** RF-19

**Objetivo:**  
Comprobar que la búsqueda no dependa de que el usuario escriba exactamente las mismas mayúsculas almacenadas.

**Datos ingresados:**

- Opción: `3`
- Búsqueda: `gamarra`

**Resultado esperado:**  
El sistema debe reconocer la entrada y encontrar Gamarra.

**Resultado obtenido:**  
La estación Gamarra fue localizada correctamente.

**Conclusión:**  
La normalización implementada permite realizar búsquedas sin depender de las mayúsculas.

**Estado:** APROBADO

---

## PF-08 - Búsqueda de una línea inexistente

**Requerimiento relacionado:** RF-20

**Objetivo:**  
Comprobar que el sistema controle consultas de información que no se encuentra registrada.

**Datos ingresados:**

- Opción: `3`
- Búsqueda: `L8`

**Resultado esperado:**  
El sistema no debe mostrar información de una línea inexistente.

**Resultado obtenido:**

`No se encontró la línea o estación ingresada.`

**Conclusión:**  
La validación impidió realizar una consulta utilizando una línea no registrada.

**Estado:** APROBADO

---

## PF-09 - Consulta de conexiones

**Requerimientos relacionados:** RF-09, RF-10

**Objetivo:**  
Comprobar que el sistema muestre correctamente las conexiones registradas entre líneas.

**Datos ingresados:**

- Opción: `4`

**Resultado esperado:**  
Mostrar la conexión registrada entre L2 y L4.

**Resultado obtenido:**

`Carmen de la Legua: L2 - L4`

**Conclusión:**  
El sistema reconoce Carmen de la Legua como punto de conexión entre ambas líneas.

**Estado:** APROBADO

---

## PF-10 - Ruta Gamarra → Bayóvar

**Requerimientos relacionados:** RF-11, RF-12, RF-14, RF-15, RF-17

**Objetivo:**  
Comprobar el cálculo de una ruta entre dos estaciones pertenecientes a la misma línea.

**Datos ingresados:**

- Opción: `5`
- Origen: `Gamarra`
- Destino: `Bayóvar`

**Ruta obtenida:**

Gamarra → Grau → El Ángel → Presbítero Maestro → Caja de Agua → Pirámide del Sol → Los Jardines → Los Postes → San Carlos → San Martín → Santa Rosa → Bayóvar

**Resultados obtenidos:**

- Total de estaciones: `12`
- Tramos recorridos: `11`
- No se requieren transbordos.

**Conclusión:**  
El sistema encontró correctamente el recorrido por L1, mantuvo el orden de las estaciones, calculó los tramos e identificó que no era necesario realizar ningún cambio de línea.

**Estado:** APROBADO

---

## PF-11 - Ruta Gambetta → Puerto del Callao

**Requerimientos relacionados:** RF-11, RF-13, RF-14, RF-15, RF-16

**Objetivo:**  
Comprobar el cálculo de una ruta que necesita utilizar dos líneas diferentes y realizar un transbordo.

**Datos ingresados:**

- Opción: `5`
- Origen: `Gambetta`
- Destino: `Puerto del Callao`

**Ruta obtenida:**

Gambetta → Canta Callao → Bocanegra → Aeropuerto → El Olivar → Quilca → Morales Duárez → Carmen de la Legua → Insurgentes → Juan Pablo II → Buenos Aires → Puerto del Callao

**Resultados obtenidos:**

- Total de estaciones: `12`
- Tramos recorridos: `11`
- Transbordo en Carmen de la Legua: `L4 → L2`
- Total de transbordos: `1`

**Conclusión:**  
El sistema encontró una ruta utilizando dos líneas distintas e identificó correctamente Carmen de la Legua como el punto donde se realiza el cambio de L4 a L2.

**Estado:** APROBADO

---

## PF-12 - Consulta del estado de las líneas

**Requerimiento relacionado:** RF-18

**Objetivo:**  
Verificar que el usuario pueda consultar el estado almacenado de todas las líneas.

**Datos ingresados:**

- Opción: `6`

**Resultado esperado:**  
Mostrar el estado correspondiente a L1, L2, L3, L4, L5 y L6.

**Resultado obtenido:**  
Los estados registrados fueron mostrados correctamente.

**Estado:** APROBADO

---

## PF-13 - Consulta de una línea proyectada

**Requerimiento relacionado:** RF-04

**Objetivo:**  
Comprobar que el sistema no invente estaciones cuando una línea todavía no tenga información registrada.

**Datos ingresados:**

- Opción: `2`
- Línea: `L3`

**Resultado esperado:**  
El sistema debe reconocer que L3 existe, pero indicar que no tiene estaciones registradas en esta versión.

**Resultado obtenido:**  
Se informó correctamente que no existen estaciones registradas.

**Conclusión:**  
La aplicación diferencia una línea existente sin estaciones de una línea completamente inexistente.

**Estado:** APROBADO

---

## PF-14 - Validación de una opción incorrecta

**Requerimiento relacionado:** RF-21

**Objetivo:**  
Comprobar que el menú rechace opciones que no correspondan a ninguna función.

**Datos ingresados:**

- Opción: `9`

**Resultado esperado:**  
El sistema debe rechazar la entrada y permitir al usuario continuar utilizando el programa.

**Resultado obtenido:**

`Opción no válida. Intente nuevamente.`

Posteriormente se volvió a mostrar el menú.

**Estado:** APROBADO

---

## PF-15 - Finalización del programa

**Requerimiento relacionado:** RF-24

**Objetivo:**  
Comprobar que el usuario pueda finalizar correctamente la ejecución.

**Datos ingresados:**

- Opción: `7`

**Resultado esperado:**  
Mostrar un mensaje de despedida y finalizar el ciclo principal del programa.

**Resultado obtenido:**

`Gracias por utilizar el Sistema de Consulta del Metro de Lima y Callao.`

La ejecución finalizó correctamente.

**Estado:** APROBADO

---

# 4. Resumen de resultados

| Estado | Cantidad |
|---|---:|
| Pruebas ejecutadas | 15 |
| Pruebas aprobadas | 15 |
| Pruebas con error | 0 |

Las pruebas realizadas permitieron comprobar las funciones principales desarrolladas en ProyectoMetro. Se verificaron consultas de líneas y estaciones, búsquedas, referencias cercanas, conexiones, rutas dentro de una misma línea, rutas con transbordo y diferentes casos de validación.

Los resultados obtenidos durante estas pruebas fueron satisfactorios para las funcionalidades evaluadas y permitieron comprobar que el sistema responde de acuerdo con los requerimientos implementados en esta versión.
