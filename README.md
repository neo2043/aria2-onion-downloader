# aria2-oniondl

Ever tried to download for example leaks from the onion network which have multiple parts with multiple GBs for each file and it took days? Look no further and behold ;)

This repo contains an docker-compose-file which will spawn an aria2ng webinterface as well as an downloaer, which creates up to 99 tor-services and allows to load-balance downloads between these via an local nginx instance. This means you can download at an really high speed, since Aria2 fragments the downloads by default to 10 connections, which get load-balanced to Tor-Services. This means you can reach up to 10th time the speed in an single download and an even higher speed when you download multiple parts in parallel!

![2021-04-12_Aria2](https://user-images.githubusercontent.com/1722036/114446811-f3760400-9bd1-11eb-9bef-7a17d077326b.PNG)

## Usage
First, always change the RPCSECRET in `docker-compose.yml`.

Afterwards you can run `docker-compose up`, which will start 2 containers, an controller and an downloader with ports bound to localhost. 6800 is the RPC-Port of the downloader, 7070 is the Web-UI. If you want to expose these ports to the internet, just change the port assignment in the `docker-compose.yml` but again, make sure you changed the secret first!

When you open the Web-UI via `http://localhost:7070`, you should first navigate to `AriaNg Settings`, afterwards click on the tab RPC and adjust the RPCSECRET to the one in the docker-compose-file. Afterwards you can add downloads. After adding if the downloads don't start at once, please give them some seconds to start :)

Your downloads will be in `./downloader/data/`.

## Why keep two containers
Yeah, the web-ui could be easily integrated into the downloader-instance. This way you would save some resources BUT in the layout it is right now, you could simply spawn multiple downloader simply by copying the corresponding lines in the docker-compose-file and adding them as RPCs in aria2, resulting in even higher download rates. If you want to integrate the web-ui in the downloader, simply copy the www-dir from the controller to downloader, add the folder in the docker-compose, and add the lines from the nginx.conf of the controller to the downloader.

## Credits
- https://github.com/sn0b4ll/aria2-onion-downloader