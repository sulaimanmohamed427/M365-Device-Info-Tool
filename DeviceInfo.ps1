<#
.SYNOPSIS
M365 Device Info Tool

.DESCRIPTION
Collects system information and exports it to CSV for IT inventory or reporting.

.AUTHOR
Mohamed Sulaiman
#>

# ==============================
# CONFIGURATION SECTION
# ==============================

$OutputPath = "$PSScriptRoot\DeviceInfo.csv"

# ==============================
# FUNCTIONS SECTION
# ==============================

function Get-SystemInfo {
    try {
        $systemInfo = Get-ComputerInfo | Select-Object `
            CsName,
            WindowsProductName,
            WindowsVersion,
            OsArchitecture,
            CsManufacturer,
            CsModel,
            CsTotalPhysicalMemory

        return $systemInfo
    }
    catch {
        Write-Host "Error collecting system info: $_" -ForegroundColor Red
    }
}

function Export-ToCSV {
    param (
        [Parameter(Mandatory)]
        [array]$Data
    )

    try {
        $Data | Export-Csv -Path $OutputPath -NoTypeInformation -Force
        Write-Host "Report saved to $OutputPath" -ForegroundColor Green
    }
    catch {
        Write-Host "Error exporting CSV: $_" -ForegroundColor Red
    }
}

# ==============================
# MAIN LOGIC
# ==============================

Write-Host "Starting Device Info Collection..." -ForegroundColor Cyan

$deviceData = Get-SystemInfo

if ($deviceData) {
    Export-ToCSV -Data $deviceData
    Write-Host "Completed successfully." -ForegroundColor Green
}
else {
    Write-Host "No data collected." -ForegroundColor Red
}
