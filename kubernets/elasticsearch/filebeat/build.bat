SET tag=registry.cn-hangzhou.aliyuncs.com/ysny/filebeat:7.15.1
docker build -t %tag% .
docker push %tag%

pause


