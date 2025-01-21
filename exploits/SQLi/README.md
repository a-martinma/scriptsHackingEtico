## `sqliBasedTime.py`

Este es un script de inyección SQL basado en el tiempo. Se utiliza para realizar ataques de **SQL Injection (SQLi)** que aprovechan el retraso temporal en la respuesta del servidor para extraer datos de la base de datos.

### Uso

El script está diseñado para funcionar con una URL objetivo. Las operaciones a realizar están actualmente comentadas en el código, **para que el script funcione correctamente, se debe ir descomentando las secciones correspondientes de acuerdo con lo que desees realizar**. 

### Comandos del Script

1. **Fuerza bruta**: El script utiliza un ciclo de fuerza bruta para adivinar los caracteres de la información que se desea extraer de la base de datos.

2. Si una consulta SQL devuelve un valor verdadero, el servidor retrasará la respuesta (en este caso, con una espera de 0.35 segundos). Al aprovechar estos retrasos, el script puede descubrir el siguiente caracter de aquello que se quiera obtener (nombre de la base de datos por ejemplo).

3. **Extracción de datos**: Una vez que se obtiene un carácter, este se añade a la información extraída. Esto se repite para cada carácter en las cadenas de datos que se desean recuperar.

### Futuro del Script

Un objetivo a largo plazo de este script es que no haya nada comentado y que todo se pueda controlar mediante parámetros desde la línea de comandos, lo que haría que el script fuera más flexible y reutilizable para diferentes escenarios de pruebas.

---

## `sqliConditionals.py`

Este es un script de inyección SQL que utiliza condiciones `OR` para realizar un ataque de **SQL Injection (SQLi)**. A diferencia de los ataques basados en tiempo, este script depende de la respuesta directa del servidor para determinar si una condición es verdadera o falsa.

### Uso

El script está diseñado para funcionar con una URL objetivo y realizar consultas SQL para extraer información de la base de datos. Al igual que en el script anterior, las secciones del código que realizan operaciones están actualmente comentadas. **Es necesario descomentar las secciones correspondientes según la operación que se desee ejecutar**.

### Comandos del Script

1. **Fuerza bruta**: Al igual que en el script anterior, el script realiza una fuerza bruta sobre los caracteres que se desean obtener de la base de datos.

2. **Condiciones OR**: El script utiliza condiciones `OR` en la inyección SQL para verificar si una determinada consulta devuelve un valor verdadero, lo que indica que una parte de la cadena de datos ha sido correctamente adivinada.

3. **Extracción de datos**: El script puede extraer información como el nombre de las bases de datos, las tablas, las columnas, o incluso los usuarios y contraseñas, dependiendo de las condiciones que se descomenten.

### Futuro del Script

El objetivo es, al igual que en el script anterior. permitir que todo el proceso se pueda controlar mediante parámetros de línea de comandos, para que el script sea más flexible y pueda ser utilizado para diferentes tipos de pruebas sin necesidad de modificar el código.

---

## `sqliMaquinaIMF.py`

Este es un script de inyección SQL diseñado específicamente para la máquina **IMF 1** de VulnHub. Utiliza un ataque de **SQL Injection (SQLi)** para extraer información sobre las páginas de administración de un CMS.

**URL de la máquina IMF 1 en VulnHub**: [IMF 1 - VulnHub](https://www.vulnhub.com/entry/imf-1,162/)

### Uso

Este script está diseñado para interactuar con una URL objetivo y utilizar un ataque de inyección SQL basado en el contenido de las respuestas. El ataque se realiza utilizando caracteres de un conjunto predefinido para adivinar los caracteres de las páginas de administración.

### Comandos del Script

1. **Fuerza bruta**: El script realiza un ataque de fuerza bruta sobre los caracteres de la página de administración utilizando un conjunto de caracteres compuesto por letras minúsculas, números y símbolos.

2. **Inyección SQL**: El script usa inyección SQL para intentar extraer información de la base de datos, específicamente los nombres de las páginas desde la tabla `admin.pages`.

3. **Extracción de datos**: A medida que se adivinan correctamente los caracteres de los nombres de las páginas, estos se añaden a la variable `data` y se muestran progresivamente en la salida.

### Futuro del Script

Este script está diseñado para ser utilizado específicamente en el contexto de la máquina **IMF 1** de VulnHub. Se puede modificar y extender para probar otras URL y adaptarse a diferentes configuraciones de CMS, pero actualmente está optimizado para este entorno específico.
