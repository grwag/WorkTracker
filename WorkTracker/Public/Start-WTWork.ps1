function Start-WTWork {
    [CmdletBinding()]
    [Alias('wtstart')]
    param (
        
    )
    
    begin {
        $StartTime = Get-WTDate
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
            Start = $StartTime.ToString("yyyyMMddHHmm")
            PauseStart = ""
            PauseTotalInMinutes = 0
            WorkEnd = ""
            TotalWorkTime = ""
        }

        Set-WTWorkingEntry -WorkingEntry $WorkingEntry
        Write-Host "Work started at $($StartTime.ToShortTimeString())" -ForegroundColor Green
    }
    
    end {
        
    }
}
