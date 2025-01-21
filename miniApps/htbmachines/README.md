# HTBMachines CLI Tool  

HTBMachines es una herramienta de línea de comandos diseñada para facilitar la búsqueda y filtrado de máquinas de Hack The Box (HTB). Ofrece una forma rápida y eficiente de encontrar información relevante sobre las máquinas mediante varios tipos de filtros personalizados. Este script recoge la información de las máquinas de `https://htbmachines.github.io/`, propiedad de `S4vitar`.

## Características  

- **Filtros avanzados**: Filtra máquinas por dificultad, categoría, sistema operativo, estado (activo/retirado) y más.  
- **Búsqueda rápida**: Encuentra máquinas utilizando palabras clave específicas.  
- **Interfaz sencilla**: Todo se maneja desde la línea de comandos con parámetros claros.  

## Requisitos  

- **Python 3.7+**: La herramienta está escrita en Python, asegurando compatibilidad con versiones modernas del lenguaje.  

## Instalación  
1. Clona este repositorio:  
   ```bash
   git clone https://github.com/a-martinma/scriptsHackingEtico.git

2. Entra en el directorio clonado
   ```bash
   cd miniApps/htbmachines

3. Ejecuta la aplicación, si se ejecuta sin parámetros se podrán ver las diferentes opciones
    ```bash
    ./htbmachines


### Observación

Para el correcto funcionamiento de la aplicación, será necesario disponer del archivo `bundle.js`. Para obtenerlo, hay que ejecutar la aplicación por primera vez de la siguiente forma:
    ```bash
    ./htbmachines -u
