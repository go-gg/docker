docker run
-v E:/development/docker/redis/redis.conf:/etc/redis/redis.conf
-v E:/development/docker/redis/data:/redisData
 --name myredis -d redis redis-server /etc/redis/redis.conf