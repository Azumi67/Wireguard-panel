<div align="center" style="font-family: Arial, sans-serif; font-size: 18px; font-weight: bold; border: 2px solid #ccc; border-radius: 10px; padding: 15px; background-color: #f9f9f9; display: inline-block; line-height: 1.2;">

🌐 Please select your preferred language

<br>

<a href="https://github.com/Azumi67/Wireguard-panel/blob/main/README-en.md" style="font-size: 16px; font-weight: bold; text-decoration: none; color: #0078d7;">English</a>
<span style="font-size: 16px; color: #555;">•</span>
<a href="https://github.com/Azumi67/Wireguard-panel/blob/main/README.md" style="font-size: 16px; font-weight: bold; text-decoration: none; color: #0078d7;">Persian</a>

</div>

------------------------
![R (2)](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/a064577c-9302-4f43-b3bf-3d4f84245a6f)
Project name : Wireguard panel with English & Persian management bot
---------------------------------------------------------------
----------------------------------

**This project does not use Xray, and all tasks are handled by Wireguard itself. Xray was added for WARP, but since we are using Wireguard itself, WARP and Xray cannot be used. The only WARP I can add is WARP WGCF and Plus.**

**For users, a template to view their configuration has been added. In the bot, after generating the configuration, the short link is displayed as part of the "Download Configuration" or "QR" section. The short link for the configuration is also displayed in the panel.**

**The issue of the database being wiped due to overwriting with the addition of several locks seems to have been resolved (always make backups regularly).**

**Always read the update section and proceed with updating the panel. You can do this through the script link and option 1.**

**This project is educational, and its use is at your own risk. If any issues arise, please do not be upset. Test it first and use it if necessary.**

--------

 <div align="left">
  <details>
    <summary><strong><img src="https://github.com/user-attachments/assets/bf3c8113-cdd1-4c57-a744-796d7530d565" alt="Image"> Timezone problems (read)</strong></summary>

------------------------------------ 

- If, after installing an Optimizer or making system changes, the panel stops updating **time/traffic calculations** (or updates incorrectly), a common cause is a **timezone mismatch** or **system clock not being synchronized via NTP**.
- To work correctly, the system timezone must be consistent and stable. If `/etc/timezone` exists, it should not contradict `/etc/localtime`.

  
```
timedatectl
cat /etc/timezone 2>/dev/null || true
readlink -f /etc/localtime
date
**Set the correct timezone**
First, find the timezone name (example: Berlin):
timedatectl list-timezones | grep -i berlin

Then set it:
sudo timedatectl set-timezone Europe/Berlin
sudo timedatectl set-ntp true

If you are on Debian/Ubuntu, you can also reconfigure tzdata to ensure everything is aligned:
sudo dpkg-reconfigure -f noninteractive tzdata

Confirm the timezone and localtime now match:
timedatectl
cat /etc/timezone 2>/dev/null || true
readlink -f /etc/localtime
date

Note: If /etc/timezone exists, it should contain a single timezone (one line), and /etc/localtime should point to the same zoneinfo path.

Restart the panel services
sudo systemctl restart wireguard-panel
sudo systemctl restart telegram-bot-en.service 
sudo systemctl restart telegram-bot-fa.service 

```

------------------------------------ 

  </details>
</div>
 <div align="left">
  <details>
    <summary><strong><img src="https://github.com/user-attachments/assets/0ddf06f0-04c1-4d5a-bbb8-d784015e93d2" alt="Image"> Possible problems (read)</strong></summary>

