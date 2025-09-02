#!/bin/bash
# server-stats.sh - Script thống kê hiệu năng cơ bản trên Ubuntu Server

echo "===== Server Performance Stats ====="

# CPU usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')  
echo "CPU Usage: $CPU %"

# Memory usage
echo "---- Memory ----"
free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'

# Disk usage
echo "---- Disk ----"
df -h --total | grep total | awk '{print "Used: "$3" / Total: "$2" ("$5" used)"}'

# Top 5 processes by CPU
echo "---- Top 5 Processes by CPU ----"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory
echo "---- Top 5 Processes by Memory ----"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# (Stretch goal)
echo "---- Extra Info ----"
echo "OS Version: $(lsb_release -d | cut -f2)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
echo "Logged in users:"
who

