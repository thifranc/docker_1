FROM debian:latest

RUN apt-get update ; apt-get upgrade ; apt-get -y install wget bzip2

RUN wget http://dl.4players.de/ts/releases/3.0.13.8/teamspeak3-server_linux_amd64-3.0.13.8.tar.bz2
RUN bzip2 -dk teamspeak3-server_linux_amd64-3.0.13.8.tar.bz2
RUN tar -xvf teamspeak3-server_linux_amd64-3.0.13.8.tar

RUN mv teamspeak3-server_linux_amd64 teamspeak3

WORKDIR ./teamspeak3

EXPOSE 9987

CMD ["sh", "./ts3server_minimal_runscript.sh"]
