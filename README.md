# docker-gitlab-runner

This is a GitLab CI runner with `docker-compose` and *git-lfs* support.

## Resources

- Docker-Compose Runner ([Image](https://hub.docker.com/r/schmunk42/gitlab-runner/), [Source](https://github.com/schmunk42/docker-gitlab-runner))
- Base GitLab Runner ([Image](https://hub.docker.com/r/gitlab/gitlab-runner/), [Source](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner))

## Requirements

- host-mounted Docker socket 

**:warning: It is strongly recommended to run this *runner* on a separate Docker host VM.** For some more details why and why this is not using Docker-in-Docker, please read [this blog posting](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/).

### >= 4.1.0

- `docker >= 1.10.0`

### 4.0.x 

- `docker >= 1.9.0`

### 1.0.0 - 3.0.0

- `docker >= 1.9.0`

See also [CHANGELOG](CHANGELOG.md) for versions of `docker` and `docker-compose` on this image.

## Setup

Connect to your runner host

    docker-machine ssh ${RUNNER_HOST}

Get token from *CI runners page* (/admin/runners).

Set variables

    export CI_RUNNER_TOKEN=<ENTER-YOUR-TOKEN-HERE>

Start runner (only one)

    docker run -d \
        --name runner \
        --restart always \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /home/gitlab-runner/config:/etc/gitlab-runner \
        -v /home/gitlab-runner/builds:/home/gitlab-runner/builds \
        schmunk42/gitlab-runner:4.2.0-rc1

> :warning: It is very important to mount `/home/gitlab-runner` to the same path inside the runner container.

First time setup

    edit /home/gitlab-runner/config

Change `concurrent` setting.

## Usage

Obtain token from GitLab CI runners page, and `export` it.

Debug commands

    docker exec -it runner gitlab-runner verify

Start runner instances (TODO: check, if they run in parallel)

    docker exec -it runner gitlab-runner \
        register \
            --executor shell \
            -u https://my.gitlab.server:443/ci \
            -r ${RUNNER_TOKEN} \
            -n

## Building the image

    docker build --pull -t local/runner .

Check version of runner    
    
    docker run local/runner -v 

---

Built by [dmstr](http://diemeisterei.de)
