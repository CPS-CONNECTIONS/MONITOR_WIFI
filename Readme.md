# MONITORES WIFI

Este script shell tem o objetivo de fazer a seleção do ponto de acesso mais próximo com o melhor sinal de rede, básicamente uma vez detectado o melhor sinal de rede ele faz a conexão baseada no BSSID do roteador. Sendo assim o coletor sempre vai estar conectado no roteador mais próximo garantindo uma boa conexão.

## Monitor Wifi Linkit

Para utilizar esse monitor é necessário ter instalado dois programas essências para configuração:
- [Winscp](https://cpsconnections-my.sharepoint.com/:u:/p/operacional/EXjZi6aNOfJKnrv3uykyfaIBXZjqhjrTWcNr8hgrnq6hXQ?e=eJdIZO) <- Link para download
- [Putty](https://cpsconnections-my.sharepoint.com/:u:/p/operacional/EbsMIh_GNFNFqAmybCBLbaUBFxULkNYxkXuWrPwYxZ7raA?e=Zu6oB0)

### Instalando o monitor **network.sh**:

Primeiro passe o arquivo **network.sh** para o Linkit via Winscp, nesse caso você precisa ter em mãos o IP do coletor, onde você conseguirá fazer a conexão colocando o usuário **root** e senha **123456**, com isso passe o arquivo para pasta **/home/root/**. Depois acesse o coletor via putty com o mesmo IP, usuário e senha de anteriormente.

- Comandos a serem executados no coletor:
```sh
  sudo apt-get install cron -y
  sudo crontab -e 
```
- No editor que será aberto quando rodar o **sudo crontab -e** digite o seguinte:
```sh
  2 * * * * /home/root/network.sh > /home/root/network.log 2>&1
```
- Para iniciar o software basta rodar o seguinte comando:
```sh
  /etc/init.d/cron start
  /etc/init.d/cron enable
```
---
## Monitor Wifi RockPi

Para utilizar esse monitor é necessário ter instalado dois programas essências para configuração:
- [Winscp](https://cpsconnections-my.sharepoint.com/:u:/p/operacional/EXjZi6aNOfJKnrv3uykyfaIBXZjqhjrTWcNr8hgrnq6hXQ?e=eJdIZO) <- Link para download
- [Putty](https://cpsconnections-my.sharepoint.com/:u:/p/operacional/EbsMIh_GNFNFqAmybCBLbaUBFxULkNYxkXuWrPwYxZ7raA?e=Zu6oB0)

### Instalando o monitor **network.sh**:

Primeiro passe o arquivo **network.sh** para o RockPi via Winscp, nesse caso você precisa ter em mãos o IP do coletor, onde você conseguirá fazer a conexão colocando o usuário **rock** e senha **rock**, com isso passe o arquivo para pasta **/home/rock/**. Depois acesse o coletor via putty com o mesmo IP, usuário e senha de anteriormente.

- Comandos a serem executados no coletor:
```sh
  sudo apt-get install cron -y
  sudo crontab -e 
```
- No editor que será aberto quando rodar o **sudo crontab -e** digite o seguinte:
```sh
  2 * * * * /home/rock/network.sh > /home/rock/network.log 2>&1
```
- Para iniciar o software basta rodar o seguinte comando:
```sh
  sudo systemctl start cron
  sudo systemctl enable cron
```
## Obs: Lembre-se de editar no arquivo o nome da rede alvo no campo SSID!

---
Para suporte técnico ou comercial, entre em contato com:

Departamento Técnico: operacional@cpsconnections.com
Departamento Comercial: adm@cpsconnections.com
Telefone/Fax: (92) 98271-0102
Endereço: Rua Belo Horizonte, Nº 351, Sala 9, Adrianópolis, Manaus - AM, 69057-060.

⏰ Horário de atendimento: Segunda à sexta, das 8h às 16h.

