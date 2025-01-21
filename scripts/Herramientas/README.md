## `decompresorRecursivo.sh`

### Descripción

Este script permite descomprimir de forma recursiva archivos comprimidos en formato `.gz` hasta alcanzar el último archivo contenido en la cadena de compresión.

### Funcionamiento

1. Define el primer archivo comprimido (`data.gz`) como punto de partida. **Modificar esta variable para extrapolarlo a otros escenarios**.
2. Extrae el archivo y determina el siguiente archivo a descomprimir dentro de su contenido.
3. Itera este proceso hasta que no quedan más archivos comprimidos en la cadena.

---

## `hostScanner.sh`

### Descripción

Este script realiza un escaneo simple para identificar hosts activos en una red local enviando paquetes ICMP (ping). Es útil para una detección rápida de dispositivos conectados en una red interna.

### Funcionamiento

1. Itera sobre todas las direcciones IP posibles dentro del rango `192.168.1.1` a `192.168.1.254`.
2. Para cada IP, envía un paquete de ping con un tiempo de espera de 1 segundo.
3. Informa qué hosts están activos en base a las respuestas recibidas.

---

## `hostScanner2.sh`

### Descripción

Este script amplía la funcionalidad del escaneo de hosts, verificando también qué puertos comunes están abiertos en cada host activo.

### Funcionamiento

1. Itera sobre las direcciones IP dentro del rango `192.168.1.1` a `192.168.1.254`.
2. Para cada IP, verifica la apertura de puertos comunes (21, 22, 23, 25, 80, 139, 443, 445, 8080).
3. Reporta las direcciones IP y los puertos abiertos.

---

## `portScanner.sh`

### Descripción

Este script escanea todos los puertos (1-65535) de la máquina local para identificar cuáles están abiertos.

### Funcionamiento

1. Itera sobre todos los puertos de la máquina local (`127.0.0.1`).
2. Verifica la conectividad usando `/dev/tcp/`.
3. Reporta los puertos abiertos.

---

## `portScanner2.sh`

### Descripción

Este script realiza un escaneo de todos los puertos de una dirección IP específica que se pasa como argumento al script.

### Funcionamiento

1. Recibe la dirección IP como argumento.
2. Itera sobre todos los puertos posibles (1-65535) en la dirección IP proporcionada.
3. Abre conexiones TCP para verificar si los puertos están abiertos y los reporta.

---

## `portScannerLua.nse`

### Descripción

Este script, implementado en Lua, está diseñado para ejecutarse con Nmap. Identifica y reporta puertos abiertos que utilizan el protocolo TCP.

### Funcionamiento

1. Define una regla que selecciona únicamente puertos TCP que están abiertos.
2. Realiza una acción en cada puerto que cumple con la regla, devolviendo un mensaje indicando que el puerto está abierto.

---

## `portScannerSquidProxy.py`

### Descripción

Este script realiza un escaneo de puertos comunes a través de un servidor proxy Squid, identificando cuáles están abiertos en el servidor de destino. Es útil en escenarios donde se necesita realizar escaneos desde detrás de un proxy, como auditorías en entornos corporativos con restricciones de red.

### Funcionamiento

1. Define un proxy Squid y una URL principal como punto de partida.
2. Itera sobre una lista de puertos TCP comunes.
3. Realiza solicitudes HTTP a través del proxy para verificar si el puerto está abierto (status distinto de 503).

---

## `testRoutes.sh`

### Descripción

Este script prueba una lista de URLs proporcionada por el usuario, verificando si están activas basándose en los códigos de estado HTTP 200 y 301. Este script es ideal para verificar la disponibilidad de rutas o endpoints en pruebas de aplicaciones web o en el mantenimiento de sistemas.

### Funcionamiento

1. Recibe como entrada un archivo que contiene una lista de URLs.
2. Valida que el archivo exista y sea legible.
3. Itera sobre cada URL en el archivo, enviando solicitudes HTTP.
4. Informa cuáles URLs están activas según los códigos de estado.

---
