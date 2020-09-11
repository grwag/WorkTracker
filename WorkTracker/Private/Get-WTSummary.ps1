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
        
        $Total = ([datetime]::ParseExact($WorkingEntry.WorkEnd, "yyyyMMddHHmm", $null)) - ([datetime]::ParseExact($WorkingEntry.Start, "yyyyMMddHHmm", $null))
        $TotalWorkTime = $Total - $TotalPause
        $WorkingEntry.TotalWorkTime = $TotalWorkTime.Ticks

        $WorkingSummary = [PSCustomObject]@{
            Date          = (Get-Date).ToShortDateString()
            WorkStart     = ([datetime]::ParseExact($WorkingEntry.Start, "yyyyMMddHHmm", $null)).ToShortTimeString()
            WorkEnd       = 0
            Pause         = $TotalPause.ToString()
            TotalWorkTime = $TotalWorkTime.ToString()
        }

        $WorkingSummary
    }
    
    end {
        
    }
}
