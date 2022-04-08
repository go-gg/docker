SET tag=registry.cn-hangzhou.aliyuncs.com/ysny/filebeat:7.17.2
docker build -t %tag% .
docker push %tag%

pause


