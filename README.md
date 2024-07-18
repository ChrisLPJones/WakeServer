# WakeServer Script for ASUS Merlin Router

This Bash script monitors the status of a server and wakes it up using Wake-on-LAN (WoL). 
It's designed for ASUS routers running Merlin firmware, but can be adapted for any router supporting similar functions.

## How It Works

The script runs an infinite loop to continuously monitor the server's status by pinging its IP address. If the server is detected as offline (no packets received), it checks if the client is online (one packet received). If the client is online, it logs the event and sends a Wake-on-LAN packet to wake up the server.

## Logging

The script logs events to `/jffs/scripts/server.log` with timestamps, recording server wake-up events triggered by the client.

## Prerequisites

- This script requires `etherwake` to be install on the router to send Wake-on-LAN packets. Install it using:
  ```bash
  opkg install etherwake
  ```
- Ensure that your server has Wake-on-LAN (WoL) enabled in BIOS and in your network settings 
## Installation

2. **Navigate to the Scripts Directory:**
   - Change directory to where your scripts are stored and add wakeserver.sh. For example:
     ```bash
     cd /jffs/scripts
     nano wakeserver.sh
     ```
   - Paste the content of wakeserver.sh.

## Configuration

Configure the following variables in the script itself:

```bash
clientName="Windows PC"              # Name of the client computer
clientIP="0.0.0.0"                   # IP address of the client computer
serverIP="0.0.0.0"                   # IP address of the server
routerNetworkInterface="eth0"        # Network interface name of the router
serverMacAddress="00:00:00:00:00:00" # MAC address of the server
```


## Adding the Script to Auto-Run on ASUS Merlin Router via CLI

To automatically run this script on your ASUS router with Merlin firmware using CLI:

4. **Create or Edit a Startup Script:**
   - Create a new script file or edit an existing one using your preferred text editor (e.g., `vi`, `nano`). For example:
     ```bash
     nano /jffs/scripts/services-start
     ```

5. **Add Script:**
   - Add wakeserver.sh to the services-start script. Ensure it includes the full path to your main script (`wakeserver.sh`). For example:
     ```bash
     #!/bin/sh

     /jffs/scripts/wakeserver.sh
     ```

6. **Save and Make Files Executable:**
   - Save the file and make it executable:
     ```bash
     chmod +x services-start
     chmod +x wakeserver.sh
     ```

7. **Reboot Your Router:**
   - Reboot your router to apply the changes and start running the watchdog script automatically.

## Notes

- Adjust the sleep durations (`sleep 10` and `sleep 100`) in the script as needed to avoid continuous rapid execution and to ensure proper operation based on your network environment.
- Ensure your router's firewall settings allow Wake-on-LAN (WoL) packets to reach your server.