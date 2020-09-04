function Set-WTWorkingEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $WorkingEntry
    )
    
    begin {
        $WorkingEntryPath = Get-WTWorkingEntryPath -Date $WorkingEntry.Date
        $ExistingWorkingEntry = Get-Content $WorkingEntryPath | ConvertFrom-Json
    }
    
    process {
        if($null -ne $WorkingData){
            $ExistingWorkingEntry.PauseStart = $WorkingEntry.PauseStart
            $ExistingWorkingEntry.PauseTotalInSeconds = $WorkingEntry.PauseTotalInSeconds
            $ExistingWorkingEntry.WorkEnd = $WorkingEntry.WorkEnd
            $ExistingWorkingEntry.TotalWorkTime = $WorkingEntry.TotalWorkTime
            
            Set-Content -Path $WorkingEntryPath -Value ($ExistingWorkingEntry | ConvertTo-Json)
        }else{
            Set-Content -Path $WorkingEntryPath -Value ($WorkingEntry | ConvertTo-Json)
        }
    }
    
    end {
        
    }
}
