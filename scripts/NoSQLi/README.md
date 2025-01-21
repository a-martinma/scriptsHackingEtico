## `nosqli.py`

Este script lleva a cabo un ataque de **fuerza bruta** sobre la contraseña de un usuario específico en una aplicación web que hace uso de una base de datos **NoSQL**. El script explota una vulnerabilidad de inyección en el campo de la contraseña, donde se utiliza una expresión regular `$regex` para probar combinaciones posibles.

### Descripción

- **Propósito**: Realizar un ataque de fuerza bruta sobre una contraseña almacenada en una base de datos **NoSQL**.
- **Proceso**: 
  1. El script realiza una solicitud `POST` a la URL de login `http://localhost:4000/user/login` con un payload que incluye una expresión regular que intenta coincidir con el inicio de la contraseña.
  2. A medida que el script encuentra coincidencias, va construyendo la contraseña, carácter por carácter, y la muestra como resultado.
  3. Utiliza el siguiente formato en la consulta: 
     ```json
     {"username": "admin","password":{"$regex":"^%s%s"}}
     ```
     donde `%s` es el progreso de la contraseña actual y `character` es el nuevo carácter que se está probando.
  
- **Vulnerabilidad**: La vulnerabilidad de NoSQLi es explotada debido al uso de una consulta NoSQL mal construida que permite a un atacante realizar inyecciones a través de la manipulación de datos no sanitizados, específicamente en la parte del campo de la contraseña.

### Requisitos

- El script utiliza la librería **pwn** para el manejo de logs y la visualización del progreso.
- Requiere Python 2.x o 3.x.
