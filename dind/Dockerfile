FROM git/dind:latest

RUN apt-get update && \
    apt-get -y install \
            make \
            rsync \
            curl \
            nano \
        --no-install-recommends && \
    rm -r /var/lib/apt/lists/* # 150901

ENV TERM=linux