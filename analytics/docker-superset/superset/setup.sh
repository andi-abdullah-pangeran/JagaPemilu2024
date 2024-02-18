#!/bin/bash -x

superset fab create-admin --username "$SUPERSET_INIT_ADMIN_USERNAME" --firstname Superset --lastname Admin --email "$SUPERSET_INIT_ADMIN_EMAIL" --password "$SUPERSET_INIT_ADMIN_PASSWORD"

superset db upgrade

tee /data/clickhouse-datasource.yaml << END
databases:
- database_name: Clickhouse
  expose_in_sqllab: true
  sqlalchemy_uri: $CLICKHOUSE_DATASOURCE_URI
END

superset import-datasources -p /data/clickhouse-datasource.yaml

superset superset init

/bin/sh -c /usr/bin/run-server.sh