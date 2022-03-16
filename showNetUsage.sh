# NOTE: you need to install notify-send package for showing notification to you and also vnstat for calculating network trafic

# for installing vnstat use this link -> https://www.cyberciti.biz/faq/ubuntu-install-vnstat-console-network-traffic-monitor/

# for Installing notify-send use this link -> https://command-not-found.com/notify-send
message=$(vnstat -h | cut -f3 -d "|" | grep "B")
notify-send -t 4000 -i "dialog-information" "Your net usage in last hour is: $message"
