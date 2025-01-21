# Ruleta Ética 🎰 - Bash Script 

Este proyecto es un script en Bash para simular un juego de ruleta. Permite elegir el dinero inicial, la técnica de apuesta (Martingala o Labouchere inversa) y si deseas apostar a números pares o impares. 

Uno de los principales objetivos de este proyecto es, además de mejorar las habilidades en scripting, darse cuenta de que jamás se puede vencer a la ruleta. La banca siempre gana.

## Características

- **Estrategias soportadas**:
  - Martingala: Duplica la apuesta tras cada pérdida.
  - Labouchere inversa: Utiliza una secuencia numérica para determinar las apuestas.
- **Opciones de apuesta**:
  - Par o impar.
- Simulación interactiva con seguimiento del progreso y estadísticas al finalizar el juego.

## Requisitos  

- **Python 3.7+**: La herramienta está escrita en Python, asegurando compatibilidad con versiones modernas del lenguaje.  

## Instalación  
1. Clona este repositorio:  
   ```bash
   git clone https://github.com/a-martinma/scriptsHackingEtico.git

2. Entra en el directorio clonado
   ```bash
   cd miniApps/ruletaEtica

3. Ejecuta la aplicación, si se ejecuta sin parámetros se podrán ver las diferentes opciones
    ```bash
    ./ruletaEtica

### Observación

Se han comentado los `echo` correspondientes a los resultados de cada jugada además de los `sleep` que hacen que se entienda mejor la forma en la que se está apostando y los resultados que se están obteniendo. 

Tal y como está implementado el script, siempre que se ejecute se va a mostrar directamente el fin del juego en el 100% de ocasiones debido a que el total de jugadas se realiza inmediatamente por la rapidez del script y que la banca siempre gana.

Para una experiencia más realista, descomentar todas las líneas comentadas.
