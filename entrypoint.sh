#! /bin/sh

cd /home/container || exit 1;

if [[ -f "/home/container/index.js" ]]; then
  redis-server --daemonize yes
  node index.js
else
  echo "index.js not found. Proceed to install StatusMonitor-Server? (Y/N)";
  read proceed;

  case "$proceed" in
    "Y")
        echo "Installing StatusMonitor-Server...";

        git clone https://github.com/DottoXD/statusmonitor-server /home/container/temp
        mv /home/container/temp/** /home/container
        rm -rf /home/container/temp

        yarn install

        echo "Installation complete. Please edit src/config.json and restart the container. WARNING: DO NOT TOUCH THE PORT OR REDIS SETTINGS, THEY ARE SET SPECIFICALLY FOR THIS CONTAINER. ONLY TOUCH THE REDIS SETTINGS IF YOU ARE USING AN EXTERNAL DATABASE, OR USING AN OLD ONE.";
        exit 0;
        ;;
    "N")
        exit 0;
        ;;
    *)
        exit 1;
        ;;
    esac
fi