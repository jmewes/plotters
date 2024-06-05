# contextmapper

## Building the image

```sh
CONTEXT_MAPPER_VERSION=6.11.1 # https://github.com/ContextMapper/context-mapper-cli/tags
docker build --build-arg CONTEXT_MAPPER_VERSION=${CONTEXT_MAPPER_VERSION} -t experimentalsoftware/context-mapper .
docker tag experimentalsoftware/context-mapper:latest experimentalsoftware/context-mapper:${CONTEXT_MAPPER_VERSION}
```

```
docker push experimentalsoftware/context-mapper:latest
docker push experimentalsoftware/context-mapper:${CONTEXT_MAPPER_VERSION}
```

## References

- https://hub.docker.com/r/bellsoft/liberica-openjdk-debian
- https://hub.docker.com/repository/docker/experimentalsoftware/context-mapper/general
- https://hub.docker.com/r/jlesage/baseimage-gui

## References

- https://github.com/ContextMapper/context-mapper-cli
