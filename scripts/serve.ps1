$rootPath = Resolve-Path (Join-Path $PSScriptRoot "..")
cd $rootPath

Write-Host "Starting local development server..." -ForegroundColor Cyan
Write-Host "Project Root: $rootPath" -ForegroundColor Gray

# Try Python
$pythonExists = Get-Command python -ErrorAction SilentlyContinue
if ($pythonExists) {
    # Check if python is actually installed (MS Store shim exits with error or prints redirect msg)
    $testPython = & python --version 2>&1
    if ($LastExitCode -eq 0 -and $testPython -like "*Python*") {
        Write-Host "Running Python web server on http://localhost:8000 ..." -ForegroundColor Green
        python -m http.server 8000
        exit
    }
}

# Try Node/npx
$npxExists = Get-Command npx -ErrorAction SilentlyContinue
if ($npxExists) {
    Write-Host "Running http-server via npx on http://localhost:8000 ..." -ForegroundColor Green
    npx http-server . -p 8000
    exit
}

# Fallback: Built-in PowerShell HTTP Listener (No dependencies required)
Write-Host "No Python or Node.js found. Starting built-in Windows HTTP Server on http://localhost:8000 ..." -ForegroundColor Yellow

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8000/")
try {
    $listener.Start()
} catch {
    Write-Error "Failed to start server. You may need to run as administrator or verify port 8000 is free."
    exit 1
}

Write-Host "Server is running! Navigate to http://localhost:8000 in your browser." -ForegroundColor Green
Write-Host "Press Ctrl+C to stop the server." -ForegroundColor Yellow

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $urlPath = $request.Url.LocalPath
        if ($urlPath -eq "/") {
            $urlPath = "/index.html"
        }

        # Resolve local path safely
        $cleanPath = $urlPath.Replace("/", "\").TrimStart("\")
        $localFilePath = Join-Path $rootPath $cleanPath

        if (Test-Path $localFilePath -PathType Leaf) {
            $content = [System.IO.File]::ReadAllBytes($localFilePath)
            
            # Simple content type mapping
            $extension = [System.IO.Path]::GetExtension($localFilePath).ToLower()
            $contentType = switch ($extension) {
                ".html" { "text/html; charset=utf-8" }
                ".css"  { "text/css; charset=utf-8" }
                ".js"   { "application/javascript; charset=utf-8" }
                ".png"  { "image/png" }
                ".jpg"  { "image/jpeg" }
                ".jpeg" { "image/jpeg" }
                ".svg"  { "image/svg+xml" }
                default { "application/octet-stream" }
            }

            $response.ContentType = $contentType
            $response.ContentLength64 = $content.Length
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            $response.StatusCode = 404
            $errBytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
            $response.OutputStream.Write($errBytes, 0, $errBytes.Length)
        }
        $response.Close()
    } catch {
        # Catch break exits gracefully
    }
}

