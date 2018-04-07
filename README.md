# cPanel_BlockMailAccountAbuse

Tests for a function that will identify SPAMMERS and block the abused account.

Just an outline of an idea, not tested.

Portuguese
--------------------------------------------------------------------

Testes para uma função que irá identificar um SPAMMER que esteja abusando de uma conta e bloquea-lo automáticamente.

Ainda estou testando o conceito da ideia. Os grandes eventos de SPAM diminuiram o que tem dificultado testes e ideias.


O objetivo será identificar uma conta que tenha enviado uma grande quantidade de mensagens e evitar que uma conta cPanel seja abusada.

Como tive uma redução dos eventos grandes de SPAM, e pelo risco de bloquear usuários legitimos, uma ideia alternativa que poderá ser implementada é a identificação de uma conta que recebeu login de múltiplos IPs e bloquea-la, pois esse não é um comportamento comum. Podemos cruzar essa ideia com a de volumetria acima para que só sejam contadas as contas que tenham multiplos IPs de login.


O Script massivespammer.sh <hour> irá buscar no log as linhas que representem logins de um usuário, se nesse tempo X uma conta tiver realizado mais de 100 logins será suspensa usando as API do cPanel/WHM e em seguida irá disparar um e-mail notificando.
A ideia é roda-lo no CRON com intervalos periódicos, como 15 minutos, onde ele irá verificar a última hora.

O Script multipleloginspammer.sh <hour> irá realizar checar o log e identificar se uma conta recebeu login de muitos IPs, no caso de ter recebido login de mais de 3 IPs o sistema irá suspender esta conta sob suspeita de ser um SPAMMER.
A ideia é roda-lo no CRON com intervalos periódicos, como 15 minutos, onde ele irá verificar a última hora.


O Script blockspammer.sh é apenas um teste preliminar, que será descartado no futuro.


Ainda busco uma ideia para identificar e barrar as contas que recebem abuso com menor frequência.
Exemplo: Enviam 5 mensagens hora e usam o mesmo IP; Julgo dificil identifica-los, pois trata-se de comportamento praticamente comum de um usuário.




English Version (Translated: Google)
----------

Tests for a function that will identify a SPAMMER that is abusing an account and automatically blocks it.

I'm still testing the concept of the idea. The large SPAM events have reduced what has hampered testing and ideas.


The goal is to identify an account that has sent a large amount of messages and prevent a cPanel account from being abused.

Since I have had a reduction in the large SPAM events, and the risk of blocking legitimate users, an alternative idea that could be implemented is to identify an account that has received multiple IPs and block it, as this is not a common behavior. We can cross this idea with the one of volumetry above so that only the accounts that have multiple login IPs are counted.


Script massivespammer.sh <hour> will log the lines representing a user's logins, if at that time X an account has performed more than 100 logins will be suspended using the cPanel / WHM APIs and then will trigger an e- mail notifying.
The idea is to wheel it on the CRON with periodic intervals, like 15 minutes, where it will check the last hour.

Script multipleloginspammer.sh <hour> will check the log and identify if an account has received login of many IPs, in case it has received login of more than 3 IPs the system will suspend this account under suspicion of being a SPAMMER.
The idea is to wheel it on the CRON with periodic intervals, like 15 minutes, where it will check the last hour.


The blockspammer.sh script is only a preliminary test, which will be discarded in the future.


I'm still looking for an idea to identify and bar accounts that get abused less often.
Example: Send 5 time messages and use the same IP; I find it difficult to identify them, because it is a user's almost common behavior.

