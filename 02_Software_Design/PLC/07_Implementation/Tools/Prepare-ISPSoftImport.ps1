[CmdletBinding()]
param(
    [string]$RepositoryRoot,
    [string]$OutputRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    $RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot "../../../..")).Path
}
else {
    $RepositoryRoot = (Resolve-Path $RepositoryRoot).Path
}

$implementationRoot = Join-Path $RepositoryRoot "02_Software_Design/PLC/07_Implementation"

if ([string]::IsNullOrWhiteSpace($OutputRoot)) {
    $OutputRoot = Join-Path $implementationRoot "ISPSoft_Import"
}

$sources = @(
    [PSCustomObject]@{ Order = 1; Path = "Types/AquaFeed_CoreTypes.st" }
    [PSCustomObject]@{ Order = 2; Path = "Globals/GVL_AquaFeed.st" }
    [PSCustomObject]@{ Order = 3; Path = "Functions/F_ElapsedMs.st" }
    [PSCustomObject]@{ Order = 4; Path = "Functions/F_CyclicDistance.st" }
    [PSCustomObject]@{ Order = 5; Path = "Function_Blocks/FB_TimeService.st" }
    [PSCustomObject]@{ Order = 6; Path = "Function_Blocks/FB_IOManager.st" }
    [PSCustomObject]@{ Order = 7; Path = "Function_Blocks/FB_SafetyCoordinator.st" }
    [PSCustomObject]@{ Order = 8; Path = "Function_Blocks/FB_AlarmManager.st" }
    [PSCustomObject]@{ Order = 9; Path = "Function_Blocks/FB_DiagnosticsManager.st" }
    [PSCustomObject]@{ Order = 10; Path = "Function_Blocks/FB_DeviceManager.st" }
    [PSCustomObject]@{ Order = 11; Path = "Function_Blocks/FB_CommunicationManager.st" }
    [PSCustomObject]@{ Order = 12; Path = "Function_Blocks/FB_HealthMonitor.st" }
    [PSCustomObject]@{ Order = 13; Path = "Function_Blocks/FB_Selector.st" }
    [PSCustomObject]@{ Order = 14; Path = "Function_Blocks/FB_Blower.st" }
    [PSCustomObject]@{ Order = 15; Path = "Function_Blocks/FB_Dosing.st" }
    [PSCustomObject]@{ Order = 16; Path = "Function_Blocks/FB_LineManager.st" }
    [PSCustomObject]@{ Order = 17; Path = "Function_Blocks/FB_RecoveryManager.st" }
    [PSCustomObject]@{ Order = 18; Path = "Function_Blocks/FB_SystemManager.st" }
    [PSCustomObject]@{ Order = 19; Path = "Programs/PRG_AquaFeedMain.st" }
)

$resolvedSources = foreach ($source in $sources) {
    $sourcePath = Join-Path $implementationRoot $source.Path

    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        throw "Required source is missing: $($source.Path)"
    }

    [PSCustomObject]@{
        Order = $source.Order
        RelativePath = $source.Path
        FullPath = (Resolve-Path -LiteralPath $sourcePath).Path
    }
}

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$packagePath = Join-Path $OutputRoot $timestamp

if (Test-Path -LiteralPath $packagePath) {
    throw "Import package already exists: $packagePath"
}

New-Item -ItemType Directory -Path $packagePath -Force | Out-Null

$manifest = foreach ($source in $resolvedSources) {
    $leafName = Split-Path $source.FullPath -Leaf
    $stagedName = "{0:D2}_{1}" -f $source.Order, $leafName
    $stagedPath = Join-Path $packagePath $stagedName

    Copy-Item -LiteralPath $source.FullPath -Destination $stagedPath

    $sourceHash = (Get-FileHash -LiteralPath $source.FullPath -Algorithm SHA256).Hash
    $stagedHash = (Get-FileHash -LiteralPath $stagedPath -Algorithm SHA256).Hash

    if ($sourceHash -ne $stagedHash) {
        throw "Hash mismatch after copy: $($source.RelativePath)"
    }

    $fileInfo = Get-Item -LiteralPath $stagedPath

    [PSCustomObject]@{
        ImportOrder = $source.Order
        SourcePath = $source.RelativePath
        StagedFile = $stagedName
        SHA256 = $stagedHash
        Bytes = $fileInfo.Length
    }
}

$manifestPath = Join-Path $packagePath "manifest.csv"
$manifest | Sort-Object ImportOrder | Export-Csv -LiteralPath $manifestPath -NoTypeInformation -Encoding UTF8

$commit = "unknown"
try {
    $gitCommit = & git -C $RepositoryRoot rev-parse HEAD 2>$null
    if ($LASTEXITCODE -eq 0 -and $gitCommit) {
        $commit = $gitCommit.Trim()
    }
}
catch {
    $commit = "unknown"
}

$instructions = @(
    "NVM AquaFeed ISPSoft import package"
    "Repository commit: $commit"
    "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss zzz')"
    ""
    "Import the numbered .st files in ascending order."
    "Do not edit staged copies without recording the exact ISPSoft diagnostic."
    "This package does not authorize PLC download or field energization."
    "See VENDOR_COMPILE_GATE.md in the source repository."
)

$instructionsPath = Join-Path $packagePath "README.txt"
$instructions | Set-Content -LiteralPath $instructionsPath -Encoding UTF8

Write-Host "ISPSoft import package created:"
Write-Host $packagePath
Write-Host ""
Write-Host "Validated sources: $($manifest.Count)"
Write-Host "Manifest: $manifestPath"
