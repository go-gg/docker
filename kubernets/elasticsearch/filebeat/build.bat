SET tag=registry.cn-hangzhou.aliyuncs.com/ysny/filebeat:7.9.3
docker build -t %tag% .
docker push %tag%

pause


