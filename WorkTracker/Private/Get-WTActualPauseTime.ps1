function Get-WTActualPauseTime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $WorkingEntry
    )
    
    begin {
        
    }
    
    process {
        $IsInPauseMode = ($WorkingEntry.PauseStart -ne "")
        $CurrentPause = New-TimeSpan

        Write-Verbose "IsInPauseMode $IsInPauseMode"
        if ($IsInPauseMode) {
            $Date = Get-WTDate
            Write-Verbose "Date $Date"
            $CurrentPause = ($Date) - [datetime]::ParseExact($WorkingEntry.PauseStart, "yyyyMMddHHmm", $null)

            Write-Verbose "CurrentPause $CurrentPause"

        }
        
        $PauseDuration = New-TimeSpan -Minutes $WorkingEntry.PauseTotalInMinutes
        Write-Verbose "PauseDuration $PauseDuration"

        $TotalPause = ($PauseDuration + $CurrentPause)

        Write-Verbose "TotalPause $TotalPause"
        $TotalPause
    }
    
    end {
        
    }
}
