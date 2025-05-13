# Enable script execution
Set-ExecutionPolicy Bypass -Scope Process -Force

# Install Chocolatey if not already installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install some common apps
$appList = @("googlechrome", "notepadplusplus", "vlc")

foreach ($app in $appList) {
    Write-Host "Installing $app..."
    choco install $app -y
}

# Set default browser to Chrome
try {
    $ProgId = "ChromeHTML"
    $RegistryPath = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice"
    Set-ItemProperty -Path $RegistryPath -Name "ProgId" -Value $ProgId -ErrorAction Stop
    Write-Host "Default browser set to Chrome."
} catch {
    Write-Warning "Failed to set default browser. Run this script as a user who has logged in with Chrome installed."
}

# Restart computer
Write-Host "Restarting computer in 10 seconds..."
Start-Sleep -Seconds 10

Restart-Computer -Force