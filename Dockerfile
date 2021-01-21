# JRE base
FROM openjdk:11.0-jre-slim

# Environment variables
ENV MC_VERSION="latest" \
    PAPER_BUILD="latest" \
    MC_RAM="4G" \
    JAVA_OPTS=""

RUN groupadd --gid 1000 minecraft
RUN useradd --uid 1000 -g minecraft -m -s /bin/sh minecraft

RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y jq \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /minecraft \
    && chown -R minecraft:minecraft /minecraft

USER minecraft

WORKDIR /papermc

ADD papermc.sh .

# Start script
CMD ["sh", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /minecraft
