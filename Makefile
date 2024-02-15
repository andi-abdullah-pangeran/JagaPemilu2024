
run-analytics:
	docker-compose -f ./analytics/docker/docker-compose.yaml up -d

stop-analytics:
	docker-compose -f ./analytics/docker/docker-compose.yaml down