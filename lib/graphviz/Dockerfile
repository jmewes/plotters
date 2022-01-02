FROM fedora:rawhide

RUN yum -y update && yum clean all
RUN yum -y install graphviz && yum clean all
RUN dot -V

WORKDIR /dot