------------------------------------ 

  - If your server has DNS issues, first resolve those or use a server and OS that do not have such issues. You can even remove the DNS settings from the Wireguard configuration.
  - It is recommended to use Debian 12. I didn't have any issues on Debian 12 and AMD.
  - Do not create two users with the same name on the same interface.
  - Always check the logs if you encounter any issues, or change the debug option in `config.yaml` to true.
  - If your service stops working after a reset, the issue is likely with the virtual environment. The `venv` folder is located in `/usr/local/bin/Wireguard-panel/src`. Fix the issue there.
  - If you are using an OS that has issues with `iproute` and `wireguard-tools`, make sure those issues are resolved. This panel uses the main command paths located in `/sbin`. Below are some examples. If this becomes too troublesome, let me know, and I can remove the main path to fix the issue. However, this shouldn't cause problems on most OS.
  - For now, I have removed the main command paths, and this will be reviewed in Bandit to see what happens later.
  - You should note that I have not tested the panel on mobile devices. You may encounter issues, so it is recommended to connect using a computer or use the bot on mobile.
  - Start your WireGuard configuration from `wg0.conf` and avoid using random names.
  - Don’t forget your username and password, and make sure to use the "Remember Me" option.
  - Be sure to check your installed OS for such issues, as the panel will not work if those problems exist.
  - If others wish, they can test other OS versions and add them to the panel.
  - The panel will not cause interference with your tunnel. Use local IPs along with the tunnel. Make sure to clear the cache and data storage on your mobile client, as the tunnel may not work in such cases.
  - Use local IPs if there are restrictions on your server. For example, Geneve - Local Script Link: https://github.com/Azumi67/6TO4-GRE-IPIP-SIT
  - After updating the panel, always reset the panel. The update process is to run the script with option 10, or download the script and execute it on the server with option 1. After the update finishes, please reset both the panel and the bot.
  

------------------------------------ 

  </details>
</div>

 <div align="left">
  <details>
    <summary><strong><img src="https://github.com/user-attachments/assets/0ddf06f0-04c1-4d5a-bbb8-d784015e93d2" alt="Image"> DNS Issues (read)</strong></summary>

------------------------------------ 

- If your server has DNS issues, both the panel's performance will degrade and the bot will stop working. I have removed the DNS section from the script.
- If your server has DNS issues, you can use an optimizer.
- On Debian 12 and Ubuntu 24 servers, you can use the following commands:

<div align="left">
  
```
sudo nano /etc/systemd/resolved.conf
## add these inside it##
[Resolve]
DNS=1.1.1.1 8.8.8.8
FallbackDNS=1.0.0.1 8.8.4.4
### now Ctrl + x , y to save ###

sudo systemctl restart systemd-resolved
sudo rm /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
cat /etc/resolv.conf

```
- If your /etc/resolv.conf configuration is reset every few minutes, you can use a cron job to handle this.

```
crontab -e
* * * * * echo -e "nameserver 1.1.1.1\nnameserver 1.0.0.1" > /etc/resolv.conf

```

- If your issue is not resolved even after using the optimizer, clearing WireGuard's DNS, using systemd-resolve, and setting up a cron job, you should consider changing your server. Preferably, use Debian 12 AMD.
- I haven’t encountered any issues on the DigitalOcean servers I’ve tested so far.


------------------------------------ 

</details>
</div>

 <div align="left">
  <details>
    <summary><strong><img src="https://github.com/user-attachments/assets/79ca8970-1e05-4e60-bc7c-aa12f3573bbc" alt="Image"> how to set a manual template</strong></summary>

------------------------------------ 
- In the Peers section, there is a default template. You can use your own custom template.
- Create a template with dimensions of 430 by 500 and place it in the directory `/usr/local/bin/Wireguard-panel/src/static/images` with the name `template.jpg`.
- Reset the panel. From now on, your custom template will be displayed.

------------------------------------ 

</details>
</div>

 <div align="left">
  <details>
    <summary><strong><img src="https://github.com/user-attachments/assets/dbbc44c0-06c0-405d-80f8-fb8c3a79a874" alt="Image"> how to debug and report</strong></summary>

------------------------------------ 

- If you had a problem, you can use these commands to find them and report or fix it by yourself.
  
```
systemctl status wireguard-panel
systemctl stop wireguard-panel
---------------------------------------
## change debug=false >> debug=true

nano /usr/local/bin/Wireguard-panel/src/config.yaml
/usr/local/bin/Wireguard-panel/src/venv/bin/python3 /usr/local/bin/Wireguard-panel/src/app.py
```
  
- for bot, it is the same
  
```
systemctl status telegram-bot-en
systemctl stop telegram-bot-en
/usr/local/bin/Wireguard-panel/src/venv/bin/python /usr/local/bin/Wireguard-panel/src/telegram/robot.py

```
 
