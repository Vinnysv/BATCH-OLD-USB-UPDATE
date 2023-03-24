# Set the directory where the downloaded file will be saved
$dir = 'C:\_Windows_FU\packages'

# Create the directory if it doesn't exist already
mkdir $dir

# Create a new web client object
$webClient = New-Object System.Net.WebClient

# Set the URL to download the file from
$url = 'https://go.microsoft.com/fwlink/?LinkID=799445'

# Set the name and path of the file to save the downloaded content
$file = "$($dir)\Win10Upgrade.exe"

# Download the file from the URL and save it to the specified directory
$webClient.DownloadFile($url,$file)

# Start the downloaded file with specified command line arguments and wait for it to finish
Start-Process -FilePath $file -ArgumentList '/NoRestartUI /skipeula /auto upgrade /copylogs $dir' -Wait
