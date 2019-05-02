#!/bin/bash
### searchspammer <TIME BEFORE in hour>

notify="YOUR_MAIL"

# Processa o Log em x horas
exim -bp > /tmp/eximqueue_

# Contar e imprimir quantidade de linhas de log
linen=`grep ">" /tmp/eximqueue_ | wc -l`
echo $linen 

# Processa o Log para obter logins e IPs
grep "<" /tmp/eximqueue_ | grep -v "<>" | grep -Po "(?<=<).*(?=>)" | sort -n | uniq -c | sort -n > /tmp/list_envio_queue

## Imprime lista de account e quantidade de IPs que acessaram acima de 1000 logins
echo -e "\r\n---------   Lista de account que efetuaram logins de mais IPs    ---------"
echo -e "\tqtde \t login"
cat /tmp/list_envio_queue | egrep "[0-9]{3,9} " > /tmp/top_queues
cat /tmp/top_queues

echo -e "\r\n\r\n ----------------------------------"

## Ler o export de logins suspeitos
for line in `cat /tmp/top_queues | awk '{print $2}'`; do
 for domainuser in `cat /etc/domainusers| sed "s/ //g"`; do
    # Pega apenas as contas
    if [[ $line =~ .*@.*  ]]; then
		# Testamos se o domínio é interno, e evitamos tentar suspender contas inexistentes
        domain=`echo ${line} | awk -F "@" '{print $2}'`
		processa=`echo $domainuser | grep ":$domain" | awk -F ":" '{print $1}' `
		if [[ -n $processa ]]; then
			### Envia e-mail para um email alertando o bloqueio
		    ##echo "Bloqueamos o usuario "$line" por ter enviado cerca de "`grep $line /tmp/top_queues | awk '{print $1}'`" mensagens na ultima $1 hora(s) para destinos que negaram a recepcao." | mail -s "Usuario "$line" bloqueado em "`hostname`" por envio de SPAM" $notify
			# Suspende o login
			echo ${line} | awk -F "@" '{print "whmapi1 listaccts search="$2" searchtype=domain | grep user" }' | sh | awk -F ": " '{print $2}' | xargs -I '{}' echo "uapi --user={} Email suspend_login email="${line} 
			echo ${line} | awk -F "@" '{print "whmapi1 listaccts search="$2" searchtype=domain | grep user" }' | sh | awk -F ": " '{print $2}' | xargs -I '{}' echo "uapi --user={} Email hold_outgoing email="${line} 
			##echo -e "\r\n -----------------------------\r\n Conta $line Suspensa"
		fi
		processa=""
    fi
 done
done

## Remover arquivos
rm /tmp/eximqueue_
rm /tmp/list_envio_queue
rm /tmp/top_queues
