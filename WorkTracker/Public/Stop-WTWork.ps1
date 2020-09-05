function Stop-WTWork {
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('wtstop')]
    param (
        
    )
    
    begin {
        $EndTime = Get-Date
    }
    
    process {
        $WorkingEntry = Get-WTWorkingEntry -Date $EndTime.ToShortDateString()
        if ($null -eq $WorkingEntry) {
            Write-Warning "Work not even started..."
            return
        }

        if ($WorkingEntry.WorkEnd -ne 0) {
            Write-Warning "Yor're already done working...get out of here!!!"
            return
        }

        $IsInPauseMode = ($WorkingEntry.PauseStart -ne 0)
        if ($WhatIfPreference) {
            $WorkingMode = if ($IsInPauseMode) {
                $PauseDuration = New-TimeSpan -Seconds $WorkingEntry.PauseTotalInSeconds
                $CurrentPause = (Get-Date) - (Get-Date $WorkingEntry.PauseStart)
                $TotalPause = ($PauseDuration + $CurrentPause)
                "PAUSE mode since $($TotalPause.ToString("hh\:mm\:ss"))"
                $Color = "Red"
            }
            else {
                "WORKING mode"
                $Color = "Green"
            }
            Write-Host "You are currently in $WorkingMode" -ForegroundColor $Color
        }

        if($IsInPauseMode -and (-not $WhatIfPreference)){
            Resume-WTWork
            $WorkingEntry = Get-WTWorkingEntry -Date $EndTime.ToShortDateString()
        }

        $WorkingEntry.WorkEnd = $EndTime.Ticks
        $Total = (Get-Date $EndTime.Ticks) - (Get-Date $WorkingEntry.Start)
        $TotalWorkTime = $Total - (New-TimeSpan -Seconds $WorkingEntry.PauseTotalInSeconds)
        $WorkingEntry.TotalWorkTime = $TotalWorkTime.Ticks

        $TotalPause = New-TimeSpan -Seconds $WorkingEntry.PauseTotalInSeconds
        $WorkingSummary = [PSCustomObject]@{
            Date          = (Get-Date).ToShortDateString()
            WorkStart     = (Get-Date $WorkingEntry.Start).ToShortTimeString()
            WorkEnd       = 0
            Pause         = $TotalPause.ToString()
            TotalWorkTime = $TotalWorkTime.ToString()
        }
        
        if (-not $WhatIfPreference) {
            Write-Verbose "Finishing work day..."
            $WorkEntryPath = Get-WTWorkingEntryPath -Date $EndTime.ToShortDateString()
            if (Test-Path -Path $WorkEntryPath) {
                Write-Verbose "Removing work entry..."
                Remove-Item -Path $WorkEntryPath -Force
            }

            $WorkingSummary.WorkEnd = (Get-Date $WorkingEntry.WorkEnd).ToShortTimeString()
            Write-Verbose "Adding work to ledger..."
            Add-WTWorkTimeToLedger -WorkingSummary $WorkingSummary
        }

        $WorkingSummary
    }
    
    end {
        
    }
}
