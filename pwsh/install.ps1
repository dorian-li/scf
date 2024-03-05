$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$profilePath = Join-Path -Path $scriptPath -ChildPath "Microsoft.PowerShell_profile.ps1"
New-Item -ItemType SymbolicLink -Path $PROFILE -Target $profilePath