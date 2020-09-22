SET tag=registry.cn-hangzhou.aliyuncs.com/ysny/filebeat:logv1
docker build -t %tag% .
docker push %tag%

pause


