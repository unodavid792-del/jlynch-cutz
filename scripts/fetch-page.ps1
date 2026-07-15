param (
    [Parameter(Mandatory=$true)]
    [string]$Url
)

$outputDir = Join-Path $PSScriptRoot "../reference"
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

$outputFile = Join-Path $outputDir "target-page.html"
$outputTxt = Join-Path $outputDir "target-text-structure.txt"

Write-Host "Fetching $Url ..." -ForegroundColor Cyan

try {
    # Fetch web page
    $response = Invoke-WebRequest -Uri $Url -UseBasicParsing
    $html = $response.Content

    # Save raw HTML reference
    $html | Out-File -FilePath $outputFile -Encoding utf8
    Write-Host "Saved raw HTML to reference/target-page.html" -ForegroundColor Green

    # Basic cleanup to extract text and structure (conserve context)
    # Strip script tags
    $cleaned = $html -replace '(?s)<script.*?>.*?</script>', ''
    # Strip style tags
    $cleaned = $cleaned -replace '(?s)<style.*?>.*?</style>', ''
    # Strip SVG paths (often huge)
    $cleaned = $cleaned -replace '(?s)<svg.*?>.*?</svg>', '[SVG Icon]'
    # Strip comments
    $cleaned = $cleaned -replace '(?s)<!--.*?-->', ''
    
    # Save cleaned structural HTML
    $cleaned | Out-File -FilePath $outputTxt -Encoding utf8
    Write-Host "Saved context-optimized text structure to reference/target-text-structure.txt" -ForegroundColor Green
    
    Write-Host "`nAll set! Your coding agent can now read 'reference/target-text-structure.txt' which uses 80-90% less context than loading the full page in browser tools." -ForegroundColor Green
}
catch {
    Write-Error "Failed to fetch URL: $_"
}
