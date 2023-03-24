@echo off

powershell Set-ExecutionPolicy RemoteSigned
:: Set PowerShell execution policy to allow remotely signed scripts to run

net stop wuauserv
:: Stop the Windows Update service

cd /d %SystemRoot%\SoftwareDistribution
:: Change the current directory to the SoftwareDistribution folder

del /s /q /f Download
del /s /q /f C:\$GetCurrent
del /s /q /f C:\_Windows_FU\packages
:: Delete the contents of the _Windows_FU\packages folder in the root directory, this resolves most windows update assistant issues.

cd /d %~dp0
:: Change the current directory to the directory of the batch file

echo Updating Adobe Acrobat Reader DC...
:: Display a message about updating Adobe Acrobat Reader DC

AcroRdrDC.exe /sAll /rs /msi EULA_ACCEPT=YES
:: Install or update Adobe Acrobat Reader DC silently, suppressing reboot and accepting EULA

echo Adobe Reader DC Updated
:: Display a message that Adobe Reader DC has been updated

:: Set Windows Update target release version and product version
Echo Y | REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /t REG_SZ /d "21H2"
Echo Y | REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersion /t REG_DWORD /d "1"
Echo Y | REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v ProductVersion /t REG_SZ /d "Windows 10"

echo Windows Updating...

Powershell "" .\windows-update.ps1
:: Run the windowsupdate.ps1 PowerShell script

:: Remove the Windows Update target release version and product version registry entries
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersionInfo /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v TargetReleaseVersion /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v ProductVersion /f

net start wuauserv
:: Start the Windows Update service

echo Windows Updated.
:: Display a message that Windows has been updated