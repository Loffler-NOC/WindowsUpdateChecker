# Check if NuGet package provider is installed
$providerName = "NuGet"
$providerInstalled = Get-PackageProvider -Name $providerName -ErrorAction SilentlyContinue -ForceBootstrap

if ($providerInstalled) {
    Write-Host "NuGet package provider is installed."
} else {
    Write-Host "NuGet package provider is not installed. Attemping to install it now."
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
}

# Check if the PSWindowsUpdate module is already installed
$moduleName = "PSWindowsUpdate"
$installedModules = Get-Module -ListAvailable | Where-Object { $_.Name -eq $moduleName }

if ($installedModules) {
    Write-Host "The '$moduleName' module is installed."
} else {
    Write-Host "The '$moduleName' module is not installed. Attemping to install it now."
    Install-Module -Name PSWindowsUpdate -Force
}

Write-Host "Importing PSWindowsUpdate module"
Import-Module PSWindowsUpdate
Write-Host "Checking what updates are available"
Get-WindowsUpdate
Write-Host "Checking what updates are installed"
Get-WindowsUpdate -IsInstalled
