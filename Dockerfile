FROM debian:stable

RUN apt-get update && apt-get -y install git
ADD git /usr/local/bin/git
