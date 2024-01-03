# bpmn-to-image

## Usage

```sh
docker run --rm -v ${PWD}/t:/app experimentalsoftware/bpmn-to-image \
  bpmn-to-image hello-world.bpmn:hello-world.png --no-footer
```

## Maintenance

```sh
# Build image
gradle build

# Publish image
docker login
gradle publish
```

## References

- https://github.com/bpmn-io/bpmn-to-image
- https://www.npmjs.com/package/bpmn-to-image
- https://github.com/buildkite/docker-puppeteer
