## `xmlrpc_bruteforce.sh`

### Descripción

Este script utiliza fuerza bruta para intentar iniciar sesión en WordPress explotando el endpoint `xmlrpc.php`. Genera solicitudes XML dinámicas con contraseñas extraídas de un diccionario, probándolas contra el usuario especificado.

### Funcionamiento

1. **Generación de solicitudes XML**:
   - La función `createXML` genera un archivo XML que contiene una solicitud al método `wp.getUsersBlogs`.
   - Inserta el nombre de usuario existente y una contraseña extraída del diccionario en la plantilla XML.
   - Envía la solicitud al servidor mediante `curl` y analiza la respuesta.
   - Si la respuesta no contiene el mensaje `"Incorrect username or password."`, se identifica la contraseña correcta y el script termina.

2. **Fuerza bruta**:
   - Lee contraseñas línea por línea del archivo `/usr/share/wordlists/rockyou.txt`.
   - Pasa cada contraseña a la función `createXML` para probarla.

### Uso

```bash
./xmlrpc_bruteforce.sh
```
