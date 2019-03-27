FROM openjdk:11-jre-slim

WORKDIR /opt

RUN mkdir /data
RUN groupadd -g 2000 kafka
RUN useradd -MN -g kafka -u 2000 -s /bin/false kafka
RUN chown kafka:kafka /data

RUN apt-get update && apt-get install -y wget libconfig-properties-perl
RUN wget http://apache.cs.utah.edu/kafka/2.2.0/kafka_2.12-2.2.0.tgz
RUN mkdir kafka && tar xzf *.tgz -C kafka --strip-component 1
RUN rm *.tgz
RUN apt-get remove -y wget && apt-get autoremove -y && rm -r /var/lib/apt/lists/*

COPY config.pl /opt/kafka
COPY start.sh /opt/kafka
RUN chown -R kafka:kafka /opt/kafka
RUN chmod ug+x /opt/kafka/start.sh

WORKDIR /opt/kafka
USER kafka
CMD ["/opt/kafka/start.sh"]