- after the problem is fixed, just reset the wireguard panel

---------------

</details>
</div>


 <div align="left">
  <details>
    <summary><strong><img src="https://github.com/user-attachments/assets/1bd45cc6-b800-40b1-a94d-03ed1dac6ce5" alt="Image"> Tunnel</strong></summary>

------------------------------------ 
- I personally use a local IP with my own port forwarding program (for personal use): https://github.com/Azumi67/proxyforwarder
- You can use local IP and dokodemo as well.
- Port forwarding might not be useful for your case. Therefore, you can use reverse proxies like frp, backhaul, or even tunnels like udp2raw and Chisel.
- For local IP, you can use this script: https://github.com/Azumi67/6TO4-GRE-IPIP-SIT
- If you still face issues, you should do a few things. Test the tunnel with the optimizer and also keep an eye on the ufw firewall.
- Be aware that sometimes the WireGuard client on your computer or mobile can cause 92B to get stuck. Restart your computer and clear the date storage and cache on your mobile.
- If you still have issues, you should change your external server. After that, your problem should be solved.
- Most of the WireGuard tunnel issues are summarized in these points.



</details>
</div>
<div align="left">
  <details>
    <summary><strong><img src="https://github.com/user-attachments/assets/5ca10d06-15c9-45b6-99d0-498bf4e80c9c" alt="Image"> How to backup</strong></summary>

------------------------------------ 
- Create a manual backup from the panel or bot. This will be saved as manualbackup.zip in the backups folder.
- This file backs up the contents of the wg interface and the database.
- If you install the panel again, place this file in the backups folder and restore it using the bot or the panel. There is an option with this name in both the panel and the bot.
- Another method for restoring user backups is to open this zip file and copy the contents of wg0.conf or wg1.conf into the /etc/wireguard folder, and the db folder into /usr/local/bin/Wireguard-panel/src/db.
- Alternatively, you can copy the entire panel to your computer. It’s better to test these methods beforehand so you are familiar with how they work.
- After restoring the backup, you must restart the panel service (wireguard-panel) and the bot. All interfaces must also be disabled and re-enabled once.
- Make backups reguraly.



</details>
</div>

-------------------

**Other stuff i need to describe**

- This panel has been fully tested by me and is working properly. If you encounter any installation issues, please report them on GitHub after reading the reporting guidelines.
- If you have a bug fix request or want a feature added, please mention it in the Issues section so I can try to resolve the issue or add the feature if possible.
- For the short link, after copying it, wait a moment until you receive the confirmation message that the link has been copied.
- Do not create users with the same name in the panel as they are not separated in the backend. Pay attention to this matter.
- Ensure that before installing the panel, there are no DNS or timezone issues and that the server has been rebuilt. If there is a DNS issue, your server might be slow in fetching data, and the bot will also encounter problems. Check your operating system (please review the instructions above).
- This panel uses JSON for traffic and monitoring limits.
- This panel allows the backup files to be moved from one server to another (please read the instructions above).
- In this panel, I have made efforts to use sanitization and the original command paths to prevent shell injection as much as possible.
- Currently, the original command paths have been removed, but they may be re-added later.
- Sanitization before using subprocess will be reviewed later to reduce Bandit errors.
- Please note that in order for the panel and features like traffic and time limits to work properly, the wireguard-panel service should always be functioning without any issues. It’s recommended to periodically check the service. If the bot is installed, you will be notified if the service is down.



----------------------------------

![check](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/13de8d36-dcfe-498b-9d99-440049c0cf14)
**Features**

