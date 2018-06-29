#!/usr/bin/env python

from pwn import *

payload = ''

# create payload here, you can use p32 and p64

with open("payload", "wb") as output_file:
    output_file.write(payload)
