## `ldapInjection.py`

Este script es un ejemplo de un ataque de inyección LDAP mediante fuerza bruta. Su propósito es obtener información sensible de una aplicación vulnerable que no valida correctamente las entradas del usuario, permitiendo la inyección de consultas LDAP maliciosas. El script realiza un ataque de fuerza bruta para descubrir los nombres de usuario válidos y luego obtiene la descripción asociada a cada uno de ellos.

---

### Funcionamiento del Script

1. **Obtención de Usuarios Válidos:**
   - El script comienza con la función `getInitialUsers`, que prueba cada carácter del alfabeto y los dígitos en el campo `user_id` para identificar los caracteres iniciales de los usuarios válidos. Esto se hace enviando peticiones POST y observando las respuestas del servidor.
   - Si la respuesta es un código de estado 301, se considera que el carácter es válido.

2. **Obtención de Usuarios Completos:**
   - Una vez obtenidos los caracteres iniciales de los usuarios, el script usa la función `getUsers` para continuar con el proceso de fuerza bruta y completar los nombres de usuario, asumiendo que ningún usuario tiene más de 15 caracteres.
   - A medida que se prueba cada carácter para cada usuario, si el código de estado de la respuesta es 301, se añade el carácter al nombre de usuario.

3. **Obtención de Descripciones de Usuarios:**
   - Para cada usuario válido encontrado, el script usa la función `getDescription` para realizar un ataque de fuerza bruta similar y obtener la descripción del usuario.
   - El script construye una consulta LDAP inyectada en el campo `user_id` para obtener la descripción completa del usuario.

### Observaciones

Estos scripts están ligados a un contexto específico pero, si se entienden, se pueden extrapolar a otros escenarios.

La protección contra este tipo de ataques debe incluir validación adecuada de las entradas del usuario y medidas de seguridad como la parametrización de consultas LDAP.
