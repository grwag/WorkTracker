function Stop-WTWork {
    [CmdletBinding(SupportsShouldProcess = $true)]
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

        if ($WhatIfPreference) {
            $WorkingMode = if ($WorkingEntry.PauseStart -ne 0) {
                "PAUSE"
                $Color = "Red"
            }
            else {
                "WORKING"
                $Color = "Green"
            }
            Write-Host "You are currently in $WorkingMode mode" -ForegroundColor $Color
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
