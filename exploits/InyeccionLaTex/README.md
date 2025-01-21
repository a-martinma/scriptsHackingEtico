## `getFilesLatex.sh`

### Descripción

Este script explota una vulnerabilidad de inyección LaTeX utilizando un payload proveniente de [PayloadAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/LaTeX%20Injection/README.md). Permite descargar y procesar archivos alojados en un servidor vulnerable, extrayendo su contenido de manera iterativa.

### Funcionamiento

1. **Configuración inicial**: 
   - Recibe como argumento el nombre del archivo que se desea descargar.
2. **Proceso de inyección**:
   - Utiliza un payload LaTeX para inyectar comandos que abren el archivo especificado y leen su contenido línea por línea.
   - Envía solicitudes POST al servidor utilizando `curl`, con el payload incrustado en los datos.
3. **Descarga y procesamiento**:
   - Cuando el servidor responde con una URL de descarga, el script utiliza `wget` para descargar el archivo.
   - Convierte el archivo PDF resultante a texto plano usando `pdftotext`.
   - Extrae y muestra la primera línea del archivo.
   - Limpia los archivos temporales descargados y generados.
4. **Iteración**:
   - El proceso se repite hasta que no se obtienen más URLs de descarga, simulando la lectura completa del archivo.

### Uso

```bash
./getFilesLatex.sh /etc/passwd
```
