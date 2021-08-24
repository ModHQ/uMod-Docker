FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine

LABEL "vendor.name"="ModHQ"
LABEL "vendor.url"="https://modhq.cc" 

RUN adduser -D -h /home/umod umod
RUN mkdir /umod;chown umod /umod



COPY scripts/umod-develop-light.ps1 /tmp/
RUN pwsh -NoProfile -ExecutionPolicy unrestricted -Command "/tmp/umod-develop-light.ps1"
RUN chown -Rf umod /usr/local/bin/.store/

USER umod
ENV HOME=/home/umod

WORKDIR /umod


ENTRYPOINT [ "umod" ]