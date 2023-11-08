SET tag=registry.cn-chengdu.aliyuncs.com/st-common/filebeat:8.11.0
docker build -t %tag% .
docker push %tag%

pause


