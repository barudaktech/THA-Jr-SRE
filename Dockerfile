FROM sonatype/nexus3:latest

USER root

ADD https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-blobstore-google-cloud/0.61.0/nexus-blobstore-google-cloud-0.61.0.kar \
    /opt/sonatype/nexus/deploy/nexus-blobstore-google-cloud.kar

RUN chown nexus:nexus /opt/sonatype/nexus/deploy/nexus-blobstore-google-cloud.kar

USER nexus
