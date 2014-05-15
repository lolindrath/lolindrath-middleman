---
layout: post
title: "Running a Teamspeak 3 Server on Digital Ocean"
date: 2013-07-03 08:47
published: true
comments: true
categories: 
---

[Digital Ocean](https://www.digitalocean.com/?refcode=d7c77f58d8de) provides a Virtual Private Server for just $5 a month. It also happens to be perfect to run a Teamspeak 3 server on. Teamspeak is a great way to chat with friends while playing games or pair programming.

This how-to assumes you're running Ubuntu 12.04 (or something close to it) and that you already have your server spun up and ready to SSH into. Visit the Community section of [Digital Ocean](https://www.digitalocean.com/?refcode=d7c77f58d8de) if you need further help.

## Step 1 - Get TeamSpeak 3 ##
Our first step is to download the TeamSpeak 3 server from teamspeak.com. Make sure you're in a directory you own and then execute the following command:

~~~
wget http://ftp.4players.de/pub/hosted/ts3/releases/3.0.10.3/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
~~~

## Step 2 - Create the `teamspeak3` User ##
Next, we need a user for the server to run as:

~~~
sudo adduser --disabled-login teamspeak3
~~~

You can hit enter for all the questions to take the default answers.
## Step 3 - Extract the Teamspeak 3 Software ##
The following step will extract the software we will need:

~~~
tar xzf teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
~~~

## Step 4 - Move the Software Into Place ##
We need to move the extracted software to a better location:

~~~
sudo mv teamspeak3-server_linux-amd64 /usr/local/teamspeak3
~~~

And then give the user we created permission to our new directory:

~~~
sudo chown -R teamspeak3 /usr/local/teamspeak3
~~~

## Step 5 - Have TeamSpeak 3 Start on Droplet Boot Up ##

The TeamSpeak software package comes with an init script that we just have to symbolically link in:

~~~
sudo ln -s /usr/local/teamspeak3/ts3server_startscript.sh /etc/init.d/teamspeak3
~~~

And then tell the server to start TeamSpeak when the Droplet starts

~~~
sudo update-rc.d teamspeak3 defaults
~~~

For the first time we will start it by hand:

~~~
sudo service teamspeak3 start
~~~

You should see the output similar to the following:

![](2013-07-03-running-a-teamspeak-3-server-on-digital-ocean/ts3_img1.png)

Copy the output from this step and save it somewhere safe, you will need it in a later step.
## Step 6 - Open the Firewall Port ##

If you're running a firewall on your droplet you will have to open the TeamSpeak 3 server port, 9987. Here's how to allow that port using [UFW - Uncomplicated Firewall](https://help.ubuntu.com/community/UFW):

~~~
sudo ufw allow 9987/udp
~~~

## Step 7 - Verify the Server Is Running ##

* Install the client locally for your operating system from [TeamSpeak - Downloads](http://teamspeak.com/?page=downloads)
* Connections -> Connect…
* Enter the IP of your droplet and connect

![](2013-07-03-running-a-teamspeak-3-server-on-digital-ocean/ts3_img2.png)

## Step 8 - Take Ownership ##

When you first log into your fresh TeamSpeak 3 server you should see the following dialog:

![](2013-07-03-running-a-teamspeak-3-server-on-digital-ocean/ts3_img3.png)

Copy everything after the `token=` and paste this:

![](2013-07-03-running-a-teamspeak-3-server-on-digital-ocean/ts3_img4.png)

Now you're the server administrator:

![](2013-07-03-running-a-teamspeak-3-server-on-digital-ocean/ts3_img5.png)

## Step 8 - Set a Password and Server Name ##

Right click on the TeamSpeak ]|[ Server item in the left-hand panel and click 'Edit Virtual Server':

![](2013-07-03-running-a-teamspeak-3-server-on-digital-ocean/ts3_img6.png)

Rename the server by changing the Server Name field and also set a password to access the server:

![](2013-07-03-running-a-teamspeak-3-server-on-digital-ocean/ts3_img7.png)

Now only the people you choose can access your TeamSpeak server.

## Conclusion ##

Now you have a great way to chat with friends using a server you control. Just distribute the your droplets address plus the password and you're set.

More help and advanced server setup articles are available in the [TeamSpeak 3 Knowledgebase](https://support.teamspeakusa.com/index.php?/Knowledgebase/List/Index/10/english)
