function Suspend-WTWork {
    [CmdletBinding()]
    [Alias('wtpause')]
    param (
        
    )
    
    begin {
        $PauseStart = Get-WTDate
        $WorkingEntry = Get-WTWorkingEntry -Date $PauseStart.ToShortDateString()
    }
    
    process {
        if($null -eq $WorkingEntry){
            Write-Warning "Work not even started..."
            return
        }

        if($WorkingEntry.PauseStart -ne ""){
            Write-Warning "You're already lazy...get back to work already!!"
            return
        }

        $WorkingEntry.PauseStart = $PauseStart.ToString("yyyyMMddHHmm")

        Set-WTWorkingEntry -WorkingEntry $WorkingEntry
        Write-Host "Pause started at $($PauseStart.ToShortTimeString())" -ForegroundColor Red
    }
    
    end {
        
    }
}
