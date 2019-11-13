function CheckAndDownloadVsWhere {
    if (Test-Path .\vswhere.exe) {
        return
    }
    Write-Host "Cannot find vswhere.exe. Start to download"
    Invoke-WebRequest "https://github.com/microsoft/vswhere/releases/download/2.8.4/vswhere.exe" -OutFile ".\vswhere.exe"
}

function Find2017InstallPath {
    $vs_result = & .\vswhere.exe -version "[15.0,16.0)" -property productPath
    return $vs_result
}

&CheckAndDownloadVsWhere
$ide_path=Find2017InstallPath
$csi_path=&Split-Path -Path $ide_path | Join-Path -ChildPath "..\..\MSBuild\15.0\Bin\Roslyn\csi.exe"
&"$csi_path" $args