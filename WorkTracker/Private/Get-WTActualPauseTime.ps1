function Get-WTActualPauseTime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $WorkingEntry
    )
    
    begin {
        
    }
    
    process {
        $IsInPauseMode = ($WorkingEntry.PauseStart -ne 0)
        $CurrentPause = New-TimeSpan

        if($IsInPauseMode){
            $Date = Get-Date
            $CurrentPause = ($Date) - ([datetime]$WorkingEntry.PauseStart)
        }
        
        $PauseDuration = New-TimeSpan -Seconds $WorkingEntry.PauseTotalInSeconds
        $TotalPause = ($PauseDuration + $CurrentPause)

        $TotalPause
    }
    
    end {
        
    }
}
