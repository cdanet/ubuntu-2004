#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Linkedin: https://www.linkedin.com/in/robson-vaamonde-0b029028/
# Instagram: https://www.instagram.com/procedimentoem/?hl=pt-br
# Data de criação: 02/11/2021
# Data de atualização: 02/11/2021
# Versão: 0.01
# Testado e homologado para a versão do Ubuntu Server 20.04.x LTS x64x
# Testado e homologado para a versão do Webmin v1.9x, Usermin v1.8x, Virtualmin v6.17x, 
#
# Webmin é um programa de gerenciamento de servidor, que roda em plataformas Unix/Linux. 
# Com ele você pode usar também o Usermin e o Virtualmin. O Webmin funciona como um 
# centralizador de configurações do sistema, monitoração dos serviços e de servidores, 
# fornecendo uma interface amigável, e que quando configurado com um servidor web, pode 
# ser acessado de qualquer local, através de um navegador: 
# Exemplo: https:\\(ip do servidor):(porta de utilização) - https:\\172.16.1.20:10000
#
# Usermin é uma interface baseada na web para webmail, alteração de senha, filtros de 
# e-mail, fetchmail e muito mais. Ele é projetado para uso por usuários não-root regulares 
# em um sistema Unix e os limita a tarefas que seriam capazes de realizar se logados via 
# SSH ou no console.
#
# Virtualmin é um módulo Webmin para gerenciar vários hosts virtuais por meio de uma única 
# interface, como Plesk ou Cpanel. Ele suporta a criação e gerenciamento de hosts virtuais 
# Apache, domínios BIND DNS, bancos de dados MySQL e caixas de correio e aliases com 
# Sendmail ou Postfix. Ele faz uso dos módulos Webmin existentes para esses servidores e, 
# portanto, deve funcionar com qualquer configuração de sistema existente, ao invés de 
# precisar de seu próprio servidor de e-mail, servidor web e assim por diante.
#
# Informações que serão solicitadas na configuração via Web do Webmin e Usermin
# Username: vaamonde
# Password: pti@2018: Sign In
#
# Site oficial do Webmin: http://www.webmin.com/
# Site oficial do Usermin: https://www.webmin.com/usermin.html
# Site oficial do Virtualmin: https://www.webmin.com/virtualmin.html
#
# Arquivo de configuração dos parâmetros utilizados nesse script
source 00-parametros.sh
#
# Configuração da variável de Log utilizado nesse script
LOG=$LOGSCRIPT
#
# Verificando se o usuário é Root e se a Distribuição é >= 20.04.x 
# [ ] = teste de expressão, && = operador lógico AND, == comparação de string, exit 1 = A maioria 
# dos erros comuns na execução
clear
if [ "$USUARIO" == "0" ] && [ "$UBUNTU" == "20.04" ]
	then
		echo -e "O usuário é Root, continuando com o script..."
		echo -e "Distribuição é >= 20.04.x, continuando com o script..."
		sleep 5
	else
		echo -e "Usuário não é Root ($USUARIO) ou a Distribuição não é >= 20.04.x ($UBUNTU)"
		echo -e "Caso você não tenha executado o script com o comando: sudo -i"
		echo -e "Execute novamente o script para verificar o ambiente."
		exit 1
