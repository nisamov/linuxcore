# Teoría sobre RAID

RAID por Hardware: Requiere una tarjeta dedicada (PCIe o integrada en placas de servidor). No consume recursos de la CPU, ofrece el máximo rendimiento y suele incluir memoria caché con batería para evitar pérdida de datos si hay un corte eléctrico.

RAID por Software: Lo gestiona el propio sistema operativo (mdadm en Linux, Storage Spaces en Windows). Es totalmente gratuito y flexible ante cambios de placa base, pero consume ciclos de procesador.

RAID Híbrido (FakeRAID): Es la opción integrada en las placas base de consumo. Aunque tiene una interfaz en la BIOS, depende de los controladores y del procesador del ordenador para realizar el trabajo.  

| Tipo de RAID | Discos mínimos | Capacidad útil | Tolerancia a fallos | Uso recomendado |
| --- | --- | --- | --- | --- |
| **RAID 0** | 2 | 100% | 0 discos | Máxima velocidad; si falla un disco se pierden todos los datos. |
| **RAID 1** | 2 | 50% | 1 disco | Duplica los datos. Ideal para el sistema operativo o servicios críticos. |
| **RAID 5** | 3 | (N - 1) discos | 1 disco | Equilibrio entre espacio y seguridad mediante paridad distribuida. |
| **RAID 6** | 4 | (N - 2) discos | 2 discos | Doble paridad; tolera la caída simultánea de dos discos. |
| **RAID 10** | 4 | 50% | 1 disco por par | Combina velocidad (RAID 0) y redundancia (RAID 1) para entornos críticos. |
