## `shellshock.py`

Este script explota la vulnerabilidad Shellshock en un servidor vulnerable. La vulnerabilidad Shellshock afecta a versiones antiguas de Bash, permitiendo a un atacante ejecutar comandos arbitrarios en el servidor a través de variables de entorno maliciosas. El script aprovecha esta vulnerabilidad para obtener una shell inversa sin necesidad de escuchar manualmente en un puerto. En su lugar, el script establece la conexión directamente desde la consola que ejecuta el ataque.

### Funcionamiento del Script

1. **Explotación de la Vulnerabilidad Shellshock:**
   - El script realiza una petición HTTP GET a un servidor vulnerable con un encabezado `User-Agent` especialmente diseñado que explota la vulnerabilidad Shellshock.
   - El encabezado malicioso ejecuta un comando en Bash en el servidor objetivo, abriendo una shell inversa que conecta con el atacante.

2. **Conexión Inversa:**
   - El servidor vulnerable envía una conexión inversa a la dirección IP del atacante en el puerto configurado (`lport`), proporcionando acceso remoto al sistema comprometido.

3. **Interacción con la Shell:**
   - Después de ejecutar el ataque, el script espera la conexión inversa y, una vez establecida, proporciona acceso a la shell interactiva del sistema comprometido. Esta shell permite al atacante ejecutar comandos directamente en la máquina vulnerable.

4. **Escucha y Tiempo de Espera:**
   - El script pone en escucha el puerto especificado (`lport`), esperando una conexión entrante durante un tiempo limitado (20 segundos). Si no se recibe una conexión, el script termina mostrando un mensaje de error.

### Observación

Este script está ligado a un contexto específico pero, si se entiende, se pueden extrapolar a otros escenarios.
