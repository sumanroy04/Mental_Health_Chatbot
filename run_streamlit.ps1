# Setup and Run Streamlit application
$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectRoot

Write-Host "Checking data-storage..." -ForegroundColor Cyan

# Copy data-storage from parent if not present in isolated directory
$ParentDataStorage = Join-Path $ProjectRoot "..\RAG_Chatbot\data-storage"
if (-not (Test-Path $ParentDataStorage)) {
    $ParentDataStorage = Join-Path $ProjectRoot "..\data-storage"
}
$LocalDataStorage = Join-Path $ProjectRoot "data-storage"

if (-not (Test-Path $LocalDataStorage)) {
    if (Test-Path $ParentDataStorage) {
        Write-Host "Copying data-storage folder from parent project..." -ForegroundColor Green
        Copy-Item -Path $ParentDataStorage -Destination $LocalDataStorage -Recurse
    } else {
        Write-Host "Warning: Parent data-storage not found. Creating empty data-storage directories." -ForegroundColor Yellow
        New-Item -ItemType Directory -Force -Path (Join-Path $LocalDataStorage "data") | Out-Null
        New-Item -ItemType Directory -Force -Path (Join-Path $LocalDataStorage "images") | Out-Null
        New-Item -ItemType Directory -Force -Path (Join-Path $LocalDataStorage "vector_db_dir") | Out-Null
    }
}

# Copy .env from parent if not present in isolated directory
$ParentEnv = Join-Path $ProjectRoot "..\RAG_Chatbot\.env"
if (-not (Test-Path $ParentEnv)) {
    $ParentEnv = Join-Path $ProjectRoot "..\.env"
}
$LocalEnv = Join-Path $ProjectRoot ".env"

if (-not (Test-Path $LocalEnv)) {
    if (Test-Path $ParentEnv) {
        Write-Host "Copying .env file from parent project..." -ForegroundColor Green
        Copy-Item -Path $ParentEnv -Destination $LocalEnv
    } else {
        Write-Host "No .env found. Creating .env from .env.example. Please add your GROQ_API_KEY." -ForegroundColor Yellow
        Copy-Item -Path ".\.env.example" -Destination $LocalEnv
    }
}

# Setup Virtual Environment
if (-not (Test-Path ".\.venv\Scripts\streamlit.exe")) {
    Write-Host "Creating virtual environment..." -ForegroundColor Cyan
    python -m venv .venv
    Write-Host "Installing dependencies..." -ForegroundColor Cyan
    .\.venv\Scripts\pip.exe install -r requirements.txt
}

Write-Host "Starting Streamlit..." -ForegroundColor Green
.\.venv\Scripts\streamlit.exe run backend/streamlit_app.py