- Traffic management in MiB, GiB
- Time management in days, months, hours, and minutes
- Display of available IPs based on your selected private IP (shows only up to 30 IPs at a time in the panel)
- Use of JSON files for backup, management, and monitoring
- Support for both automatic and manual backups, as well as restoring them
- Display of WireGuard interfaces and users
- Display of CPU, disk, and RAM usage on the main page
- Supports both Persian and English languages with a single installation
- Includes installation script
- Includes an admin bot for user creation, editing, backup management, and other tasks in both English and Persian (installed from the panel)
- Basic WARP support via wgcf and xray (added experimentally)
- Ability to modify WireGuard and Flask settings from within the panel
- TLS support via Certbot
- Default template display for users with QR code and config download
- Reset traffic and time with active/inactive buttons
- Pagination with 10 users per page
- Display logs, server IPs, bot service, WARP, and more
- Display of program notifications in the admin bot
- Time calculation after the first connection
- Bot support for multiple admin chat IDs
- Support for endpoint using subdomains and IPs
- User config view via short link (refer to the screenshot for the template view)
- Ability to create users in bulk both in the panel and via the bot
- Ability to view short links in the panel and bot


-------
  <div align="left">
  <details>
    <summary><strong><img src="https://github.com/Azumi67/Rathole_reverseTunnel/assets/119934376/3cfd920d-30da-4085-8234-1eec16a67460" alt="Image"> Update notes</strong></summary>
  
------------------------------------ 

- The Persian and English bots have been updated to support compact mode menus.
- The update script has been modified to trigger with the `wire` command.
- Updated `app.py` for redirecting the registration page to login if a username and password exist (thanks to opiran for mentioning this).
- Updated `script-fa.js` to fix the issue of refreshing the peer list when filters are active.
- The issue with the panel not loading due to the addition of the `pytz` module has been fixed.
- The main command paths have been removed temporarily, and this topic is considered for review in Bandit to see how it evolves.
- The update script now supports panel updates via either `download.sh` or `wire` (added experimentally).
- For the bot: Only the admin chat ID will have access to the bot.
- For the bot: Peer creation information has been made more complete, with `mtu` added.
- For the bot: The "first usage" section calculates time after the first connection.
- For the bot: Fixed the `mtu` issue in the settings.
- The update now supports multiple admin chat IDs. Use commas, like `674565756, 6545675`.
- The update adds support for subdomains instead of using an IP.
- The `telegram.yaml` file has been updated for encryption.
- An update has been added for disabling/enabling notifications based on the health status of `app.py`.
- Pagination has been updated to avoid returning to the first page.
- The issue with the Persian bot disappearing has been fixed.
- The `keepalive` feature has been added to the bot.
- The update for available IPs in the bot now works correctly, showing available IPs.
- Timezone update has been implemented in `app.py`.
- The issue with deleting peers from the main page has been fixed.
- `app.py` has been updated to monitor traffic so that usage doesn’t reset after server reboot.
- Mismatches in the JSON file have been fixed.
- The issue with resetting and not editing interfaces other than the default has been resolved.
- The bot now includes additional information for downloading config files and QR codes.
- The script update ensures that your templates won't be overwritten. Update via the script inside GitHub (make sure to reset the panel and bot after updating).
- The bot now correctly resets traffic and usage.
- The bot will display the contents of the `conf` file underneath it.
- Temporarily added `tmp` before saving to the JSON files and locked the monitor and decrement functions to see if this resolves the issue of JSON files being deleted.
- An update has been added to prevent showing users from an interface when pagination is used.
- A checkbox has been added for activation when `geosites` are present.
- A lock has been added to all paths that write the JSON file to ensure the proper sequence of commands (may take time due to the lock).
- The update for blocking users after expiration now works correctly.
- The config view template for users has been added. After creating the config in the bot, the short link to the config will be visible in the config download or QR section. It will be shown separately in both.
- Fixed issues with short links and the time not displaying correctly in the template.
- Fixed the issue with user display limits.
- Updated the template to properly show remaining time and volume.
- Pagination update: Added transition animation for the WireGuard config and pagination.
- Added an update for deletion: If a user isn’t found on the page, it returns to the previous page. If the user is found, it stays on the same page. The same applies to editing a user.
- The toggle peer update now resets traffic properly, by first deleting the public key before adding it again. Previously, traffic was reset but didn’t work with toggle peer.
- Update for the panel and bot to support bulk user creation. A `-1` is appended to each user’s name.
- The update for the short link in the panel allows users to copy their short link if available. Wait a moment to receive the confirmation message in the panel after copying.



</details>
</div>

----------------------

