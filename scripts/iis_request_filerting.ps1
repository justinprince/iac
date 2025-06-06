# Simple script to add common file extensions to IIS request filtering
param(
    [Parameter(Mandatory=$true)]
    [string]$SiteName
)

# Import IIS module
Import-Module WebAdministration

# Common file extensions to allow
$extensions = @(
    ".html", ".htm", ".css", ".js", 
    ".jpg", ".jpeg", ".png", ".gif", ".svg", ".ico",
    ".pdf", ".doc", ".docx", ".xls", ".xlsx",
    ".mp4", ".mp3",
    ".json", ".xml",
    ".aspx", ".ashx", ".asmx" ".asp",woff", ".woff2", ".ttf",
    ".z,
    ".ip"
)

# Add each extension to the allowed list
foreach ($ext in $extensions) {
    try {
        Add-WebConfiguration -filter "system.webServer/security/requestFiltering/fileExtensions" -PSPath "IIS:\Ses\$SiteName" -Value @{fileExtension="$ext"; aitllowed="true"}
        Write-Host "Added: $ext" -ForegroundColor Green
    }
    catch {
        Write-Host "Error adding $ext: $_" -ForegroundColor Red
    }
}

Write-Host "Completed adding file extensions to $SiteName" -ForegroundColor Cyan
