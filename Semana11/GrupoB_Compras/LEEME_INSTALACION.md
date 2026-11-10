# Cómo armar el proyecto en Xcode (Grupo B · Compras)

## 1. Crear el proyecto
1. Xcode ▸ File ▸ New ▸ Project ▸ iOS ▸ App
2. Product Name: `apple_lab11_03_SwiftUI_Compras` · Interface: **SwiftUI** · Language: **Swift** · Storage: **SwiftData**
3. Guárdalo dentro de tu repo, en `Semana11/`.
4. Deployment target: iOS **17.0** o superior (target ▸ General ▸ Minimum Deployments).

## 2. Borrar lo de la plantilla
Borra (Move to Trash): `ContentView.swift`, `Item.swift` y el archivo `..._ComprasApp.swift` que creó Xcode
(nuestro `ComprasApp.swift` ya tiene el `@main`; si dejas los dos, dará error "multiple @main").

## 3. Agregar los archivos
Arrastra la carpeta `Compras/` (con Modelos, Sesion, Utilidades, Vistas y ComprasApp.swift) al navegador de Xcode.
Marca **Copy items if needed** y **Create groups**, con el target seleccionado.

## 4. Ícono y nombre
- Assets.xcassets ▸ AppIcon ▸ arrastra `Icono/AppIcon-Compras-1024.png` al recuadro de 1024.
- Target ▸ General ▸ Display Name = `Compras`.
- Ejecuta, detén y pulsa Shift + Cmd + H para ver el ícono. Toma captura.

## 5. Probar
- En el login pulsa **Cargar datos de prueba** (crea `supervisor` / `comprador`, clave `123456`, 3 proveedores, 4 productos y una compra vencida para el caso 8).
- Sigue los casos del EXPEDIENTE.md.
- Si sale error de migración al cambiar el modelo: borra la app del simulador y ejecuta de nuevo.

## 6. Archivos y qué pantalla son
| Archivo | Pantalla |
|---|---|
| Vistas/Auth/LoginView.swift | B1 |
| Vistas/Auth/RegistroView.swift | B2 |
| Vistas/Comun/ProductosView.swift | B3 (+ formulario) |
| Vistas/Comun/ProveedoresView.swift | B4 (+ formulario) |
| Vistas/Comprador/NuevaCompraView.swift | B5 |
| Vistas/Comprador/MisComprasView.swift | B6 (+ "Ver todas" del supervisor) |
| Vistas/Supervisor/AprobarView.swift | B7 (+ hoja de rechazo) |
| Vistas/Supervisor/PorPagarView.swift | B8 |
| Vistas/Supervisor/ResumenView.swift | B9 |
| Vistas/Comun/AvatarMenu.swift | Cuenta (menú del avatar) |
| Modelos/Modelos.swift | 4 clases @Model |
| Modelos/ReglasCompra.swift | IGV, aprobación, costo promedio, pagar |
| Sesion/Sesion.swift | Sesión @Observable, login y registro |
| ComprasApp.swift | @main, contenedor, RootView y TabView por rol |