![6348248](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/398f8b07-65be-472e-9821-631f7b70f783)
**How to install with Script**
 <div align="left">
  <details>
    <summary><strong><img src="https://github.com/Azumi67/Rathole_reverseTunnel/assets/119934376/fcbbdc62-2de5-48aa-bbdd-e323e96a62b5" alt="Image"> </strong>How to install with Script</summary>

------------------------------------ 

- Run the script first
 
```
sudo apt update && sudo apt install -y curl && apt install git -y && curl -fsSL -o download.sh https://raw.githubusercontent.com/Azumi67/Wireguard-panel/refs/heads/main/download.sh && bash download.sh
```


<p align="left">
  <img src="https://github.com/user-attachments/assets/3c70376b-330b-4ffe-b8f2-60ed18f80a30" alt="Image" />
</p>


- First install everything until you reach number 4

<p align="left">
  <img src="https://github.com/user-attachments/assets/9a7379c1-f19d-491d-847d-de5342f2c218" alt="Image" />
</p>

- First, enter the port for your panel, and adjust other settings based on available resources if necessary, or proceed with the default settings to the next step.
- Enter the program's password key.
- If you need TLS, enter "yes"; if you don't need it, enter "No" to use without TLS.
- If you enter "yes" for TLS, you will need to provide your subdomain and email. Make sure that your subdomain's DNS is correctly linked to your server's IP.
- If you encounter installation issues, manually install Certbot and then return to this step.
- If you're not using TLS, your dashboard address will be `http://publicip:port/home`; if using TLS, it will be `https://subdomain:port/home`.

<p align="left">
  <img src="https://github.com/user-attachments/assets/5f861a94-bb47-4cd2-82ef-cf8c6d78a85c" alt="Image" />
</p>

- The next step is setting up the WireGuard configuration.
- Always start with the `wg0` configuration, followed by `wg1` and `wg2`.
- The private IP should be version 4, and there is no need for an IPv6 address.
- Enter the port and other required details.
- If you are using a firewall, make sure to open the port and the private IP range.

<p align="left">
  <img src="https://github.com/user-attachments/assets/c4ce3873-ebd3-435e-8a66-d66a9cf9f260" alt="Image" />
</p>

- This step is for instructional purposes and is only done after installing the script and inside the panel. Please note that to use the bot in English, first change the panel's language to English, then install the bot. The same applies for Persian.
- You can install the bot from within the panel. As seen in the screenshot, enter the bot token you received from @BotFather.
- The address of the page will depend on whether you're using TLS or not. If you're not using TLS, it should be `http://publicip:port`, and if you're using TLS, it should be `https://subdomain:port`.
- The next section is the API key that you received from the panel.
- The next section is the admin chat ID of the bot you created inside BotFather. You can find this by using @userinfobot to get your bot's ID.
- To add multiple admin chat IDs, just enter them separated by commas, like this: `676676767, 67676767` (use commas as shown).
- Please use only one bot, either Persian or English.
- Then, install options 6 and 7 of the script, and your panel will be ready.
- On the main page, you'll see your dashboard address.


------------------

  </details>
</div>  

 <div align="left">
  <details>
    <summary><strong><img src="https://github.com/Azumi67/Rathole_reverseTunnel/assets/119934376/fcbbdc62-2de5-48aa-bbdd-e323e96a62b5" alt="Image"> </strong>Manual Setup</summary>

------------------------------------ 


<div align="left">
  
