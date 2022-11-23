#Check that it's the correct path where Lively is installed
$livelyexePath = 'C:\Program Files (x86)\Lively Wallpaper\Lively.exe'

#Change to your wallpaper directories here (can be a list of different directories)
$wallpapersPaths = 'C:\Users\Administrator\Pictures\Wallpapers'

if (-not (Test-Path -Path $livelyexePath)) {
    Write-Host "The Lively Wallpaper app is not installed in the default path. Please change the path in the file to the corresponding one and try again."
    Exit
}

#We check if Lively Command Utility is existing and is added to the path
try {
    Livelycu
}
catch {
    Write-Host "Livelycu not found, please check that the environment variable is set correctly and that Livelycu (command utility) is installed
    https://github.com/rocksdanister/lively/wiki/Command-Line-Controls"
    Exit
}

# You can add here other formats of your choice
$output = Get-ChildItem -Path "$($wallpapersPaths)" -Recurse -Include *.png, *.jpg, *.jpeg, *.webp | Get-Random | % {Livelycu setwp --file $_.FullName}

#Tries to run the command, if fails, it start lively or shows an error message
if ($output -eq "WARNING: Lively core is currently not running!"){
    Start-Process $livelyexePath
}
elseif ($null -ne $output){
    "Error:`n$($output)"
    Exit
}


#Setting the task scheduler to run the script every minutes
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File '$($MyInvocation.MyCommand.Path)'" 
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1) #Change the interval here
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType "S4U" -RunLevel Highest

Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -TaskName "AutoWallpaper" -Description "Powershell script that automatically changes the wallpaper of Lively Wallpaper" -Force