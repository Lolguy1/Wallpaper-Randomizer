# Define the wallpaper paths
$wallpapers = @(
    "C:\Users\theuser\Desktop\Wallpaper\Hero (RED).jpg",
    "C:\Users\theuser\Desktop\Wallpaper\Hero.jpg"
)

# Choose a random wallpaper
$randomWallpaper = Get-Random -InputObject $wallpapers

# Set as wallpaper
$RegPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $RegPath -Name WallPaper -Value $randomWallpaper

# Refresh desktop to apply the change
rundll32.exe user32.dll, UpdatePerUserSystemParameters

# Automatically add this script to Startup
$scriptPath = "$PSScriptRoot\random_wallpaper.ps1"
$startupShortcut = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\RandomWallpaper.lnk"

if (!(Test-Path $startupShortcut)) {
    $WScriptShell = New-Object -ComObject WScript.Shell
    $shortcut = $WScriptShell.CreateShortcut($startupShortcut)
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$scriptPath`""
    $shortcut.Save()
}
