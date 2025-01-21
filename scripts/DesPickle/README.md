## `deserializacionPickle.py`

### Descripción

Este script demuestra cómo una vulnerabilidad en la deserialización de objetos Pickle puede ser explotada para ejecutar comandos arbitrarios en un sistema. Se basa en la sobrecarga del método `__reduce__`, utilizado por Pickle durante el proceso de deserialización, para inyectar y ejecutar una shell inversa en el sistema objetivo.

### Funcionamiento

- **Clase `Exploit`**:
    - Esta clase sobrecarga el método especial `__reduce__`. En Pickle, el método `__reduce__` es utilizado durante el proceso de deserialización para decidir cómo reconstruir un objeto.
    - En nuestro caso, sobrecargamos este método para que, en lugar de reconstruir un objeto tradicional, **ejecute un comando de sistema** cuando el objeto sea deserializado. Específicamente, el comando establece una reverse shell que conecta al atacante en la dirección `<IP_Atacante>` en el puerto `443`.

- **Generación de la cadena Pickle**:
    - La función `pickle.dumps()` toma el objeto `Exploit` y lo convierte en una cadena de bytes.
    - Luego, utilizamos `binascii.hexlify()` para convertir esa cadena de bytes en un formato hexadecimal, que es más fácil de manejar, especialmente cuando se va a insertar en un campo de entrada web.

- Una vez que el script Python se ha ejecutado, generará una cadena hexadecimal que representa el objeto Pickle manipulado. Esta cadena es la que se debe introducir en el campo de entrada de la web vulnerable.
   Lo que sucede a continuación es que la web **deserializa** el objeto Pickle proporcionado en ese campo de entrada. Si la aplicación no valida ni sanitiza adecuadamente la entrada, el objeto Pickle manipulado se deserializa y, al hacerlo, ejecuta el comando `os.system`, lo que da lugar a la **ejecución de la reverse shell** en el sistema del atacante.
