docker run
-v ./redis.conf:/etc/redis/redis.conf
-v ./data:/data
--name redis -d redis redis-server /etc/redis/redis.conf