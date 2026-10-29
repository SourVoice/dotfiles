$ErrorActionPreference = 'Stop'

$dotfilesRoot = $PSScriptRoot
$backupRoot = Join-Path $HOME 'dotfiles_old'
$relativePaths = @(
    '.vim'
    '.config/nvim'
    'vscode'
    '.bash_profile'
    '.bash_prompt'
    '.bashrc'
    '.gitconfig'
    '.vimrc'
    '.tmux.conf'
    '.zshrc'
    'install.sh'
    'install.ps1'
)

foreach ($relativePath in $relativePaths) {
    $sourcePath = Join-Path $dotfilesRoot $relativePath
    $destinationPath = Join-Path $HOME $relativePath
    $destinationParent = Split-Path -Parent $destinationPath
    $backedUpPath = $null

    if (-not (Test-Path -LiteralPath $sourcePath)) {
        throw "Source path not found: $sourcePath"
    }

    New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null

    $temporaryPath = "$destinationPath.dotfiles-$([guid]::NewGuid().ToString('N'))"
    $isDirectory = Test-Path -LiteralPath $sourcePath -PathType Container

    try {
        if ($isDirectory) {
            New-Item -ItemType Junction -Path $temporaryPath -Target $sourcePath | Out-Null
        }
        else {
            New-Item -ItemType SymbolicLink -Path $temporaryPath -Target $sourcePath | Out-Null
        }

        $existingItem = Get-Item -LiteralPath $destinationPath -Force -ErrorAction SilentlyContinue
        if ($null -ne $existingItem) {
            $backupPath = Join-Path $backupRoot $relativePath
            $backupParent = Split-Path -Parent $backupPath
            New-Item -ItemType Directory -Path $backupParent -Force | Out-Null

            if (Test-Path -LiteralPath $backupPath) {
                $backupPath = "$backupPath.$(Get-Date -Format 'yyyyMMdd-HHmmssfff')"
            }

            Move-Item -LiteralPath $destinationPath -Destination $backupPath
            $backedUpPath = $backupPath
            Write-Host "Backed up $destinationPath to $backupPath"
        }

        Move-Item -LiteralPath $temporaryPath -Destination $destinationPath
        Write-Host "Linked $destinationPath -> $sourcePath"
    }
    catch {
        Remove-Item -LiteralPath $temporaryPath -Force -ErrorAction SilentlyContinue
        if ($null -ne $backedUpPath -and -not (Test-Path -LiteralPath $destinationPath)) {
            try {
                Move-Item -LiteralPath $backedUpPath -Destination $destinationPath
            }
            catch {
                Write-Warning "Could not restore the backup at '$backedUpPath'."
            }
        }
        throw "Failed to install '$relativePath'. Windows may require Developer Mode or an elevated PowerShell session for symbolic links. $($_.Exception.Message)"
    }
}

Write-Host 'Dotfiles installation complete.'