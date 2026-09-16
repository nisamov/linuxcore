# Acerca de la Memoria RAM
## La RAM vista como matriz
La RAM está organizada internamente como una matriz de fila y columnas dentro de cada banco de memoria. Para leer o escribir datos, la memoria no puede acceder directamente a una dirección como tal sino que deber seguir los siguientes pasos:
1. Abrir (activar) una fila y cargarla en un registro interno
2. Acceder a una columna dentro de esa fila (latencia CAS)
3. Cerrar (pre-cargar) la fila cuando se quiera cambiar a otra fila.

## Latencias
En la RAM, la latencia describe cuántos ciclos de reloj se requieren para acceder a datos
dentro de un banco de memoria. Los valores típicos se expresan como una serie `CL-tRCD-RP-tRAS`
- Latencia CAS o CL (Column Access Strobe)
    - Se refiere al número de ciclos desde que se solicita una columna dentro de una fila ya abierta hasta que los datos están disponibles.
    - Es la latencia más citada porque afeceta directamente al tiempo de respuesta.
- Latencia RAS to CAS (tRCD)
    - Latencia entre seleccionar una fila (activar dicha fila) y luego seleccionar una columna en esa fila. Indica el tiempo necesario para pasar de activar fila a lectura/escritura real (Row Access Strobe to Column Access Strobe)
- Precharge Time (tRP)
    - Tiempo necesario para cerrar una fila actualmente abierta antes de poder abrir otra en el
mismo banco. Representa el costo de resetear.
- Active to Precharge Time (tRAS)
    - Tiempo mínimo que una fila debe permanecer abierta antes de poder cerrarla con el Precharge. Garantizas que la operación sobre la fila se complete correctamente.

| Latencia | Acción | Qué controla |
|--------------|--------------|--------------|
| CL/CAS | Leer columna | Tiempo hasta recibir datos |
| RAS to CAS (tRCD) | Seleccionar fila y columna | Preparar acceso a columna tras activar la fila. |
| tRP (Precharge) | Cerrar fila | Cambiar de dentro del mismo banco |
| tRAS (Active) | Mantener fila abierta | Duración mínima antes de cerrar |

# Tipos de Memorias RAM
## DRAM (Dynamic RAM)
La RAM dinámica almacena cada bit como una carga en un capacitor.
Ventajas:
- Alta densidad
- Barata
Inconvenientes:
- Los capacitores se descargan con el tiempo y necesitan ser refrescados.
- Por lo tanto es más lenta.

## SRAM (Static RAM)
La RAM estática almacena bits usando flip-flops (transistores).
Ventajas:
- No necesita refrescar
- Rápida y estable
Inconvenientes:
- Baja densidad
- Cara

## SDRAM (Synchronous DRAM)
Esta DRAM está sincronizada con el reloj del sistema (antes era asíncrona). Fue la base del DDR. Ejemplos: PC100, PC133.

## DDR SDRAM (Double Data Rate SDRAM)
Evolución de la SDRAM. Es capaz de enviar datos en el flanco de subida y bajada del reloj,
por eso es Double Data Rate.
- DDR1: voltaje típico de 2.5V, módulo de 184 pines, 200-400 MT/s
- DDR2: voltaje típico de 1.8V, módulo de 240 pines, 400-800 MT/s
- DDR3: voltaje típico de 1.5V, módulo de 240 pines, 800-2133 MT/s
- DDR4: voltaje típico de 1.2V, módulo de 288 pines, 2133-3200 MT/s
- DDR5: voltaje típico de 1.1V, módulo de 288 pines, 4800 MT/s

Notas acerca de DDR SDRAM
1. No son compatibles físicamente entre sí. Las muescas de los módulos no coinciden.
2. Cada generación aumento el ancho de banda interno, la eficiencia, el paralelismo y la frecuencia mientras se reduce el voltaje.
3. Las unidades MT/s indican MegaTransferencias por segunda. Una
megatransferencia implica un millón de transferencias (10^6).

## Dual, Triple, Quad Channel
Estas tecnologías se refieren a cómo el controlador de memoria accede a varios módulos
de RAM en paralelo para aumentar el ancho de banda:
- Dual Channel: se usan 2 módulos de RAM del mismo tamaño y velocidad. Cada módulo se comunica por su propio canal de 64 bits, funcionando en paralelo, por lo que se casi-duplica el ancho de banda.
- Triple Channel: lo mismo que dual pero con tres canales.
- Quad Channel: lo mismo pero con 4 módulos y 4 canales
Es importante colocar los módulos en los slots adecuados según indique el manual. De lo contrario el modo funciona incorrectamente, se desactiva o funciona directamente por single channel.

# Módulos físicos
- Single Inline Memory Module (SIMM): Módulo antiguo de memoria paralela. Los pines están en una sola línea.
- Dual Inline Memory Module (DIMM): Módulo moderno con contactos eléctricos diferentes en cada lado, duplicando la conexión y ofreciendo un mayor ancho de banda.
- DIMM DDR: DIMM especial que se usa para el DDR capaz de transmitir y recibir datos en el flanco de subido y en el de bajada del reloj.
- Rambus Inline Memory Module (RIMM): Módulo para una memoria RDRAM de Rambus. Data de finales de los 90 y principio de los 2000.
- SO-DIMM (Small Outline DIMM): Versión compacta de DIMM para los portátiles. Ocupa menos espacio, consume menos energía.
- Micro-DIMM: DIMM aún más pequeña que se usa un ultranotebooks, netbooks o dispositivos muy copmpactos.