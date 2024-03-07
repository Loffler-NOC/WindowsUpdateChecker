# Check if NuGet package provider is installed
$providerName = "NuGet"
$providerInstalled = Get-PackageProvider -Name $providerName -ErrorAction SilentlyContinue -ForceBootstrap

if ($providerInstalled) {
    Write-Host "NuGet package provider is installed."
}
else {
    Write-Host "NuGet package provider is not installed. Attemping to install it now."
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
}

# Check if the PSWindowsUpdate module is already installed
$moduleName = "PSWindowsUpdate"
$installedModules = Get-Module -ListAvailable | Where-Object { $_.Name -eq $moduleName }

if ($installedModules) {
    Write-Host "The '$moduleName' module is installed."
}
else {
    Write-Host "The '$moduleName' module is not installed. Attemping to install it now."
    Install-Module -Name PSWindowsUpdate -Force
}

Write-Host "Importing PSWindowsUpdate module"
Import-Module PSWindowsUpdate


Write-Host "Checking what updates are available"
Write-Output "-----------------------------"
Write-Output "Windows update legend"
Write-Output @"
isDownloaded = D
isInstalled = I
isMandatory = M
isHidden = H
isUninstallable = U
isBeta = B
"@
Write-Output "-----------------------------"

# Save Get-WindowsUpdate to a variable
$updates = Get-WindowsUpdate

if ($updates.Count -ne 0) {

    # Loop through each update and output desired fields
    foreach ($update in $updates) {
        $kb = $update.KB
        $status = $update.Status
        $title = $update.Title
        $description = $update.Description
        $rebootRequired = $update.RebootRequired

        Write-Output "KB: $kb"
        Write-Output "Status: $status"
        Write-Output "Title: $title"
        Write-Output "Description: $description"
        Write-Output "Reboot Required: $rebootRequired"
        Write-Output "-----------------------------"
    }
}
else {
    Write-Output "There are currently no updates available"
    Write-Output "-----------------------------"
}


Write-Host "Checking what updates are installed"
Write-Output "-----------------------------"
Write-Output "Windows update legend"
Write-Output @"
isDownloaded = D
isInstalled = I
isMandatory = M
isHidden = H
isUninstallable = U
isBeta = B
"@
Write-Output "-----------------------------"

# Save Get-WindowsUpdate to a variable
$updates = Get-WindowsUpdate -IsInstalled

if ($updates.Count -ne 0) {
    
    # Loop through each update and output desired fields
    foreach ($update in $updates) {
        $kb = $update.KB
        $status = $update.Status
        $title = $update.Title
        $description = $update.Description
        $rebootRequired = $update.RebootRequired

        Write-Output "KB: $kb"
        Write-Output "Status: $status"
        Write-Output "Title: $title"
        Write-Output "Description: $description"
        Write-Output "Reboot Required: $rebootRequired"
        Write-Output "-----------------------------"
    }
}
else {
    Write-Output "There are currently no updates installed"
}
