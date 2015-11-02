# docker-gitlab-runner

## Ressources

- [Image on DockerHub](https://hub.docker.com/r/schmunk42/gitlab-runner/)

## Setup

Connect to your runner host

    docker-machine ssh $RUNNER_HOST

Get token from *CI runners page* (/admin/runners).

Set variables

    export CI_RUNNER_TOKEN=508a8a6dcc9f3be6ba40

Start runner (only one)

    docker run -d \
      --name runner \
      --restart always \
      --privileged \
      -v `which docker`:/usr/bin/docker \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v /srv/gitlab-runner/config:/etc/gitlab-runner \
      -v /srv/gitlab-runner/builds:/root/builds \
      schmunk42/gitlab-runner:latest

First time setup

    edit /srv/gitlab-runner/config

Change `concurrent` setting.

## Usage

Debug commands

    docker exec -it runner gitlab-runner verify

Start runner instances (TODO: check, if they run in parallel)

    docker exec -it runner gitlab-runner register -e shell -u https://gitlab:443/ -r $CI_RUNNER_TOKEN -n
