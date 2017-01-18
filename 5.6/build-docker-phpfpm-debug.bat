copy /Y %~dp0DockerfileDebug %~dp0Dockerfile

docker build -t php-5.6-debug .

docker tag php-5.6-debug:latest 640373737790.dkr.ecr.us-east-1.amazonaws.com/php-5.6-debug:latest

docker push 640373737790.dkr.ecr.us-east-1.amazonaws.com/php-5.6-debug:latest

echo Push to Amazon Container Services finished.
