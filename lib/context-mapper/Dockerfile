ARG JDK_VERSION=21

from bellsoft/liberica-openjdk-debian:${JDK_VERSION} as build
ARG JDK_VERSION
ARG CONTEXT_MAPPER_VERSION
ADD https://repo1.maven.org/maven2/org/contextmapper/context-mapper-cli/${CONTEXT_MAPPER_VERSION}/context-mapper-cli-${CONTEXT_MAPPER_VERSION}.tar /context-mapper-cli-${CONTEXT_MAPPER_VERSION}.tar
RUN tar xvf /context-mapper-cli-${CONTEXT_MAPPER_VERSION}.tar

from bellsoft/liberica-openjdk-debian:${JDK_VERSION}
ARG JDK_VERSION
ARG CONTEXT_MAPPER_VERSION
RUN apt-get update && apt-get install graphviz -y
COPY --from=build /context-mapper-cli-${CONTEXT_MAPPER_VERSION}/ /usr/local/context-mapper-cli/
ENTRYPOINT ["/usr/local/context-mapper-cli/bin/cm"]
