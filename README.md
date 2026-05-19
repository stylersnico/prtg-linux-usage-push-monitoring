# Linux usage monitoring with PRTG Push sensor
Monitoring Linux usage (CPU, Memory, Disk Usage, Uptime) with HTTP Push Data Advanced PRTG Sensor.

It's cheaper on the sensor cost.

## Tested on
- Debian 13
- Ubuntu 24.04.4 LTS
- Home Assistant OS 17.3

## Setup Debian

Create a **HTTP Push Data Advanced** sensor in your PRTG and grab the **Identification Token**.

Download the script:
```bash
mkdir -p /var/prtg/scriptsxml/
cd /var/prtg/scriptsxml/
wget https://raw.githubusercontent.com/stylersnico/prtg-linux-usage-push-monitoring/refs/heads/main/debian-usage.sh
```

Run it for testing after edditing the PRTG server IP and the Token:
```bash
chmod +x  /var/prtg/scriptsxml/debian-usage.sh
bash /var/prtg/scriptsxml/debian-usage.sh
```

Add it to your crontab:
```bash
* * * * * /var/prtg/scriptsxml/debian-usage.sh  > /dev/null 2>&1
```

## Setup Home Assistant OS

Create a **HTTP Push Data Advanced** sensor in your PRTG and grab the **Identification Token**.

Download the script:
```bash
mkdir -p /var/prtg/scriptsxml/
cd /var/prtg/scriptsxml/
wget https://raw.githubusercontent.com/stylersnico/prtg-linux-usage-push-monitoring/refs/heads/main/ha-usage.sh
```

Run it for testing after edditing the PRTG server IP and the Token:
```bash
chmod +x  /var/prtg/scriptsxml/ha-usage.sh
bash /var/prtg/scriptsxml/ha-usage.sh
```

Add it to your crontab:
```bash
* * * * * /var/prtg/scriptsxml/ha-usage.sh  > /dev/null 2>&1
```
