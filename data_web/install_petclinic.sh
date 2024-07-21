#!/bin/bash

git clone https://github.com/ghkim-dev/spring-petclinic.git
cd spring-petclinic
./mvnw package
nohup java -jar target/*.jar &
