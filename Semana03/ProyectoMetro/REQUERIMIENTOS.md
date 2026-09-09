# Requerimientos Funcionales

## Sistema de Consulta del Metro de Lima y Callao

Los siguientes requerimientos funcionales corresponden a las funcionalidades desarrolladas y probadas en el proyecto ProyectoMetro realizado en Swift.

| Código | Función | Descripción detallada | Criterio verificable |
|---|---|---|---|
| RF-01 | Mostrar menú principal | El sistema debe presentar un menú principal desde el cual el usuario pueda acceder a todas las funciones disponibles mediante opciones numéricas. | Al iniciar el programa deben mostrarse las opciones del 1 al 7. |
| RF-02 | Mostrar líneas del metro | El sistema debe permitir consultar las líneas L1, L2, L3, L4, L5 y L6 registradas dentro de la aplicación. | Al seleccionar la opción 1 deben mostrarse las seis líneas registradas. |
| RF-03 | Mostrar estado de las líneas | El sistema debe almacenar y mostrar el estado correspondiente a cada línea, diferenciando entre operativa, operación parcial, en construcción o proyectada. | Al seleccionar la opción 6 debe mostrarse el estado registrado de cada línea. |
| RF-04 | Consultar estaciones por línea | El usuario debe poder ingresar una línea y visualizar las estaciones registradas que pertenecen a ella. | Al ingresar L1 deben mostrarse sus estaciones en orden. |
| RF-05 | Mostrar cantidad de estaciones | Al consultar una línea, el sistema debe indicar la cantidad total de estaciones registradas para dicha línea. | Al finalizar el listado debe mostrarse el total de estaciones. |
| RF-06 | Controlar líneas sin estaciones registradas | Si una línea existe pero no posee estaciones almacenadas en esta versión, el sistema debe comunicarlo al usuario. | Al consultar L3, L5 o L6 debe indicarse que no existen estaciones registradas. |
| RF-07 | Buscar una línea | El sistema debe permitir consultar directamente una línea utilizando su código o una forma equivalente reconocida por la aplicación. | Al buscar L1 debe mostrarse su estado y sus estaciones. |
| RF-08 | Buscar una estación | El usuario debe poder buscar una estación registrada escribiendo su nombre. | Al ingresar Gamarra debe localizarse correctamente la estación. |
| RF-09 | Identificar línea de una estación | Cuando se encuentre una estación, el sistema debe indicar la línea o líneas a las que pertenece. | Al consultar Gamarra debe indicarse que pertenece a L1. |
| RF-10 | Mostrar lugares cercanos | El sistema debe mostrar los lugares, zonas o puntos de referencia almacenados para una estación consultada. | Al buscar Gamarra deben aparecer las referencias cercanas registradas. |
| RF-11 | Consultar referencias de diferentes estaciones | La consulta de lugares cercanos debe funcionar para las diferentes estaciones que tengan referencias almacenadas. | Al buscar Aeropuerto deben mostrarse las referencias registradas de su zona. |
| RF-12 | Mostrar conexiones | El sistema debe mostrar las conexiones registradas entre las diferentes líneas. | La opción 4 debe mostrar Carmen de la Legua como conexión entre L2 y L4. |
| RF-13 | Identificar estación de intercambio | El sistema debe reconocer una estación que pertenezca a más de una línea como punto de intercambio. | Carmen de la Legua debe ser reconocida como conexión entre L2 y L4. |
| RF-14 | Ingresar estación de origen | Para calcular una ruta, el sistema debe solicitar y validar una estación de origen. | Si el origen existe, debe aceptarse y posteriormente solicitar el destino. |
| RF-15 | Ingresar estación de destino | El sistema debe solicitar y validar una estación de destino antes de realizar el cálculo del recorrido. | Si el destino existe, el sistema debe continuar con el cálculo. |
| RF-16 | Calcular ruta entre estaciones | El sistema debe encontrar un recorrido entre origen y destino utilizando las relaciones existentes entre estaciones consecutivas. | Gamarra → Bayóvar debe producir una ruta válida. |
| RF-17 | Calcular ruta entre líneas diferentes | Cuando exista una conexión registrada, el sistema debe poder construir una ruta utilizando estaciones de diferentes líneas. | Gambetta → Puerto del Callao debe utilizar L4 y L2. |
| RF-18 | Mostrar recorrido ordenado | La ruta calculada debe mostrar las estaciones en el orden en que deben recorrerse desde el origen hasta el destino. | La primera estación debe ser el origen y la última debe ser el destino. |
| RF-19 | Mostrar total de estaciones de la ruta | El sistema debe indicar cuántas estaciones forman parte del recorrido calculado, incluyendo origen y destino. | Después del cálculo debe mostrarse el total de estaciones. |
| RF-20 | Mostrar tramos recorridos | El sistema debe calcular cuántos desplazamientos existen entre las estaciones consecutivas de la ruta. | Los tramos deben corresponder al total de estaciones menos uno. |
| RF-21 | Detectar transbordos | El sistema debe detectar cuándo una ruta cambia de una línea a otra e indicar dónde ocurre. | Gambetta → Puerto del Callao debe indicar el transbordo en Carmen de la Legua. |
| RF-22 | Contar transbordos | El sistema debe informar la cantidad de cambios de línea realizados durante una ruta. | Una ruta con cambio de línea debe mostrar el total de transbordos. |
| RF-23 | Informar rutas sin transbordo | Cuando todo el recorrido pertenezca a una misma línea, el sistema debe informar que no se requiere cambiar de línea. | Gamarra → Bayóvar debe indicar que no se requieren transbordos. |
| RF-24 | Validar estación inexistente | El sistema debe detectar cuando una estación ingresada no se encuentre registrada y evitar continuar con datos inválidos. | Una estación inexistente debe producir un mensaje informativo. |
| RF-25 | Validar línea inexistente | El sistema debe detectar códigos de línea que no correspondan a las líneas registradas. | Al ingresar L8 debe indicarse que no se encontró la línea o estación. |
| RF-26 | Normalizar búsquedas | El sistema debe permitir buscar estaciones sin depender de diferencias entre mayúsculas, minúsculas o tildes. | La búsqueda "gamarra" debe encontrar la estación Gamarra. |
| RF-27 | Validar opciones del menú | El sistema debe comprobar que la opción seleccionada se encuentre entre las alternativas disponibles. | Al ingresar 9 debe mostrarse "Opción no válida. Intente nuevamente." |
| RF-28 | Validar origen y destino iguales | El sistema debe detectar cuando origen y destino sean la misma estación y evitar realizar un cálculo innecesario. | Si ambas estaciones son iguales debe mostrarse un mensaje informativo. |
| RF-29 | Regresar al menú principal | Después de realizar una consulta, búsqueda o cálculo, el sistema debe permitir al usuario continuar utilizando el programa. | Al finalizar una operación debe volver a mostrarse el menú principal. |
| RF-30 | Finalizar aplicación | El usuario debe poder finalizar voluntariamente la ejecución mediante la opción 7. | Al seleccionar 7 debe mostrarse el mensaje de despedida y finalizar el programa. |
