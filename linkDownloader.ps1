# Define the path to the text file containing the URLs
$urlFile = "url_list.txt"

# Get the path to the desktop folder
$desktopPath = [Environment]::GetFolderPath("Desktop")

# Read the contents of the file into an array
$urls = Get-Content $urlFile

# Loop through each URL and download the file
foreach ($url in $urls) {
    $uri = [System.Uri] $url
    $filename = (Split-Path -Path $uri.LocalPath -Leaf)
    $outputFile = Join-Path -Path $desktopPath -ChildPath $filename
    Invoke-WebRequest -Uri $url -OutFile $outputFile
}
