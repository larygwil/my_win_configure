$allPackages = @()

$installedPackages = Get-AppxPackage | Select-Object Name,PackageFullName,InstallLocation,Publisher
foreach($pkg in $installedPackages){
    $allPackages += $pkg
}

$provisionedPackages = Get-AppxProvisionedPackage -online | Select-Object Name,PackageFullName,InstallLocation,Publisher
foreach($pkg in $provisionedPackages){
    $allPackages += $pkg
}

$uniqueAndSortedPackages = $allPackages | Sort-Object -Property Name, PackageFullName -unique

$uniqueAndSortedPackages|format-list|out-file -filepath g:\p.txt
