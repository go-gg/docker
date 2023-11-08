FROM elastic/filebeat:8.11.0

USER root
RUN mkdir -p /usr/share/filebeat/module/golang/log/config
RUN mkdir -p /usr/share/filebeat/module/golang/log/ingest

COPY ./module/golang/log/config/log.yml /usr/share/filebeat/module/golang/log/config/log.yml
COPY ./module/golang/log/ingest/pipeline.json /usr/share/filebeat/module/golang/log/ingest/pipeline.json
COPY ./module/golang/log/manifest.yml /usr/share/filebeat/module/golang/log/manifest.yml
COPY ./modules.d/golang.yml /usr/share/filebeat/modules.d/golang.yml