fi
#
# Script de instalação do Webmin, Usermin e Virtualmin no GNU/Linux Ubuntu Server 20.04.x
# opção do comando echo: -e (enable) habilita interpretador, \n = (new line)
# opção do comando hostname: -d (domain)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" &>> $LOG
clear
echo
#
echo -e "Instalação do Webmin no GNU/Linux Ubuntu Server 20.04.x\n"
echo -e "Porta padrão utilizada pelo Webmin.: TCP 10000"
echo -e "Porta padrão utilizada pelo Usermin.: TCP 20000"
echo -e "Porta padrão utilizada pelo Virtualmin.: TCP \n"
echo -e "Após a instalação do Webmin acessar a URL: https://$(hostname -I | cut -d ' ' -f1):10000/"
echo -e "Após a instalação do Usermin acessar a URL: https://$(hostname -I | cut -d ' ' -f1):20000/"
echo -e "Após a instalação do Virtualmin acessar a URL: https://$(hostname -I | cut -d ' ' -f1):20000/\n"
echo -e "Aguarde, esse processo demora um pouco dependendo do seu Link de Internet...\n"
sleep 5
#
echo -e "Adicionando o Repositório Universal do Apt, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	add-apt-repository universe &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Adicionando o Repositório Multiversão do Apt, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository multiverse &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Atualizando as listas do Apt, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	apt update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Atualizando todo o sistema, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando apt: -y (yes)
	apt -y upgrade &>> $LOG
	apt -y dist-upgrade &>> $LOG
	apt -y full-upgrade &>> $LOG
echo -e "Sistema atualizado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Removendo software desnecessários, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando apt: -y (yes)
	apt -y autoremove &>> $LOG
	apt -y autoclean &>> $LOG
echo -e "Software removidos com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Iniciando a Instalação e Configurando o Webmin, Usermin e Virtualmin, aguarde...\n"
sleep 5
#
echo -e "Instalando as dependências do Webmin, Usermin e Virtualmin, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes), \ (Bar, opção de quebra de linha no apt)
	apt -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime \
	libio-pty-perl apt-show-versions python unzip &>> $LOG
echo -e "Instalação das dependências feita com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Fazendo o download do Webmin, Usermin e Virtualmin do site Oficial, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# removendo versões anteriores baixadas do Webmin
	# opção do comando rm: -v (verbose)
	# opção do comando wget: -O (output document file)
	rm -v webmin.deb &>> $LOG
	rm -v usermin.deb &>> $LOG
	rm -v virtualmin.deb &>> $LOG
	wget $WEBMIN -O webmin.deb &>> $LOG
	wget $USERMIN -O usermin.deb &>> $LOG
	wget $VIRTUALMIN -O virtualmin.deb &>> $LOG
echo -e "Download do feito com sucesso!!!, continuando com o script...\n"
sleep 5
#				 
echo -e "Instalando o Webmin, esse processo demora um pouco, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando dpkg: -i (install)
	dpkg -i webmin.deb &>> $LOG
echo -e "Instalação do Webmin feita com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Instalando o Usermin, esse processo demora um pouco, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando dpkg: -i (install)
	dpkg -i usermin.deb &>> $LOG
echo -e "Instalação do Usermin feita com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Instalando o Virtualmin, esse processo demora um pouco, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando dpkg: -i (install)
	dpkg -i virtulamin.deb &>> $LOG
echo -e "Instalação do Virtualmin feita com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Iniciando os Serviços do Webmin, Usermin e do Virtualmin, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	systemctl start webmin &>> $LOG
	systemctl start usermin &>> $LOG
	systemctl start virtulamin &>> $LOG
echo -e "Serviços iniciados com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando as portas de conexões do Webmin, Usermin e do Virtualmin, aguarde..."
	# opção do comando lsof: -n (inhibits the conversion of network numbers to host names for 
	# network files), -P (inhibits the conversion of port numbers to port names for network files), 
	# -i (selects the listing of files any of whose Internet address matches the address specified 
	# in i), -s (alone directs lsof to display file size at all times)
	lsof -nP -iTCP:'10000,20000,30000' -sTCP:LISTEN
echo -e "Portas verificadas com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Instalação e Configuração do Webmin, Usermin e do Virtualmin feita com Sucesso!!!"
	# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
	# opção do comando date: +%T (Time)
	HORAFINAL=$(date +%T)
	# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
	HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
	HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
	# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second), 
	TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
	# $0 (variável de ambiente do nome do comando)
	echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo -e "Pressione <Enter> para concluir o processo."
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" &>> $LOG
read
exit 1