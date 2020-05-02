function SysInfo {

<#
.SYNOPSIS
    Recolección de información del sistema.
.DESCRIPTION
    Recolecta información y envíala a un servidor FTP.
    Versión, arquitectura, hostaname, updates, usuarios administradores, procesos en ejecución.
.NOTES
    Función : SysInfo
    Autor : Adrián Lois
    Prerrequisitos : PowerShell v3.0 o superior.
.LINK
    Script publicado en:
    https://github.com/adrianlois/Fingerprinting-envio-FTP-PowerShell
.EXAMPLE
    SysInfo -LocalPath %temp% -Ip 192.168.0.10 -User Pepe -Pass Abc123.
    SysInfo -LocalPath "C:\Users\admin\AppData\Local\Temp\" -Ip 192.168.0.10 -User Pepe -Pass Abc123.
    Usuario y password del servidor FTP.
.EXAMPLE
    SysInfo -LocalPath %temp% -Ip 192.168.0.10
    Usuario anónimo FTP.
#>

    Param (
        [Parameter(Mandatory)]
        [String]$LocalPath,
        [Parameter(Mandatory)]
        [String]$Ip,
        [Parameter()]
        [String]$User,
        [Parameter()]
        [String]$Pass
    )

$filename = "SysInfo-$env:computername.txt"
$LocalPath = $LocalPath+=$filename

# Fecha y hora
Get-Date -Format G > $LocalPath

Write-Output "`n[+] Info del sistema:" >> $LocalPath
    $osInfo = Get-WmiObject Win32_OperatingSystem
    $object = New-Object -TypeName PSObject
    $object | Add-Member -MemberType NoteProperty -Name OS -Value $osInfo.Caption
    $object | Add-Member -MemberType NoteProperty -Name OSVersion -Value $osInfo.Version
    $object | Add-Member -MemberType NoteProperty -Name SystemInfo -Value $osInfo.PSComputerName
    # Otra forma de asignar propiedades a un objeto con el parámetro -InputObject de Add-Member
    Add-Member -InputObject $object -MemberType NoteProperty -Name Arquitectura -Value $osInfo.OSArchitecture
    (Write-Output $object | Format-List | Out-String).Trim() | Out-File -FilePath $LocalPath -Append

Write-Output "`n[+] Info de las revisiones:" >> $LocalPath
    (Get-HotFix).HotFixID | Format-Table | Out-File -FilePath $LocalPath -Append

Write-Output "`n[+] Usuarios que pertenecen al grupo local Administradores:" >> $LocalPath
    (Get-LocalGroupMember -Group "Administradores").Name | Format-Table | Out-File -FilePath $LocalPath -Append

Write-Output "`n[+] info de los procesos:" >> $LocalPath
    (Get-Process).ProcessName | Format-Table | Out-File -FilePath $LocalPath -Append

# "ftp://$User`:$pass@Ip/SysInfo-$env:computername.txt"
$ftp = "ftp://$User" ; $ftp += ":" ; $ftp += "$Pass@$Ip/$filename"
$uri = New-Object -TypeName System.Uri -ArgumentList $ftp
(New-Object Net.WebClient).UploadFile($uri, $LocalPath)

# Sleep 3
Remove-Item -Force $LocalPath
}
