#!/bin/bash

# 
# Script para identificar contas que estão sendo constantemente negadas.
# Apenas lista contas que receberam negação com códigos 4.7.x e 5.7.x
# 

exigrep ": [0-9]{1,3} [4|5]\.7\.[0-9] " /var/log/exim_mainlog | grep -Poe '(?<=(dovecot_login|dovecot_plain):)[^ ]+(?= )' | sort -n | uniq -c
