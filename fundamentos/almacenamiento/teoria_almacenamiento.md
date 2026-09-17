# Teoría General de Almacenamiento

* **Aprovisionamiento duro** (*thick provisioning*) reserva todo el recurso físico del disco.
* **Aprovisionamiento blando** (*thin provisioning*) asigna el espacio bajo demanda, a medida que se va utilizando el disco.

| Característica | Aprovisionamiento Duro (*Thick*) | Aprovisionamiento Blando (*Thin*) |
| --- | --- | --- |
| **Reserva de espacio** | **100% por adelantado.** Pides 1 TB y se bloquea 1 TB entero en el disco al instante. | **A medida que usas.** Pides 1 TB, pero si solo guardas 50 GB, solo ocupa 50 GB reales. |
| **Ventaja** | **Rendimiento constante.** No hay sorpresas de espacio; el recurso está garantizado. | **Ahorro de costes y espacio.** Aprovecha al máximo la capacidad real del sistema. |
| **Riesgo / Desventaja** | **Desperdicio.** Pagas/bloqueas espacio que a lo mejor nunca utilizas. | **Riesgo de colapso.** Si todos los usuarios llenan su espacio a la vez, el disco real se agota. |
