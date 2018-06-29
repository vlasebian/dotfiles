#!/usr/bin/env python

from pwn import *

# Command
cmd = '/bin/ls' 

# Run it
p = process(cmd, shell=True)

p.recvuntil('Input prompt: ')
p.sendline('write your input here')

p.interactive()

