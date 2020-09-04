function Get-WTWorkingEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Date
    )
    
    begin {
        $WorkingEntryPath = Get-WTWorkingEntryPath -Date $Date
    }
    
    process {
        if(-not (Test-Path -Path $WorkingEntryPath)){
            New-Item -Path $WorkingEntryPath -ItemType File -Force
        }

        Get-Content -Path $WorkingEntryPath | ConvertFrom-Json
    }
    
    end {
        
    }
}
