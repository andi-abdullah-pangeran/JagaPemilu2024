
run-apps:
	docker-compose -f ./analytics/docker-superset/docker-compose.yaml up -d

stop-apps:
	docker-compose -f ./analytics/docker-superset/docker-compose.yaml down

superset-build:
	docker build --platform linux/amd64 --progress=plain \
 		-f ./analytics/docker-superset/superset/Dockerfile \
 		--tag "superset:0.0.1" \
 		./analytics/docker-superset/superset/.

crawl-pilpres:
	benthos -c crawler_suara.yaml

crawl-pileg:
	benthos -c crawler_suara_pileg.yaml