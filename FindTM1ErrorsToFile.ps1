param (
    [string]$TargetDir,
    [string]$OutputFile,
    [int]$Days = 2,  # Default to 2 days if not provided
    [string]$SkipString1 = "",
    [string]$SkipString2 = "",
    [string]$SkipString3 = "",
    [string]$SkipString4 = "",
    [string]$SkipString5 = ""
)

# Check if the parameters are provided
if (-not $TargetDir) {
    Write-Host "Usage: script.ps1 [directory_path] [output_file] [days] [skip_string1] [skip_string2] [skip_string3] [skip_string4] [skip_string5]"
    exit
}

if (-not $OutputFile) {
    Write-Host "Usage: script.ps1 [directory_path] [output_file] [days] [skip_string1] [skip_string2] [skip_string3] [skip_string4] [skip_string5]"
    exit
}

# Check if the directory exists
if (-not (Test-Path $TargetDir)) {
    Write-Host "The directory '$TargetDir' does not exist."
    exit
}

# Clear the output file if it exists
if (Test-Path $OutputFile) {
    Clear-Content -Path $OutputFile
}

Write-Host "Searching for files beginning with 'TM1ProcessError' in '$TargetDir' that are less than $Days days old..."

# Get the current date
$currentDate = Get-Date

# Build an array of substrings to skip
$skipStrings = @($SkipString1, $SkipString2, $SkipString3, $SkipString4, $SkipString5) | Where-Object { $_ -ne "" }

# Get all files starting with "TM1ProcessError" in the target directory
$files = Get-ChildItem -Path $TargetDir -Filter "TM1ProcessError*"

foreach ($file in $files) {
    # Get the last modified time of the file
    $fileDate = $file.LastWriteTime

    # Calculate the file age in days
    $fileAge = ($currentDate - $fileDate).Days

    # Skip the file if it is older than the specified number of days
    if ($fileAge -ge $Days) {
        continue
    }

    # Skip the file if its name contains any of the specified substrings
    $skipFile = $false
    foreach ($substring in $skipStrings) {
        if ($file.Name -like "*$substring*") {
            Write-Host "Skipping file (contains substring '$substring'): $($file.Name)"
            $skipFile = $true
            break
        }
    }

    if ($skipFile) {
        continue
    }

    # Write the file name to the output file
    Write-Host "Found (less than $Days days old): $($file.Name)"
    $file.Name | Out-File -FilePath $OutputFile -Append
}

Write-Host "Search complete. Results saved to '$OutputFile'."
