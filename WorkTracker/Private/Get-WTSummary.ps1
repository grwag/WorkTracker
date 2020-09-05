function Get-WTSummary {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $WorkingEntry
    )
    
    begin {

    }
    
    process {
        $TotalPause = Get-WTActualPauseTime -WorkingEntry $WorkingEntry
        
        $Total = ([datetime] $WorkingEntry.WorkEnd) - ([datetime] $WorkingEntry.Start)
        $TotalWorkTime = $Total - $TotalPause
        $WorkingEntry.TotalWorkTime = $TotalWorkTime.Ticks

        $WorkingSummary = [PSCustomObject]@{
            Date          = (Get-Date).ToShortDateString()
            WorkStart     = (Get-Date $WorkingEntry.Start).ToShortTimeString()
            WorkEnd       = 0
            Pause         = $TotalPause.ToString()
            TotalWorkTime = $TotalWorkTime.ToString()
        }

        $WorkingSummary
    }
    
    end {
        
    }
}
