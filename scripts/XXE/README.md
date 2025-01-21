## `xxe_oob.sh`:

Este script ha sido diseñado para un escenario específico en el que se presenta una vulnerabilidad XXE. Sin embargo, si se comprende el funcionamiento, se puede adaptar a otros casos similares.
 
Se trata de un script en Bash que automatiza el proceso completo de explotación mediante técnicas de exfiltración Out-Of-Band (OOB):
  1. Genera un archivo `malicious.dtd` dinámicamente según el archivo objetivo a extraer.
  2. Inicia un servidor web local para capturar datos exfiltrados.
  3. Envía el payload malicioso al servidor vulnerable.
  4. Recoge y decodifica los datos extraídos.


El archivo `xxe_oob.sh` crea el archivo `malicious.dtd` como parte de su operación. Juntos permiten:
1. Especificar dinámicamente el archivo objetivo en el servidor vulnerable.
2. Automatizar el envío del payload y la extracción de datos.
3. Procesar los resultados y mostrar el contenido del archivo exfiltrado.
