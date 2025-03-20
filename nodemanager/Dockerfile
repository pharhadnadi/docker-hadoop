FROM pharhadnadi/hadoop-base:3.2.4

LABEL "MAINTAINER"="Farhad Nadi<farhad.nadi@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1


ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]
