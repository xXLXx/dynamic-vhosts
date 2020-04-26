# Dynamic Hosts
This is a MacOS setup to allow you to access your htdocs files as dynamic vhosts e.g. dev.my-project.com

![Sample](https://i.imgur.com/9BArdVd.png)

## Requirements
- OSX with a bash
- MAMP installed on your `/Applications/` folder

## Installation
- Download this as zip, and extract
- On your terminal, `cd` to where you extracted the zip file. (Usually `cd ~/Downloads`)
- Run `sh install.sh`

## Usage
- Just create folders or as usual checkout repositories to your `/Applications/MAMP/htdocs` folder and it should update your `/etc/hosts` file and will let you access your pages as `http://dev.folder.com`
