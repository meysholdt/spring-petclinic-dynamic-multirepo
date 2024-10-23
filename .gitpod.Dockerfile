FROM gitpod/workspace-full

USER gitpod

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && \
     sdk install java 21.0.4.fx-zulu  && \
     sdk default java 21.0.4.fx-zulu "