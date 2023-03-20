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


#========MONGO GUI CLIENT=======

mongo-gui-setup: ## spin up Mondo DB Container
	docker run --network db-network -d -p 3000:3000 --name MongoGUI-Client mongoclient/mongoclient

mongo-gui-destroy: ## Destroy Mongo GUI Client Container
	docker rm -vf  MongoGUI-Client
#	docker network rm db-network