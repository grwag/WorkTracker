function Stop-WTWork {
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Alias('wtstop')]
    param (
        
    )
    
    begin {
        $EndTime = Get-WTDate
    }
    
    process {
        $WorkingEntry = Get-WTWorkingEntry -Date $EndTime.ToShortDateString()
        if ($null -eq $WorkingEntry) {
            Write-Warning "Work not even started..."
            return
        }

        if ($WorkingEntry.WorkEnd -ne "") {
            Write-Warning "Yor're already done working...get out of here!!!"
            return
        }

        $IsInPauseMode = ($WorkingEntry.PauseStart -ne "")
        if ($WhatIfPreference) {
            $WorkingMode = if ($IsInPauseMode) {
                "PAUSE"
                $Color = "Red"
            }
            else {
                "WORKING"
                $Color = "Green"
            }
            Write-Host "You are currently in $WorkingMode mode" -ForegroundColor $Color
        }

        if($IsInPauseMode -and (-not $WhatIfPreference)){
            Resume-WTWork
            $WorkingEntry = Get-WTWorkingEntry -Date $EndTime.ToShortDateString()
        }

        $WorkingEntry.WorkEnd = $EndTime.ToString("yyyyMMddHHmm")
        $WorkingSummary = Get-WTSummary -WorkingEntry $WorkingEntry
        
        if (-not $WhatIfPreference) {
            Write-Verbose "Finishing work day..."
            $WorkEntryPath = Get-WTWorkingEntryPath -Date $EndTime.ToShortDateString()
            if (Test-Path -Path $WorkEntryPath) {
                Write-Verbose "Removing work entry..."
                Remove-Item -Path $WorkEntryPath -Force
            }

            $WorkingSummary.WorkEnd = [datetime]::ParseExact($WorkingEntry.WorkEnd, "yyyyMMddHHmm", $null)
            Write-Verbose "Adding work to ledger..."
            Add-WTWorkTimeToLedger -WorkingSummary $WorkingSummary
        }

        $WorkingSummary
    }
    
    end {
        
    }
}
