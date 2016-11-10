
REM Build the image with new source code
docker build -t alphadoggames/phpfpm-5.6 .

REM Upload to Docker Hub
docker push alphadoggames/phpfpm-5.6
