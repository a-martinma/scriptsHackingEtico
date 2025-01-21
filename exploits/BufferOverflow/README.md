## `BufOvMaquinaIMF.py`

### Descripción

Este script ha sido diseñado específicamente para explotar una vulnerabilidad de desbordamiento de búfer en la máquina **IMF 1** disponible en la plataforma VulnHub: [IMF 1 - VulnHub](https://www.vulnhub.com/entry/imf-1,162/).

El objetivo principal del script es ejecutar código malicioso controlando el flujo de ejecución del programa vulnerable. Esto se logra mediante la manipulación de la pila para redirigir la ejecución hacia una sección específica del código, como una shell inversa o cualquier payload deseado.


### Detalles del Exploit

1. **Identificación de la vulnerabilidad:** El desbordamiento de búfer ocurre al enviar datos que exceden el límite de un búfer en la pila.
2. **Control del EIP:** El script calcula el offset necesario para sobrescribir el registro de instrucción (EIP).
3. **Payload malicioso:** Se inserta un payload que puede ser una shell inversa o un código arbitrario diseñado para el escenario.
4. **Ejecución del exploit:** Se envía el payload a la aplicación vulnerable para tomar control del flujo de ejecución.

Este script está diseñado para un caso específico en la máquina IMF 1, pero puede ser adaptado para otros escenarios de desbordamiento de búfer.
