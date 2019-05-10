If you test dns, you should edit /etc/resolv.conf.
And you can use dig domain

When use docker network, you should build your own network like:
docker network create --subnet=172.18.0.0/16 mynetwork
