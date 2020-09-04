function Suspend-WTWork {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        $PauseStart = Get-Date
        $WorkingEntry = Get-WTWorkingEntry -Date (Get-Date).ToShortDateString()
    }
    
    process {
        if($null -eq $WorkingEntry){
            Write-Warning "Work not even started..."
            return
        }

        if($WorkingEntry.PauseStart -ne 0){
            Write-Warning "You're already lazy...get back to work already!!"
            return
        }

        $WorkingEntry.PauseStart = $PauseStart.Ticks

        Set-WTWorkingEntry -WorkingEntry $WorkingEntry
    }
    
    end {
        
    }
}
