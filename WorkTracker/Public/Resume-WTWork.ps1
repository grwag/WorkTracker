function Resume-WTWork {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        $PauseEnd = Get-Date
        $WorkingEntry = Get-WTWorkingEntry -Date (Get-Date).ToShortDateString()
    }
    
    process {
        if($null -eq $WorkingEntry){
            Write-Warning "Work not even started..."
            return
        }

        if($WorkingEntry.PauseStart -eq 0){
            Write-Warning "Pause not even started..."
            return
        }

        $PauseStart = (Get-Date $WorkingEntry.PauseStart)
        $PauseTotal = ($PauseEnd - $PauseStart)

        $WorkingEntry.PauseTotalInSeconds += $PauseTotal.TotalSeconds
        $WorkingEntry.PauseStart = 0

        Set-WTWorkingEntry -WorkingEntry $WorkingEntry
    }
    
    end {
        
    }
}
