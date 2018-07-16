#!/bin/bash

# 
# Script para identificar contas que estão sendo constantemente negadas.
# Apenas lista contas que receberam negação com códigos 4.7.x e 5.7.x
# 

## Localiza os logins do log todo
#exigrep ": [0-9]{1,3} [4|5]\.7\.[0-9] " /var/log/exim_mainlog | grep -Poe '(?<=(dovecot_login|dovecot_plain):)[^ ]+(?= )' | sort -n | uniq -c

## Localiza os logins da última hora
exigrep ": [0-9]{1,3} [4|5]\.7\.[0-9] " /var/log/exim_mainlog | awk '($0 >= from)' from="$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S' -d -1hour)" | grep -Poe '(?<=(dovecot_login|dovecot_plain):)[^ ]+(?= )'
