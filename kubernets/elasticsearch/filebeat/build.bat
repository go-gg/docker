SET tag=registry.cn-hangzhou.aliyuncs.com/eioos/filebeat:7.17.8
docker build -t %tag% .
docker push %tag%

pause


