Start elasticsearch
```
docker run -d --name=elasticsearch elasticsearch
```

Start suricata
```
docker run -d --name=suricata --net=host --cap-add=NET_ADMIN pandrew/suricata
```

Mount the logs for logstash to read
```
docker run -d --name=logstash --volumes-from=suricata --link=elasticsearch:elasticsearch  pandrew/suricata:logstash
```
