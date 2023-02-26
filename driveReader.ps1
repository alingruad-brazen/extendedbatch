$drive = $args[0]
if (-not $drive) {
    $drive = (Get-Item -Path ".\").PSDrive.Name + ":"
}

$drive_info = Get-PSDrive $drive
$drive_size = $drive_info.Used + $drive_info.Free
$drive_used = ($drive_info.Used / $drive_size) * 100
$drive_free = $drive_info.Free

# Set the color based on drive utilization percentage
if ($drive_used -lt 20) {
    $color = "Green"
} elseif ($drive_used -lt 60) {
    $color = "Yellow"
} elseif ($drive_used -lt 90) {
    $color = "DarkYellow"
} else {
    $color = "Red"
}

# Format the output string with color
$output = "Drive {0} utilization: {1}%" -f $drive, ([math]::Round($drive_used))
Write-Host $output -ForegroundColor $color

Write-Host "Drive $drive size: $([math]::Round($drive_size / 1GB, 2)) GB"
Write-Host "Drive $drive free: $([math]::Round($drive_free / 1GB, 2)) GB"
