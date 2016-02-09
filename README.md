# docker-gitlab-runner

This is a GitLab CI runner with `docker-compose` support.

> :information_sign: You need to link the socket file or specify `DOCKER_HOST` 

## Ressources

- [Image on DockerHub](https://hub.docker.com/r/schmunk42/gitlab-runner/)

## Requirements

- host-mounted Docker socket

### 4.1.x 

- `docker >= 1.10.0`

### 4.0.x 

- `docker >= 1.9.0`

### 1.0.0 - 3.0.0

- `docker >= 1.9.0`

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
      -v /home/gitlab-runner/config:/etc/gitlab-runner \
      -v /home/gitlab-runner/builds:/home/gitlab-runner/builds \
      schmunk42/gitlab-runner:<VERSION>

First time setup

    edit /home/gitlab-runner/config

Change `concurrent` setting.

## Usage

Obtain token from GitLab CI runners page, and `export` it.

Debug commands

    docker exec -it runner gitlab-runner verify

Start runner instances (TODO: check, if they run in parallel)

    docker exec -it runner gitlab-runner register --executor shell -u https://gitlab:443/ -r $CI_RUNNER_TOKEN -n

---

Built by [dmstr](http://diemeisterei.de)
