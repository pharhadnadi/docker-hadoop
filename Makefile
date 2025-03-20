DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := 3.2.4 #$(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t pharhadnadi/hadoop-base:$(current_branch) ./base
	docker build -t pharhadnadi/hadoop-namenode:$(current_branch) ./namenode
	docker build -t pharhadnadi/hadoop-datanode:$(current_branch) ./datanode
	docker build -t pharhadnadi/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t pharhadnadi/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t pharhadnadi/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t pharhadnadi/hadoop-submit:$(current_branch) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} pharhadnadi/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} pharhadnadi/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.4/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} pharhadnadi/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} pharhadnadi/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} pharhadnadi/hadoop-base:$(current_branch) hdfs dfs -rm -r /input
