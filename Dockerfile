FROM alpine:3.7 as quorum-istanbul-builder

RUN \
    apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
    git clone https://github.com/jpmorganchase/quorum.git && \
    cd quorum && \
    git checkout tags/v2.2.1 && \
    make all && \
    go get github.com/getamis/istanbul-tools/cmd/istanbul

FROM maven:3.5.4-jdk-8 as tessera-builder

RUN \
    git clone https://github.com/jpmorganchase/tessera.git && \
    cd /tessera && mvn clean -Dmaven.repo.local=/tessera/.m2/repository -DskipTests package


FROM openjdk:8-jre-alpine

COPY --from=quorum-istanbul-builder /quorum/build/bin/geth /usr/local/bin
COPY --from=quorum-istanbul-builder /quorum/build/bin/bootnode /usr/local/bin
COPY --from=quorum-istanbul-builder /root/go/bin/istanbul /usr/local/bin
COPY --from=tessera-builder /tessera/tessera-app/target/*-app.jar /tessera/tessera-app.jar

# set tessera alias
RUN \
    apk add --update bash curl && rm -rf /var/cache/apk/* && \
    echo -e '#!/bin/sh \njava -jar /tessera/tessera-app.jar' > /usr/bin/tessera && \
    chmod +x /usr/bin/tessera 

CMD ["tessera", "help" ]
