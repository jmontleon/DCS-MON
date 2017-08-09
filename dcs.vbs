'****************************************
'* Application Restart Script           *
'* based on http://www.intelliadmin.com *
'* amended by s77th yeti for DCS        *
'* amended by Hudson                    *
'* AutoHotkey is also needed in order   *
'* to re-start the dcs server           *
'****************************************
WScript.Sleep (60000)
set Service = GetObject ("winmgmts:")
set Shell = WScript.CreateObject("WScript.Shell")
set fso = CreateObject("Scripting.FileSystemObject")

'****************************************
'* Set variables                        *
'****************************************
hot_key_path = "C:\Users\DCS\Documents\"
hot_key_script = "dcs.ahk"

dcs_user = "DCS"
dcs_pass = "password"

release_monitor = true
alpha_monitor = false
beta_monitor = false

exe_name = "DCS.exe"
release_path = "C:\Program Files\Eagle Dynamics\DCS World\bin\DCS.exe"
alpha_path = "C:\Program Files\Eagle Dynamics\DCS World 2 OpenAlpha\bin\DCS.exe"
beta_path = "C:\Program Files\Eagle Dynamics\DCS World OpenBeta\bin\DCS.exe"

release_port = "10308"
alpha_port = "10309"
beta_port = "10310"

'Coordinates you want the top corner of each window at relative to your screen resolution.
release_window_x = "1271"
release_window_y = "-7"
'alpha_window_x = "-7"
'alpha_window_y = "610"
'beta_window_x = "1271"
'beta_window_y = "610"

'*************************************************************************************
'* Button locations are based on the top corner of the game window.                  *
'* If you run the game in 1280x800 windows hopefully you won't need to touch these.  *
'* And if you run all at the same resolution they should all match.                  *
'*************************************************************************************
release_login_button_x = "275"
release_login_button_y = "200"
release_multiplayer_button_x = "1085"
release_multiplayer_button_y = "360"
release_new_server_button_x = "640"
release_new_server_button_y = "780"
release_mission_x = "1160"
release_mission_y = "180"
release_start_button_x = "1160"
release_start_button_y = "780"
alpha_login_button_x = "275"
alpha_login_button_y = "200"
alpha_multiplayer_button_x = "1085"
alpha_multiplayer_button_y = "360"
alpha_new_server_button_x = "640"
alpha_new_server_button_y = "780"
alpha_mission_x = "1160"
alpha_mission_y = "180"
alpha_start_button_x = "1160"
alpha_start_button_y = "780"
beta_login_button_x = "275"
beta_login_button_y = "200"
beta_multiplayer_button_x = "1085"
beta_multiplayer_button_y = "360"
beta_new_server_button_x = "640"
beta_new_server_button_y = "780"
beta_start_button_x = "1160"
beta_start_button_y = "780"
beta_mission_x = "1160"
beta_mission_y = "180"

'****************************************
'* NO NEED TO EDIT BELOW THIS LINE *
'****************************************
Sub PortMonitor (port, path)
  command = "cmd /C netStat -an |find "":" & port & """ > " & hot_key_path & "port_status.txt"
  Shell.Run command, 0, True
  port_status = fso.GetFile(hot_key_path & "port_status.txt").size

  if port_status = 0 then
    for each Process in Service.InstancesOf ("Win32_Process")
      if Process.Name = exe_name and Process.ExecutablePath = path then
        Process.Terminate()
      end if
    next
  end if
end Sub

Sub ProcessMonitor (path, window_x, window_y, multiplayer_button_x, multiplayer_button_y, new_server_button_x, new_server_button_y, start_button_x, start_button_y, login_button_x, login_button_y, mission_x, mission_y)
  running = false

  for each Process in Service.InstancesOf ("Win32_Process")
    if Process.Name = exe_name and Process.ExecutablePath = path then
      running = true
      exit for
    end if
  next

  if (not running) then
    command = chr(34) & hot_key_path & hot_key_script & chr(34) & " " & dcs_user & " " & dcs_pass & " " & chr(34) & path & chr(34) & " " & window_x & " " & window_y & " " & multiplayer_button_x & " " & multiplayer_button_y & " " & new_server_button_x & " " & new_server_button_y & " " & start_button_x & " " & start_button_y & " " & login_button_x & " " & login_button_y & " " & mission_x & " " & mission_y
    Shell.Run command, 0, True
    WScript.Sleep (60000)
  end if
end Sub

while true
  if release_monitor = true then
    PortMonitor release_port, release_path
    ProcessMonitor release_path, release_window_x, release_window_y, release_multiplayer_button_x, release_multiplayer_button_y, release_new_server_button_x, release_new_server_button_y, release_start_button_x, release_start_button_y, release_login_button_x, release_login_button_y, release_mission_x, release_mission_y
  End If

  if alpha_monitor = true then
    PortMonitor alpha_port, alpha_path
    ProcessMonitor alpha_path, alpha_window_x, alpha_window_y, alpha_multiplayer_button_x, alpha_multiplayer_button_y, alpha_new_server_button_x, alpha_new_server_button_y, alpha_start_button_x, alpha_start_button_y, alpha_login_button_x, alpha_login_button_y, alpha_mission_x, alpha_mission_y
  End If

  if beta_monitor = true then
    PortMonitor beta_port, beta_path
    ProcessMonitor beta_path, beta_window_x, beta_window_y, beta_multiplayer_button_x, beta_multiplayer_button_y, beta_new_server_button_x, beta_new_server_button_y, beta_start_button_x, beta_start_button_y, beta_login_button_x, beta_login_button_y, beta_mission_x, beta_mission_y
  End If

  WScript.Sleep (10000)
wend
