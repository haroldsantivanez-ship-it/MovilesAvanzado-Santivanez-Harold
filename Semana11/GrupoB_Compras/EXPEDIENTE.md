# Expediente · Laboratorio 11 · Grupo B · Compras (SwiftUI + SwiftData)

## 1. Integrantes y caso
- Integrante(s): Harold Eduardo Santivañez Garcia · (compañero/a)
- Grupo: **B** · App: **Compras** · Curso: Programación en Móviles Avanzado (5 C24) · Docente: Juan León

## 2. Modelo de datos

| Clase @Model | Propiedades | Relaciones |
|---|---|---|
| Usuario | nombre, usuario, clave, rol (String: Comprador / Supervisor) | compras: [Compra] · `.deny`, inverse `\Compra.comprador` |
| Proveedor | nombre, ruc (String) | compras: [Compra] · `.deny`, inverse `\Compra.proveedor` |
| Producto | nombre, categoria (String), stock (Int), costoPromedio (Double) | compras: [Compra] · `.deny`, inverse `\Compra.producto` |
| Compra | fecha (Date), cantidad (Int), costoUnitario, igv, total (Double), alCredito (Bool), vence (Date), estado (String), pagada (Bool), motivoRechazo (String?) | comprador: Usuario? · proveedor: Proveedor? · producto: Producto? |

```
Usuario  1 ──< Compra >── 1 Proveedor
                 │
                 └── 1 Producto
```
Delete rule **.deny** en los tres lados "uno": no se borra un usuario, proveedor o producto con compras.
Además la vista revisa `compras.isEmpty` antes de borrar y muestra una alerta.

## 3. Roles y permisos

| Qué puede hacer | Comprador | Supervisor |
|---|---|---|
| Pestañas | Productos, Proveedores, Compra, Mis compras | Resumen, Aprobar, Por pagar, Productos, Proveedores |
| Productos y proveedores | Consultar y buscar | Crear, editar y borrar (si no tienen compras) |
| Compras | Registrar y ver solo las suyas | Aprobar / rechazar, ver todas y pagar |
| Cuenta | Menú del avatar con Cerrar sesión | Menú del avatar con Cerrar sesión |

## 4. Reglas de negocio (ejemplos resueltos a mano)

**IGV (crédito fiscal):** 18 % del subtotal. Total = subtotal + IGV.
- 10 × 120.00 = 1,200.00 → IGV 216.00 → total **1,416.00**
- 50 × 120.00 = 6,000.00 → IGV 1,080.00 → total **7,080.00**

**Aprobación:** total < S/ 5,000 → Aprobada al instante. Total ≥ S/ 5,000 → Pendiente (no cambia stock, costo ni por pagar).
- 1,416.00 → Aprobada · 7,080.00 → Pendiente

**Costo promedio ponderado (al aprobar):** (stock × costoProm + cantidad × costoUnit) / (stock + cantidad)
- (40 × 110 + 10 × 120) / 50 = 5,600 / 50 = **112.00**
- (40 × 110 + 50 × 120) / 90 = 10,400 / 90 = **115.56**

**Contado / crédito:** contado → `pagada = true`. Crédito → `pagada = false`, `vence = fecha + 30 días`.
Por pagar con `vence < hoy` → **VENCIDA**.

**Pagar (supervisor):** `pagada = true`, sale de Pendientes y baja el total por pagar.

## 5. Pantallas

| Pant. | Propósito | Lee / escribe |
|---|---|---|
| B1 Login | Ingresar | Lee Usuario (#Predicate usuario + clave) |
| B2 Registro | Crear cuenta y entrar | fetchCount de Usuario; inserta Usuario |
| B3 Productos | Inventario y valor | @Query Producto; supervisor crea/edita/borra |
| B4 Proveedores | Deuda y total comprado | @Query Proveedor; calcula desde proveedor.compras |
| B5 Nueva compra | Registrar compra | Inserta Compra; si se aprueba actualiza Producto |
| B6 Mis compras | Historial del comprador | usuario.compras (relación inversa) |
| B7 Aprobar | Aprobar / rechazar | @Query estado == Pendiente; actualiza Compra y Producto |
| B8 Por pagar | Cuentas por pagar | @Query con #Predicate según filtro; marca pagada |
| B9 Resumen | Indicadores del supervisor | Lee Producto, Proveedor y Compra |

## 6. Casos de prueba

| N.º | Caso | Resultado esperado |
|---|---|---|
| 1 | Registrar "mtorres" (Comprador) y repetir "MTORRES" | El primero entra; el segundo: "Ese usuario ya existe" |
| 2 | Login con clave incorrecta | "Usuario o clave incorrectos"; no entra |
| 3 | Stock 40, costo 110.00; compra 10 × 120.00 al crédito | 1,200.00 · 216.00 · 1,416.00 · Aprobada · stock 50 · costo 112.00 · vence +30 días |
| 4 | La misma compra al contado | Pagada; no aparece en Pendientes de pago |
| 5 | Compra 50 × 120.00 | 7,080.00 · Pendiente · stock sigue 40 · no suma a por pagar |
| 6 | Supervisor aprueba el caso 5 | Stock 90 · costo 115.56 · aparece en Por pagar |
| 7 | Rechazar sin motivo y luego con motivo | Sin motivo el botón está deshabilitado; con motivo queda Rechazada y el comprador lo ve |
| 8 | Crédito vencido y luego Pagar | Aparece en Vencidas con VENCIDA; al pagar pasa a Pagadas y baja el total |
| 9 | Comprador abre Mis compras e intenta pagar | Solo ve sus compras; no tiene pestaña Por pagar ni opción Pagar |
| 10 *(propio)* | Supervisor intenta borrar un proveedor con compras | Alerta "tiene compras registradas"; no se borra |
| 11 *(propio)* | Registro con clave de 4 caracteres | "La clave debe tener mínimo 6 caracteres" |

> Para los casos 3–6 el producto debe empezar con stock 40 y costo 110: ejecutar 3/4 y 5/6 con la base recién cargada (o editar el producto entre casos).

## 7. Plan de commits
1. Modelo de datos (4 clases y relaciones)
2. Sesión, login y registro
3. TabView por rol y avatar con cerrar sesión
4. Productos (B3) · 5. Proveedores (B4)
6. Nueva compra con IGV y aprobación (B5) · 7. Mis compras (B6)
8. Aprobar / rechazar (B7) · 9. Por pagar con #Predicate (B8)
10. Resumen (B9) · 11. Ícono y Display Name · 12. PROMPTS.md y capturas

## 8. Plan de uso de IA
- A mano (rama `manual`): modelo de datos, login/registro, cálculo de IGV y costo promedio.
- Con IA (rama `ia-asistida`): diseño visual de tarjetas, gráfico de barras, filtros con #Predicate.
- Verificación: ejecutar los 11 casos de prueba y comparar con los cálculos de la sección 4.

## 9. Visto bueno
Fecha: ____ / ____ / 2026 · Confirmación del docente: ______________________