```
sudo apt update && sudo apt install git -y
cd /usr/local/bin
sudo git clone https://github.com/Azumi67/Wireguard-panel.git
cd /usr/local/bin/Wireguard-panel

sudo apt install -y python3 python3-pip python3-venv git redis nftables iptables wireguard-tools iproute2 \
    fonts-dejavu certbot curl software-properties-common wget

sudo systemctl enable redis-server.service
sudo systemctl start redis-server.service
sudo systemctl status redis-server.service

# creating env

python3 --version
sudo apt update && sudo apt install python3 python3-pip python3-venv
python3 -m venv /usr/local/bin/Wireguard-panel/src/venv
source /usr/local/bin/Wireguard-panel/src/venv/bin/activate
pip install --upgrade pip
pip install python-dotenv python-telegram-bot aiohttp matplotlib qrcode "python-telegram-bot[job-queue]" pyyaml flask-session Flask SQLAlchemy Flask-Limiter Flask-Bcrypt Flask-Caching jsonschema psutil pytz requests pynacl apscheduler redis werkzeug jinja2 fasteners gunicorn pexpect cryptography Pillow arabic-reshaper python-bidi

sudo apt-get install -y libsystemd-dev
deactivate

# permissions

chmod 644 /usr/local/bin/Wireguard-panel/src/config.yaml
chmod -R 600 /usr/local/bin/Wireguard-panel/src/db
chmod -R 700 /usr/local/bin/Wireguard-panel/src/backups
chmod 644 /usr/local/bin/Wireguard-panel/src/telegram/telegram.yaml
chmod 644 /usr/local/bin/Wireguard-panel/src/telegram/config.json
chmod 644 /usr/local/bin/Wireguard-panel/src/install_progress.json
chmod 644 /usr/local/bin/Wireguard-panel/src/api.json
chmod 744 /usr/local/bin/Wireguard-panel/src/install_telegram.sh
chmod 744 /usr/local/bin/Wireguard-panel/src/install_telegram-fa.sh
chmod -R 644 /usr/local/bin/Wireguard-panel/src/static/fonts
chmod -R 644 /usr/local/bin/Wireguard-panel/src/telegram/static/fonts
chmod -R 755 /etc/wireguard

```

- Flask & gunicorn configuration :

```
nano /usr/local/bin/Wireguard-panel/src/config.yaml

###
flask:
  port: 8443
  tls: true
  cert_path: "/etc/letsencrypt/live/subdomain.com/fullchain.pem"
  key_path: "/etc/letsencrypt/live/subdomain.com/privkey.pem"
  secret_key: "azumi"
  debug: false

gunicorn:
  workers: 2
  threads: 1
  loglevel: "info"
  timeout: 120
  accesslog: ""
  errorlog: ""

wireguard:
  config_dir: "/etc/wireguard"
##

```

- Wireguard configuration :

```
nano /etc/wireguard/wg0.conf

##
[Interface]
Address = 166.66.66.1/25
ListenPort = 20821
PrivateKey = aBY+lbhuOlBknLDDi2MbI11LZKEDGOSsvIbWQDuCSX0=
MTU = 1380
DNS = 1.1.1.1

PostUp = iptables -I INPUT -p udp --dport 20821 -j ACCEPT
PostUp = iptables -I FORWARD -i eth0 -o wg0 -j ACCEPT
PostUp = iptables -I FORWARD -i wg0 -j ACCEPT
PostUp = iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

PostDown = iptables -D INPUT -p udp --dport 20821 -j ACCEPT
PostDown = iptables -D FORWARD -i eth0 -o wg0 -j ACCEPT
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT
PostDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

##

Commands for generating private & pub key :
wg genkey | tee privatekey
cat privatekey | wg pubkey > publickey


```

- Wireguard panel service
```
nano /etc/systemd/system/wireguard-panel.service

##
[Unit]
Description=Wireguard Panel
After=network.target

[Service]
User=root
WorkingDirectory=/usr/local/bin/Wireguard-panel/src
ExecStart=/usr/local/bin/Wireguard-panel/src/venv/bin/python3 /usr/local/bin/Wireguard-panel/src/app.py
Restart=always
Environment=PATH=/usr/local/bin/Wireguard-panel/src/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
Environment=LANG=en_US.UTF-8
Environment=LC_ALL=en_US.UTF-8

[Install]
WantedBy=multi-user.target

##
```
------------------------------------ 

  </details>
</div>  
<div align="left">
  <details>
    <summary><strong><img src="https://github.com/Azumi67/Rathole_reverseTunnel/assets/119934376/fcbbdc62-2de5-48aa-bbdd-e323e96a62b5" alt="Image"> </strong>How to use bulk & short links</summary>

------------------------------------ 

