
# retrive OS version and save under veriable 
$osVersion = Get-ComputerInfo | Select-Object -ExpandProperty WindowsVersion

# retives the system up time and save under veriable
$uptime = (Get-CimInstance Win32_operatingSystem).LastBootUpTime

# Retive CPU Info
$cpuInfo = Get-CimInstance Win32_Processor | Select-Object -Property Name, NumberOfCores, MaxClockSpeed

# Retive memory info
$memoryInfo = Get-CimInstance Win32_OperatingSystem | Select-Object -Property TotalVisibleMemorySize, FreePhysicalMemory

# Retive Netowrk Info
$networkInfo = Get-NetAdapter | Select-Object -Property Name, Status, MacAddress
$ipAddress = Get-NetIPAddress | Select-Object -Property InterfaceAlias, IPAddress

# system model info
$systemInfo = Get-CimInstance Win32_ComputerSystem | Select-Object -Property Manufacturer, Model

# GPU Info
$gpuinfo = Get-WmiObject Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion

# exteneded info
# Get-WmiObject Win32_VideoController | Format-List *



# retives avalible disc space and saved under veriable
$diskSpace = Get-PSDrive -PSProvider FileSystem | Select-Object -Property Name, @{
    Name="FreeSpaceGB";Expression={
        [math]::round($_.Free/1GB,2)
    }
}, @{
    Name="UsedSpaceGB";Expression={
        [math]::round(($_.Used/1GB),2)
    }
}, @{
    Name="TotalSpaceGB";Expression={
        [math]::round(($_.Used + $_.Free)/1GB,2)
    }
}    
            
        

# print details 

Write-Output "System Information" 
Write-Output "--------------------" 
Write-Output "Operating System Version: $osVersion" 
Write-Output "System Uptime: $([DateTime]::Now - $uptime)" 
Write-Output "Available Disk Space:" 
$diskSpace | Format-Table -AutoSize -Property Name, FreeSpaceGB, UsedSpaceGB, TotalSpaceGB
Write-Output "" 
Write-Output "CPU Information:" $cpuInfo | Format-Table -AutoSize 
Write-Output "" 
Write-Output "Memory Information:" 
$memoryInfo | ForEach-Object {
    [PSCustomObject]@{
        TotalMemoryGB = [math]::round($_.TotalVisibleMemorySize / 1MB, 2) 
        FreeMemoryGB = [math]::round($_.FreePhysicalMemory / 1MB, 2) 
        } 
} | Format-Table -AutoSize
Write-Output "" 
Write-Output "Network Information:" 
$networkInfo | Format-Table -AutoSize 
$ipAddress | Format-Table -AutoSize
Write-Output "" 
Write-Output "System Model and Manufacturer:" 
$systemInfo | Format-Table -AutoSize
Write-Output ""
Write-Output "GPU INFO"
$gpuinfo | Format-Table -AutoSize