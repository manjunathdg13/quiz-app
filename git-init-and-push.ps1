# From C:\Users\Administrator\Desktop\Quiz-MS\quiz
.\git-init-and-push.ps1 -RemoteUrl "https://github.com/yourname/your-repo.git" -Branch main<#
Usage:
  .\git-init-and-push.ps1 -RemoteUrl "https://github.com/yourname/yourrepo.git" -Branch main
If you omit -RemoteUrl the script will prompt you.
#>
param(
    [string]$RemoteUrl,
    [string]$Branch = "main"
)

function Run-Command {
    param([string]$cmd)
    Write-Host "> $cmd"
    $res = Invoke-Expression $cmd
    return $LASTEXITCODE
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is not installed or not in PATH. Install Git and retry."
    exit 1
}

if (-not $RemoteUrl) {
    $RemoteUrl = Read-Host "Enter remote repository URL (HTTPS or SSH)"
}

$cwd = Get-Location
Write-Host "Working in $cwd"

if (-not (Test-Path .git)) {
    git init
    if ($LASTEXITCODE -ne 0) { Write-Error "git init failed"; exit 1 }
    Write-Host "Initialized new git repository"
} else {
    Write-Host "Repository already initialized (found .git)"
}

# Configure local user if not set
$localName = git config user.name
$localEmail = git config user.email
if (-not $localName -or -not $localEmail) {
    Write-Host "Local git user.name or user.email not set. You can set them now (leave blank to skip)."
    $inputName = Read-Host "user.name"
    $inputEmail = Read-Host "user.email"
    if ($inputName) { git config user.name "$inputName" }
    if ($inputEmail) { git config user.email "$inputEmail" }
}

# Stage and commit
git add .
if ($LASTEXITCODE -ne 0) { Write-Error "git add failed"; exit 1 }

# Commit only if there are staged changes
$changes = git diff --cached --name-only
if ($changes) {
    git commit -m "Initial commit"
    if ($LASTEXITCODE -ne 0) { Write-Error "git commit failed"; exit 1 }
    Write-Host "Committed changes"
} else {
    Write-Host "No changes to commit"
}

# Set branch
git branch -M $Branch
if ($LASTEXITCODE -ne 0) { Write-Error "git branch command failed"; exit 1 }

# Add or update remote
$existing = git remote
if ($existing -contains 'origin') {
    git remote set-url origin $RemoteUrl
    Write-Host "Updated existing remote origin -> $RemoteUrl"
} else {
    git remote add origin $RemoteUrl
    Write-Host "Added remote origin -> $RemoteUrl"
}

# Push
Write-Host "Pushing to origin/$Branch..."
git push -u origin $Branch
if ($LASTEXITCODE -ne 0) { Write-Error "git push failed. Check credentials and remote URL."; exit 1 }
Write-Host "Push successful"

