DCS-MON
=======

Description
-----------
As there is no dedicated server for DCS and it is quite unstable at times it can be tedious to keep a server up and running at all times. DCS-MON is an attempt to help work around the shortcomings. 

How It Works
------------
DCS-MON runs in the background checking that the DCS process is running and listening on the specified port. If it is running but not listening it will be terminated. If it is not running it will be started via the AutoHotkey script as the specified user. The AutoHotKey script will also automatically move the window to the specified coordinates and press the appropriate buttons to get back to a running server. Button presses are done via Window coordinate so if you run the server windows at a resolution other than 1280x800 they will likely need some adjustment.

Instructions
------------
1. Create an unprivileged user
2. Set a password for the user
 * There's no reason you can't use this script with your account, but your're probably an admin...
3. Install [AutoHotKey](https://autohotkey.com/)
4. Place dcs.ahk where it makes sense to you. 
4. Edit the dcs.vbs 'Set variables' section:
  * Make sure the ahk script path and name are correct for your preference.
  * Update the script with the user and password from steps 1 and 2.
  * Choose which versions of the game you want to monitor.
  * Make sure the paths for your installations match.
  * Specify the port any monitored versions will be listening on.
  * Specify the coordinates you want the top left corner of each windows to be moved to.
  * Either set the game windows to run at 1280x800 or modify the button locations.
5. Place dcs.vbs in your startup folder. 
  * The per user start folder is C:\Users\$USER\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
6. Either reboot or double click the script to start the monitor process. It pauses for a minute before it starts doing it's thing.
7. If you need to stop it kill the "Microsoft ® Windows Based Script Host" process in the Task Manager. This could probably be improved...
8. The game will hang when it crashes to the  Windows Error Reporting window waiting for you to press 'OK' unless you make some registry edits. I've seen two suggestions and together they seem to work, but I do not know if either works on its own:

```
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"ForceQueue"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent]
"DefaultConsent"=dword:00000001
```

and/or:

```
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"DontShowUI"=dword:00000001
```
