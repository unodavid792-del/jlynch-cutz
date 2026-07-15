$projectRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$filesToCheck = @("index.html", "style.css", "app.js", "AGENTS.md")
$allPassed = $true

Write-Host "Verifying project structure..." -ForegroundColor Cyan

foreach ($file in $filesToCheck) {
    $filePath = Join-Path $projectRoot $file
    if (Test-Path $filePath) {
        $size = (Get-Item $filePath).Length
        if ($size -gt 0) {
            Write-Host "[OK] $file exists and is valid ($size bytes)" -ForegroundColor Green
        } else {
            Write-Warning "[EMPTY] $file exists but is empty!"
            $allPassed = $false
        }
    } else {
        Write-Error "[MISSING] $file is missing from project root!"
        $allPassed = $false
    }
}

# Verify HTML syntax basics
$htmlPath = Join-Path $projectRoot "index.html"
if (Test-Path $htmlPath) {
    $htmlContent = Get-Content $htmlPath -Raw
    if ($htmlContent -like "*<head>*" -and $htmlContent -like "*<body>*") {
        Write-Host "[OK] index.html structure verified" -ForegroundColor Green
    } else {
        Write-Warning "[WARN] index.html seems to be missing standard head or body tags"
        $allPassed = $false
    }
}

if ($allPassed) {
    Write-Host "`nAll verification checks passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`nSome checks failed. Please check files." -ForegroundColor Red
    exit 1
}
