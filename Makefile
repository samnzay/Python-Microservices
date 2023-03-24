.PHONY: help mysql-setup


help: ## Print help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)



#==========MySQL==============
mysql-setup: ## Setup mysql Database
#	docker network create python-microservices-network
	docker run --network python-microservices-network -d -v ~/.db-data/mysql:/var/lib/mysql --name mysql-db -p 3307:3306 -e MYSQL_ROOT_PASSWORD=secret mysql
	
mysql-execute:
	docker run --network python-microservices-network -it --rm mysql mysql -hmysql-db -uroot -psecret 
#   docker exec -i mysql-db bash < src/auth/init.sql
#	mysql -u root -psecret

mysql-start: ## Start the MySQL DB Container
	docker start mysql-db

mysql-stop: ## Start the MySQL DB Container without Destroying it.
	docker stop mysql-db
	
mysql-destroy:
	docker rm -vf mysql-db
#	docker network rm db-network


#==========MONGO DB============

mongo-setup: ## spin up Mondo DB
	docker run --network python-microservices-network -d ~/.db-data/mongo:/data/db -p 27017:27017 --name mongo-db mongo:6

mongo-shell: ## MongoShell for terminal interaction with Mongo DB
	docker exec -it mongo-db mongosh

mongo-destroy: ##Destroy Mondo DB Container
	docker rm -vf mongo-db
#	docker network rm db-network

mongo-start: ## Start the MySQL DB Container
	docker start mongo-db

mongo-stop: ## Start the MySQL DB Container without Destroying it.
	docker stop mongo-db


#========MONGO GUI CLIENT=======

mongo-gui-setup: ## spin up Mondo DB Container
	docker run --network db-network -d -p 3000:3000 --name MongoGUI-Client mongoclient/mongoclient

mongo-gui-destroy: ## Destroy Mongo GUI Client Container
	docker rm -vf  MongoGUI-Client
#	docker network rm db-network


##======AUTHENTICATION SERVICE======

auth-build: ## Build "auth" service as docker image
	docker build --tag auth-service:v1.0.4 -f src/auth/Dockerfile .

auth-tag: ## Tag "auth" service to push into DockerHub
	docker tag auth-service:v1.0.4 samnzay/auth-service:v1.0.4

auth-push: ## Push auth-service image to image repository. eg: DockerHub
	docker push samnzay/auth-service:v1.0.4

auth-deploy: ## Deploy Auth service into kubernetes cluster. Local Minikube cluster in our case.
	kubectl apply -f ./src/auth/manifests/

auth-destroy: ## Delete Auth service resources into kubernetes cluster. Local Minikube cluster in our case.
	kubectl delete -f ./src/auth/manifests/

#=======GatewayAPI Service=======

	
gateway-freeze: ## Export app dependencies to requirements file
	pip3 freeze > src/gateway/requirements.txt 

gateway-build: ## Build "gateway" service as docker image
	docker build --tag gateway-service:v1.0.1 -f src/gateway/Dockerfile .

gateway-tag: ## Tag "gateway" service to push into DockerHub
	docker tag gateway-service:v1.0.1 samnzay/gateway-service:v1.0.1

gateway-push: ## Push gateway-service image to image repository. eg: DockerHub
	docker push samnzay/gateway-service:v1.0.1

gateway-deploy: ## Deploy Gateway service into kubernetes cluster. Local Minikube cluster in our case.
	kubectl apply -f ./src/gateway/manifests/

gateway-destroy: ## Delete Gateway service resources into kubernetes cluster. Local Minikube cluster in our case.
	kubectl delete -f ./src/gateway/manifests/

#=======Rabbitmq Service=======

rabbitmq-deploy: ## Deploy Auth service into kubernetes cluster. Local Minikube cluster in our case.
	kubectl apply -f ./src/rabbitmq/manifests/

rabbitmq-destroy: ## Delete all Auth service resources into kubernetes cluster. Local Minikube cluster in our case.
	kubectl delete -f ./src/rabbitmq/manifests/

rabbitmq-pvc: ## Describe Persistent Volume Claim
	kubectl describe pvc





#========K9s INSTALL=============
k9s:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/h2s/.bashrc

	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

	brew doctor

#===========================