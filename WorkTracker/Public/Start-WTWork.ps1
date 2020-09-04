function Start-WTWork {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        $StartTime = Get-Date
    }
    
    process {
        $WorkingEntry = Get-WTWorkingEntry -Date $StartTime.ToShortDateString()
        if($null -ne $WorkingEntry.Start){
            $WorkingEntry.Start
            Write-Warning "Work today already started..."
            return
        }

        if(Test-WTWorkDay){
            Write-Warning "You already worked today...go home!"
            return
        }

        $WorkingEntry = @{
            Date = $StartTime.ToShortDateString()
            Start = $StartTime.Ticks
            PauseStart = 0
            PauseTotalInSeconds = 0
            WorkEnd = 0
            TotalWorkTime = 0
        }

        Set-WTWorkingEntry -WorkingEntry $WorkingEntry
    }
    
    end {
        
    }
}
