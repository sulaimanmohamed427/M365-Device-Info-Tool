Get-ComputerInfo |
Select-Object CsName, WindowsVersion, OsArchitecture, TotalPhysicalMemory |
Export-Csv "DeviceInfo.csv" -NoTypeInformation
