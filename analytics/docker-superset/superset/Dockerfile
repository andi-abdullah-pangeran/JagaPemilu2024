FROM apache/superset

USER root
COPY setup.sh /app/custom-setup.sh
RUN chmod +x /app/custom-setup.sh

RUN mkdir /data && chown -R superset:superset /data

RUN pip --no-cache --no-cache-dir install clickhouse-connect

USER superset

COPY config.py /app/custom_config.py
ENV SUPERSET_CONFIG_PATH /app/custom_config.py
ENV SQLALCHEMY_DATABASE_URI="sqlite:////data/superset.db"

ENTRYPOINT [ "/app/custom-setup.sh" ]