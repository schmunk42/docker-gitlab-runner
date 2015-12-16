FROM gitlab/gitlab-runner:latest

RUN apt-get update && \
    apt-get -y install \
            make \
            rsync \
            curl \
            nano \
            sshpass \
        --no-install-recommends && \
    rm -r /var/lib/apt/lists/* # 150901

RUN curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

ENV TERM=linux

RUN git config --global user.email "ci-runner@example.com" && \
    git config --global user.name "CI Runner"

CMD ["run", "--user=root", "--working-directory=/home/gitlab-runner"]
