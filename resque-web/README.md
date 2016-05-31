# Resque Web GUI

## (With Resque Cleaner & Resque Sliders)

Need a GUI to monitor your Redis / Resque queues but freak out when you read the instructions for setting up resque-web? why do you need a framework? and a ruby env? and all these gem's etc etc etc?.

This will sort you out - in 1 command you can point this at your Redis server and have a GUI that will allow you to monitor, manage and most importantly (the reason I started this) the ability to requeue failed jobs easily!
Supports redis sentinel as well as single redis hosts.

## Getting the container

### Download

Obviously you need to have docker installed:

	sudo apt-get install docker.io

Clone this into a directory and issue (as root or sudo)

	git clone git@gitlab.fidelize.com.br:docker/resque-web.git
	docker build -t resque-web resque-web

### Usage

Specifying LOCAL nodes (Locally, the sentinel mode does not work. This is because when the resque-web asks pens ip pro sentinel, the sentinel responds as if the IP was localhost, but from within the resque-web docker localhost context is different):

```
docker run -p 9292:9292 resque-web --sentinel redis-sentinel.fidelize.com.br:26379 --sentinel 192.168.11.1:26379 --master mymaster --db 6
```

Specifying Sentinel nodes (With ttdev ip sentinel):

```
docker run -p 9292:9292 resque-web --sentinel redis-sentinel.fidelize.com.br:26379 --sentinel 192.168.11.1:26379 --master mymaster --db 6
```

Specifying with multi Sentinel nodes:

```
docker run -p 9292:9292 resque-web --sentinel 192.168.11.1:26379 --sentinel 192.168.99.1:26379 --master mymaster -db 6
```

Specifying a single Redis node:

```
docker run -p 9292:9292 resque-web --redis redis.my.host
```

Specifying a single Redis node and a database number:

```
docker run -p 9292:9292 resque-web --redis redis.my.host --db 3
```

### Instalando de dentro da fidelize

Rode o comando abaixo depois de ler as observações que estão a seguir

```
docker run -p 9292:9292 ttdev.fidelize.com.br:5000/resque-web --sentinel 192.168.11.1:26379 --master mymaster --db 6
```

Por padrão o Docker, ao fazer download de novas imagens, requer uma rede segura (TLS).
Enquanto a rede segura não estiver disponibilizada no ttdev, temos alguns workarounds para conseguir o acesso "não-seguro".

Basicamente, na hora de executar o serviço do docker, adicione o seguinte parametro: --insecure-registry ttdev.fidelize.com.br:5000
Raros os casos onde o IP do ttdev teve que ser utilizado para que esta configuração funcionasse.

Para Ubuntu (o conceito também se aplica a outras distribuições, pequenas alterações podem ser necessárias):
    - altere o arquivo /etc/default/docker, tire o comentário da opção DOCKER_OPTS e substitua seu conteúdo com o parametro citado, ficando:
        DOCKER_OPTS="--insecure-registry ttdev.fidelize.com.br:5000"

    - Certifique-se que o arquivo /lib/systemd/system/docker.service possua as seguintes definições para os parâmetros citados.
        * ExecStart=/usr/bin/docker daemon -H fd:// $DOCKER_OPTS
        * EnvironmentFile=-/etc/default/docker

    - Reinicie o serviço do docker:
        - sudo systemctl daemon-reload
        - sudo systemctl restart docker

    ** Para conferir se funcionou, rode o comando: ps aux | grep docker e verifique que o processo do docker possui o parametro de insecure-registry.

Para windows (algum comando similar deverá ser aplicado ao Mac, o importante é alterar o start da VM):
    - Altere o arquivo C:\Program Files\Docker Toolbox\start.sh, procure pela palavra create.
    - Confira se esta de fato está criando uma nova VM.
    - Adicione o seguinte parâmetro: --engine-insecure-registry ttdev.fidelize.com.br:5000
    - Apague a VM que você possuia anteriormente
    - Rode o start.sh

Como exemplo, você pode baixar imagens do ttdev utilizando o seguinte comando:
docker pull ttdev.fidelize.com.br:5000/redis:3.0
