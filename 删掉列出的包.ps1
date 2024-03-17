# 文本文件路径
$filePath = 'g:\pd.txt'

# 读取文件的每一行
$packageFullNames = Get-Content -Path $filePath

# 为将要删除的包创建两个空数组
$packagesToRemove = @()
$provisionedPackagesToRemove = @()

# 检查每个包全名
foreach ($pkgFullName in $packageFullNames) {
    # 删除每一行两侧的空白字符
    $pkgFullName = $pkgFullName.Trim()

    # 判断trim后的字符串是否为空
    if (![string]::IsNullOrWhiteSpace($pkgFullName)) {
        # 检查是否已安装该包
        $installedPackage = Get-AppxPackage -AllUsers | Where-Object { $_.PackageFullName -eq $pkgFullName }

        if ($installedPackage -ne $null) {
            # 如果已安装，添加到删除列表
            $packagesToRemove += $installedPackage
        }

        # 检查是否预设了此包
        $provisionedPackage = Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -eq $pkgFullName }

        if ($provisionedPackage -ne $null) {
            # 如果预设了，添加到删除列表
            $provisionedPackagesToRemove += $provisionedPackage
        }
    }
}

# 显示要删除的已安装包
Write-Host "The following installed packages will be removed:"
foreach ($pkg in $packagesToRemove) {
    Write-Host $pkg.PackageFullName
}

# 显示将要删除的预设包
Write-Host "The following provisioned packages will be removed:"
foreach ($pkg in $provisionedPackagesToRemove) {
    Write-Host $pkg.PackageName
}

# 提示用户确认
$confirm = Read-Host "Are you sure you want to remove these packages? (Y/N)"

# 验证选择
if ($confirm -eq 'Y') {
    # 如果用户确认，删除已安装包
    foreach ($pkg in $packagesToRemove) {
        $pkg | Remove-AppxPackage -AllUsers
        Write-Host "Removed installed package: $($pkg.PackageFullName)"
    }

    # 删除预设包
    foreach ($pkg in $provisionedPackagesToRemove) {
        $pkg | Remove-AppxProvisionedPackage -Online
        Write-Host "Removed provisioned package: $($pkg.PackageName)"
    }
    Write-Host "All specified packages have been removed."
}
else {
    Write-Host "Operation canceled."
}
