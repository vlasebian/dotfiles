#!/usr/bin/env python

from pwn import *

payload = ''

# open a connection (ip or dns name and port number)
conn = remote('127.0.0.1', 9999)

# send payload
conn.sendline(payload)

# shell interaction
conn.interactive()
