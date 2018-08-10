
## Run

```
docker run -d \
  --restart unless-stopped \
  --name scouter-server \
  --hostname scouter-server \
  -p 6100:6100/tcp \
  -p 6100:6100/udp \
  -v /path/to/datadir:/webapp/data \
  -v /path/to/logdir:/webapp/logs \
  yidigun/scouter-server:latest
```

## Build

```
docker build -t yidigun/scouter-server .
```
