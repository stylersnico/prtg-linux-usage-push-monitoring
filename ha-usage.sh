#!/bin/bash

# PRTG configuration
PRTG_URL="http://PRTG_IP:5050/TOKEN?content="

# Get CPU usage (percentage)
cpu_usage=0

cpu_line=$(top -bn1 | grep "CPU" -m 1 | awk '{print $2}' | cut -d'%' -f1 | sed 's/[^0-9.]//g') 
if [ ! -z "$cpu_line" ]; then
    cpu_usage=$(printf "%.0f" "$cpu_line")
fi

# Get memory usage (percentage)
mem_usage=0
mem_line=$(free | grep Mem | awk '{printf "%.0f", ($3/$2)*100.0}')
if [ ! -z "$mem_line" ]; then
    mem_usage=$mem_line
fi

# Get uptime in seconds and convert to days
uptime_seconds=$(cat /proc/uptime | awk '{print int($1)}')
uptime_days=$((uptime_seconds / 86400))

# Get disk usage for root partition (percentage)
disk_usage=0
disk_line=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ ! -z "$disk_line" ]; then
    disk_usage=$disk_line
fi

# Build XML for PRTG with proper structure
PRTG_XML="<?xml version=\"1.0\" encoding=\"utf-8\" ?>
<prtg>
<result>
<channel>CPU Usage</channel>
<value>$cpu_usage</value>
<unit>Percent</unit>
<LimitMode>1</LimitMode>
<LimitMaxWarning>80</LimitMaxWarning>
<LimitMaxError>90</LimitMaxError>
</result>
<result>
<channel>Memory Usage</channel>
<value>$mem_usage</value>
<unit>Percent</unit>
<LimitMode>1</LimitMode>
<LimitMaxWarning>80</LimitMaxWarning>
<LimitMaxError>90</LimitMaxError>
</result>
<result>
<channel>Uptime</channel>
<value>$uptime_days</value>
<unit>Days</unit>
<LimitMode>1</LimitMode>
<LimitMaxWarning>30</LimitMaxWarning>
<LimitMaxError>45</LimitMaxError>
</result>
<result>
<channel>Disk Usage</channel>
<value>$disk_usage</value>
<unit>Percent</unit>
<LimitMode>1</LimitMode>
<LimitMaxWarning>80</LimitMaxWarning>
<LimitMaxError>90</LimitMaxError>
</result>
</prtg>"

# Send to PRTG
curl -s --data "$PRTG_XML" -H "Content-Type: text/xml" "$PRTG_URL"
