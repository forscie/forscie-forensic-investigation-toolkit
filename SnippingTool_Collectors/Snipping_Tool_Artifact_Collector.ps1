# Description: Retrieve Snipping Tool Cached Images, Videos, and Settings
# Author: Forscie
# Version: 1.2

# Define relative paths to search under the user profile
$paths = @(
    "Pictures\Screenshots",
    "Videos\Screen Recordings",
    "AppData\Local\Packages\Microsoft.ScreenSketch_8wekyb3d8bbwe\TempState\Snips",
    "AppData\Local\Packages\Microsoft.ScreenSketch_8wekyb3d8bbwe\TempState\Recordings"  # Added for .mp4 files
)

# Define path to Settings.dat
$settingsDatRelativePath = "AppData\Local\Packages\Microsoft.ScreenSketch_8wekyb3d8bbwe\Settings\Settings.dat"

# Generate timestamp and destination folder on the Desktop
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$destinationRoot = Join-Path $env:USERPROFILE "Desktop\Snip_Collect_$timestamp"

# Iterate over each target path
foreach ($relativePath in $paths) {
    $sourcePath = Join-Path $env:USERPROFILE $relativePath

    # Check if the path exists and contains files
    if ((Test-Path $sourcePath) -and (Get-ChildItem -Path $sourcePath -Recurse -File -ErrorAction SilentlyContinue)) {
        # Create the full output path under the destination
        $outputPath = Join-Path $destinationRoot $relativePath

        # Create destination directory
        New-Item -ItemType Directory -Path $outputPath -Force | Out-Null

        # Copy files while preserving structure
        Copy-Item -Path "$sourcePath\*" -Destination $outputPath -Recurse -Force
    }
}

# Collect Settings.dat file separately
$settingsDatSource = Join-Path $env:USERPROFILE $settingsDatRelativePath
if (Test-Path $settingsDatSource) {
    $settingsDatDestination = Join-Path $destinationRoot $settingsDatRelativePath
    $settingsDatDir = Split-Path $settingsDatDestination -Parent

    # Create directory structure if needed
    New-Item -ItemType Directory -Path $settingsDatDir -Force | Out-Null

    # Copy the Settings.dat file
    Copy-Item -Path $settingsDatSource -Destination $settingsDatDestination -Force
}

Write-Host "Collection complete. Files saved to: $destinationRoot"

# Documentation
# Snipping Tool Cached Screenshots - https://insiderthreatmatrix.org/detections/DT129
# Snipping Tool TempState\Snips - https://insiderthreatmatrix.org/detections/DT130
# Snipping Tool Cached Screen Recordings - https://insiderthreatmatrix.org/detections/DT131
# Snipping Tool TempState\Recordings - https://insiderthreatmatrix.org/detections/DT132
# Snipping Tool Autosave Setting Modification - https://insiderthreatmatrix.org/detections/DT133