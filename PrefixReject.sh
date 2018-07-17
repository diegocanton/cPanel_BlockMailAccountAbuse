#!/bin/bash

# 
# Script para identificar contas que estão sendo constantemente negadas.
# Apenas lista contas que receberam negação com códigos 4.7.x e 5.7.x
# 

## Localiza os logins do log todo
#exigrep ": [0-9]{1,3} [4|5]\.7\.[0-9] " /var/log/exim_mainlog | grep -Poe '(?<=(dovecot_login|dovecot_plain):)[^ ]+(?= )' | sort -n | uniq -c

## Localiza os logins da última hora
## EXEMPLOS:
## Exim + cPanel
exigrep ": [0-9]{1,3} [4|5]\.7\.[0-9] " /var/log/exim_mainlog | awk '($0 >= from)' from="$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S' -d -1hour)" | grep -Po '(?<=(dovecot_login|dovecot_plain):)[^ ]+(?= )' | sort | uniq -c | sort

## Exim
exigrep ": [0-9]{1,3} [4|5]\.7\.[0-9] " /var/log/exim_mainlog | awk '($0 >= from)' from="$(LC_ALL=C date +'%Y-%m-%d %H:%M:%S' -d -1hour)" | grep -Po '(?<=plain_server:)[^ ]+(?= )' | sort | uniq -c | sort

## POSTFIX + Zimbra
egrep ": [0-9]{1,3} [4|5]\.7\.[0-9] " /var/log/mail.log | awk '($0 >= from)' from="$(LC_ALL=C date +'%b %d %H:%M:%S' -d -1hour)" |  grep -Po '(?<=from=<)[^>]+(?=>)' | sort | uniq -c | sort


#
