# Prompts utilizados — Laboratorio 04

## Herramienta de IA utilizada

ChatGPT

## Caso 2B — Biblioteca

### Prompt 1:

Soy estudiante de Swift y estoy trabajando el Laboratorio 04 de Programación Orientada a Objetos.

Necesito desarrollar una biblioteca usando:

- enum EstadoLibro
- struct Libro
- class Biblioteca
- arrays
- bucles
- funciones
- switch

La clase Biblioteca debe tener los métodos agregar(libro:), prestar(titulo:), devolver(titulo:) e inventario().

Para buscar los libros debo recorrer el arreglo usando:

for i in 0..<libros.count

No debo usar:

- optionals
- guard let
- firstIndex(where:)
- didSet
- propiedades calculadas
- genéricos

También necesito que cada línea tenga un comentario sencillo explicando qué hace.

La salida debe mostrar:

Préstamo aprobado: La ciudad y los perros
Error: La ciudad y los perros ya está prestado
Devolución registrada: La ciudad y los perros
Préstamo aprobado: El Quijote
Error: no existe El Principito
===== INVENTARIO =====
Cien años de soledad (Gabriel García Márquez) - disponible
La ciudad y los perros (Mario Vargas Llosa) - disponible
El Quijote (Miguel de Cervantes) - prestado

### Respuesta de la IA:

La IA generó el enum EstadoLibro, el struct Libro y la clase Biblioteca con los métodos solicitados.

También utilizó un arreglo para almacenar los libros y recorrió las posiciones con un bucle por índice para realizar los préstamos y devoluciones.

El código fue comentado línea por línea para que se pueda entender qué función cumple cada parte.

### ¿Funcionó a la primera?

Sí.

La salida obtenida coincidió con la salida esperada del laboratorio.

### ¿Usó algo que no hemos visto en clase?

No.

La solución se mantuvo usando los temas indicados en clase: enum, struct, class, arrays, bucles, funciones y switch.

No se utilizaron optionals, guard let, firstIndex(where:), didSet, propiedades calculadas ni genéricos.

## Mi versión (Parte A) vs. la versión de la IA (Parte B)

### ¿Qué hizo distinto la IA respecto a mi solución?

La lógica principal fue parecida porque ambas versiones tenían que cumplir el mismo enunciado. La diferencia principal fue que la versión generada con IA tenía más comentarios explicando cada línea y estaba un poco más ordenada visualmente.

### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?

No tuve problemas con alguna línea en particular porque la solución utilizó estructuras y funciones que ya se habían trabajado anteriormente en clase.

### ¿Qué me pareció mejor de MI versión?

Mi versión fue más directa y tenía menos comentarios, por lo que el código quedó más corto y sencillo de revisar.

### ¿Qué me pareció mejor de la versión de la IA?

Me ayudó a organizar mejor el código y a explicar con comentarios qué estaba haciendo cada parte. Eso hizo más fácil revisar la lógica de los préstamos, devoluciones y el inventario.
