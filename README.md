# BATCH-PS-OLD-USB-UPDATE
This is the old method of updating completing an in-place update. This is a simple script that updates Windows feature updates and also updated Adobe Acrobat.

This script updates Adobe Acrobat Reader DC and then updates Windows to a specified target release version and product version. The script is intended to be run as an administrator.

#Usage
Download the windows-update.bat and windows-update.ps1 files from this repository.
Run windows-update.bat as an administrator.
Script Details

#The script performs the following actions:

Sets PowerShell execution policy to allow remotely signed scripts to run.
Stops the Windows Update service.
Deletes the contents of the _Windows_FU\packages folder in the root directory. This resolves most Windows Update Assistant issues.
Installs or updates Adobe Acrobat Reader DC silently, suppressing reboot and accepting the EULA.
Sets the Windows Update target release version and product version to the specified values.
Runs the windows-update.ps1 PowerShell script, which updates Windows to the specified target release version and product version.
Removes the Windows Update target release version and product version registry entries.
Starts the Windows Update service.
Displays a message that Windows has been updated.
