#!/usr/bin/python3

import sys, signal, requests

def def_handler(sig, frame):
    print("\n\n[!] Saliendo...\n")
    sys.exit(1)

# Ctrl+C
signal.signal(signal.SIGINT, def_handler)

main_url = "http://192.168.1.179"
squid_proxy = {'http': 'http://192.168.1.179:3128'}

def portDiscovery():

    common_tcp_ports = {20, 21, 22, 23, 25, 53, 67, 68, 69, 80, 110, 119, 123, 135, 137, 138, 139, 143, 161, 162, 179, 194, 389, 443, 445, 465, 500, 514, 515, 520, 587, 631, 993, 995, 1080, 1194, 1433, 1434, 1521, 1701, 1723, 1812, 1813, 1883, 2049, 3306, 3389, 5060, 5900, 8080, 8443}

    for tcp_port in common_tcp_ports:

        r = requests.get(main_url + ':' + str(tcp_port), proxies=squid_proxy)

        if r.status_code != 503:
            print("\n[+] Port " + str(tcp_port) + " - OPEN")

if __name__ == '__main__':

    portDiscovery()