- To create a user, follow the same process as before, but at the bottom, check the "Add in bulk" box and enter the number of users (should not exceed 50, for example, 10 is good).
- First, give the username, for example, "azumi," then select the user's private IP, and choose the other options as before. Make sure to check the "Add in bulk" box and specify the number of users.
- To display the short link, click on the link and wait for the confirmation message. If the short link exists, you will receive a "success" message.
- The same applies for the bot.
- Click on "bulk," then enter the number of users and the name.


------------------------------------ 

  </details>
</div>  

---------------
![check](https://github.com/user-attachments/assets/723872d1-1594-4d31-b48b-2b1c41adfaa9)
**Screenshots**

- Screens are in persian, but it also support english languange.

<div style="direction: ltr; text-align: left;">
  <details>
    <summary style="font-size: 14px; padding: 5px;">Panel</summary>
    <p style="margin: 0; text-align: left;">
     <p align="left">
      <img src="https://github.com/user-attachments/assets/cb754472-6a4a-4511-acde-b037737b600f" alt="menu screen" style="max-width: 100px; height: auto;" />
    </p>
  </details>

  <details>
    <summary style="font-size: 14px; padding: 5px;">Create User</summary>
    <p style="margin: 0; text-align: left;">
     <p align="left">
      <img src="https://github.com/user-attachments/assets/d8b799b5-8825-4079-bfbb-e68c9fa1c7c5" alt="menu screen" style="max-width: 100px; height: auto;" />
    </p>
  </details>

  <details>
    <summary style="font-size: 14px; padding: 5px;">User Box</summary>
    <p style="margin: 0; text-align: left;">
     <p align="left">
      <img src="https://github.com/user-attachments/assets/ec328904-6e78-4536-a08b-600f3a0c6a64" alt="menu screen" style="max-width: 100px; height: auto;" />
    </p>
  </details>

  <details>
    <summary style="font-size: 14px; padding: 5px;">Bot</summary>
    <p style="margin: 0; text-align: left;">
     <p align="left">
      <img src="https://github.com/user-attachments/assets/33a595b4-8667-4507-a181-764101d6924f" alt="menu screen" style="max-width: 100px; height: auto;" />
    </p>
  </details>

  <details>
    <summary style="font-size: 14px; padding: 5px;">Create User (Bot)</summary>
    <p style="margin: 0; text-align: left;">
     <p align="left">
      <img src="https://github.com/user-attachments/assets/dc478252-de84-4173-9aa8-9233385dbdbd" alt="menu screen" style="max-width: 100px; height: auto;" />
    </p>
  </details>

  <details>
    <summary style="font-size: 14px; padding: 5px;">User Template Display</summary>
    <p style="margin: 0; text-align: left;">
     <p align="left">
      <img src="https://github.com/user-attachments/assets/926d9ee2-fa13-46a4-a998-5b60080e15c2" alt="menu screen" style="max-width: 100px; height: auto;" />
    </p>
  </details>

  <details>
    <summary style="font-size: 14px; padding: 5px;">User Config Download Display</summary>
    <p style="margin: 0; text-align: left;">
     <p align="left">
      <img src="https://github.com/user-attachments/assets/81692c7b-d042-4d09-a1f3-bb1302e24395" alt="menu screen" style="max-width: 100px; height: auto;" />
    </p>
  </details>

  <details>
    <summary style="font-size: 14px; padding: 5px;">Bot User Menu</summary>
    <p style="margin: 0; text-align: left;">
     <p align="left">
      <img src="https://github.com/user-attachments/assets/c8fd5c11-74a9-4393-8977-3431e4f76f73" alt="menu screen" style="max-width: 100px; height: auto;" />
    </p>
  </details>
</div>



-----------------------------------------------------

![R (a2)](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/716fd45e-635c-4796-b8cf-856024e5b2b2)
**Script**
----------------

- Main script to install & update

```
sudo apt update && sudo apt install -y curl && apt install git -y && curl -fsSL -o download.sh https://raw.githubusercontent.com/Azumi67/Wireguard-panel/refs/heads/main/download.sh && bash download.sh

```

- Recalling the script

```
chmod +x /usr/local/bin/Wireguard-panel/src/setup.sh
wire
```
