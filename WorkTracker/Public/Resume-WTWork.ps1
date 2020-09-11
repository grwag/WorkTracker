function Resume-WTWork {
    [CmdletBinding()]
    [Alias('wtres')]
    param (
        
    )
    
    begin {
        $PauseEnd = Get-WTDate
        $WorkingEntry = Get-WTWorkingEntry -Date $PauseEnd.ToShortDateString()
    }
    
    process {
        if($null -eq $WorkingEntry){
            Write-Warning "Work not even started..."
            return
        }

        if($WorkingEntry.PauseStart -eq ""){
            Write-Warning "Pause not even started..."
            return
        }

        $PauseStart = [datetime]::ParseExact($WorkingEntry.PauseStart, "yyyyMMddHHmm", $null)
        $PauseTotal = ($PauseEnd - $PauseStart)

        $WorkingEntry.PauseTotalInMinutes += $PauseTotal.TotalMinutes
        $WorkingEntry.PauseStart = ""

        Set-WTWorkingEntry -WorkingEntry $WorkingEntry
        Write-Host "Pause ended at $($PauseEnd.ToShortTimeString())" -ForegroundColor Green
    }
    
    end {
        
    }
}
