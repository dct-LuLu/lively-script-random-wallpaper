
# A Powershell script to randomly switch wallpapers on Lively

This is a small powershell script that uses [Lively](https://github.com/rocksdanister/lively) and [Livelycu](https://github.com/rocksdanister/lively/wiki/Command-Line-Controls#instruction) to choose random wallpapers and apply them every now and then.



## Installation

- Install [Lively](https://github.com/rocksdanister/lively) if needed

- Then download [Livelycu](https://github.com/rocksdanister/lively/wiki/Command-Line-Controls#instruction) unzip it a folder in your Lively installation.


  Next add **Livelycu.exe** to your system path environment variables by entering this command in the powershell <kbd>Win</kbd>+<kbd>X</kbd> <kbd>A</kbd> and replace ***YOUR_Livelycu.exe_PATH*** in the command

```powershell
  [Environment]::SetEnvironmentVariable("Path", $env:Path + ";YOUR_Livelycu.exe_PATH", "Machine")
```

- Editing the Powershell script so that it suits your use.

  Now, if you installed [Lively](https://github.com/rocksdanister/lively) elsewhere than the default location you might need to change the path in the file:

  ```powershell
    $livelyexePath = 'LOCATION\Lively Wallpaper\Lively.exe'
  ```

  There you'll need to change the path of your wallpapers folders, you can give a path to a parent folder the program will look in subfolders, you can also give multiples paths like this:

  ```powershell
    $wallpapersPaths = 'LOCATION\Wallpaper2022','OTHERLOCATION\Wallpaper2023'
  ```


  You might want to change the files extensions too, at the line 23 of the script so that it works with some of your files.

  You're also able to change the time interval, although it must be at least 1 minute long since it's using window's task scheduler.
