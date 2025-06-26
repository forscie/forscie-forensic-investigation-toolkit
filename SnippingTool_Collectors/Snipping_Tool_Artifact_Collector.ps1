# Description: Retrieve Snipping Tool Cached Images and Videos
# Author: Forscie
# Version: 1.0

# Define relative paths to search under the user profile
$paths = @(
    "Pictures\Screenshots",
    "Videos\Screen Recordings",
    "AppData\Local\Packages\Microsoft.ScreenSketch_8wekyb3d8bbwe\TempState\Snips"
)

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

Write-Host "Collection complete. Files saved to: $destinationRoot"

# Documentation
# Snipping Tool Cached Screenshots - https://insiderthreatmatrix.org/detections/DT129
# Snipping Tool TempState\Snips - https://insiderthreatmatrix.org/detections/DT130
# Snipping Tool Cached Screen Recordings - https://insiderthreatmatrix.org/detections/DT131
