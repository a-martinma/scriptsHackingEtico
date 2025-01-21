## `email.js`

Este script solicita al usuario que ingrese su dirección de correo electrónico mediante un cuadro de texto `prompt`. Si el usuario introduce un correo electrónico válido, el script realiza una solicitud a un servidor (ubicado en `http://192.168.1.42/`), enviando el correo electrónico como parámetro en la URL.

### Descripción

- **Propósito**: Extraer el correo electrónico del usuario mediante un cuadro de texto.
- **Vulnerabilidad**: El script es vulnerable a un ataque de XSS al enviar el correo electrónico a un servidor malicioso sin validación o protección.

## `emailAndPassword.js`

Este script presenta un formulario donde el usuario puede introducir su correo electrónico y contraseña. Al hacer clic en el botón de envío, se envían las credenciales (correo y contraseña) a un servidor en la URL `http://192.168.1.42/` mediante una solicitud `fetch`.

### Descripción

- **Propósito**: Capturar las credenciales del usuario (correo electrónico y contraseña).
- **Vulnerabilidad**: El formulario no realiza ninguna validación sobre los datos introducidos, lo que permite que un atacante extraiga las credenciales sin que el usuario se percate.

## `keylogger.js`

Este script actúa como un **keylogger**. Cada vez que el usuario presiona una tecla, el script registra la tecla pulsada y la envía a un servidor a través de una solicitud `Image` con la cadena de teclas que el usuario ha escrito hasta ese momento.

### Descripción

- **Propósito**: Registrar todas las teclas presionadas por el usuario.
- **Vulnerabilidad**: Al ser ejecutado en el navegador de la víctima, este script puede capturar cualquier tipo de entrada del usuario, como contraseñas o información sensible.

## `pwned.js`

Este script realiza una doble solicitud HTTP. Primero, obtiene un token CSRF de una página web y luego lo usa para realizar una segunda solicitud `POST` para enviar datos maliciosos a un servidor.

### Descripción

- **Propósito**: Realizar un ataque de tipo **Cross-Site Request Forgery (CSRF)** utilizando un token CSRF extraído de una página vulnerable.
- **Vulnerabilidad**: Aprovecha la falta de protección en el servidor para enviar datos maliciosos sin el conocimiento del usuario.
