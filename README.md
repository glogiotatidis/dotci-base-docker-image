DotCI Base Test Runner
----------------------

[DotCI](https://github.com/groupon/DotCi) can be configured to use
Dockerfiles. In this case it uses the docker image defined in
`.ci.yml:image` to `git clone` the project and run `docker build`
against its Dockerfile.

This is a basic debian image that provides `git` so DotCI can run `git
clone`.

It also provides a wrapper around `docker` command, that executes the
original `docker` with all the parameters given except that when the
docker command is `build`, it sets the datetime of all files in
current `.` directory to a predefined datetime. It also adds
`/app/.git` directory to `.dockerignore` so it's not send as part of
the context to the Docker daemon.

This is needed to take advantage of docker caching
mechanism. Otherwise because DotCI runs `git clone` on every test run,
`/app/*` files have different datetimes on each run of the
tests. Docker includes in the context both files and mtime of the
files and therefore the Docker daemon believes that the context is
always new and does not use the cached images.

An automated build of this repository can be found in
[Docker Registry](https://registry.hub.docker.com/u/giorgos/dotci-base-docker-image/).

An example project that uses DotCI with Dockerfile build and this base
test runner can be found in
[glogiotatidis/dotci-reference-dockerfile](https://github.com/glogiotatidis/dotci-reference-dockerfile).
