FROM yidigun/centos-java8:latest
MAINTAINER dklee@yidigun.com

ENV SCOUTER_VERSION 1.8.6

COPY . /
RUN mkdir -p /webapp/data /webapp/logs && \
    curl -jksSL https://github.com/scouter-project/scouter/releases/download/v${SCOUTER_VERSION}/scouter-min-${SCOUTER_VERSION}.tar.gz | \
    tar zxf - -C /webapp scouter/server && \
    ln -sf ../../../config/scouter.conf /webapp/scouter/server/conf/scouter.conf

EXPOSE 6100/tcp
EXPOSE 6100/udp

ENTRYPOINT ["/webapp/bin/bootstrap.sh"]
CMD ["start"]
