copy /Y %~dp0DockerfileLive %~dp0Dockerfile

docker build -t php-5.6-release .

docker tag php-5.6-release:latest 640373737790.dkr.ecr.us-east-1.amazonaws.com/php-5.6-release:latest

docker push 640373737790.dkr.ecr.us-east-1.amazonaws.com/php-5.6-release:latest

echo Push to Amazon Container Services finished.
